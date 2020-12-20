#!/usr/bin/perl -w
if (-r '/dev/null') {
    print "a\n";
}
if (-r 'nonexistantfile') {
    print "b\n";
}
