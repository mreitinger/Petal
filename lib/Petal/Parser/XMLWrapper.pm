=head1 NAME

Petal::Parser::XMLWrapper

=head1 DESCRIPTION

A Wrapper class for XML::Parser that is meant to be used
with XML::Template::Pal::Canonicalizer.

=cut
package Petal::Parser::XMLWrapper;
use strict;
use warnings;

use Petal::Canonicalizer::XML;
use Petal::Canonicalizer::XHTML;
use XML::Parser;

use vars qw /$Canonicalizer/;


sub new
{
    my $class = shift;
    $class = ref $class || $class;
    return bless { @_ }, $class;
}


sub process
{
    my $self = shift;
    local $Canonicalizer = shift;
    
    my $data_ref = shift;
    $data_ref = (ref $data_ref) ? $data_ref : \$data_ref;
    
    my $parser = new XML::Parser (
	Style    => 'Stream',
	Pkg      => ref $self,
       );
    
    $parser->parse ($$data_ref);
}


sub StartTag      { $Canonicalizer->StartTag() }
sub EndTag        { $Canonicalizer->EndTag()   }
sub Text
{
    s/\&/\&amp;/g;
    s/\</\&lt\;/g;
    s/\>/\&gt\;/g;
    s/\"/\&quot\;/g;
    $Canonicalizer->Text();
}


1;


__END__
