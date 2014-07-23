# ABSTRACT: a plugin for adding Ajax route handlers

package Dancer2::Plugin::Ajax;
$Dancer2::Plugin::Ajax::VERSION = '0.149000_01';
use strict;
use warnings;

use Dancer2;
use Dancer2::Plugin;


register 'ajax' => sub {
    my ( $dsl, $pattern, @rest ) = @_;

    my $default_methods = [ 'get', 'post' ];

    # If the given pattern is an ArrayRef, we override the defaults
    # and pass these onto to DSL->any()
    if( ref($pattern) eq "ARRAY" ) {
        $default_methods = $pattern;
        $pattern = shift(@rest);
    }

    my $code;
    for my $e (@rest) { $code = $e if ( ref($e) eq 'CODE' ) }

    my $content_type = plugin_setting->{content_type} || 'text/xml';

    my $ajax_route = sub {

        # must be an XMLHttpRequest
        if ( not $dsl->request->is_ajax ) {
            $dsl->pass and return 0;
        }

        # Default response content type is either what's defined in the
        # plugin setting or text/xml
        $dsl->response->header('Content-Type')
          or $dsl->response->content_type( $content_type );

        # disable layout
        my $layout = $dsl->setting('layout');
        $dsl->setting( 'layout' => undef );
        my $response = $code->();
        $dsl->setting( 'layout' => $layout );
        return $response;
    };

    $dsl->any( $default_methods => $pattern, $ajax_route );
};

register_plugin;
1;

__END__

=pod

=head1 NAME

Dancer2::Plugin::Ajax - a plugin for adding Ajax route handlers

=head1 VERSION

version 0.149000_01

=head1 SYNOPSIS

    package MyWebApp;

    use Dancer2;
    use Dancer2::Plugin::Ajax;

    # For GET / POST
    ajax '/check_for_update' => sub {
        # ... some Ajax code
    };

    # For all valid HTTP methods
    ajax ['get', 'post', ... ] => '/check_for_more' => sub {
        # ... some Ajax code
    };

    dance;

=head1 DESCRIPTION

The C<ajax> keyword which is exported by this plugin allow you to define a route
handler optimized for Ajax queries.

The route handler code will be compiled to behave like the following:

=over 4

=item *

Pass if the request header X-Requested-With doesn't equal XMLHttpRequest

=item *

Disable the layout

=item *

The action built matches POST / GET requests by default. This can be extended by passing it an ArrayRef of allowed HTTP methods.

=back

=head1 CONFIGURATION

By default the plugin will use a content-type of 'text/xml' but this can be overridden
with plugin setting 'content_type'.

Here is example to use JSON:

  plugins:
    Ajax:
      content_type: 'application/json'

=head1 AUTHOR

Dancer Core Developers

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Alexis Sukrieh.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
