#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use Test::More;
use XML::LibXML::jQuery;


my $html = '<div class="container"><h2>Greetings</h2><div class="inner">Hello</div><div class="inner">Goodbye</div></div>';

my $j = j($html);

j('<p>Test</p>')->insert_before($j->find('.inner'));

is $j->as_html,
    '<div class="container"><h2>Greetings</h2><p>Test</p><div class="inner">Hello</div><p>Test</p><div class="inner">Goodbye</div></div>', 'new content';

$j = j($html);
is $j->find('h2')->insert_before($j->find('.inner'))->end->as_html, '<div class="container"><h2>Greetings</h2><div class="inner">Hello</div><h2>Greetings</h2><div class="inner">Goodbye</div></div>', 'existing element';


done_testing;
