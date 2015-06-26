package Sweet::Oracle::Sqlldr;
use latest;
use Moose;

use MooseX::AttributeShortcuts;

use namespace::autoclean;

has bad_file => (
    is  => 'lazy',
    isa => 'Sweet::Oracle::Sqlldr::BadFile',
);

has control_file => (
    is  => 'lazy',
    isa => 'Sweet::Oracle::Sqlldr::ControlFile',
);

has data_file => (
    is  => 'lazy',
    isa => 'Sweet::Oracle::Sqlldr::DataFile',
);

has discard_file => (
    is  => 'lazy',
    isa => 'Sweet::Oracle::Sqlldr::DiscardFile',
);

has log_file => (
    is  => 'lazy',
    isa => 'Sweet::Oracle::Sqlldr::LogFile',
);

__PACKAGE__->meta->make_immutable;

__END__

=encoding utf8

=head1 NAME

Sweet::Oracle::Sqlldr

=head1 ATTRIBUTES

=head2 bad_file

=head2 control_file

=head2 data_file

=head2 discard_file

=head2 log_file

=cut

