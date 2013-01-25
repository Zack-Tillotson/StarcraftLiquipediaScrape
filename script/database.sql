-- Update games' play_date from endpoints table
update games g inner join endpoints e on e.id = g.event_id set g.play_date = e.date;
-- Update the endpoints dates from csv
for LINE in `cat data/endpoint-dates.csv`; do echo $LINE; ID=`echo $LINE | awk -F',' '{print $1}'`; VAL=`echo $LINE | awk -F',' '{print $2}'`; mysql -h -u --password= -e "update endpoints set date = str_to_date('$VAL', '%Y-%m') where id = '$ID'"; done;

-- Get the win and loss count for each month for each race
select a.month, a.race, a.win_cnt, b.loss_cnt from (select month(play_date) month, p1_race race, count(*) win_cnt from games where p1_race not in ("", "r") group by p1_race, month(play_date) order by 1 asc, 2 asc) a, (select month(play_date) month, p2_race race, count(*) loss_cnt from games where p2_race not in ("", "r") group by p2_race, month(play_date) order by 1 asc, 2 asc) b where a.month = b.month and a.race = b.race order by 1 asc, 2 asc;

-- Get the win count, loss count, and win percent for each month for each race for koreans only
select a.month, a.race, a.win_cnt, b.loss_cnt, a.win_cnt / (a.win_cnt + b.loss_cnt) win_percent from (select month(play_date) month, p1_race race, count(*) win_cnt from games where p1_country = 'kr' and p1_race not in ("", "r") group by p1_race, month(play_date) order by 1 asc, 2 asc) a, (select month(play_date) month, p2_race race, count(*) loss_cnt from games where p2_country = 'kr' and p2_race not in ("", "r") group by p2_race, month(play_date) order by 1 asc, 2 asc) b where a.month = b.month and a.race = b.race order by 2 asc, 1 asc;

-- Get the games that a single player has played in
select a.play_date, case when lower(p1_name) = 'idra' then p2_name else p1_name end opp_name, case when lower(p1_name) = 'idra' then 1 else 0 end win from (select p1_name, p1_race, p2_name, p2_race, play_date, event_id from games where 'idra' in (lower(p1_name), lower(p2_name))) a;

-- Get the number of wins and total games played by opponent race by month for a single player 
elect month(a.play_date), case when lower(p1_name) = 'idra' then p2_race else p1_race end opp_race, sum(case when lower(p1_name) = 'idra' then 1 else 0 end) win_count, count(*) game_count from (select p1_name, p1_race, p2_name, p2_race, play_date, event_id from games where 'idra' in (lower(p1_name), lower(p2_name))) a group by month(a.play_date), case when lower(p1_name) = 'idra' then p2_race else p1_race end;

-- Get the win count, loss count, and win percent for each month for each race for foreigers beating koreans only
select a.month, a.race, a.win_cnt, b.loss_cnt, 10000 * a.win_cnt div (a.win_cnt + b.loss_cnt) / 100 win_percent from (select month(play_date) month, p1_race      race, count(*) win_cnt from games where p1_country != 'kr' and p1_race not in ('', 'r') and p2_country = 'kr' and p2_race not in ('', 'r') group by p1_race, month(play_date) order by   1 asc, 2 asc) a, (select month(play_date) month, p2_race race, count(*) loss_cnt from games where p2_country != 'kr' and p2_race not in ('', 'r') and p1_country = 'kr' and p1_race not  in ('', 'r') group by p2_race, month(play_date) order by 1 asc, 2 asc) b where a.month = b.month and a.race = b.race order by 2 asc, 1 asc
