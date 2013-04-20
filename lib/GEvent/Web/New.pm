package GEvent::Web::New;
use Mojo::Base 'Mojolicious::Controller';
use utf8;


# This action will render a template
sub index {
  my $self = shift;

  my $itr = $self->db->search_by_sql
  ('SELECT id, address, create_at, detail, name, type, lat, lng FROM markers ORDER BY create_at desc LIMIT 0 , 20');

  my @markers = $itr->all;

  $self->render(template =>'new/index',  markers => \@markers);
 
}

1;
