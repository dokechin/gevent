package GEvent::Web::Event;
use Mojo::Base 'Mojolicious::Controller';
use HTML::FillInForm;
use FormValidator::Lite;
use utf8;
use Data::Dumper;
use DateTime;

# This action will render a template
sub search {
  my $self = shift;

  my $center_lat = $self->param("lat");
  my $center_lng = $self->param("lng");
  my $radius = $self->param("radius");

  my $dt1 = DateTime->now( time_zone => 'local' )->add( days => -1);
  my $dt2 = DateTime->now( time_zone => 'local' );

  my $itr = $self->db->search_by_sql
  ('SELECT id, address, create_at, detail, name, type, lat, lng, ( 3959 * acos( cos( radians(?) ) * cos( radians( lat ) ) * cos( radians( lng ) - radians(?) ) + sin( radians(?) ) * sin( radians( lat ) ) ) ) AS distance FROM Markers where create_at between ? and ? HAVING distance < ? ORDER BY distance LIMIT 0 , 20',
  [ $center_lat, $center_lng, $center_lat, DateTime::Format::MySQL->format_datetime($dt1),DateTime::Format::MySQL->format_datetime($dt2) , $radius]);

  my @markers = $itr->all;

  $self->render(template =>'event/search', format=> 'xml',  markers => \@markers);

}

# This action will render a template
sub create {
  my $self = shift;

  my $lat = $self->param("lat");
  my $lng = $self->param("lng");
  my $name = $self->param("name");
  my $address = $self->param("address");
  my $detail = $self->param("detail");
  my $type = $self->param("type");
  my $dt = DateTime->now( time_zone=>'local' );

  my $marker = $self->db->insert('Markers',
   {address => $address, type=> $type, name=> $name, detail => $detail,lat=> $lat, lng => $lng, create_at => $dt});

  $self->render(template =>'event/create', format=> 'xml', marker => $marker);

}


# This action will render a template
sub show {
  my $self = shift;

  my $id = $self->param("id");

  my $marker = $self->db->single('Markers', +{id => $id});
  
  $self->stash(id =>$marker->id);
  $self->stash(name =>$marker->name);
  $self->stash(address =>$marker->address);

 my $html = $self->render_partial(template => 'event/show'  )->to_string;
 $self->render_text(HTML::FillInForm->fill(\$html, {name => $marker->name, create_at => $marker->create_at ,address => $marker->address, detail => $marker->detail }),            format => 'html');
 
}

1;
