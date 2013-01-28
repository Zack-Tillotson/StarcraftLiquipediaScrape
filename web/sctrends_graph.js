<?php
    var chart1;
$renderTo = $_GET['container'];
$title = $_GET['title'];
$graph_id = $_GET['graph_id'];
$query = null;
if($graph_id == "NonKRvsKR") {
  $query = "select a.month, a.race, a.win_cnt, b.loss_cnt, 10000 * a.win_cnt div (a.win_cnt + b.loss_cnt) / 100 win_percent from (select (month(play_date)-1) month, p1_race      race, count(*) win_cnt from games where p1_country != 'kr' and p1_race not in ('', 'r') and p2_country = 'kr' and p2_race not in ('', 'r') and p1_race != p2_race group by p1_race,      (month(play_date)-1) order by 1 asc, 2 asc) a, (select (month(play_date)-1) month, p2_race race, count(*) loss_cnt from games where p2_country != 'kr' and p2_race not in ('', 'r') and p1_country = 'kr' and p1_race not in ('', 'r') and p1_race != p2_race group by p2_race, (month(play_date)-1) order by 1 asc, 2 asc) b where a.month = b.month and a.race = b.race order by   2 asc, 1 asc";
} elseif($graph_id == "KRvsKR") {
  $query = "select a.month, a.race, a.win_cnt, b.loss_cnt, 10000 * a.win_cnt div (a.win_cnt + b.loss_cnt) / 100 win_percent from (select (month(play_date)-1) month, p1_race      race, count(*) win_cnt from games where p1_country = 'kr' and p1_race not in ('', 'r') and p2_country = 'kr' and p2_race not in ('', 'r') and p1_race != p2_race group by p1_race,      (month(play_date)-1) order by 1 asc, 2 asc) a, (select (month(play_date)-1) month, p2_race race, count(*) loss_cnt from games where p2_country = 'kr' and p2_race not in ('', 'r') and          p1_country = 'kr' and p1_race not in ('', 'r') and p1_race != p2_race group by p2_race, (month(play_date)-1) order by 1 asc, 2 asc) b where a.month = b.month and a.race = b.race order by   2 asc, 1 asc";
} elseif($graph_id == "All") {
  $query = "select a.month, a.race, a.win_cnt, b.loss_cnt, 10000 * a.win_cnt div (a.win_cnt + b.loss_cnt) / 100 win_percent from (select month(play_date)-1 month, p1_race      race, count(*) win_cnt from games where p1_race != p2_race and p1_race not in ('', 'r') group by p1_race, month(play_date)-1 order by 1 asc, 2 asc) a, (select month(play_date)-1 month,      p2_race race, count(*) loss_cnt from games where p1_race != p2_race and p2_race not in ('', 'r') group by p2_race, month(play_date)-1 order by 1 asc, 2 asc) b where a.month = b.month and  a.race = b.race order by 2 asc, 1 asc";
}
$result = mysql_query($query) or die(mysql_error());

$win_cs = array("z" => array(), "t" => array(), "z" => array());
$tot_cs = array("z" => array(), "t" => array(), "z" => array());
$percents = array("z" => array(), "t" => array(), "z" => array());
while($row = mysql_fetch_array( $result )) {
  $percents[$row['race']][$row['month']] = $row['win_percent'];
  $win_cs[$row['race']][$row['month']] = $row['win_cnt'];
  $tot_cs[$row['race']][$row['month']] = $row['win_cnt'] + $row['loss_cnt'];
}

foreach(array('z', 'p', 't') as $race) {
  $sw = array();
  $st = array();
  for($i = 0; $i <= 11; $i++) {
    $sw[$race][$i] = $win_cs[$race][$i];
    $st[$race][$i] = $tot_cs[$race][$i];
    if($i == 0) { 
      $sw[$race][$i] += $sw[$race][$i+1]; 
      $st[$race][$i] += $st[$race][$i+1]; 
    } elseif($i == 11) { 
      $sw[$race][$i] += $sw[$race][$i-1]; 
      $st[$race][$i] += $st[$race][$i-1]; 
    } else {
      $sw[$race][$i] += $sw[$race][$i+1]; 
      $st[$race][$i] += $st[$race][$i+1]; 
      $sw[$race][$i] += $sw[$race][$i-1]; 
      $st[$race][$i] += $st[$race][$i-1]; 
    }
    $sw[$race][$i] = $sw[$race][$i] / (($i == 0 || $i == 11) ? 2 : 3); 
    $st[$race][$i] = $st[$race][$i] / (($i == 0 || $i == 11) ? 2 : 3); 
  }
  for($i = 0; $i <= 11; $i++) {
    $percents[$race][$i] = 100.*$sw[$race][$i] / $st[$race][$i];
  }
}

?>
chart1 = new Highcharts.Chart({
    chart: {
        renderTo: '<?php print $renderTo; ?>',
        type: 'line',
        marginRight: 50,
        marginLeft: 50,
        marginBottom: 25,
        marginTop: 25
    },
    title: {
        text: '<?php print $title; ?>', 
        x: -20 //center
    },
    subtitle: {
        text: '3 Month Moving Average, Source: <a href="//wiki.teamliquid.net/starcraft2/">Liquipedia, 2012 Premier Tournaments</a>',
        x: -20
    },
    xAxis: {
        categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    },
    yAxis: {
        title: {
            text: 'Wins (%)'
        },
        plotLines: [{
            value: 0,
            width: 1,
            color: '#808080'
        }],
        tickInterval: 10,
        min: 20,
        max: 60
    },
    tooltip: {
        formatter: function() {
                return '<b>'+ this.series.name +'</b><br/>'+
                this.x +': '+ this.y +'%';
        }
    },
    legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'top',
        x: -10,
        y: 100,
        borderWidth: 0
    },
    series: [{
        name: 'Zerg',
        data: [<?php for($i = 1; $i <= 12; $i++) { print $percents['z']["$i"] . ($i == 12 ? "" : ","); } ?>]
    }, {
        name: 'Terran',
        data: [<?php for($i = 1; $i <= 12; $i++) { print $percents['t']["$i"] . ($i == 12 ? "" : ","); } ?>]
    }, {
        name: 'Protoss',
        data: [<?php for($i = 1; $i <= 12; $i++) { print $percents['p']["$i"] . ($i == 12 ? "" : ","); } ?>]
    }]
});
