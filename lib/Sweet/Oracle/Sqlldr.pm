package Sweet::Oracle::Sqlldr;
use latest;
use Moose;

use MooseX::AttributeShortcuts;
use Sweet::Oracle::Environment;
use Sweet::Oracle::Sqlldr::BadFile;
use Sweet::Oracle::Sqlldr::DiscardFile;
use Sweet::Oracle::Sqlldr::LogFile;

use namespace::autoclean;

has bad_file => (
    is  => 'lazy',
    isa => 'Sweet::Oracle::Sqlldr::BadFile',
);

sub _build_bad_file {
    my $self = shift;

    my $data_file = $self->data_file;

    my $name = $data_file->name_without_extension . '.bad';
    my $dir  = $data_file->dir;

    my $bad_file = Sweet::Oracle::Sqlldr::BadFile->new(
        name => $name,
        dir  => $dir,
    );

    return $bad_file;
}

has command => (
  is => 'lazy',
  isa => 'Str',
);

sub _build_command {
    my $self = shift;

    my $exe_path = 'sqlldr';    # TODO use File::Which and put it in an attribute.

    my $bad_file     = $self->bad_file;
    my $control_file = $self->control_file;
    my $data_file    = $self->data_file;
    my $discard_file = $self->discard_file;
    my $log_file     = $self->log_file;

    my $userid = $self->userid;

# FIXME credentials in command line are not ok, try to use some param file.
#       It is ok to let user build such a command, but, it should not be the default, it should be explicitly not recommended.
    my $command = "$exe_path $userid CONTROL=$control_file DATA=$data_file LOG=$log_file BAD=$bad_file DISCARD=$discard_file";

    return $command;
}

has serviceid => (
is => 'lazy',
isa=>'Str',
);

sub _build_serviceid { shift->env->ORACLE_SID }

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

sub _build_discard_file {
    my $self = shift;

    my $data_file = $self->data_file;

    my $name = $data_file->name_without_extension . '.dis';
    my $dir  = $data_file->dir;

    my $discard_file = Sweet::Oracle::Sqlldr::DiscardFile->new(
        name => $name,
        dir  => $dir,
    );

    return $discard_file;
}

has env => (
    is  => 'lazy',
    isa => 'Sweet::Oracle::Environment',
);

sub _build_env { Sweet::Oracle::Environment->new }

has log_file => (
    is  => 'lazy',
    isa => 'Sweet::Oracle::Sqlldr::LogFile',
);

sub _build_log_file {
    my $self = shift;

    my $data_file = $self->data_file;

    my $name = $data_file->name_without_extension . '.log';
    my $dir  = $data_file->dir;

    my $log_file = Sweet::Oracle::Sqlldr::LogFile->new(
        name => $name,
        dir  => $dir,
    );

    return $log_file;
}

has password => (
  is => 'lazy',
  isa => 'Str',
);

has userid => (
  is => 'lazy',
  isa => 'Str',
);

sub _build_userid {
    my $self = shift;

    my $username = $self->username;
    my $password = $self->password;
    my $serviceid = $self->serviceid;

    # Note that password is quoted to prevent unexpected behaviour with special characters.
    my $userid = "$username/" . '\"'.$password . '\"' . '@' . $serviceid;

    return $userid;
}

has username => (
  is => 'lazy',
  isa => 'Str',
);

sub run {
    my $self = shift;

    my $command = $self->command;
    my $env     = $self->env;

    my $ORACLE_HOME = $env->ORACLE_HOME;
    my $ORACLE_SID = $env->ORACLE_SID;

    $ENV{ORACLE_HOME} = $ORACLE_HOME;
    $ENV{ORACLE_SID} = $ORACLE_SID;

    # TODO use a more modern approach like IPC::Run or something better.

    my $status = system($command);

    if (($status >>= 8) != 0) {
        die $?;
    }
}

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

=head2 env

Instance of L<Sweet::Oracle::Environment>.

=head2 log_file

=head2 userid

=head2 password

=head2 serviceid

=head1 METHODS

=head2 run

=head1 PRIVATE METHODS

=head2 _build_bad_file

Defines default L<bad_file> path as the same as L<data_file> but with C<.bad> extension.

=head2 _build_command

=head2 _build_discard_file

Defines default L<discard_file> path as the same as L<data_file> but with C<.dis> extension.

=head2 _build_env

Defaults to a plain L<Sweet::Oracle::Environment>.

=head2 _build_log_file

Defines default L<log_file> path as the same as L<data_file> but with C<.log> extension.

=head2 _build_userid

=head2 _build_serviceid

=cut

