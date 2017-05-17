readCSV

# how many bytes each data type takes

var bitConversion = {
  "varchar": varcharConverter,
  "integer": 32,
  "datetime": 64
}



{
  title:          varchar(100),  # 100 bit
  movie_number:   integer,       # 32 bit
  number_tickets: integer,       # 32 bit
  show_time:      datetime       # 64 bit
}

total_length = 228


{ title, movie_number, number_tickets, show_time, \n }

{ "Inception",    3, 100,  "2016-10-01 10:00:00" }
{ "Danny Darko",  4, 100,  "2016-11-02 10:00:00" }
{ "Batman",       5, 100,  "2016-05-01 10:00:00" }
{ "The Notebook", 6, 100,  "2016-04-08 10:00:00" }
{ "Lion King",    7, 100,  "2016-03-01 10:00:00" }


function readSchema(schema) {
  var totalLength = 0
  var schemaHash = {}

  for(var key in schema){
   totalLength += schema[key];
  }
}










