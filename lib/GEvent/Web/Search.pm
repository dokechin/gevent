package GEvent::Web::Search;
use Mojo::Base 'Mojolicious::Controller';
use HTML::FillInForm;
use FormValidator::Lite;
use utf8;
use Data::Dumper;

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

  $self->render(template =>'search/index', format=> 'xml',  markers => \@markers);

}

1;
