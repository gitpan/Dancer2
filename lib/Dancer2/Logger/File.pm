# ABSTRACT: file-based logging engine for Dancer2

package Dancer2::Logger::File;
{
  $Dancer2::Logger::File::VERSION = '0.02';
}
use Carp 'carp';
use Moo;
use Dancer2::Core::Types;

with 'Dancer2::Core::Role::Logger';

use File::Spec;
use Dancer2::FileUtils qw(open_file);
use IO::File;


has log_dir => (
    is      => 'rw',
    isa     => Str,
    trigger => sub {
        my ($self, $dir) = @_;
        if (!-d $dir && !mkdir $dir) {
            return carp
              "Log directory \"$dir\" does not exist and unable to create it.";
        }
        return carp "Log directory \"$dir\" is not writable." if !-w $dir;
    },
    builder => '_build_log_dir',
    lazy    => 1,
);

sub _build_log_dir {
    my ($self) = @_;
    return $self->config->{logdir}
      || File::Spec->catdir($self->location, 'logs');
}

has file_name => (
    is      => 'ro',
    isa     => Str,
    builder => '_build_file_name',
    lazy    => 1
);

sub _build_file_name {
    my ($self) = @_;
    my $env = $self->environment;
    return "$env.log";
}

has log_file => (is => 'rw', isa => Str);
has fh => (is => 'rw');

sub BUILD {
    my $self = shift;
    my $logfile = File::Spec->catfile($self->log_dir, $self->file_name);

    my $fh;
    unless ($fh = open_file('>>', $logfile)) {
        carp "unable to create or append to $logfile";
        return;
    }
    $fh->autoflush;
    $self->log_file($logfile);
    $self->fh($fh);
}



sub log {
    my ($self, $level, $message) = @_;
    my $fh = $self->fh;

    return unless (ref $fh && $fh->opened);

    $fh->print($self->format_message($level => $message))
      or carp "writing to logfile $self->{logfile} failed";
}

1;

__END__
=pod

=head1 NAME

Dancer2::Logger::File - file-based logging engine for Dancer2

=head1 VERSION

version 0.02

=head1 DESCRIPTION

This is a logging engine that allows you to save your logs to files on disk.

=head1 METHODS

=head2 init

This method is called when C<< ->new() >> is called. It initializes the log
directory, creates if it doesn't already exist and opens the designated log
file.

=head2 logdir

Returns the log directory, decided by "logs" either in "appdir" setting.
It's also possible to specify a logs directory with the log_path option.

  setting log_path => $dir;

=head2 log

Writes the log message to the file.

=head1 AUTHOR

Dancer Core Developers

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Alexis Sukrieh.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

