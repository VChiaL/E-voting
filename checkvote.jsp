<%@ page language="java" contentType="text/html; charset=GB2312"%>
<%@ page import="web.bean.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="style/templates.css" type="text/css" rel="stylesheet" rev="stylesheet"/>
<link href="style/checkvote.css" type="text/css" rel="stylesheet" rev="stylesheet"/>
<jsp:useBean id="checkVoteBean" class="web.bean.CheckVoteBean" scope="session"></jsp:useBean>
<script src="resources/jquery.js"></script>
<script type="text/javascript">
<%

	CheckVoteBean bean = null;
	bean = (CheckVoteBean)session.getAttribute("checkVoteBean");
	int num = bean.getVoteNum();
	String[] votetittle = bean.getVoteTittle();
	String[] votestarttime = bean.getVoteStartTime();
	String[] votedeadline = bean.getVoteDeadline();
	int[] isoutofdate = bean.getIsOutOfDate();
	int[] voteID = bean.getVoteID();
	int[] candidateVoteState = bean.getCandidateVoteState();
	int rowNum = 0;
	int n = 0;
	int i;
%>
$(document).ready(function(){
<%
	for(i = 0;i < num;i++){
		n++;
		if(n%4 == 0){
			n = 1;
			rowNum++;
		}
		if(isoutofdate[i] == 0){
			if(candidateVoteState[i] == 1){
%>
				$("#right").append("<div class='vote' id='<%=i%>' style='margin-top:169px;margin-left:177px;top:"+171*<%=rowNum%>+"px;left:"+390*<%=n-1%>+"px' value='<%=voteID[i]%>' onclick='window.location.href='checkVoteDetailServlet?voteID=<%=voteID[i]%>''><div class='votetittle'>"+"<%=votetittle[i]%>"+"</div><div class='votestarttime'>��ʼʱ�䣺"+"<%=votestarttime[i]%>"+"</div><div class='voteendtime'>����ʱ�䣺"+"<%=votedeadline[i]%>"+"</div><div class='votestate3'>��ѡ������<div id='voteimg'></div></div></div>");
<%
			}
			else if(candidateVoteState[i] == 0){
%>
				$("#right").append("<div class='vote' id='<%=i%>' style='margin-top:169px;margin-left:177px;top:"+171*<%=rowNum%>+"px;left:"+390*<%=n-1%>+"px' value='<%=voteID[i]%>' onclick='window.location.href='checkVoteDetailServlet?voteID=<%=voteID[i]%>''><div class='votetittle'>"+"<%=votetittle[i]%>"+"</div><div class='votestarttime'>��ʼʱ�䣺"+"<%=votestarttime[i]%>"+"</div><div class='voteendtime'>����ʱ�䣺"+"<%=votedeadline[i]%>"+"</div><div class='votestate1'>ͶƱ������<div id='voteimg'></div></div></div>");
<%	
			}
			else if(candidateVoteState[i] == 2){
%>
				$("#right").append("<div class='vote' id='<%=i%>' style='margin-top:169px;margin-left:177px;top:"+171*<%=rowNum%>+"px;left:"+390*<%=n-1%>+"px' value='<%=voteID[i]%>' onclick='window.location.href='checkVoteDetailServlet?voteID=<%=voteID[i]%>''><div class='votetittle'>"+"<%=votetittle[i]%>"+"</div><div class='votestarttime'>��ʼʱ�䣺"+"<%=votestarttime[i]%>"+"</div><div class='voteendtime'>����ʱ�䣺"+"<%=votedeadline[i]%>"+"</div><div class='votestate1'>ͶƱ������<div id='voteimg'></div></div></div>");
<%	
			}
		}
		else if(isoutofdate[i] == 1){
%>
			$("#right").append("<div class='vote' id='<%=i%>' style='margin-top:169px;margin-left:177px;top:"+171*<%=rowNum%>+"px;left:"+390*<%=n-1%>+"px' value='<%=voteID[i]%>' onclick='window.location.href='checkVoteDetailServlet?voteID=<%=voteID[i]%>''><div class='votetittle'>"+"<%=votetittle[i]%>"+"</div><div class='votestarttime'>��ʼʱ�䣺"+"<%=votestarttime[i]%>"+"</div><div class='voteendtime'>����ʱ�䣺"+"<%=votedeadline[i]%>"+"</div><div class='votestate2'>ͶƱ�ѽ���<div id='voteimg'></div></div></div>");
<%
		}
	}
%>
	var div1 = document.getElementById("left_bg");
	var height1 = 120+310*<%=rowNum%>;
	div1.style.height = height1+"px";
	$(".vote").click(function(){
		var name = $(this).attr("value");
		window.location.href="checkVoteDetailServlet?voteID="+name;
	});
});
</script>
<title>Insert title here</title>
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
				<p>��ӭ  ${sessionScope.loginBean.logName} �û���¼��ϵͳ&nbsp;&nbsp;<a id="likTc" href="Exit.jsp">�˳�</a></p>
			</div>
			<div id="u3_2">
				<p></p>				<!-- ��Ҫ֪ͨ������ƣ� -->
			</div>
			<div id="u3_3">
					<script type="text/javascript">
						function showTime(){
							var today = new Date();
							var year = today.getFullYear();
							var date = today.getDate();
							var day = today.getDay();
							var month = today.getMonth()+1;
							if(day==0) var xingqi = "������";
							if(day==1) var xingqi = "����һ";
							if(day==2) var xingqi = "���ڶ�";
							if(day==3) var xingqi = "������";
							if(day==4) var xingqi = "������";
							if(day==5) var xingqi = "������";
							if(day==6) var xingqi = "������";
							var dateString  = today.toLocaleDateString(); //�������ʾ��Ч���ȽϺ�
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
			<!-- ��������  -->
			<form action="userCenterServlet" method="post">
				<input id="u5" name="Button1" type="submit" value="" width="143" height="143" align="middle">
			</form>
			<!-- �鿴ͶƱ  -->
			<div id="u6">
				<img src="images/checkvote_state2.png" name="checkvote_pic" width="143" height="143" border="0" align="middle"> 
			</div>
			<!-- ����ͶƱ  -->
			<a href="createvote.jsp"><img id="u7" value="" width="143" height="143" align="middle"></a>
		</div>
	</div>
	<div id="right">
		
	</div>
</body>
</html>