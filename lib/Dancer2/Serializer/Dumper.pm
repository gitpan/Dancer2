# ABSTRACT: Serializer for handling Dumper data

package Dancer2::Serializer::Dumper;
{
  $Dancer2::Serializer::Dumper::VERSION = '0.03';
}

use Moo;
use Carp 'croak';
use Data::Dumper;

with 'Dancer2::Core::Role::Serializer';



# helpers
sub from_dumper {
    my $s = Dancer2::Serializer::Dumper->new;
    $s->deserialize(@_);
}

sub to_dumper {
    my $s = Dancer2::Serializer::Dumper->new;
    $s->serialize(@_);
}

# class definition
sub loaded {1}


sub serialize {
    my ($self, $entity) = @_;

    {
        local $Data::Dumper::Purity = 1;
        return Dumper($entity);
    }
}


sub deserialize {
    my ($self, $content) = @_;

    my $res = eval "my \$VAR1; $content";
    croak "unable to deserialize : $@" if $@;
    return $res;
}


sub content_type {'text/x-data-dumper'}

1;


__END__
=pod

=head1 NAME

Dancer2::Serializer::Dumper - Serializer for handling Dumper data

=head1 VERSION

version 0.03

=head1 SYNOPSIS

=head1 DESCRIPTION

Turn Perl data structures into L<Data::Dumper> output and vice-versa.

=head1 METHODS

=head2 serialize

Serialize a Perl data structure into a Dumper string.

=head2 deserialize

Deserialize a Dumper string into a Perl data structure

=head2 content_type

Return 'text/x-data-dumper'

=head1 AUTHOR

Dancer Core Developers

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Alexis Sukrieh.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

