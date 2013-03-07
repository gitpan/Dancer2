# ABSTRACT: Class for handling the AutoPage feature

package Dancer2::Handler::AutoPage;
{
  $Dancer2::Handler::AutoPage::VERSION = '0.03';
}
use Moo;
use Carp 'croak';
use Dancer2::Core::Types;

with 'Dancer2::Core::Role::Handler';
with 'Dancer2::Core::Role::StandardResponses';

sub register {
    my ($self, $app) = @_;

    return unless $app->config->{auto_page};

    $app->add_route(
        method => $_,
        regexp => $self->regexp,
        code   => $self->code,
    ) for $self->methods;
}

sub code {
    sub {
        my $ctx = shift;

        my $template = $ctx->app->config->{template};
        if (!defined $template) {
            $ctx->response->has_passed(1);
            return;
        }

        my $page      = $ctx->request->params->{'page'};
        my $view_path = $template->view($page);
        if (!-f $view_path) {
            $ctx->response->has_passed(1);
            return;
        }

        my $ct = $template->process($page);
        $ctx->response->header('Content-Length', length($ct));
        return ($ctx->request->method eq 'GET') ? $ct : '';
    };
}

sub regexp {'/:page'}

sub methods {qw(head get)}

1;

__END__
=pod

=head1 NAME

Dancer2::Handler::AutoPage - Class for handling the AutoPage feature

=head1 VERSION

version 0.03

=head1 AUTHOR

Dancer Core Developers

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Alexis Sukrieh.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

