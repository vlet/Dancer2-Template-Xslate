use strict;
use warnings;

use Test::More;
use FindBin qw($Bin);
use File::Spec;

BEGIN { use_ok('Dancer::Template::Xslate') }

subtest 'new' => sub {
    my $xs = Dancer::Template::Xslate->new();
    isa_ok $xs, 'Dancer::Template::Xslate';
    ok $xs->does('Dancer::Core::Role::Template'), "Role Template";
};

subtest 'render' => sub {
    my $xs = Dancer::Template::Xslate->new(
        views  => File::Spec->catfile( $Bin, 'views' ),
        layout => 'main.tt',
    );

    is $xs->process(
        'test.tt',
        {
            array =>
              [ { "key1" => 1, "key2" => 2 }, { "key1" => 3, "key2" => 4 } ]
        }
      ),
      "{{1-23-4\n}}\n", "checking render";
};

done_testing;
