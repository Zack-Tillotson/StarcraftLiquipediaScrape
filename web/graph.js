function makeGraphRaceOverTime(container, chartName, chartSubtitle, dataUrl) {
  $.getJSON(dataUrl, function(data) {
    var chart = new Highcharts.Chart({
      chart: {
          renderTo: container,
          type: 'line',
          marginRight: 50,
          marginLeft: 50,
          marginBottom: 25,
          marginTop: 25
      },
      title: {
          text: chartName,
          x: -20
      },
      subtitle: {
          text: chartSubtitle,
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
          tickInterval: 10
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
          data: data.z
      }, {
          name: 'Terran',
          data: data.t
      }, {
          name: 'Protoss',
          data: data.p
      }]
    });
  });
}
