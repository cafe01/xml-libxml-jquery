#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use Test::More;
use XML::LibXML::jQuery;


my $html = '<div class="container"><div class="foo">Hello</div><div class="bar">Goodbye</div></div>';


my $j = j($html);

is $j->find('.foo')->add($j->find('.bar'))->as_html, '<div class="foo">Hello</div><div class="bar">Goodbye</div>';


done_testing;


