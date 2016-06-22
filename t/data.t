#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use Test::More;
use XML::LibXML::jQuery;
use Data::Dumper;



my $j = j('<div><p data-role="page" data-last-value="42" data-hidden="true" data-options=\'{"foo":"bar"}\'></p></div>');


is $j->find('p')->data('foo', 420)->end, $j, 'data(key, val)';
is $j->find('p')->data('bar', { count => 40, some => 'thing' })->end, $j, 'data(key, obj)';
is $j->find('p')->data({ baz => [1, 2, 3] })->end, $j, 'data(obj)';;

is $j->find('p')->data('foo'), 420, 'data(key)';
is $j->find('p')->data('foo', undef), 420, 'data(key, undef)';

$j->find('p')->data('foo', 10);

is_deeply $j->find('p')->data(), {
    foo => 10,
    bar => { count => 40, some => 'thing' },
    baz => [1, 2, 3]
}, 'data()';


# data-*
is $j->find('p')->data('role'), 'page', 'data(key) - from data-role attribute';
is $j->find('p')->data('lastValue'), 42, 'data(key) - from data-last-value attribute (decamelize)';
is_deeply $j->find('p')->data('options'), { foo => 'bar' }, 'data(key) - from data-options attribute (JSON)';

is_deeply $j->find('p')->data(), {
    foo => 10,
    bar => { count => 40, some => 'thing' },
    baz => [1, 2, 3],
    options => { foo => 'bar' },
    role => 'page',
    lastValue => 42
}, 'data() now has values pulled from data-*';

#diag Dumper(XML::LibXML::jQuery->data);
undef $j;
is_deeply 'XML::LibXML::jQuery'->data, {}, 'data storage empty after document is destructed';


done_testing;
