#!/usr/bin/perl -w

##this script is used to search fgs genes covered by pacbio genes, if fgs genes located in transcript region of iso-seq, they will be the result, to compare woth gramene split gene models, not only based on exon overlap, but the based on transcipt region;

system "awk \'\{print \$1\,\"\\t\"\,\$4\}\' fgs_contained_by_pacbio \>fgs_contained_by_pacbio_temp";

open A,"fgs_contained_by_pacbio_temp"||die $!;
open T,">temp_fgs"||die $!;
while(<A>){
   chomp;
   @st=split(/\s+/,$_);
   @nd=split(/\./,$st[1]);
   $st[1]=join('.',$nd[0],$nd[1]);
   @thd=split(/\_/,$st[0]);
   $st[0]=$thd[0];
   $new_line=join("\t",$st[0],$st[1]);
   print T "$new_line\n";}

close A;
close T;

system "cat temp_fgs \| sort \| uniq \>fgs_genes_covered_by_pacbio_gene";
system "awk \'\{print \$2\}\' fgs_genes_covered_by_pacbio_gene \>id";

open B,"fgs_genes_covered_by_pacbio_gene"||die $!;
$all=join'',<B>;
@at=split(/\n/,$all);
close B;

open C,"id"||die $!;
open O,">fgs_genes_covered_by_pacbio_gene_final_out"||die $!;
while(<C>){
   chomp;
   print O "$_\t";
   $len1=length($_);
   foreach $line(@at){
     @sp=split(/\s+/,$line);
     $len2=length($sp[1]);
     if(($len1==$len2)&&($sp[1]=~/$_/)){
        print O "$sp[0]\t";}
   }
  print O "\n";}
close C;
close O;

open D,"fgs_genes_covered_by_pacbio_gene_final_out"||die $!;
open E,">more_than_two_fgsgenes_covered_by_pacbio_gene_final_out"||die $!;
while(<D>){
   chomp;
   @dd=split(/\s+/,$_);
   if(scalar(@dd)>2){
    $new=join("\t",@dd);
    print E "$new\n";}
  }
close D;
close E;

system "rm \-rf temp_fgs";
system "rm \-rf id"; 

