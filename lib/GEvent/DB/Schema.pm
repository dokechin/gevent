package GEvent::DB::Schema;
use Teng::Schema::Declare;
use DateTime::Format::MySQL;

table {
    name 'Markers';
    pk Id;
    columns qw( Id Name address detail Lat lng type create_at );

    inflate 'create_at' => sub {
        DateTime::Format::MySQL->parse_datetime(shift);
    };
    deflate 'create_at' => sub {
        DateTime::Format::MySQL->format_datetime(shift);
    };
};

1;
