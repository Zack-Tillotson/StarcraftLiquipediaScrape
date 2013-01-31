<?php
include_once '_mysql_connect.php'
$result = mysql_query("select a.month, a.race, a.win_cnt, a.win_cnt + b.loss_cnt tot_cnt from (select month(play_date) month, p1_race race, count(*) win_cnt from games where p1_race != p2_race and p1_race not in ('', 'r') group by p1_race, month(play_date) order by 1 asc, 2 asc) a, (select month(play_date) month, p2_race race, count(*) loss_cnt from games where p1_race != p2_race and p2_race not in ('', 'r') group by p2_race, month(play_date) order by 1 asc, 2 asc) b where a.month = b.month and  a.race = b.race order by 2 asc, 1 asc") or die(mysql_error());

$data = array(
    "t" => array()
  , "p" => array()
  , "z" => array()
);
while($row = mysql_fetch_array( $result )) {
  $data[$row['race']][$row['month']] = array();
  $data[$row['race']][$row['month']]['win_cnt'] = $row['win_cnt'];
  $data[$row['race']][$row['month']]['tot_cnt'] = $row['tot_cnt'];
  $data[$row['race']][$row['month']]['months'] = 1;
}

foreach(array('z', 't', 'p') as $race) {
  for($i = 1; $i<= 12; $i++) {
    if($i > 1) {
      $data[$race][$i]['win_cnt'] += $data[$race][$i-1]['win_cnt'];
      $data[$race][$i]['tot_cnt'] += $data[$race][$i-1]['tot_cnt'];
      $data[$race][$i]['months']++;
    }
    if($i < 12) {
      $data[$race][$i]['win_cnt'] += $data[$race][$i+1]['win_cnt'];
      $data[$race][$i]['tot_cnt'] += $data[$race][$i+1]['tot_cnt'];
      $data[$race][$i]['months']++;
    }
    $data[$race][$i]['win_cnt'] /= $data[$race][$i]['months'];
    $data[$race][$i]['tot_cnt'] /= $data[$race][$i]['months'];
  }
}

foreach(array('z', 't', 'p') as $race) {
  $vals = array();
  for($i = 1; $i<= 12; $i++) {
    $vals[] = intval(10000 * $data[$race][$i]['win_cnt'] / $data[$race][$i]['tot_cnt']) / 100.;
  }
  $data[$race] = $vals;
}
    
print json_encode(array_reverse($data));
?>
