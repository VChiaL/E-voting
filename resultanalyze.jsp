<%@ page language="java" contentType="text/html; charset=GB2312"%>
<%@ page import="web.bean.*" %>
<%@ page import = "java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="style/templates.css" type="text/css" rel="stylesheet" rev="stylesheet" />
<link href="style/resultanalyze.css" type="text/css" rel="stylesheet" rev="stylesheet" />
<jsp:useBean id="loginBean" class="web.bean.LoginBean" scope="session"></jsp:useBean>
<script src="resources/jquery.js"></script>
<script src="dist/Chart.js"></script>
<script type="text/javascript">
<%
	VoteAnalyzeBean bean = null;
	bean = (VoteAnalyzeBean)session.getAttribute("voteAnalyzeBean");
	String voteTittle = bean.getVoteTittle();
	int[] optionVotedNum = bean.getOptionVotedNum();
	int[] optionIDArr = bean.getOptionIDArr();
	String[] collegeNameArr = bean.getCollegeNameArr();
	int[][] optionCollegeVoteArr = bean.getOptionCollegeVoteArr();
	int voteID = bean.getVoteID();
	int optionNum = optionIDArr.length;
	int collegeCount = collegeNameArr.length;
	int tottleVotedNum = 0;
	String[] dataTemp = new String[optionNum];
	for(int i = 0;i < optionNum;i++){
		tottleVotedNum += optionVotedNum[i];
	}
%>
var randomScalingFactor = function() {
    return (Math.random() > 0.5 ? 1.0 : -1.0) * Math.round(Math.random() * 100);
};
var randomColorFactor = function() {
    return Math.round(Math.random() * 255);
};
var randomBarColor = function() {
    return 'rgba(' + randomColorFactor() + ',' + randomColorFactor() + ',' + randomColorFactor() + ',.7)';
};
var randomDoughnutColor = function() {
    return 'rgba(' + randomColorFactor() + ',' + randomColorFactor() + ',' + randomColorFactor() + ',1)';
};
function GroupTypeChoice(){
	if($("#u14collegechoice").find("option:selected").val() == 0){
		$("#u14grouptypechoice").empty();
		$("#u14grouptypechoice").append("<option value=1>Ñ§Ôº</option>");
		$("#u14grouptypechoice").append("<option value=2>Ïµ</option>");
		$("#u14grouptypechoice").append("<option value=3>°à¼¶</option>");
	}
	else{
		if($("#u14departchoice").find("option:selected").val() == 0){
			$("#u14grouptypechoice").empty();
			$("#u14grouptypechoice").append("<option value=2>Ïµ</option>");
			$("#u14grouptypechoice").append("<option value=3>°à¼¶</option>");
		}
		else{
			$("#u14grouptypechoice").empty();
			$("#u14grouptypechoice").append("<option value=3>°à¼¶</option>");
		}
	}
}
function u14DougnutChartChange(){
	$.ajax({
		url:"u14ChartChangeServlet",
		type : 'POST',
		typeType: 'json',
		data : {
				voteID:<%=voteID%>,
				sex:$("#u14sexchoice").find("option:selected").attr("value"),
				entranceTime:$("#u14entrancetimechoice").find("option:selected").attr("value"),
				collegeNum:$("#u14collegechoice").find("option:selected").attr("value"),
				departNum:$("#u14departchoice").find("option:selected").attr("value"),
				classNum:$("#u14classchoice").find("option:selected").attr("value"),
				groupType:$("#u14grouptypechoice").find("option:selected").attr("value")
		},
		async : false,
		error : function() {  
	        alert('Operate Failed!');  
	    },
		success : function(data,status){
			$("#chartarea2").empty();
			var obj = JSON.parse(data);
			var tottleLen = obj.length;
			var groupFlag = tottleLen/<%=optionNum%>;
			var colNum2 = 0;
			var rowNum2 = 0;
			var backgroundColor1 = [];
			for(var i = 0;i < groupFlag;i++){
				backgroundColor1.push(randomDoughnutColor());
			}
			for(var num2 = 1;num2 <= <%=optionNum%>;num2++){
				for(var groupNum = 0;groupNum < groupFlag;groupNum++){
					var chartjsData = [];
					var chartjsLabels = [];
					for (var x = 0; x < groupFlag; x++) {
					    chartjsData.push(obj[groupFlag*(num2-1)+x].data);
					    chartjsLabels.push(obj[groupFlag*(num2-1)+x].labels);
					}
				}
				colNum2 ++;
				if(num2 % 2 == 1){
					rowNum2 ++;
					colNum2 = 0;
				}
				$("#chartarea2").append("<div id='optioncanvasholder"+num2+"' class='canvasholder' style='width: 35%;margin-top:20px;margin-left:20px;left:"+480*colNum2+"px;top:"+270*(rowNum2-1)+"px'><canvas id='optioncanvas"+num2+"' height='250' width='450'></canvas></div>");
				var ctx = document.getElementById("optioncanvas"+num2).getContext("2d");
				var config = {
				        type: 'doughnut',
				        data: {
				            datasets: [{
				                data: chartjsData,
				                backgroundColor: backgroundColor1,
				                label: '±»Í¶´ÎÊý'
				            }],
				            labels: chartjsLabels
				        },
				        options: {
				            responsive: true,
				            legend: {
				                position: 'top',
				            },
				            title: {
				                display: true,
				                text: 'Ñ¡Ïî'+num2
				            },
				            tooltips: {
				    			callbacks: {
				    				title: function() { return '';},
				    				label: function(tooltipItem, data) {
				    					return data.labels[tooltipItem.index] + ': ' + data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index] + 'Æ±';
				    				}
				    			}
				    		}
				        }
				    };
			        window.myDoughnut = new Chart(ctx, config);
			}
		}
	});
}
function u14BarchartChange(){
	$(".charttypechoice").empty();
	$(".charttypechoice").append("<option value=1>Öù×´Í¼</option><option value=2>»·ÐÎÍ¼</option>");
	$.ajax({
		url:"u14ChartChangeServlet",
		type : 'POST',
		typeType: 'json',
		data : {
				voteID:<%=voteID%>,
				sex:$("#u14sexchoice").find("option:selected").attr("value"),
				entranceTime:$("#u14entrancetimechoice").find("option:selected").attr("value"),
				collegeNum:$("#u14collegechoice").find("option:selected").attr("value"),
				departNum:$("#u14departchoice").find("option:selected").attr("value"),
				classNum:$("#u14classchoice").find("option:selected").attr("value"),
				groupType:$("#u14grouptypechoice").find("option:selected").attr("value")
		},
		async : false,
		error : function() {  
	        alert('Operate Failed!');  
	    },
		success : function(data,status){
			$("#chartarea2").empty();
			var obj = JSON.parse(data);
			var tottleLen = obj.length;
			var groupFlag = tottleLen/<%=optionNum%>;
			var colNum2 = 0;
			var rowNum2 = 0;
			for(var num2 = 1;num2 <= <%=optionNum%>;num2++){
				for(var groupNum = 0;groupNum < groupFlag;groupNum++){
					var chartjsData = [];
					var chartjsLabels = [];
					for (var x = 0; x < groupFlag; x++) {
					    chartjsData.push(obj[groupFlag*(num2-1)+x].data);
					    chartjsLabels.push(obj[groupFlag*(num2-1)+x].labels);
					}
				}
				colNum2 ++;
				if(num2 % 2 == 1){
					rowNum2 ++;
					colNum2 = 0;
				}
				$("#chartarea2").append("<div id='optioncanvasholder"+num2+"' class='canvasholder' style='width: 30%;margin-top:20px;margin-left:20px;left:"+480*colNum2+"px;top:"+270*(rowNum2-1)+"px'><canvas id='optioncanvas"+num2+"' height='250' width='450'></canvas></div>");
				var ctx = document.getElementById("optioncanvas"+num2).getContext("2d");
				var barChartData = {
			        labels: chartjsLabels,
			        datasets: [{
			            label: "Í¶Æ±´ÎÊý",
			            backgroundColor: randomBarColor(),
			            data: chartjsData
			        }]
			    };
				window.myBar = new Chart(ctx, {
					type: 'bar',
					data: barChartData,
					options: {
						responsive: false,
						legend: {
							display: false
						},
						title: {
						    display: false
						},
						scales: {
							xAxes: [{
								stacked: true,
								scaleLabel: {
									display: true,
									labelString: "Ñ¡Ïî"+num2
								},
								ticks: {
									fontSize:8
								},
								categoryPercentage: 0.5
							}],
							yAxes: [{
								stacked: true,
								ticks: {
									beginAtZero:true
								},
								scaleLabel: {
									display: true,
									labelString: "Í¶Æ±´ÎÊý"
								}
							}]
						}
					}
				});
			}
		}
	});
}
function u15DougnutChartChange(){
	$.ajax({
		url:"u15ChartChangeServlet",
		type : 'POST',
		typeType: 'json',
		data : {
				voteID:<%=voteID%>,
				sex:$("#u15sexchoice").find("option:selected").attr("value"),
				entranceTime:$("#u15entrancetimechoice").find("option:selected").attr("value"),
				collegeNum:$("#u15collegechoice").find("option:selected").attr("value"),
				departNum:$("#u15departchoice").find("option:selected").attr("value"),
				classNum:$("#u15classchoice").find("option:selected").attr("value"),
				groupType:$("#u15grouptypechoice").find("option:selected").attr("value")
		},
		async : false,
		error : function() {  
	        alert('Operate Failed!');  
	    },
		success : function(data,status){
			$("#chartarea3").empty();
			var obj = JSON.parse(data);
			var tottleLen = obj.length;
			var backgroundColor1 = [];
			var chartjsData = [];
			var chartjsLabels = [];
			for (var x = 0; x < tottleLen; x++) {
			    chartjsData.push(obj[x].data);
			    chartjsLabels.push(obj[x].labels);
			    backgroundColor1.push(randomDoughnutColor());
			}
			$("#chartarea3").append("<div id='chartmain3' style='width: 55%'><canvas id='canvas3' height='450' width='600'></canvas></div>");
			var ctx = document.getElementById("canvas3").getContext("2d");
			var config = {
			        type: 'doughnut',
			        data: {
			            datasets: [{
			                data: chartjsData,
			                backgroundColor: backgroundColor1,
			                label: '±»Í¶´ÎÊý'
			            }],
			            labels: chartjsLabels
			        },
			        options: {
			            responsive: true,
			            legend: {
			                position: 'top',
			            },
			            title: {
			                display: true,
			                text: 'ÓÃ»§×é·ÖÎö'
			            },
			            tooltips: {
			    			callbacks: {
			    				title: function() { return '';},
			    				label: function(tooltipItem, data) {
			    					return data.labels[tooltipItem.index] + ': ' + data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index] + 'Æ±';
			    				}
			    			}
			    		}
			        }
			    };
		        window.myDoughnut = new Chart(ctx, config);
			}
	});
}
function u15BarchartChange(){
	$(".charttypechoice").empty();
	$(".charttypechoice").append("<option value=1>Öù×´Í¼</option><option value=2>»·ÐÎÍ¼</option>");
	$.ajax({
		url:"u15ChartChangeServlet",
		type : 'POST',
		typeType: 'json',
		data : {
				voteID:<%=voteID%>,
				sex:$("#u15sexchoice").find("option:selected").attr("value"),
				entranceTime:$("#u15entrancetimechoice").find("option:selected").attr("value"),
				collegeNum:$("#u15collegechoice").find("option:selected").attr("value"),
				departNum:$("#u15departchoice").find("option:selected").attr("value"),
				classNum:$("#u15classchoice").find("option:selected").attr("value"),
				groupType:$("#u15grouptypechoice").find("option:selected").attr("value")
		},
		async : false,
		error : function() {  
	        alert('Operate Failed!');  
	    },
		success : function(data,status){
			$("#chartarea3").empty();
			var obj = JSON.parse(data);
			var tottleLen = obj.length;
			var chartjsData = [];
			var chartjsLabels = [];
			for (var x = 0; x < tottleLen; x++) {
			    chartjsData.push(obj[x].data);
			    chartjsLabels.push(obj[x].labels);
			}
			$("#chartarea3").empty();
			$("#chartarea3").append("<div id='chartmain3' style='width: 55%'><canvas id='canvas3' height='450' width='600'></canvas></div>");
			var ctx = document.getElementById("canvas3").getContext("2d");
			var barChartData = {
		        labels: chartjsLabels,
		        datasets: [{
		            label: "Í¶Æ±´ÎÊý",
		            backgroundColor: randomBarColor(),
		            data: chartjsData
		        }]
		    };
			window.myBar = new Chart(ctx, {
				type: 'bar',
				data: barChartData,
				options: {
					responsive: true,
					legend: {
						display: false
					},
					title: {
					    display: false
					},
					scales: {
						xAxes: [{
							stacked: true,
							scaleLabel: {
								display: true,
								labelString: "Ñ¡Ïî"
							},
							categoryPercentage: 0.5
						}],
						yAxes: [{
							stacked: true,
							scaleLabel: {
								display: true,
								labelString: "Í¶Æ±´ÎÊý"
							}
						}]
					}
				}
			});
		}
	});
}
$(document).ready(function() {
	$("#u8").text("<%=voteTittle%>");
	$("#u14").hide();
	$("#u15").hide();
	var div1 = document.getElementById("u8");
	var div2 = document.getElementById("u9");
	var div3 = document.getElementById("u13");
	var div4 = document.getElementById("u14");
	var div5 = document.getElementById("u15");
	var div6 = document.getElementById("left_bg");
	height1 = div1.offsetTop + div1.offsetHeight + 5;
	height2 = height1 + 45;
	div2.style.top = height1 + "px";
	div3.style.top = height2 + "px";
	div4.style.top = height2 + "px";
	div5.style.top = height2 + "px";
	height3 = div3.offsetTop + div3.offsetHeight + 200;
	div6.style.height = height3 + "px";
	
<%
	String labels1 = "";
	labels1 += "[";
	for(int i = 1;i <= optionNum;i++){
		labels1 += "'Ñ¡Ïî"+i+"'";
		if(i < optionNum){
			labels1 += ",";
		}
	}
	labels1 += "]";
	String data1 = "";
	data1 += "[";
	for(int i = 0;i < optionNum;i++){
		data1 += optionVotedNum[i];
		if(i < optionNum-1){
			data1 += ",";
		}
	}
	data1 += "]";
	String backgroundColor1 = "";
	backgroundColor1 += "[";
	for(int i = 0;i < optionNum;i++){
		backgroundColor1 += "randomDoughnutColor()";
		if(i < optionNum-1){
			backgroundColor1 += ",";
		}
	}
	backgroundColor1 += "]";
%>
	$("#charttypechoice2").change(function(){
		if($("#charttypechoice2").find("option:selected").val() == 1){
			u14BarchartChange();
		}
		else if($("#charttypechoice2").find("option:selected").val() == 2){
			u14DougnutChartChange();
		}
	});
	$("#charttypechoice3").change(function(){
		if($("#charttypechoice3").find("option:selected").val() == 1){
			u15BarchartChange();
		}
		else if($("#charttypechoice3").find("option:selected").val() == 2){
			u15DougnutChartChange();
		}
	});
	$("#u14entrancetimechoice").change(function(){
		$.post("entranceTimeChoiceChangeServlet",
		{
			entranceTime:$("#u14entrancetimechoice").find("option:selected").attr("value"),
			collegeNum:$("#u14collegechoice").find("option:selected").attr("value"),
			departNum:$("#u14departchoice").find("option:selected").attr("value")
		},
		function(data,status){
			if($("#u14classchoice").attr("disabled") != "disabled"){
				$("#u14classchoice").empty();
				$("#u14classchoice").append("<option value='0'>°à¼¶</option>");
				$("#u14classchoice").append(data);
			}
		});
		u14BarchartChange();
	});
	$("#u14collegechoice").change(function(){
		if($("#u14collegechoice").find("option:selected").val() == 0){
			$("#u14departchoice").empty();
			$("#u14departchoice").append("<option value='0'>Ïµ</option>");
			$("#u14departchoice").attr("disabled","disabled");
		}
		else{
			$.post("analyzeCollegeChoiceChangeServlet",
			{college:$("#u14collegechoice").find("option:selected").val()},
			function(data,status){
				$("#u14departchoice").empty();
				$("#u14departchoice").append("<option value='0'>Ïµ</option>");
				$("#u14departchoice").append(data);
			});
			$("#u14departchoice").removeAttr("disabled");
		}
		$("#u14classchoice").empty();
		$("#u14classchoice").append("<option value='0'>°à¼¶</option>");
		$("#u14classchoice").attr("disabled","disabled");
		GroupTypeChoice();
		u14BarchartChange();
	});
	$("#u14departchoice").change(function(){
		$.post("departChoiceChangeServlet",
		{
			departNum:$("#u14departchoice").find("option:selected").attr("value"),
			entranceTime:$("#u14entrancetimechoice").find("option:selected").attr("value")
		},
		function(data,status){
			$("#u14classchoice").empty();
			$("#u14classchoice").append("<option value='0'>°à¼¶</option>");
			$("#u14classchoice").append(data);
		});
		if($("#u14departchoice").find("option:selected").text() == "Ïµ"){
			$("#u14classchoice").attr("disabled","disabled");
		}
		else{
			$("#u14classchoice").removeAttr("disabled");
		}
		GroupTypeChoice();
		u14BarchartChange();
	});
	$("#u14classchoice").change(function(){
		u14BarchartChange();
	});
	$("#u14sexchoice").change(function(){
		u14BarchartChange();
	});
	$("#u14grouptypechoice").change(function(){
		u14BarchartChange();
	});
	$("#u15entrancetimechoice").change(function(){
		$.post("entranceTimeChoiceChangeServlet",
		{
			entranceTime:$("#u15entrancetimechoice").find("option:selected").attr("value"),
			collegeNum:$("#u15collegechoice").find("option:selected").attr("value"),
			departNum:$("#u15departchoice").find("option:selected").attr("value")
		},
		function(data,status){
			if($("#u15classchoice").attr("disabled") != "disabled"){
				$("#u15classchoice").empty();
				$("#u15classchoice").append("<option value='0'>°à¼¶</option>");
				$("#u15classchoice").append(data);
			}
		});
		u15BarchartChange();
	});
	$("#u15collegechoice").change(function(){
		if($("#u15collegechoice").find("option:selected").val() == 0){
			$("#u15departchoice").empty();
			$("#u15departchoice").append("<option value='0'>Ïµ</option>");
			$("#u15departchoice").attr("disabled","disabled");
		}
		else{
			$.post("analyzeCollegeChoiceChangeServlet",
			{college:$("#u15collegechoice").find("option:selected").val()},
			function(data,status){
				$("#u15departchoice").empty();
				$("#u15departchoice").append("<option value='0'>Ïµ</option>");
				$("#u15departchoice").append(data);
			});
			$("#u15departchoice").removeAttr("disabled");
		}
		$("#u15classchoice").empty();
		$("#u15classchoice").append("<option value='0'>°à¼¶</option>");
		$("#u15classchoice").attr("disabled","disabled");
		u15BarchartChange();
	});
	$("#u15departchoice").change(function(){
		$.post("departChoiceChangeServlet",
		{
			departNum:$("#u15departchoice").find("option:selected").attr("value"),
			entranceTime:$("#u15entrancetimechoice").find("option:selected").attr("value")
		},
		function(data,status){
			$("#u15classchoice").empty();
			$("#u15classchoice").append("<option value='0'>°à¼¶</option>");
			$("#u15classchoice").append(data);
		});
		if($("#u15departchoice").find("option:selected").text() == "Ïµ"){
			$("#u15classchoice").attr("disabled","disabled");
		}
		else{
			$("#u15classchoice").removeAttr("disabled");
		}
		u15BarchartChange();
	});
	$("#u15classchoice").change(function(){
		u15BarchartChange();
	});
	$("#u15sexchoice").change(function(){
		u15BarchartChange();
	});
	$("#u15grouptypechoice").change(function(){
		u15BarchartChange();
	});
	$("#u10_img").click(function() {
		$("#u13chart").remove();
		$("#chartmain1").append("<canvas id='u13chart' height='450' width='600'></canvas>");		
		var all_options = document.getElementById("charttypechoice1").options;
		for (var i=0; i<all_options.length; i++){
			if (all_options[i].value == 1)
			{
				all_options[i].selected = true;
			}
		}
		$("#u10_img").find("img").attr("src","images/underline.png");
		$("#u10_img").find("img").removeAttr("onMouseOver");
		$("#u10_img").find("img").removeAttr("onMouseOut");
		$("#u11_img").find("img").attr("src","images/withoutunderline.png");
		$("#u11_img").find("img").attr("onMouseOver","this.src='images/underline.png'");
		$("#u11_img").find("img").attr("onMouseOut","this.src='images/withoutunderline.png'");
		$("#u12_img").find("img").attr("src","images/withoutunderline.png");
		$("#u12_img").find("img").attr("onMouseOver","this.src='images/underline.png'");
		$("#u12_img").find("img").attr("onMouseOut","this.src='images/withoutunderline.png'");
		$("#u13").show();
		$("#u14").hide();
		$("#u15").hide();
	    var barChartData = {
	        labels: <%=labels1%>,
	        datasets: [{
	            label: '±»Í¶´ÎÊý',
	            backgroundColor: randomBarColor(),
	            data: <%=data1%>
	        }]

	    };
		var ctx = document.getElementById("u13chart").getContext("2d");
		window.myBar = new Chart(ctx, {
			type: 'bar',
			data: barChartData,
			options: {
				responsive: true,
				legend: {
					display: false
				},
				title: {
				    display: false
				},
				scales: {
					xAxes: [{
						stacked: true,
						scaleLabel: {
							display: true,
							labelString: "Ñ¡Ïî"
						},
						categoryPercentage: 0.5
					}],
					yAxes: [{
						stacked: true,
						scaleLabel: {
							display: true,
							labelString: "Í¶Æ±´ÎÊý"
						}
					}]
				}
			}
		});
	});
<%
	String labels2 = "";
	labels2 += "[";
	for(int n = 0;n < collegeCount;n++){
		labels2 += "'"+collegeNameArr[n]+"'";
		if(n < collegeCount-1){
			labels2 += ",";
		}
	}
	labels2 += "]";
%>
	$("#u11_img").click(function() {
		$(".charttypechoice").empty();
		$(".charttypechoice").append("<option value=1>Öù×´Í¼</option><option value=2>»·ÐÎÍ¼</option>");
		$("#u11_img").find("img").attr("src","images/underline.png");
		$("#u11_img").find("img").removeAttr("onMouseOver");
		$("#u11_img").find("img").removeAttr("onMouseOut");
		$("#u10_img").find("img").attr("src","images/withoutunderline.png");
		$("#u10_img").find("img").attr("onMouseOver","this.src='images/underline.png'");
		$("#u10_img").find("img").attr("onMouseOut","this.src='images/withoutunderline.png'");
		$("#u12_img").find("img").attr("src","images/withoutunderline.png");
		$("#u12_img").find("img").attr("onMouseOver","this.src='images/underline.png'");
		$("#u12_img").find("img").attr("onMouseOut","this.src='images/withoutunderline.png'");
		$("#chartarea2").empty();
		$("#u13").hide();
		$("#u15").hide();
		$("#u14").show();
		$(".collegechoice").find("option[value=0]").attr("selected",true);
		$(".departchoice").empty();
		$(".departchoice").append("<option value=0>Ïµ</option>");
		$(".classchoice").attr("disabled","disabled");
		$(".classchoice").empty();
		$(".classchoice").append("<option value=0>°à¼¶</option>");
<%
	int colNum = 0;
	int rowNum = 0;
	for(int num = 1;num <= optionNum;num++){
		colNum ++;
		if(num % 2 == 1){
			rowNum ++;
			colNum = 0;
		}
		String data2 = "";
		data2 += "[";
		for(int i = 0;i < collegeCount;i++){
			data2 += optionCollegeVoteArr[num-1][i];
			if(i < collegeCount-1){
				data2 += ",";
			}
		}
		data2 += "]";
%>
		$("#chartarea2").append("<div id='optioncanvasholder"+"<%=num%>"+"' class='canvasholder' style='width: 30%;margin-top:20px;margin-left:20px;left:"+480*(<%=colNum%>)+"px;top:"+270*<%=rowNum-1%>+"px'><canvas id='optioncanvas"+"<%=num%>"+"' height='250' width='450'></canvas></div>");
		var ctx = document.getElementById("optioncanvas"+"<%=num%>").getContext("2d");
		var barChartData = {
	        labels: <%=labels2%>,
	        datasets: [{
	            label: '±»Í¶´ÎÊý',
	            backgroundColor: randomBarColor(),
	            data: <%=data2%>
	        }]
	    };
		window.myBar = new Chart(ctx, {
			type: 'bar',
			data: barChartData,
			options: {
				responsive: false,
				legend: {
					display: false
				},
				title: {
				    display: false
				},
				scales: {
					xAxes: [{
						stacked: true,
						scaleLabel: {
							display: true,
							labelString: "Ñ¡Ïî"+<%=num%>
						},
						ticks: {
							fontSize:8
						},
						categoryPercentage: 0.5
					}],
					yAxes: [{
						stacked: true,
						ticks: {
							beginAtZero:true
						},
						scaleLabel: {
							display: true,
							labelString: "Í¶Æ±´ÎÊý"
						}
					}]
				}
			}
		});
<%
	}
%>
		var div7 = document.getElementById("chartarea2");
		div7.style.height = 280*<%=rowNum%> + "px";
		div4.style.height = div7.offsetHeight + 150 + "px";
		var height4 = div4.offsetTop + div4.offsetHeight + 200;
		div6.style.height = height4 + "px";
		
	});
	$("#u12_img").click(function() {
		$(".charttypechoice").empty();
		$(".charttypechoice").append("<option value=1>Öù×´Í¼</option><option value=2>»·ÐÎÍ¼</option>");
		$("#canvas1").remove();
		$("#chartmain3").append("<canvas id='canvas1' height='450' width='600'></canvas>");
		$("#u12_img").find("img").attr("src","images/underline.png");
		$("#u12_img").find("img").removeAttr("onMouseOver");
		$("#u12_img").find("img").removeAttr("onMouseOut");
		$("#u10_img").find("img").attr("src","images/withoutunderline.png");
		$("#u10_img").find("img").attr("onMouseOver","this.src='images/underline.png'");
		$("#u10_img").find("img").attr("onMouseOut","this.src='images/withoutunderline.png'");
		$("#u11_img").find("img").attr("src","images/withoutunderline.png");
		$("#u11_img").find("img").attr("onMouseOver","this.src='images/underline.png'");
		$("#u11_img").find("img").attr("onMouseOut","this.src='images/withoutunderline.png'");
		$("#u13").hide();
		$("#u14").hide();
		$("#u15").show();
		$(".collegechoice").find("option[value=0]").attr("selected",true);
		$(".departchoice").attr("disabled","disabled");
		$(".departchoice").empty();
		$(".departchoice").append("<option value=0>Ïµ</option>");
		$(".classchoice").attr("disabled","disabled");
		$(".classchoice").empty();
		$(".classchoice").append("<option value=0>°à¼¶</option>");
		 var barChartData = {
	        labels: <%=labels1%>,
	        datasets: [{
	            label: '±»Í¶´ÎÊý',
	            backgroundColor: randomBarColor(),
	            data: <%=data1%>
	        }]

	    };
		var ctx = document.getElementById("canvas3").getContext("2d");
		window.myBar = new Chart(ctx, {
			type: 'bar',
			data: barChartData,
			options: {
				responsive: true,
				legend: {
					display: false
				},
				title: {
				    display: false
				},
				scales: {
					xAxes: [{
						stacked: true,
						scaleLabel: {
							display: true,
							labelString: "Ñ¡Ïî"
						},
						categoryPercentage: 0.5
					}],
					yAxes: [{
						stacked: true,
						scaleLabel: {
							display: true,
							labelString: "Í¶Æ±´ÎÊý"
						}
					}]
				}
			}
		});
	});

	$("#charttypechoice1").change(function() {
		if($(this).val() == 1){
			$("#u13chart").remove();
 			$("#chartmain1").append("<canvas id='u13chart' height='450' width='600'></canvas>");
 			var barChartData = {
				labels: <%=labels1%>,
		        datasets: [{
		            label: '±»Í¶´ÎÊý',
		            backgroundColor: randomBarColor(),
		            data: <%=data1%>
		        }]
		    };
			var ctx = document.getElementById("u13chart").getContext("2d");
			window.myBar = new Chart(ctx, {
				type: 'bar',
				data: barChartData,
				options: {
					responsive: true,
					legend: {
						display: false
					},
					title: {
					    display: false
					},
					scales: {
						xAxes: [{
							stacked: true,
							scaleLabel: {
								display: true,
								labelString: "Ñ¡Ïî"
							},
							categoryPercentage: 0.5
						}],
						yAxes: [{
							stacked: true,
							scaleLabel: {
								display: true,
								labelString: "Í¶Æ±´ÎÊý"
							}
						}]
					}
				}
			});
		}
		else if($(this).val() == 2){
			$("#u13chart").remove();
 			$("#chartmain1").append("<canvas id='u13chart' height='450' width='600'></canvas>");
 			var config = {
		        type: 'doughnut',
		        data: {
		            datasets: [{
		                data: <%=data1%>,
		                backgroundColor: <%=backgroundColor1%>,
		                label: '±»Í¶´ÎÊý'
		            }],
		            labels: <%=labels1%>
		        },
		        options: {
		            responsive: true,
		            legend: {
		                position: 'top',
		            },
		            title: {
		                display: false
		            },
		            tooltips: {
		    			callbacks: {
		    				title: function() { return '';},
		    				label: function(tooltipItem, data) {
		    					return data.labels[tooltipItem.index] + ': ' + data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index] + 'Æ±';
		    				},
		    				afterLabel: function(tooltipItem, data) {
		    					var num = parseInt(data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index]/<%=tottleVotedNum%>*100);
		    					return "  Õ¼±È£º"+num+"%";
		    				}
		    			}
		    		}
		        }
		    };

	        var ctx = document.getElementById("u13chart").getContext("2d");
	        window.myDoughnut = new Chart(ctx, config);
	        console.log(window.myDoughnut);
		}
	});

    var barChartData = {
        labels: <%=labels1%>,
        datasets: [{
            label: '±»Í¶´ÎÊý',
            backgroundColor: randomBarColor(),
            data: <%=data1%>
        }]

    };
	var ctx = document.getElementById("u13chart").getContext("2d");
	window.myBar = new Chart(ctx, {
		type: 'bar',
		data: barChartData,
		options: {
			responsive: true,
			legend: {
				display: false
			},
			title: {
			    display: false
			},
			scales: {
				xAxes: [{
					stacked: true,
					scaleLabel: {
						display: true,
						labelString: "Ñ¡Ïî"
					},
					categoryPercentage: 0.5
				}],
				yAxes: [{
					stacked: true,
					scaleLabel: {
						display: true,
						labelString: "Í¶Æ±´ÎÊý"
					}
				}]
			}
		}
	});
	$(".collegechoice").change(function (){
		if($(this).val() != 0){
			$(this).siblings(".departchoice").removeAttr("disabled");
		}
		else{
			$(this).siblings(".departchoice").attr("disabled","disabled");
			$(this).siblings(".departchoice").empty();
			$(this).siblings(".departchoice").append("<option value=0>Ïµ</option>");
			$(this).siblings(".classchoice").attr("disabled","disabled");
			$(this).siblings(".classchoice").empty();
			$(this).siblings(".classchoice").append("<option value=0>°à¼¶</option>");
		}
	});
	$(".departchoice").change(function (){
		if($(this).val() != 0){
			$(this).siblings(".classchoice").removeAttr("disabled");
		}
		else{
			$(this).siblings(".classchoice").attr("disabled","disabled");
			$(this).siblings(".classchoice").empty();
			$(this).siblings(".classchoice").append("<option value=0>°à¼¶</option>");
		}
	});
});
</script>
<title>Insert title here</title>
</head>
<body>
	<div id="top">
		<div id="u1">
			<div id="logo">
				<img id="logo_img" class="img " src="images/index_logo.png" />
			</div>
		</div>
		<div id="u2">
			<img id="logo_img" class="img " src="images/u3_line.png" />
		</div>
		<div id="u3">
			<div id="u3_1">
				<p>»¶Ó­ ${sessionScope.loginBean.logName} ÓÃ»§µÇÂ¼±¾ÏµÍ³</p>
			</div>
			<div id="u3_2">
				<p></p>
				<!-- ÖØÒªÍ¨Öª£¨×ßÂíµÆ£© -->
			</div>
			<div id="u3_3">
				<script type="text/javascript">
					function showTime() {
						var today = new Date();
						var year = today.getFullYear();
						var date = today.getDate();
						var day = today.getDay();
						var month = today.getMonth() + 1;
						if (day == 0)
							var xingqi = "ÐÇÆÚÈÕ";
						if (day == 1)
							var xingqi = "ÐÇÆÚÒ»";
						if (day == 2)
							var xingqi = "ÐÇÆÚ¶þ";
						if (day == 3)
							var xingqi = "ÐÇÆÚÈý";
						if (day == 4)
							var xingqi = "ÐÇÆÚËÄ";
						if (day == 5)
							var xingqi = "ÐÇÆÚÎå";
						if (day == 6)
							var xingqi = "ÐÇÆÚÁù";
						var dateString = today.toLocaleDateString(); //Õâ¸öÊÇÏÔÊ¾µÄÐ§¹û±È½ÏºÃ
						var dateAndTime = today.toLocaleString();
						var time = today.toLocaleTimeString();
						var hour = today.getHours();
						var minute = today.getMinutes();
						if (minute < 10) {
							minute = "0" + minute;
						}
						var second = today.getSeconds();
						if (second < 10) {
							second = "0" + second;
						}
						timeString = "<p>" + year + "-" + month + "-" + date
								+ "  " + xingqi + " " + hour + ":" + minute
								+ ":" + second + "</p>";
						document.getElementById("u3_3").innerHTML = timeString;
						window.setTimeout("showTime();", 1000);
					}
					window.onload = showTime;
				</script>
			</div>
		</div>
		<div id="u4">
			<img id="logo_img" class="img " src="images/u18_line.png" />
		</div>
	</div>
	<div id="left">
		<div id="left_bg" style="z-index: -1; min-height: 100%">
			<!-- ¸öÈËÖÐÐÄ  -->
			<form action="userCenterServlet" method="post">
				<input id="u5" name="Button1" type="submit" value="" width="143"
					height="143" align="middle">
			</form>
			<!-- ²é¿´Í¶Æ±  -->
			<div id="u6">
				<img src="images/checkvote_state2.png" name="checkvote_pic"
					width="143" height="143" border="0" align="middle">
			</div>
			<!-- ´´½¨Í¶Æ±  -->
			<a href="createvote.jsp"><img id="u7" value="" width="143"
				height="143" align="middle"></a>
		</div>
	</div>
	<div id="right">
		<div id="u8">Í¶Æ±±êÌâÍ¶Æ±±êÌâÍ¶Æ±±êÌâÍ¶Æ±±êÌâÍ¶Æ±±êÌâÍ¶Æ±</div>
		<div id="u9">
			<div id="u10">¸Å¹Û</div>
			<div id="u10_img">
				<img src="images/underline.png" width="200" height="40" border="0"
					align="middle" />
			</div>
			<div id="u11">Ñ¡Ïî·ÖÎö</div>
			<div id="u11_img">
				<img src="images/withoutunderline.png" width="200" height="40"
					border="0" align="middle"
					onMouseOver="this.src='images/underline.png'"
					onMouseOut="this.src='images/withoutunderline.png'" />
			</div>
			<div id="u12">ÓÃ»§×é·ÖÎö</div>
			<div id="u12_img">
				<img src="images/withoutunderline.png" width="200" height="40"
					border="0" align="middle"
					onMouseOver="this.src='images/underline.png'"
					onMouseOut="this.src='images/withoutunderline.png'" />
			</div>
		</div>
		<%
			LoginBean lgnBean = null;
			lgnBean = (LoginBean)session.getAttribute("loginBean");
			Connection con;
			Statement sql;
			String uri = "jdbc:mysql://localhost:3306/evoting?"
					+"user=root&password=1234&characterEncoding=gb2312";
			con = DriverManager.getConnection(uri);
			String condition1 = "SELECT distinct entrance_time FROM class ORDER BY entrance_time";
			String condition2 = "SELECT college.college_name,college.college_num FROM school JOIN schoolcollege JOIN college ON school.school_num = schoolcollege.school_num AND schoolcollege.college_num = college.college_num WHERE school.school_name = '"+lgnBean.getSchoolName()+"'";
			String condition3 = "SELECT student.stu_num FROM school JOIN schoolcollege ON school.school_num = schoolcollege.school_num JOIN collegedepart ON schoolcollege.college_num = collegedepart.college_num JOIN departclass ON collegedepart.depart_num = departclass.depart_num JOIN classstu ON departclass.class_num = classstu.class_num JOIN student ON classstu.stu_num = student.stu_num WHERE school.school_name = '"
					+lgnBean.getSchoolName()+"' ORDER BY student.stu_num";
			
			sql = con.createStatement();
			
		%>
		<div id="u13">
			<div class="charttype">
				Í¼±íÑùÊ½£º
				<select id="charttypechoice1" class="charttypechoice">
					<option value=1>Öù×´Í¼</option>
					<option value=2>»·ÐÎÍ¼</option>
				</select>
			</div>
			<div id="chartarea1">
				<div id="chartmain1" style="width: 55%">
					<canvas id="u13chart" height="450" width="600"></canvas>
				</div>
			</div>
		</div>
		<div id="u14">
			<div class="charttype">
				Í¼±íÑùÊ½£º
				<select id="charttypechoice2" class="charttypechoice">
					<option value=1>Öù×´Í¼</option>
					<option value=2>»·ÐÎÍ¼</option>
				</select>
			</div>
			<div id="targetgroup1" class="targetgroup">
				Í¶Æ±ÈËÈºÑ¡Ôñ£º
				<select id="u14sexchoice" class="sexchoice">
					<option value=0>ÐÔ±ð</option>
					<option value=1>ÄÐ</option>
					<option value=2>Å®</option>
				</select>
				<select id="u14entrancetimechoice" class="entrancetimechoice">
					<option value=0>ÈëÑ§Äê·Ý</option>
					<%
						ResultSet rs1 = sql.executeQuery(condition1);
						rs1.last();
						int rowCount1 = rs1.getRow();
						rs1.first();
						for(int i = 0;i < rowCount1;i++){
							out.print("<option value='"+rs1.getString("entrance_time")+"'>");
							out.print(rs1.getString("entrance_time"));
							out.print("</option>");
							rs1.next();
						}
						rs1.close();
					%>
				</select>
				<select id="u14collegechoice" class="collegechoice">
					<option value=0>Ñ§Ôº</option>
					<%
						ResultSet rs2 = sql.executeQuery(condition2);
						rs2.last();
						int rowCount2 = rs2.getRow();
						rs2.first();
						for(int i = 0;i < rowCount1;i++){
							out.print("<option value='"+rs2.getString("college_num")+"'>");
							out.print(rs2.getString("college_name"));
							out.print("</option>");
							rs2.next();
						}
						rs2.close();
					%>
				</select>
				<select id="u14departchoice" class="departchoice" disabled="disabled">
					<option value=0>Ïµ</option>
				</select>
				<select id="u14classchoice" class="classchoice" disabled="disabled">
					<option value=0>°à¼¶</option>
				</select>
			</div>
			<div class="grouptype">
				·Ö×é·½Ê½£º
				<select id="u14grouptypechoice" class="grouptypechoice">
					<option value=1>Ñ§Ôº</option>
					<option value=2>Ïµ</option>
					<option value=3>°à¼¶</option>
				</select>
			</div>
			<div id="chartarea2">
			</div>
		</div>
		<div id="u15">
			<div class="charttype">
				Í¼±íÑùÊ½£º
				<select id="charttypechoice3" class="charttypechoice">
					<option value=1>Öù×´Í¼</option>
					<option value=2>»·ÐÎÍ¼</option>
				</select>
			</div>
			<div id="targetgroup2" class="targetgroup">
				ÓÃ»§×éÑ¡Ôñ£º
				<select id="u15sexchoice" class="sexchoice">
					<option value=0>ÐÔ±ð</option>
					<option value=1>ÄÐ</option>
					<option value=2>Å®</option>
				</select>
				<select id="u15entrancetimechoice" class="entrancetimechoice">
					<option value=0>ÈëÑ§Äê·Ý</option>
					<%
						ResultSet rs3 = sql.executeQuery(condition1);
						rs3.last();
						int rowCount3 = rs3.getRow();
						rs3.first();
						for(int i = 0;i < rowCount3;i++){
							out.print("<option value='"+rs3.getString("entrance_time")+"'>");
							out.print(rs3.getString("entrance_time"));
							out.print("</option>");
							rs3.next();
						}
						rs3.close();
					%>
				</select>
				<select id="u15collegechoice" class="collegechoice">
					<option value=0>Ñ§Ôº</option>
					<%
						ResultSet rs4 = sql.executeQuery(condition2);
						rs4.last();
						int rowCount4 = rs4.getRow();
						rs4.first();
						for(int i = 0;i < rowCount4;i++){
							out.print("<option value='"+rs4.getString("college_num")+"'>");
							out.print(rs4.getString("college_name"));
							out.print("</option>");
							rs4.next();
						}
						rs4.close();
					%>
				</select>
				<select id="u15departchoice" class="departchoice" disabled="disabled">
					<option value=0>Ïµ</option>
				</select>
				<select id="u15classchoice" class="classchoice" disabled="disabled">
					<option value=0>°à¼¶</option>
				</select>
			</div>
			<div id="chartarea3">
				<div id="chartmain3" style="width: 55%">
					<canvas id="canvas3" height="450" width="600"></canvas>
				</div>
			</div>
		</div>
	</div>
</body>
</html>