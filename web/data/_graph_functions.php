<?php

function smooth_data($data) {

  $tmp = array('z'=>array(), 't'=>array(), 'p'=>array());
  foreach(array('z', 't', 'p') as $race) {
    for($i = 1; $i<= 12; $i++) {
      $tmp[$race][$i] = array();
      if($data[$race][$i] == null) {
        $tmp[$race][$i]['win_cnt'] = 0;
        $tmp[$race][$i]['tot_cnt'] = 0;
      } else {
        $tmp[$race][$i]['win_cnt'] = $data[$race][$i]['win_cnt'];
        $tmp[$race][$i]['tot_cnt'] = $data[$race][$i]['tot_cnt'];
      }
      if($i > 1) {
        $tmp[$race][$i]['win_cnt'] += $data[$race][$i-1]['win_cnt'];
        $tmp[$race][$i]['tot_cnt'] += $data[$race][$i-1]['tot_cnt'];
      }
      if($i < 12) {
        $tmp[$race][$i]['win_cnt'] += $data[$race][$i+1]['win_cnt'];
        $tmp[$race][$i]['tot_cnt'] += $data[$race][$i+1]['tot_cnt'];
      }
    }
  }

  foreach(array('z', 't', 'p') as $race) {
    $vals = array();
    for($i = 1; $i<= 12; $i++) {
      if($tmp[$race][$i]['tot_cnt'] == 0) {
        $vals[] = 0;
      } else {
        $vals[] = intval(10000 * $tmp[$race][$i]['win_cnt'] / $tmp[$race][$i]['tot_cnt']) / 100.;
      }
    }
    $tmp[$race] = $vals;
  }

  return $tmp;

}
      
function fill_data($data) {

  foreach(array('z', 't', 'p') as $race) {
    if($data[$race] == null) {
      $data[$race] = array();
    }
    for($i = 1; $i<= 12; $i++) {
      if($data[$race][$i] == null) {
        $data[$race][$i] = array();
        $data[$race][$i]['win_cnt'] = 0;
        $data[$race][$i]['loss_cnt'] = 0;
      }
    }
  }

  $ret = array();
  foreach(array('z', 't', 'p') as $race) {
    $vals = array('w'=>array(), 'l'=>array());
    for($i = 1; $i<= 12; $i++) {
      $vals['w'][] = intval($data[$race][$i]['win_cnt']);
      $vals['l'][] = intval($data[$race][$i]['loss_cnt']);
    }
    $ret[$race] = $vals;
  }

  return $ret;

}
      
?>
