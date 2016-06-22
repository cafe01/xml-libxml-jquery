#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use Test::More;
use XML::LibXML::jQuery;



my $html = '<div class="container"><h2>Greetings</h2><div class="inner">Hello</div><div class="inner">Goodbye</div></div>';

is j($html)->find('.inner')->before('<p>Test</p>')->end->as_html,
    '<div class="container"><h2>Greetings</h2><p>Test</p><div class="inner">Hello</div><p>Test</p><div class="inner">Goodbye</div></div>', 'after';

my $j = j($html);
is $j->find('.inner')->before($j->find('h2'))->end->as_html, '<div class="container"><h2>Greetings</h2><div class="inner">Hello</div><h2>Greetings</h2><div class="inner">Goodbye</div></div>', 'existing element';

# document
$j = j('<div/><div/><div/>');
j($j->get(0))->before('<span/>');
is $j->document->as_html, "<span></span><div></div><div></div><div></div>\n", 'on root node - node is first child';

# document
$j = j('<foo/><bar/><baz/>');
j($j->get(1))->before('<span/>');
is $j->document->as_html, "<foo></foo><span></span><bar></bar><baz></baz>\n", 'on root node - not first child';

# document
is j('<foo/><bar/><baz/>')->before('<span/>')->document->as_html, "<span></span><foo></foo><span></span><bar></bar><span></span><baz></baz>\n", 'on multiple root node';

done_testing;
