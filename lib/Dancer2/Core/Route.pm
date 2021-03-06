package Dancer2::Core::Route;
# ABSTRACT: Dancer2's route handler
$Dancer2::Core::Route::VERSION = '0.158000';
use Moo;
use Dancer2::Core::Types;
use Carp 'croak';

has method => (
    is       => 'ro',
    isa      => Dancer2Method,
    required => 1,
);

has code => (
    is       => 'ro',
    required => 1,
    isa      => CodeRef,
);

has regexp => (
    is       => 'ro',
    required => 1,
);

has spec_route => ( is => 'ro' );

has prefix => (
    is        => 'ro',
    isa       => Maybe [Dancer2Prefix],
    predicate => 1,
);

has options => (
    is        => 'ro',
    isa       => HashRef,
    trigger   => \&_check_options,
    predicate => 1,
);

sub _check_options {
    my ( $self, $options ) = @_;
    return 1 unless defined $options;

    my @supported_options = (
        qw/content_type agent user_agent content_length
          path_info/
    );
    for my $opt ( keys %{$options} ) {
        croak "Not a valid option for route matching: `$opt'"
          if not( grep {/^$opt$/} @supported_options );
    }
    return 1;
}

# private attributes

has _should_capture => (
    is  => 'ro',
    isa => Bool,
);

has _match_data => (
    is      => 'rw',
    isa     => HashRef,
);

has _params => (
    is      => 'ro',
    isa     => ArrayRef,
    default => sub { [] },
);

sub match {
    my ( $self, $request ) = @_;

    if ( $self->has_options ) {
        return unless $self->validate_options($request);
    }

    my @values = $request->dispatch_path =~ $self->regexp;

    # if some named captures are found, return captures
    # no warnings is for perl < 5.10
    if (my %captures =
        do { no warnings; %+ }
      )
    {
        return $self->_match_data( { captures => \%captures } );
    }

    return unless @values;

    # regex comments are how we know if we captured a token,
    # splat or a megasplat
    my @token_or_splat = $self->regexp =~ /\(\?#([token|(?:mega)?splat]+)\)/g;
    if (@token_or_splat) {
        # our named tokens
        my @tokens = @{ $self->_params };

        my %params;
        my @splat;
        for ( my $i = 0; $i < @values; $i++ ) {
            # Is this value from a token?
            if ( $token_or_splat[$i] eq 'token' ) {
                $params{ shift @tokens } = $values[$i];
                 next;
            }

            # megasplat values are split on '/'
            if ($token_or_splat[$i] eq 'megasplat') {
                $values[$i] = [ split '/' => $values[$i] ];
            }
            push @splat, $values[$i];
        }
        return $self->_match_data( {
            %params,
            (splat => \@splat)x!! @splat,
        });
    }

    if ( $self->_should_capture ) {
        return $self->_match_data( { splat => \@values } );
    }

    return $self->_match_data( {} );
}

sub execute {
    my ( $self, @args ) = @_;
    return $self->code->(@args);
}

# private subs

sub BUILDARGS {
    my ( $class, %args ) = @_;

    my $prefix = $args{prefix};
    my $regexp = $args{regexp};

    # regexp must have a leading /
    if ( ref($regexp) ne 'Regexp' ) {
        index( $regexp, '/', 0 ) == 0
            or die "regexp must begin with /\n";
    }

    # init prefix
    if ( $prefix ) {
        $args{regexp} =
            ref($regexp) eq 'Regexp' ? qr{^\Q${prefix}\E${regexp}$} :
            $regexp eq '/'           ? qr{^\Q${prefix}\E/?$} :
            $prefix . $regexp;
    }

    # init regexp
    $regexp = $args{regexp}; # updated value
    $args{spec_route} = $regexp;

    if ( ref($regexp) eq 'Regexp') {
        $args{_should_capture} = 1;
    }
    else {
        @args{qw/ regexp _params _should_capture/} =
            @{ _build_regexp_from_string($regexp) };
    }

    return \%args;
}

sub _build_regexp_from_string {
    my ($string) = @_;

    my $capture = 0;
    my @params;

    # look for route with tokens [aka params] (/hello/:foo)
    if ( $string =~ /:/ ) {
        @params = $string =~ /:([^\/\.\?]+)/g;
        if (@params) {
            $string =~ s!(:[^\/\.\?]+)!(?#token)([^/]+)!g;
            $capture = 1;
        }
    }

    # parse megasplat
    # we use {0,} instead of '*' not to fall in the splat rule
    # same logic for [^\n] instead of '.'
    $capture = 1 if $string =~ s!\Q**\E!(?#megasplat)([^\n]+)!g;

    # parse wildcards
    $capture = 1 if $string =~ s!\*!(?#splat)([^/]+)!g;

    # escape dots
    $string =~ s/\./\\\./g if $string =~ /\./;

    # escape slashes
    $string =~ s/\//\\\//g;

    return [ "^$string\$", \@params, $capture ];
}

sub validate_options {
    my ( $self, $request ) = @_;

    while ( my ( $option, $value ) = each %{ $self->options } ) {
        return 0
          if ( not $request->$option ) || ( $request->$option !~ $value );
    }
    return 1;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dancer2::Core::Route - Dancer2's route handler

=head1 VERSION

version 0.158000

=head1 ATTRIBUTES

=head2 method

The HTTP method of the route (lowercase). Required.

=head2 code

The code reference to execute when the route is ran. Required.

=head2 regexp

The regular expression that defines the path of the route.
Required. Coerce from Dancer2's route I<patterns>.

=head2 prefix

The prefix to prepend to the C<regexp>. Optional.

=head2 options

A HashRef of conditions on which the matching will depend. Optional.

=head1 METHODS

=head2 match

Try to match the route with a given pair of method/path.
Returns the hash of matching data if success (captures and values of the route
against the path) or undef if not.

    my $match = $route->match( get => '/hello/sukria' );

=head2 execute

Runs the coderef of the route.

=head1 AUTHOR

Dancer Core Developers

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Alexis Sukrieh.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
