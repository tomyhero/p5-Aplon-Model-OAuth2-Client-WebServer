package Aplon::Model::OAuth2::Client::WebServer::Facebook;
use strict; 
use Mouse;
extends 'Aplon::Model::OAuth2::Client::WebServer';

has '+authorize_uri' => ( default => 'https://graph.facebook.com/oauth/authorize' );
has '+access_token_uri' => ( default => 'https://graph.facebook.com/oauth/access_token' );
has 'display' => ( is => 'rw', default => 'page' );

has 'extra' => (
    is => 'rw', 
    lazy_build => 1,
);

sub _build_extra {
    my $self = shift;
    my $hash = {};
    $hash->{display} = $self->display;
    return $hash;
}   
    
__PACKAGE__->meta->make_immutable();

no Mouse;

1; 
