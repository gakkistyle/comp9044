#!/usr/bin/perl -w
if (-d '/dev/null') {
    print "/dev/null\n";
}
if (-d '/dev') {
    print "/dev\n";
}
