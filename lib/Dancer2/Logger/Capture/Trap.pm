package Dancer2::Logger::Capture::Trap;
# ABSTRACT: a place to store captured Dancer2 logs
$Dancer2::Logger::Capture::Trap::VERSION = '0.150000';
use Moo;
use Dancer2::Core::Types;

has storage => (
    is      => 'rw',
    isa     => ArrayRef,
    default => sub { [] },
);

sub store {
    my ( $self, $level, $message ) = @_;
    push @{ $self->storage }, { level => $level, message => $message };
}

sub read {
    my $self = shift;

    my $logs = $self->storage;
    $self->storage( [] );
    return $logs;
}

1;

__END__

=pod

=head1 NAME

Dancer2::Logger::Capture::Trap - a place to store captured Dancer2 logs

=head1 VERSION

version 0.150000

=head1 SYNOPSIS

    my $trap = Dancer2::Logger::Capture::Trap->new;
    $trap->store( $level, $message );
    my $logs = $trap->read;

=head1 DESCRIPTION

This is a place to store and retrieve capture Dancer2 logs used by
L<Dancer2::Logger::Capture>.

=head2 Methods

=head3 new

=head3 store

    $trap->store($level, $message);

Stores a log $message and its $level.

=head3 read

    my $logs = $trap->read;

Returns the logs stored as an array ref and clears the storage.

For example...

    [{ level => "warning", message => "Danger! Warning! Dancer2!" },
     { level => "error",   message => "You fail forever" }
    ];

=head1 SEE ALSO

L<Dancer2::Logger::Capture>

=head1 AUTHOR

Dancer Core Developers

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Alexis Sukrieh.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
