# ABSTRACT: Role for Serializer engines

package Dancer2::Core::Role::Serializer;
{
    $Dancer2::Core::Role::Serializer::VERSION = '0.07';
}
use Dancer2::Core::Types;

use Moo::Role;
with 'Dancer2::Core::Role::Engine';

sub supported_hooks {
    qw(
      engine.serializer.before
      engine.serializer.after
    );
}

sub _build_type {'Serializer'}


requires 'serialize';
requires 'deserialize';
requires 'loaded';

has error => (
    is        => 'rw',
    isa       => Str,
    predicate => 1,
);

around serialize => sub {
    my ( $orig, $self, @data ) = @_;
    $self->execute_hook( 'engine.serializer.before', @data );
    my $serialized = eval { $self->$orig(@data); };

    if ($@) {
        $self->error($@);
    }
    else {
        $self->execute_hook( 'engine.serializer.after', $serialized );
    }
    return $serialized;
};

around deserialize => sub {
    my ( $orig, $self, @data ) = @_;
    my $data = eval { $self->$orig(@data); };
    $self->error($@) if $@;
    return $data;
};

# attribute vs method?
sub content_type {'text/plain'}

# most serializer don't have to overload this one
sub support_content_type {
    my ( $self, $ct ) = @_;
    return unless $ct;

    my @toks = split ';', $ct;
    $ct = lc( $toks[0] );
    return $ct eq $self->content_type;
}

1;

__END__

=pod

=head1 NAME

Dancer2::Core::Role::Serializer - Role for Serializer engines

=head1 VERSION

version 0.07

=head1 REQUIREMENTS

Classes that consume that role must implement the following methods
C<serialize>, C<deserialize> and C<loaded>.

=head1 AUTHOR

Dancer Core Developers

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Alexis Sukrieh.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
