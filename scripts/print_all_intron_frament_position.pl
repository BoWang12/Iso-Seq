#!/usr/bin/perl -w

##This scrip tis used to get every intron start position and stop position, to compare with short read intron to see if theya re consistent;
##usage:perl print_all_intron_frament.pl pacbio_intron_chain_each_transcript;

open A,"$ARGV[0]"||die $!;
#open T,">temp"||die $!;
while(<A>){
   if($_!~/This/){
   chomp;
   @tm=split(/\s+/,$_);
   $count=scalar(@tm);
   $pos=($count-2)/2;
   #$start=0;
   for(($i=2)&&($start=1);$i<=$count-2;($i=$i+2)&&($start++)){
      print  "$tm[0]\t$tm[$i]\t$tm[$i+1]\t$start\/$pos\n";}
  }
}
close A;
#close T;

#system "cat temp \| sort \| uniq \>uniq\_pacbio\_intron\_fragment\_tocompare\_shortreads\_verification";
