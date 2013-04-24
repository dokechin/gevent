package GEvent::Web::Root;
use Mojo::Base 'Mojolicious::Controller';
use HTML::FillInForm;
use FormValidator::Lite;
use utf8;

# This action will render a template
sub index {
  my $self = shift;

  # Render template "example/welcome.html.ep" with message
  $self->render(
    message => 'Welcome to the Mojolicious real-time web framework!');
}

1;
