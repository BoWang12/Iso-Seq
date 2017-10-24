#!/usr/bin/perl -w
#
open A,"$ARGV[0]"||die $!;
%fa=<A>;
foreach $id(keys%fa){
     $seq=$fa{$id};
     chomp($id);
     @tm=split(/\//,$id);
     $start=$tm[2]-40;
     chomp($seq);
     $subseq=substr($seq,$start,40);
     print "$subseq\n";}
close A;


