use Mojo::Base -strict;

use Test::More tests => 1;
use Data::Dumper;
use GEvent::DB;

my $conf = require "./g_event-web.conf";

my $db = GEvent::DB->new($conf->{db});

my $center_lat = 11;
my $center_lng = 22;
my $radius = 10;
  
my @markers = $db->search_by_sql('SELECT address, detail, name, lat, lng, ( 3959 * acos( cos( radians(?) ) * cos( radians( lat ) ) * cos( radians( lng ) - radians(?) ) + sin( radians(?) ) * sin( radians( lat ) ) ) ) AS distance FROM markers HAVING distance < ? ORDER BY distance LIMIT 0 , 20',
  [ $center_lat, $center_lng, $center_lat, $radius],'markers');

for my $marker (@markers){
#    print Dumper ($marker);
    print $marker->lat;
    print "hoge";

}
  