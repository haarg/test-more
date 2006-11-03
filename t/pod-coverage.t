#!/usr/bin/perl -w

use Test::More;
eval "use Test::Pod::Coverage 1.00";
plan skip_all => "Test::Pod::Coverage 1.00 required for testing POD coverage" if $@;
eval "use Pod::Coverage::CountParents";
plan skip_all => "Pod::Coverage::CountParents required for testing POD coverage" if $@;

my @modules = all_modules();
plan tests => scalar @modules;

my %coverage_params = (
    "Test::Builder" => {
        also_private => [ qr/^(share|lock|BAILOUT)$/ ]
    },
    "Test::More" => {
        trustme => [ qr/^(skip|todo)$/ ]
    },
);

for my $module (@modules) {
    pod_coverage_ok( $module, { coverage_class => 'Pod::Coverage::CountParents',
                                %{$coverage_params{$module} || {}} }
                   );
}