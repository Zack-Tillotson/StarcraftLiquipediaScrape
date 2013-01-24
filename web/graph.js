$(function () {
    var chart1, chart2, chart3;
    $(document).ready(function() {
        chart1 = new Highcharts.Chart({
            chart: {
                renderTo: 'graph1',
                type: 'line',
                marginRight: 50,
                marginLeft: 50,
                marginBottom: 25,
                marginTop: 25
            },
            title: {
                text: 'Win Percentage',
                x: -20 //center
            },
            subtitle: {
                text: 'Source: <a href="//wiki.teamliquid.net/starcraft2/">Liquipedia</a>',
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
            tooltip: {
                formatter: function() {
                        return '<b>'+ this.series.name +'</b><br/>'+
                        this.x +': '+ this.y +'°C';
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
                data: [
                  48, 
                 50,                              
                  49,                              
                   45,                              
                    50,                              
                     45,                              
                      54,                              
                       52,                              
                        52,                              
                         51,                              
                          51,                              
                           49
                  ]
            }, {
                name: 'Terran',
                data: [
                   51, 
                 49, 
                  55, 
                   51, 
                    52, 
                     42, 
                      52, 
                       52, 
                        50, 
                         47, 
                          52, 
                           53
                  ]
            }, {
                name: 'Protoss',
                data: [
                  50, 
                 50, 
                  45, 
                   49, 
                    47, 
                     56, 
                      53, 
                       49, 
                        45, 
                         50, 
                          53, 
                           48
                  ]
            }]
        });
    });
    $(document).ready(function() {
        chart2 = new Highcharts.Chart({
            chart: {
                renderTo: 'graph2',
                type: 'line',
                marginRight: 50,
                marginLeft: 50,
                marginBottom: 25,
                marginTop: 25
            },
            title: {
                text: 'Korean Win Percentage vs Korean Opponents',
                x: -20 //center
            },
            subtitle: {
                text: 'Source: <a href="//wiki.teamliquid.net/starcraft2/">Liquipedia</a>',
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
            tooltip: {
                formatter: function() {
                        return '<b>'+ this.series.name +'</b><br/>'+
                        this.x +': '+ this.y +'°C';
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
                data: [
                  47, 
                 51, 
                  49, 
                   42, 
                    47, 50,
                     50, 
                      49, 
                       54, 
                        54, 
                         51, 
                          37
                  ]
            }, {
                name: 'Terran',
                data: [
                 49,
                 48,
                  52,
                   37,
                    52,50,
                     46,
                      51,
                       44,
                        48,
                         52,
                          81
                  ]
            }, {
                name: 'Protoss',
                data: [
                  54, 
                 50, 
                  46, 
                   70, 
                    50, 50,
                     52, 
                      49, 
                       52, 
                        48, 
                         44, 
                          57
                  ]
            }]
        });
    });
    $(document).ready(function() {
        chart3 = new Highcharts.Chart({
            chart: {
                renderTo: 'graph3',
                type: 'line',
                marginRight: 50,
                marginLeft: 50,
                marginBottom: 25,
                marginTop: 25
            },
            title: {
                text: 'Non Korean Win Percentage vs Korean Opponents',
                x: -20 //center
            },
            subtitle: {
                text: 'Source: <a href="//wiki.teamliquid.net/starcraft2/">Liquipedia</a>',
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
            tooltip: {
                formatter: function() {
                        return '<b>'+ this.series.name +'</b><br/>'+
                        this.x +': '+ this.y +'°C';
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
                data: [
                  35, 
                 49, 
                  34, 
                   54, 
                    40, 
                     52, 
                      45, 
                       39, 
                        41, 
                         35, 
                          35, 
                           51
                  ]
            }, {
                name: 'Terran',
                data: [
                   38, 
                 52, 
                  53, 
                   65, 
                    26, 
                     55, 
                      43, 
                       33, 
                        40, 
                         38, 
                          23, 
                           33
                  ]
            }, {
                name: 'Protoss',
                data: [
                  26, 
                 44, 
                  30, 
                   32, 
                    40, 
                     67, 
                      46, 
                       40, 50,
                        45, 
                         30, 
                          27
                  ]
            }]
        });
    });
});
