use strict;
use warnings;

use ExtUtils::MakeMaker 6.64;

WriteMakefile(
    ABSTRACT_FROM => 'lib/Sweet/Oracle.pm',
    VERSION_FROM  => 'lib/Sweet/Oracle.pm',
    AUTHOR        => 'G. Casati <fibo@cpan.org>',
    NAME          => 'Sweet::Oracle',
    LICENSE      => 'artistic_2',
    MIN_PERL_VERSION => '5.12.0',
    META_MERGE => {
        resources => {
            homepage   => 'https://metacpan.org/pod/Sweet::Oracle',
            license    => 'http://g14n.info/artistic-license',
            repository => 'https://github.com/fibo/Sweet-Oracle-pm',
            bugtracker => 'https://github.com/fibo/Sweet-Oracle-pm/issues'
        },
    },
    PREREQ_PM => {
        'latest'                      => '0.03',
        'Moose'                       => '2.1403',
        'MooseX::AttributeShortcuts', => '0.028',
        'namespace::autoclean'        => '0.24',
        'Sweet::Home'                 => '0.06',
    },
    # EXE_FILES => ['bin/foo', 'bin/bar'],
    BUILD_REQUIRES => {
        'ExtUtils::MakeMaker' => '6.64'
    },
    test => { TESTS => 't/*.t' },
    TEST_REQUIRES => {
        'Test::Compile'      => '1.2.1',
        'Test::More'         => '1.001009',
        'Test::Pod'          => '1.48'
    }
);

