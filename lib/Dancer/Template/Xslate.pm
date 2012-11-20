package Dancer::Template::Xslate;

use strict;
use warnings;
use Carp;
use Moo;
use Dancer::Core::Types;
use Text::Xslate;

our $VERSION = "0.020";

with 'Dancer::Core::Role::Template';

has '+engine' => ( isa => InstanceOf ['Text::Xslate'], );

sub _build_name { 'Xslate' }

sub _build_engine {
    my $self = shift;

    my $config = { %{ $self->config } };
    if ( !exists $config->{path} ) {
        $config->{path} = $self->views;
    }
    return Text::Xslate->new(%$config);
}

sub render {
    my ( $self, $template, $tokens ) = @_;

    if ( !ref $template ) {
        -f $template or croak "'$template' doesn't exist or not a regular file";
        if ( index( $template, $self->views ) != 0 ) {
            croak "'$template' not found under view paths";
        }
    }

    substr( $template, 0, length( $self->views ) ) = '';
    my $content = eval { $self->engine->render( $template, $tokens ) };
    return $content;
}

1;

__END__

=head1 NAME

Dancer::Template::Xslate - Text::Xslate template engine for Dancer2

=head1 AUTHOR

Vladimir Lettiev <crux@cpan.org>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.2 or,
at your option, any later version of Perl 5 you may have available.

=cut
