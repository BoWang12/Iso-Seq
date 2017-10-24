#!/usr/bin/perl -w

##this script is used to see the correlation between isoforms number and intron number;
##usage: perl get_isoform_number_and_its_most_introns.pl intron_number_per_transcript;

system "cat intron_number_per_transcript \| cut \-d \'.\' \-f 1\,2 \| sort \| uniq \>pbgeneid_temp";

open A,"$ARGV[0]"||die $!;
$all=join'',<A>;
@sp=split(/\n/,$all);
close A;

open B,"pbgeneid_temp"||die $!;
open T,">pbtemp"||die $!;
while(<B>){
   chomp;
   print T "$_";
   $len1=length($_);
   foreach $line(@sp){
      @tm=split(/\t/,$line);
      $id=trim($tm[0]);
      $len2=length($id);
      if(($len1==$len2)&&($id=~/$_/)){
          print T "\t$tm[1]";}
     }
    print T "\n";
   }

close B;
close T;

open C,"pbtemp"||die $!;
open O,">isoforms_intron_correlation"||die $!;
$qq=join'',<C>;
@ww=split(/\n/,$qq);
foreach $ee(@ww){
    @sec=split(/\t/,$ee);
    print O "$sec[0]\t";
    shift(@sec);
    if(scalar@sec<2){
       print O "1"."\t"."$sec[0]\n";}
    elsif(scalar@sec>1){
      $isoforms_number=scalar(@sec);
      $start=$sec[0];
         shift(@sec);
         foreach $num(@sec){
          if($start<$num){
            $start=$num;}
          elsif($start>$num){
            next;}
     }
        print O "$isoforms_number\t$start\n";} 
}

close C;
close O;

sub trim {
    my $aa=shift;
    my @bb=split(/\./,$aa);
    my $new=join('.',$bb[0],$bb[1]);
    return $new;
 }
