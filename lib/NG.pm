package NG;
use strict;
use warnings;

our $VERSION = '0.001';
use File::Basename qw(dirname);
push @INC, dirname(__FILE__);
use HTTP::Client;
use EMail;
use Object;
use Array;
use Hashtable;
use SHashtable;
use DB;
use Excel;
use File;
use Log;
use System;
use Time;

use base 'Exporter';
our @EXPORT = qw(
  local_run
  remote_run
  taskset

  web_get

  mail_send
  mail_get

  from_json
  from_yaml
  mkdir_p
  rm_r
  cp_r
  read_file
  read_dir
  file_stat

  process_log
  geo_ip

  db

  say
);

sub local_run   { System::local_run(@_) }
sub remote_run  { System::remote_run(@_) }
sub taskset     { System::taskset(@_) }
sub web_get     { HTTP::Client::web_get(@_) }
sub mail_send   { EMail::send(@_) }
sub mail_get    { EMail::get(@_) }
sub from_json   { File::from_json(@_) }
sub from_yaml   { File::from_yaml(@_) }
sub mkdir_p     { File::mkdir_p(@_) }
sub rm_r        { File::rm_r(@_) }
sub cp_r        { File::cp_r(@_) }
sub read_file   { File::read_file(@_) }
sub read_dir    { File::read_dir(@_) }
sub file_stat   { File::fstat(@_) }
sub process_log { Log::process_log(@_) }
sub geo_ip      { Log::geo_ip(@_) }
sub db          { DB->new(@_) }

sub import {
    my $class = shift;
    strict->import;
    warnings->import;
    utf8->import;
    feature->import(':5.10');
    $class->export_to_level(1, $class, @EXPORT);
}

1;
