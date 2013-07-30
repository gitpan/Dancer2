# ABSTRACT: Role for DSL

package Dancer2::Core::Role::DSL;
{
    $Dancer2::Core::Role::DSL::VERSION = '0.06';
}
use Moo::Role;
use Dancer2::Core::Types;
use Carp 'croak';

with 'Dancer2::Core::Role::Hookable';

has app => ( is => 'ro', required => 1 );

has keywords => (
    is      => 'rw',
    isa     => ArrayRef,
    lazy    => 1,
    builder => '_build_dsl_keywords',
);

sub supported_hooks { }

sub _build_dsl_keywords {
    my ($self) = @_;
    $self->can('dsl_keywords')
      ? $self->dsl_keywords
      : [];
}

sub register {
    my ( $self, $keyword, $is_global ) = @_;

    grep {/^$keyword$/} @{ $self->keywords }
      and croak "Keyword '$keyword' is not available.";

    push @{ $self->keywords }, [ $keyword, $is_global ];
}

sub dsl { $_[0] }

sub dsl_keywords_as_list {
    map { $_->[0] } @{ shift->dsl_keywords() };
}

# exports new symbol to caller
sub export_symbols_to {
    my ( $self, $caller, $args ) = @_;
    my $exports = $self->_construct_export_map($args);

    foreach my $export ( keys %{$exports} ) {
        no strict 'refs';
        my $existing = *{"${caller}::${export}"}{CODE};

        next if defined $existing;

        *{"${caller}::${export}"} = $exports->{$export};
    }

    return keys %{$exports};
}

# private

sub _compile_keyword {
    my ( $self, $keyword, $is_global ) = @_;

    my $compiled_code = sub {
        core_debug( "["
              . $self->app->name
              . "] -> $keyword("
              . join( ', ', map { defined() ? $_ : '<undef>' } @_ )
              . ")" );
        $self->$keyword(@_);
    };

    if ( !$is_global ) {
        my $code = $compiled_code;
        $compiled_code = sub {
            croak "Function '$keyword' must be called from a route handler"
              unless defined $self->app->context;
            $code->(@_);
        };
    }

    return $compiled_code;
}

sub _construct_export_map {
    my ( $self, $args ) = @_;
    my %map;
    foreach my $keyword ( @{ $self->keywords } ) {
        my ( $keyword, $is_global ) = @{$keyword};

        # check if the keyword were excluded from importation
        $args->{ '!' . $keyword }
          and next;
        $map{$keyword} = $self->_compile_keyword( $keyword, $is_global );
    }
    return \%map;
}

# TODO move that elsewhere
sub core_debug {
    my $msg = shift;
    return unless $ENV{DANCER_DEBUG_CORE};

    chomp $msg;
    print STDERR "core: $msg\n";
}

1;

__END__

=pod

=head1 NAME

Dancer2::Core::Role::DSL - Role for DSL

=head1 VERSION

version 0.06

=head1 AUTHOR

Dancer Core Developers

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Alexis Sukrieh.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
