<?php
include_once '_graph_functions.php';
$result = mysql_query("select a.month, a.race, a.win_cnt, a.win_cnt + b.loss_cnt tot_cnt from (select month(play_date) month, p1_race race, count(*) win_cnt from games where  p1_country != 'kr' and p2_country = 'kr' and p1_race != p2_race and p1_race in ('z', 't', 'p') and p2_race in ('z', 't', 'p') group by p1_race, month(play_date) order by 1 asc, 2 asc) a, (select month(play_date) month, p2_race race, count(*) loss_cnt from games where p1_country = 'kr' and p2_country != 'kr' and p1_race != p2_race and p1_race in ('z', 't', 'p') and p2_race in ('z', 't', 'p') group by p2_race, month(play_date) order by 1 asc, 2 asc) b where a.month = b.month and  a.race = b.race order by 2 asc, 1 asc") or die(mysql_error());

$data = array(
    "t" => array()
  , "p" => array()
  , "z" => array()
);
while($row = mysql_fetch_array( $result )) {
  $data[$row['race']][$row['month']] = array();
  $data[$row['race']][$row['month']]['win_cnt'] = $row['win_cnt'];
  $data[$row['race']][$row['month']]['tot_cnt'] = $row['tot_cnt'];
}
mysql_close();

print json_encode(array_reverse(smooth_data($data)));
?>
