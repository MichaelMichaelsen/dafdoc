#!/usr/bin/perl
#
# csv2yaml.pl - convert csv file to yaml for parameters
#
use strict;
binmode(STDOUT, ":utf8");

my $filename = "CPR_v3.2_2017.09.04_Bilag 2_Tjeneste_CprPersonFullComplete.csv";

open(CSV, $filename) or die "unable to open $filename";

my $header =<CSV>;
while (my $line=<CSV>) {
   chomp($line);
   
   my ($navn, $type, $beskrivelse, $default, $uuid, $overskriver, $kraever, $kreavet) = split(/;/,$line);
   my $format = $type;
   if ($type eq "Date") {
     $type = "string";
     $format = "date";
   }
   printf "\t- name: %s\n", $navn;
   printf "\t  type: %s\n", lc($type);
   printf "\t  format: %s\n", lc($format);
   printf "\t  in: query\n";
   printf "\t  description: |\n\t\t %s (%s)\n", $beskrivelse, $uuid;
}



