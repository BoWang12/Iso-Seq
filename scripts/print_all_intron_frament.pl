#!/usr/bin/perl -w

##This scrip tis used to get every intron start position and stop position, to compare with short read intron to see if theya re consistent;
##usage:perl print_all_intron_frament.pl pacbio_intron_chain_each_transcript;

open A,"$ARGV[0]"||die $!;
open T,">temp"||die $!;
while(<A>){
   if($_!~/This/){
   chomp;
   @tm=split(/\s+/,$_);
   $count=scalar(@tm);
   for($i=2;$i<=$count-2;$i=$i+2){
      print T "$tm[0]\t$tm[$i]\t$tm[$i+1]\n";}
  }
}
close A;
close T;

system "cat temp \| sort \| uniq \>uniq\_pacbio\_intron\_fragment\_tocompare\_shortreads\_verification";
