# ABSTRACT: class for handling file content rendering

package Dancer2::Handler::File;
{
  $Dancer2::Handler::File::VERSION = '0.03';
}
use Carp 'croak';
use Moo;
use HTTP::Date;
use Dancer2::FileUtils 'path', 'read_file_content';
use Dancer2::Core::MIME;
use Dancer2::Core::Types;
use File::Spec;

with 'Dancer2::Core::Role::Handler';
with 'Dancer2::Core::Role::StandardResponses';
with 'Dancer2::Core::Role::Hookable';

sub supported_hooks {
    qw(
      handler.file.before_render
      handler.file.after_render
    );
}

has mime => (
    is      => 'ro',
    isa     => InstanceOf ['Dancer2::Core::MIME'],
    default => sub { Dancer2::Core::MIME->new },
);

has encoding => (
    is      => 'ro',
    default => sub {'utf-8'},
);

has public_dir => (is => 'rw',);

has regexp => (
    is      => 'ro',
    default => sub {'/**'},
);

sub BUILD {
    my ($self) = @_;

    if (!defined $self->public_dir) {
        my $public =
             $self->app->config->{public}
          || $ENV{DANCER_PUBLIC}
          || path($self->app->location, 'public');

        $self->public_dir($public);
    }
}

sub register {
    my ($self, $app) = @_;

    # don't register the handler if no valid public dir
    return if !-d $self->public_dir;

    $app->add_route(
        method => $_,
        regexp => $self->regexp,
        code   => $self->code($app->prefix),
    ) for $self->methods;
}

sub methods { ('head', 'get') }

sub code {
    my ($self, $prefix) = @_;

    sub {
        my $ctx  = shift;
        my $path = $ctx->request->path_info;

        if ($path =~ /\0/) {
            return $self->response_400($ctx);
        }

        if ($prefix && $prefix ne '/') {
            $path =~ s/^\Q$prefix\E//;
        }

        my @tokens = File::Spec->splitdir(join '', (File::Spec->splitpath($path))[1,2]);
        if (grep $_ eq '..', @tokens) {
            return $self->response_403($ctx);
        }

        my $file_path = path($self->public_dir, @tokens);
        $self->execute_hook('handler.file.before_render', $file_path);

        if (!-f $file_path) {
            $ctx->response->has_passed(1);
            return;
        }

        if (!-r $file_path) {
            return $self->response_403($ctx);
        }

        my $content = read_file_content($file_path);
        my $content_type = $self->mime->for_file($file_path) || 'text/plain';

        if ($content_type =~ m!^text/!) {
            $content_type .= "; charset=" . ($self->encoding || "utf-8");
        }

        my @stat = stat $file_path;

        $ctx->response->header('Content-Type')
          or $ctx->response->header('Content-Type', $content_type);

        $ctx->response->header('Content-Length')
          or $ctx->response->header('Content-Length', $stat[7]);

        $ctx->response->header('Last-Modified')
          or $ctx->response->header('Last-Modified',
            HTTP::Date::time2str($stat[9]));

        $ctx->response->content($content);
        $self->execute_hook('handler.file.after_render', $ctx->response);
        return ($ctx->request->method eq 'GET') ? $content : '';
    };
}

1;

__END__
=pod

=head1 NAME

Dancer2::Handler::File - class for handling file content rendering

=head1 VERSION

version 0.03

=head1 AUTHOR

Dancer Core Developers

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Alexis Sukrieh.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

