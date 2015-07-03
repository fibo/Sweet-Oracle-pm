package Sweet::Oracle::Environment;
use latest;
use Moose;

use MooseX::AttributeShortcuts;
use MooseX::Types::Path::Class;

use namespace::autoclean;

has ORACLE_HOME => (
    is  => 'lazy',
    isa => 'Path::Class::Dir',
);

sub _build_ORACLE_HOME { $ENV{ORACLE_HOME} }

has ORACLE_SID => (
    is  => 'lazy',
    isa => 'Path::Class::Dir',
);

sub _build_ORACLE_SID { $ENV{ORACLE_SID} }

__PACKAGE__->meta->make_immutable;

__END__

=encoding utf8

=head1 NAME

Sweet::Oracle::Environment

=head1 ATTRIBUTES

=head2 ORACLE_HOME

=head2 ORACLE_SID

=cut

