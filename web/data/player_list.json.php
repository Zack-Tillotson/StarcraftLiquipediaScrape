<?php
$result = mysql_query("select name, race, country, win_count, loss_count from     (    select n.name, race, country, case when w.win_count then w.win_count else 0 end win_count, case when l.loss_count then l.loss_count else 0 end loss_count from     (select name, min(race) race from (            (             select name, min(race) race from (select trim(p1_name) name, p1_race race, count(*) cnt from games where p1_race != '' group by trim(p1_name), p1_race order by 3 desc) a      group by name, race            )       union (             select name, min(race) race from (select trim(p2_name) name, p2_race race, count(*) cnt from games where p2_race != '' group by trim(p2_name), p2_race order by 3 desc) a      group by name, race      )) z group by name     ) n left join (select p1_name, count(*) win_count from games group by p1_name) w on n.name like binary w.p1_name left join (select p2_name, count(*) loss_count from  games group by p2_name) l on n.name like l.p2_name left join    (select name, min(country) country from ((            select name, min(country) country from (select trim(p1_name) name, p1_country country, count(*) cnt from games where             p1_country != '' group by trim(p1_name), p1_country       order by 3 desc) a group by a.name, country            )      union (            select name, min(country) country from        (select trim(p2_name) name, p2_country country, count(*) cnt from games where p2_country != '' group by trim(p2_name), p2_country    order by 3 desc) a group by a.name, country)) a group by name     ) fl on fl.name = n.name  ) a order by win_count + loss_count") or die(mysql_error());

$rows = array();
while($row = mysql_fetch_array( $result )) {
  $rows[] = $row;
}
mysql_close();
print json_encode(array_reverse($rows));
?>
