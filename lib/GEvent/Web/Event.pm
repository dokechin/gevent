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

  my $itr = $self->db->search_by_sql
  ('SELECT address, create_at, detail, name, type, lat, lng, ( 3959 * acos( cos( radians(?) ) * cos( radians( lat ) ) * cos( radians( lng ) - radians(?) ) + sin( radians(?) ) * sin( radians( lat ) ) ) ) AS distance FROM markers HAVING distance < ? ORDER BY distance LIMIT 0 , 20',
  [ $center_lat, $center_lng, $center_lat, $radius]);

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
1;
