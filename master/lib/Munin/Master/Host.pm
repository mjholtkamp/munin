package Munin::Master::Host;

use base qw(Munin::Master::Group);

# $Id$

use warnings;
use strict;

use Carp;

sub new {
    my ($class, $host_name, $group, $attributes) = @_;

    $attributes ||= {};

    my $self = {
        host_name => $host_name,
        group     => $group,

        port          => 4949,
        update        => 1,
        use_node_name => 1,
        
        %$attributes,
    };

    # "Address" is required but must be lazy about it.
    # die "Attribute 'address' is required for $host_name, config line $.\n" unless $self->{address};

    return bless $self, $class;
}


sub add_attributes_if_not_exists {
    my ($self, $attributes) = @_;

    %$self = (%$attributes, %$self);
}


sub get_canned_ds_config {
    my ($self, $service, $data_source) = @_;

    # XXX: Could this be done in some sane way?

    my %ds_config;
    my $svc_ds_prefix = "$service.$data_source.";

    for my $svc_ds_prop (keys %$self) {
        if (index($svc_ds_prop, $svc_ds_prefix) == 0) {
            my $prop = substr($svc_ds_prop, length($svc_ds_prefix));
            $ds_config{$prop} = $self->{$svc_ds_prop};
        }
    }

    return \%ds_config;
}

1;


__END__

=head1 NAME

Munin::Master::Host - Holds information on hosts we are interested in
collection data from. 

=head1 SYNOPSIS

FIX

=head1 DESCRIPTION

Note that a host and a node is not the same thing. FIX elaborate

=head1 METHODS

=over

=item B<new>

FIX

=item B<add_attributes_if_not_exists>

FIX

=back

