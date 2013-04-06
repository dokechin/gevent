package GEvent::Web;
use Mojo::Base 'Mojolicious';
use GEvent::DB;

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  my $ config = $self->plugin('Config');
  
  $self->helper(db => sub { GEvent::DB->new ( $config->{db} )});

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('root#index');
  $r->post('/newentry')->to('newentry#register');
  $r->get('/search')->to('search#search');
}

1;
