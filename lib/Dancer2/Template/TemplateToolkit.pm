# ABSTRACT: Template toolkit engine for Dancer2

package Dancer2::Template::TemplateToolkit;
$Dancer2::Template::TemplateToolkit::VERSION = '0.156001';
use strict;
use warnings;
use Carp qw/croak/;
use Moo;
use Dancer2::Core::Types;
use Template;

with 'Dancer2::Core::Role::Template';

has '+engine' => ( isa => InstanceOf ['Template'], );

sub _build_engine {
    my $self      = shift;
    my $charset   = $self->charset;
    my %tt_config = (
        ANYCASE  => 1,
        ABSOLUTE => 1,
        length($charset) ? ( ENCODING => $charset ) : (),
        %{ $self->config },
    );

    my $start_tag = $self->config->{'start_tag'};
    my $stop_tag = $self->config->{'stop_tag'} || $self->config->{end_tag};
    $tt_config{'START_TAG'} = $start_tag
      if defined $start_tag && $start_tag ne '[%';
    $tt_config{'END_TAG'} = $stop_tag
      if defined $stop_tag && $stop_tag ne '%]';

    $tt_config{'INCLUDE_PATH'} ||= $self->views;

    return Template->new(%tt_config);
}

sub render {
    my ( $self, $template, $tokens ) = @_;

    ( ref $template || -f $template )
      or croak "$template is not a regular file or reference";

    my $content = "";
    my $charset = $self->charset;
    my @options = length($charset) ? ( binmode => ":encoding($charset)" ) : ();
    $self->engine->process( $template, $tokens, \$content, @options )
      or croak $self->engine->error;
    return $content;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dancer2::Template::TemplateToolkit - Template toolkit engine for Dancer2

=head1 VERSION

version 0.156001

=head1 SYNOPSIS

To use this engine, you may configure L<Dancer2> via C<config.yaml>:

    template:   "template_toolkit"

Or you may also change the rendering engine on a per-route basis by
setting it manually with C<set>:

    # code code code
    set template => 'template_toolkit';

=head1 DESCRIPTION

This template engine allows you to use L<Template::Toolkit> in L<Dancer2>.

=head1 METHODS

=head2 render($template, \%tokens)

Renders the template.  The first arg is a filename for the template file
or a reference to a string that contains the template.  The second arg
is a hashref for the tokens that you wish to pass to
L<Template::Toolkit> for rendering.

=head1 SEE ALSO

L<Dancer2>, L<Dancer2::Core::Role::Template>, L<Template::Toolkit>.

=head1 AUTHOR

Dancer Core Developers

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Alexis Sukrieh.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
