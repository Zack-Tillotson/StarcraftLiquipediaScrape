-- Update games' play_date from endpoints table
update games g inner join endpoints e on e.id = g.event_id set g.play_date = e.date;
-- Update the endpoints dates from csv
for LINE in `cat data/endpoint-dates.csv`; do echo $LINE; ID=`echo $LINE | awk -F',' '{print $1}'`; VAL=`echo $LINE | awk -F',' '{print $2}'`; mysql -h -u --password= -e "update endpoints set date = str_to_date('$VAL', '%Y-%m') where id = '$ID'"; done;
