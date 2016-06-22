#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use Test::More;
use XML::LibXML::jQuery;


my $html = '<div class="container"><h2>Greetings</h2><div class="inner">Hello</div><div class="inner">Goodbye</div></div>';

is j($html)->find('.inner')->after('<p>Test</p>')->end->as_html,
    '<div class="container"><h2>Greetings</h2><div class="inner">Hello</div><p>Test</p><div class="inner">Goodbye</div><p>Test</p></div>', 'after - new content';


my $j = j($html);
is $j->find('.inner')->after($j->find('h2'))->end->as_html, '<div class="container"><div class="inner">Hello</div><h2>Greetings</h2><div class="inner">Goodbye</div><h2>Greetings</h2></div>', 'existing element';

# document
$j = j('<div/><div/><div/>');
j($j->get(2))->after('<span/>');
is $j->document->as_html, "<div></div><div></div><div></div><span></span>\n", 'on root node - node is last child';


# document
$j = j('<foo/><bar/><baz/>');
j($j->get(1))->after('<span/>');
is $j->document->as_html, "<foo></foo><bar></bar><span></span><baz></baz>\n", 'on root node - not last child';


# document
is j('<foo/><bar/><baz/>')->after('<span/>')->document->as_html, "<foo></foo><span></span><bar></bar><span></span><baz></baz><span></span>\n", 'on multiple root node';


done_testing;
