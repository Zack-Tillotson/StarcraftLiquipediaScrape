function makeGraphRaceOverTime(container, chartName, chartSubtitle, dataUrl) {
  $.getJSON(dataUrl, function(data) {
    var chart = new Highcharts.Chart({
      chart: {
          renderTo: container,
          type: 'spline',
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
      colors: [
          '#0099FF',
          '#d81417',
          '#2a9c3b'
      ],
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
function makeGraphRaceWinCountsOverTime(container, chartName, chartSubtitle, dataUrl) {
  $.getJSON(dataUrl, function(data) {
    var chart = new Highcharts.Chart({
      chart: {
          renderTo: container,
          type: 'column',
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
          }]
      },
      colors: [
          '#F2B8B8',
          '#B8B8F2',
          '#B8F2B8',
          '#d81417',
          '#0099FF',
          '#2a9c3b'
      ],
      tooltip: {
          formatter: function() {
                  console.log(this.series);
                  return '<b>'+ this.x+'</b><br/>'+
                  this.series.name +': '+ this.y + "/" + this.point.stackTotal;
          }
      },
      plotOptions: {
          column: {
            stacking: 'normal'
          }
      },
      legend: {
          layout: 'vertical',
          align: 'right',
          verticalAlign: 'top',
          x: 0,
          y: 100,
          borderWidth: 0
      },
      series: [{
          name: 'Losses vs Zerg',
          data: data.z.l,
          stack: 'Zerg'
      }, {
          name: 'Losses vs Terran',
          data: data.t.l,
          stack: 'Terran'
      }, {
          name: 'Losses vs Protoss',
          data: data.p.l,
          stack: 'Protoss'
      }, {
          name: 'Wins vs Zerg',
          data: data.z.w,
          stack: 'Zerg'
      }, {
          name: 'Wins vs Terran',
          data: data.t.w,
          stack: 'Terran'
      }, {
          name: 'Wins vs Protoss',
          data: data.p.w,
          stack: 'Protoss'
      }]
    });
  });
}
