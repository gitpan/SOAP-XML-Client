
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Simple frame work for talking with web services",
  "AUTHOR" => "Leo Lapworth",
  "BUILD_REQUIRES" => {
    "Data::Dumper" => 0,
    "Test::More" => 0,
    "warnings" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "SOAP-XML-Client",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "SOAP::XML::Client",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Class::Accessor::Fast" => 0,
    "Encode" => 0,
    "File::Slurp" => 0,
    "SOAP::Data::Builder" => "0.8",
    "SOAP::Lite" => "0.67",
    "XML::LibXML" => "0.6",
    "base" => 0,
    "strict" => 0,
    "vars" => 0
  },
  "VERSION" => "2.6",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



