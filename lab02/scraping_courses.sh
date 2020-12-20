#!/bin/bash

Code=$1
curl --silent "http://legacy.handbook.unsw.edu.au/vbook2018/brCoursesByAtoZ.jsp?StudyLevel=Undergraduate&descr=ALL" "http://legacy.handbook.unsw.edu.au/vbook2018/brCoursesByAtoZ.jsp?StudyLevel=Postgraduate&descr=ALL"|egrep "/$Code"|sed 's/^.*2018\///g'|sed 's/\.html">/ /g'|sed 's/<.*$//g'|sed 's/ $//g'|sort|uniq