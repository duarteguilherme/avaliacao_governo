var svg = dimple.newSvg("#chartContainer", 900, 900); // Abre dimple

d3.csv("avaliacao.csv", function(data) { // Carrega dados
var myChart = new dimple.chart(svg, data); // Carrega gráfico dimple
myChart.setBounds(60, 30, 800, 600); // Seta Limites
var x = myChart.addTimeAxis("x", "data", "%Y-%m-%d", "%m-%Y"); // 
var y1 = myChart.addPctAxis("y", "valor");
var y2 = myChart.addPctAxis("y", "serie");
y1.overrideMax = ".85"; // Coloca o limite do eixo y para 85%
y2.overrideMax = ".85";
y2.hidden = true;
ibope = dimple.filterData(data, "instituto", "ibope");
datafolha = dimple.filterData(data, "instituto", "datafolha");
tempo_dados = dimple.filterData(data, "controle_tempo","0");

var s = myChart.addSeries(["tipo_avaliacao"], dimple.plot.bubble, [x,y1]);
var v = myChart.addSeries(["tipo_avaliacao"], dimple.plot.bubble, [x,y1]);
s.data = ibope;
v.data = datafolha;
tempo = myChart.addSeries("tipo_avaliacao", dimple.plot.line,[x,y2]);
s.stacked=false;


tempo.data = tempo_dados;
console.log(tempo_dados);

tempo.lineWeight = 1;
myChart.assignColor("Otimo-bom", "#0000FF");
myChart.assignColor("Regular", "#C0C0C0");
myChart.assignColor("Ruim-Pessimo", "#FF0000");
myChart.assignColor("Nao sabe", "#000000");

myChart.draw();


$(".dimple-series-0").css("fill","white");

});



