#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use Test::More;
use XML::LibXML::jQuery;




my $html = '<div class="container"><div class="first">Hello</div><div class="second">Goodbye</div></div>';

is j($html)->find('.first')->attr('class'), 'first', 'attr(name)';

is j($html)->find('div')->attr('class', 'ok')->as_html, '<div class="ok">Hello</div><div class="ok">Goodbye</div>', 'attr(name, value)';

is j($html)->find('div')->attr({ class => 'ok', foo => 'bar' })->as_html, '<div class="ok" foo="bar">Hello</div><div class="ok" foo="bar">Goodbye</div>', 'attr(attributes)';


is j($html)->find('div')->attr('class', sub {
    my ($i, $oldval) = @_;
    return unless $i;
    "$oldval-$i";
})->as_html, '<div class="first">Hello</div><div class="second-1">Goodbye</div>', 'attr(name, function)';

is j($html)->document->attr('foo', 'bar')->size, 1, 'set skips non-element node';
is j($html)->document->attr('foo'), undef, 'get on non-element node';


done_testing;

