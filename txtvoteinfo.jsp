<%@ page language="java" contentType="text/html; charset=GB2312"%>
<%@ page import="web.bean.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="style/templates.css" type="text/css" rel="stylesheet" rev="stylesheet"/>
<link href="style/txtvoteinfo.css" type="text/css" rel="stylesheet" rev="stylesheet"/>
<script src="resources/jquery.js"></script>
<script type="text/javascript">
<%
	CheckVoteDetailBean bean = null;
	bean = (CheckVoteDetailBean)session.getAttribute("checkVoteDetailBean");
	LoginBean loginBean = null;
	loginBean = (LoginBean)session.getAttribute("loginBean");
	String userID = loginBean.getUserID();
	int num = bean.getOptionNum();
	String voteTittle = bean.getVoteTittle();
	String voteCreator = bean.getVoteCreator();
	String userAnswer = bean.getUserAnswer();
	String voteInfo = bean.getVoteinfo();
	int isOutOfDate = bean.getIsOutOfDate();
	int voteState = bean.getVoteState();
	int voteID = bean.getVoteID();
%>
$(document).ready(function(){
	$("#votetittle").text("<%=voteTittle%>");
<%
	if(voteInfo != ""){
%>
		$("#voteinfo").text("<%=voteInfo%>");
<%
	}
%>
	if($("#voteinfo").text()){
		$("#voteinfo").text("投票描述：");
		$("#voteinfo").append("<%=voteInfo%>");
	}
<%
	if(isOutOfDate == 1){
%>
		$("#votestateinfo").attr("class","votestateinfo2");
<%
	}
	else if(isOutOfDate == 0){
%>
		$("#votestateinfo").attr("class","votestateinfo1");
<%
	}
%>
	if($("#votestateinfo").attr("class") == "votestateinfo1"){
		$("#votestatetxt").text("投票进行中");
		$("#buttontxt").text("提交");
	};
	if($("#votestateinfo").attr("class") == "votestateinfo2"){
		$("#votestatetxt").text("投票已结束");
		$("#inputtxt").attr("disabled","disabled");
		$("#submitbutton").attr("class","return");
		$("#buttontxt").text("返回");
	};
	if($("#inputtxt").attr("disabled") == "disabled"){
		$("#inputtxt").val("");
	};
<%
	if(voteState == 1){
%>
		$("#inputtxt").css("color","#666666")
		$("#inputtxt").val("<%=userAnswer%>");
		$("#inputtxt").attr("disabled","disabled");
		$("#submitbutton").attr("class","return");
		$("#buttontxt").text("返回");
<%
	}
	if(userID.equals(voteCreator)){
%>
		$("#inputmain").after("<form action='voteAnalyzeServlet' method='post'><div id='resultanalysebutton'><div id='submit_img'><input id='resultanalyse' name='Button1' type='submit' value='' width='100' height='30' align='middle'></div><div id='buttontxt'>查看投票结果</div></div></form>");
<%
	}
%>
	var div1 = document.getElementById("votetittle");
	var div2 = document.getElementById("inputmain");
	var div3 = document.getElementById("submitbutton");
	var div4 = document.getElementById("resultanalysebutton");
	var div5 = document.getElementById("voteinfo");
	var div6 = document.getElementById("left_bg");
	var div7 = document.getElementById("u8");
	var height1 = div1.offsetTop + div1.offsetHeight + 10;
	div5.style.top = height1 + "px";
	var height2 = div1.offsetTop + div1.offsetHeight + div5.offsetHeight + 19;
	var height3 = height2 + div2.offsetHeight + 15;
	div2.style.top = height2+"px";
	div3.style.top = height3+"px";
	div4.style.top = height3+"px";
	div4.style.left = "900px";
	var height4 = div2.offsetTop + div2.offsetHeight + 60;
	var height5 = div2.offsetTop + div2.offsetHeight + 300;
	div7.style.height = height4+"px";
	div6.style.height = height5+"px";
	$(".return").click(function(){
		window.location.href="checkvote.jsp";
	});
	$(".submit").click(function(){
		if($("#inputtxt").val() == "" || $("#inputtxt").val() == "请输入，限250字"){
			alert("请输入回答！");
		}
		else{
			var inputTxt = $("#inputtxt").val();
			$.post("submittxtVoteServlet",
			{
				userID:<%=userID%>,
				voteID:<%=voteID%>,
				inputTxt:inputTxt
			},
			function(data,status){
				if(data == "1"){
					alert('投票成功！');
					window.location.href = 'checkvote.jsp';
				}
				else if(data == "0"){
					alert('投票失败！请稍后重试');
				}
			});
		}
	});
});
</script>
<title>投票-浙江传媒学院投票网</title>
</head>
<body>
	<div id="top">
		<div id="u1">
			<div id="logo">
				<img id="logo_img" class="img " src="images/index_logo.png"/>
			</div>
		</div>
		<div id="u2">
			<img id="logo_img" class="img " src="images/u3_line.png"/>
		</div>
		<div id="u3">
			<div id="u3_1">
				<p>欢迎 ${sessionScope.loginBean.logName} 用户登录本系统&nbsp;&nbsp;<a id="likTc" href="Exit.jsp">退出</a></p>
			</div>
			<div id="u3_2">
				<p></p>				<!-- 重要通知（走马灯） -->
			</div>
			<div id="u3_3">
				<script type="text/javascript">
					function showTime(){
						var today = new Date();
						var year = today.getFullYear();
						var date = today.getDate();
						var day = today.getDay();
						var month = today.getMonth()+1;
						if(day==0) var xingqi = "星期日";
						if(day==1) var xingqi = "星期一";
						if(day==2) var xingqi = "星期二";
						if(day==3) var xingqi = "星期三";
						if(day==4) var xingqi = "星期四";
						if(day==5) var xingqi = "星期五";
						if(day==6) var xingqi = "星期六";
						var dateString  = today.toLocaleDateString(); //这个是显示的效果比较好
						var dateAndTime = today.toLocaleString(); 
						var time = today.toLocaleTimeString();
						var hour = today.getHours();
						var minute = today.getMinutes();
						if(minute < 10){
							minute = "0" + minute;
						}
						var second = today.getSeconds();
						if(second < 10){
							second = "0" + second;
						}
						timeString = "<p>" + year + "-" + month + "-" + date + "  " + xingqi + " " + hour + ":" + minute+ ":" + second + "</p>";
						document.getElementById("u3_3").innerHTML = timeString;
						window.setTimeout("showTime();", 1000);
					}
					window.onload = showTime;
				</script>
			</div>
		</div>
		<div id="u4">
			<img id="logo_img" class="img " src="images/u18_line.png"/>
		</div>
	</div>
	<div id="left">
		<div id="left_bg" style="z-index:-1;min-height: 100%">
			<!-- 个人中心  -->
			<form action="userCenterServlet" method="post">
				<input id="u5" name="Button1" type="submit" value="" width="143" height="143" align="middle">
			</form>
			<!-- 查看投票  -->
			<div id="u6">
				<img src="images/checkvote_state2.png" name="checkvote_pic" width="143" height="143" border="0" align="middle"> 
			</div>
			<!-- 创建投票  -->
			<a href="createvote.jsp"><img id="u7" value="" width="143" height="143" align="middle"></a>
		</div>
	</div>
	
	<div id="right">
		<div id="votestateinfo">
			<div id="votestatetxt" style="margin-left:45px"></div>
			<div id="voteimg"></div>
		</div>
		<div id="u8">
			<div id="votetittle"></div>
			<div id="voteinfo"></div>
			<div id="inputmain" >
				<div id="input">
					<textarea id="inputtxt" rows="5" maxlength="250" onfocus="if (value =='请输入，限250字'){value=''}" onblur="if (value ==''){value='请输入，限250字'}">请输入，限250字</textarea>
				</div>
			</div>
			<div id="submitbutton" class="submit">
				<div id="submit_img">
					<img src="images/loginbutton.png" width="100" height="30" border="0" align="middle"/>
				</div>
				<div id="buttontxt"></div>
			</div>
		</div>
	</div>
</body>
</html>