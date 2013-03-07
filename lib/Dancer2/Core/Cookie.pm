# ABSTRACT: A cookie representing class

package Dancer2::Core::Cookie;
{
  $Dancer2::Core::Cookie::VERSION = '0.03';
}
use Moo;
use URI::Escape;
use Dancer2::Core::Types;
use Dancer2::Core::Time;
use Carp 'croak';


sub to_header {
    my $self   = shift;
    my $header = '';

    my $value = join('&', map { uri_escape($_) } $self->value);
    my $no_httponly = defined($self->http_only) && $self->http_only == 0;

    my @headers = $self->name . '=' . $value;
    push @headers, "path=" . $self->path       if $self->path;
    push @headers, "expires=" . $self->expires if $self->expires;
    push @headers, "domain=" . $self->domain   if $self->domain;
    push @headers, "Secure"                    if $self->secure;
    push @headers, 'HttpOnly' unless $no_httponly;

    return join '; ', @headers;
}



has value => (
    is       => 'rw',
    isa      => ArrayRef,
    required => 0,
    coerce   => sub {
        my $value = shift;
        my @values =
            ref $value eq 'ARRAY' ? @$value
          : ref $value eq 'HASH'  ? %$value
          :                         ($value);
        return [@values];
    },
);

around value => sub {
    my $orig  = shift;
    my $self  = shift;
    my $array = $orig->($self, @_);
    return wantarray ? @$array : $array->[0];
};


has name => (
    is       => 'rw',
    isa      => Str,
    required => 1,
);



has expires => (
    is       => 'rw',
    isa      => Str,
    required => 0,
    coerce   => sub {
        Dancer2::Core::Time->new(expression => $_[0])->gmt_string;
    },
);



has domain => (
    is       => 'rw',
    isa      => Str,
    required => 0,
);


has path => (
    is        => 'rw',
    isa       => Str,
    default   => sub {'/'},
    predicate => 1,
);


has secure => (
    is       => 'rw',
    isa      => Bool,
    required => 0,
    default  => sub {0},
);


has http_only => (
    is       => 'rw',
    isa      => Bool,
    required => 0,
    default  => sub {0},
);

1;

__END__
=pod

=head1 NAME

Dancer2::Core::Cookie - A cookie representing class

=head1 VERSION

version 0.03

=head1 SYNOPSIS

    use Dancer2::Core::Cookie;

    my $cookie = Dancer2::Cookie->new(
        name => $cookie_name, value => $cookie_value
    );

=head1 DESCRIPTION

Dancer2::Cookie provides a HTTP cookie object to work with cookies.

=head1 ATTRIBUTES

=head2 value

The cookie's value.

=head2 name

The cookie's name.

=head2 expires

The cookie's expiration date.  There are several formats.

Unix epoch time like 1288817656 to mean "Wed, 03-Nov-2010 20:54:16 GMT"

It also supports a human readable offset from the current time such as "2 hours". 
See the documentation of L<Dancer2::Core::Time> for details of all supported
formats.

=head2 domain

The cookie's domain.

=head2 path

The cookie's path.

=head2 secure

If true, it instructs the client to only serve the cookie over secure
connections such as https.

=head2 http_only

By default, cookies are created with a property, named C<HttpOnly>,
that can be used for security, forcing the cookie to be used only by
the server (via HTTP) and not by any JavaScript code.

If your cookie is meant to be used by some JavaScript code, set this
attribute to 0.

=head1 METHODS

=head2 my $cookie=new Dancer2::Cookie (%opts);

Create a new Dancer2::Cookie object.

You can set any attribute described in the I<ATTRIBUTES> section above.

=head2 my $header=$cookie->to_header();

Creates a proper HTTP cookie header from the content.

=head1 AUTHOR

Dancer Core Developers

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Alexis Sukrieh.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

