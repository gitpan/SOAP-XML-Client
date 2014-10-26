#!/usr/bin/perl -w

use strict;
use Data::Dumper;
use Carp;
use blib;
use Test::More tests => 5;
# use SOAP::Lite ( +trace => 'all', readable => 1, outputxml => 1, );

BEGIN { use_ok( 'SOAP::XML::Client::DotNet' ); }

# Create out object with basic SOAP::Lite config stuff
my $obj = SOAP::XML::Client::DotNet->new({
	uri => 'http://www.webserviceX.NET',
	proxy => 'http://www.webservicex.net/convertMetricWeight.asmx',
	xmlns => 'http://www.webserviceX.NET/',
	timeout => '2',
});

my $xml = "
<MetricWeightValue _value_type='double'>10.1</MetricWeightValue>
<fromMetricWeightUnit>kilogram</fromMetricWeightUnit>
<toMetricWeightUnit>microgram</toMetricWeightUnit>";

my $method = 'ChangeMetricWeightUnit';

my %xml_conf = (
	method => $method,
	xml => $xml,
	name => 'pass_in_xml',
);

fetch(\%xml_conf);

my %file_conf = (
	method => $method,
	filename => 't/dot_net.xml',
	name => 'xml_from_file',
);

fetch(\%file_conf);

sub fetch {
	my $conf = shift;
	# Call the SOAP
	if( $obj->fetch($conf) ) {
		ok(1, $conf->{name} . " fetch() - no errors");

		my $xml_res = $obj->results_xml();
		my $nodes = $xml_res->findnodes("//ChangeMetricWeightUnitResult");

		if(my $node = $nodes->get_node(1)) {
			my $value = $node->findvalue('.',$node);
			is('10100000000',$value,$conf->{name} . ' got conversion expected');
		} else {
			ok(0,$conf->{name} . ' could not get result from .Net data returned');
		}
	} else {
		ok(0,$conf->{name} . 'Could not fetch data');
		ok(0,$conf->{name} . 'Error:' . $obj->error());
	}
}
