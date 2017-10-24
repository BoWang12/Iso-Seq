#!/usr/bin/perl -w

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

