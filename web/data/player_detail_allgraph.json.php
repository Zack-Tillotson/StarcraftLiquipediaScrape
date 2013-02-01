<?php
include_once '_graph_functions.php';
$id = filter_input(INPUT_GET, 'id', FILTER_SANITIZE_STRING);
$query = sprintf("(select a.month, a.race, a.win_cnt, b.loss_cnt loss_cnt from (select month(play_date) month, p2_race race, count(*) win_cnt from games where p1_name like binary '%s' group by p2_race, month(play_date) order by 1 asc, 2 asc) a left join (select month(play_date) month, p1_race race, count(*) loss_cnt from games where p2_name like binary '%s' group by p1_race, month(play_date) order by 1 asc, 2 asc) b on a.month = b.month and  a.race = b.race order by 2 asc, 1 asc) union (select a.month, a.race, a.win_cnt, b.loss_cnt loss_cnt from (select month(play_date) month, p2_race race, count(*) win_cnt from games where p1_name like binary '%s' group by p2_race,         month(play_date) order by 1 asc, 2 asc) a right join (select month(play_date) month, p1_race race, count(*) loss_cnt from games where p1_name like binary '%s' group by p2_race, month(play_date) order by 1 asc,  2 asc) b on a.month = b.month and  a.race = b.race order by 2 asc, 1 asc)", mysql_real_escape_string($id), mysql_real_escape_string($id), mysql_real_escape_string($id), mysql_real_escape_string($id));
$result = mysql_query($query) or die(mysql_error());
$data = array(
    "t" => array()
  , "p" => array()
  , "z" => array()
);
while($row = mysql_fetch_array( $result )) {
  $data[$row['race']][$row['month']] = array();
  $data[$row['race']][$row['month']]['win_cnt'] = $row['win_cnt'];
  $data[$row['race']][$row['month']]['loss_cnt'] = $row['loss_cnt'];
}
mysql_close();

print json_encode(array_reverse(fill_data($data)));
?>
