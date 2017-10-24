#!/usr/bin/perl -w

open A,"$ARGV[0]"||die $!;
while(<A>){
   chomp;
   @tm=split(/\s+/,$_);
   $num=@tm;
   $exon_number=($num/2)-1;
   print "$tm[1]\t$exon_number\n";}
close A;


