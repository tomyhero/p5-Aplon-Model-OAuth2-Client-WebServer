package Aplon::Model::OAuth2::Client::WebServer;
use strict;
use Mouse;
extends 'Aplon';
with 'Aplon::Validator::Simple';
use OAuth::Lite2::Client::WebServer;


our $VERSION = '0.01';

# for instance
has 'id' => ( is => 'rw', required => 1);
has 'secret' => ( is => 'rw', required => 1);
has 'authorize_uri' => ( is => 'rw', required => 1);
has 'access_token_uri' => ( is => 'rw', required => 1);


has 'redirect_uri' => (is => 'rw', required => 1);
has 'scope' => (is => 'rw', default => '');
has 'state' => (is => 'rw', default => '');
has 'immediate' => (is => 'rw', default => '');
has 'extra' => ( is => 'rw', default => sub {+{}} );

has 'client' => (
    is => 'rw',
    lazy_build => 1,
);

sub _build_client {
    my $self = shift;
    my $client = OAuth::Lite2::Client::WebServer->new(
        id               => $self->id,
        secret           => $self->secret,
        authorize_uri    => $self->authorize_uri,
        access_token_uri => $self->access_token_uri,
    );
    return $client;
}

sub start_authorize {
    my $self = shift;
    my $redirect_url = $self->client->uri_to_redirect(
            redirect_uri => $self->redirect_uri,
            scope        => $self->scope,
            state        => $self->state,
            immediate    => $self->immediate,
            extra        => $self->extra,
            );
    return $redirect_url;
}

sub callback {
    my $self = shift;
    my $args = shift || {};
    my $code = $args->{code} or $self->abort_with('',{
        code => "OAUTH2_FAILED" ,
        missing => ['code'],
    });
    my $client = $self->client;
    my $access_token = $client->get_access_token(
            code         => $code,
            redirect_uri => $self->redirect_uri,
            ) or $self->abort_with('get_access_token_faild',{ code => 'OAUTH2_FAILED' });

    return $self->do_complate( $access_token );
}

sub do_complate {
    my $self = shift;
    my $access_token = shift ;
    die 'do_complate() is ABSTRACT method';
}


__PACKAGE__->meta->make_immutable();

no Mouse;

1;
