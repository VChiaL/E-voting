<%@ page language="java" contentType="text/html; charset=GB2312"%>
<%@ page import="web.bean.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="style/templates.css" type="text/css" rel="stylesheet" rev="stylesheet"/>
<link href="style/usercenter.css" type="text/css" rel="stylesheet" rev="stylesheet"/>
<jsp:useBean id="userCenterBean" class="web.bean.UserCenterBean" scope="session"></jsp:useBean>
<script src="resources/jquery.js"></script>
<script type="text/javascript">
<%
	UserCenterBean bean = null;
	bean = (UserCenterBean)session.getAttribute("userCenterBean");
	int num1 = bean.getVoteNum1();
	String[] votetittle1 = bean.getVoteTittle1();
	int num2 = bean.getVoteNum2();
	String[] votetittle2 = bean.getVoteTittle2();
	int num3 = bean.getVoteNum3();
	String[] votetittle3 = bean.getVoteTittle3();
	int[] voteID1 = bean.getVoteID1();
	int[] voteID2 = bean.getVoteID2();
	int[] voteID3 = bean.getVoteID3();
%>
function reload(o){
	var voteID = o.id;
	window.location.href="checkVoteDetailServlet?voteID="+voteID;
}
function reload2(o){
	var voteID = o.id;
	window.location.href="checkCandidateServlet?voteID="+voteID;
}
$(document).ready(function(){
<%
	for(int i = 0;i < num1;i++){
%>
		$("#u19").append("<div class='vote' id='<%=voteID1[i]%>' style='margin-top:30px;top:"+100*<%=i%>+"px' onclick='reload(this);'>"+"<%=votetittle1[i]%>"+"</div>");
<%
	}
%>
<%
	for(int i = 0;i < num2;i++){
%>
		$("#u22").append("<div class='vote' id='<%=voteID2[i]%>' style='margin-top:30px;top:"+100*<%=i%>+"px' onclick='reload(this);'>"+"<%=votetittle2[i]%>"+"</div>");
<%
	}
%>
<%
	for(int i = 0;i < num3;i++){
%>
		$("#u24").append("<div class='vote' id='<%=voteID3[i]%>' style='margin-top:30px;top:"+100*<%=i%>+"px' onclick='reload2(this);'>"+"<%=votetittle3[i]%>"+"</div>");
<%
	}
%>
	var div1 = document.getElementById("u19");
	var div2 = document.getElementById("u22");
	var div4 = document.getElementById("u24");
	var div3 = document.getElementById("left_bg");
	var height1 = 80+100*<%=num1%>;
	var height2 = 80+100*<%=num2%>;
	var height3 = 80+100*<%=num3%>;
	div1.style.height = height1+"px";
	div3.style.height = height1+400+"px";
	function divReload1(){
		div1.style.height = height1+"px";
		div3.style.height = height1+400+"px";
	}
	function divReload2(){
		div2.style.height = height2+"px";
		div3.style.height = height2+400+"px";
	}
	function divReload3(){
		div4.style.height = height3+"px";
		div3.style.height = height3+400+"px";
	}
	$("#u22").hide();
	$("#u17_img").click(function(){
		$("#u22").hide();
		$("#u19").show();
		$("#u24").hide();
		divReload1();
	});
	$("#u18_img").click(function(){
		$("#u19").hide();
		$("#u22").show();
		$("#u24").hide();
		divReload2();
	});
	$("#u23_img").click(function(){
		$("#u19").hide();
		$("#u22").hide();
		$("#u24").show();
		divReload3();
	});
	$("#u17_img").click(function(){
		$("#u17_img").find("img").attr("src","images/underline.png");
		$("#u17_img").find("img").removeAttr("onMouseOver");
		$("#u17_img").find("img").removeAttr("onMouseOut");
		$("#u18_img").find("img").attr("src","images/withoutunderline.png");
		$("#u18_img").find("img").attr("onMouseOver","this.src='images/underline.png'");
		$("#u18_img").find("img").attr("onMouseOut","this.src='images/withoutunderline.png'");
		$("#u23_img").find("img").attr("src","images/withoutunderline.png");
		$("#u23_img").find("img").attr("onMouseOver","this.src='images/underline.png'");
		$("#u23_img").find("img").attr("onMouseOut","this.src='images/withoutunderline.png'");
	});
	$("#u18_img").click(function(){
		$("#u18_img").find("img").attr("src","images/underline.png");
		$("#u18_img").find("img").removeAttr("onMouseOver");
		$("#u18_img").find("img").removeAttr("onMouseOut");
		$("#u17_img").find("img").attr("src","images/withoutunderline.png");
		$("#u17_img").find("img").attr("onMouseOver","this.src='images/underline.png'");
		$("#u17_img").find("img").attr("onMouseOut","this.src='images/withoutunderline.png'");
		$("#u23_img").find("img").attr("src","images/withoutunderline.png");
		$("#u23_img").find("img").attr("onMouseOver","this.src='images/underline.png'");
		$("#u23_img").find("img").attr("onMouseOut","this.src='images/withoutunderline.png'");
	});
	$("#u23_img").click(function(){
		$("#u23_img").find("img").attr("src","images/underline.png");
		$("#u23_img").find("img").removeAttr("onMouseOver");
		$("#u23_img").find("img").removeAttr("onMouseOut");
		$("#u17_img").find("img").attr("src","images/withoutunderline.png");
		$("#u17_img").find("img").attr("onMouseOver","this.src='images/underline.png'");
		$("#u17_img").find("img").attr("onMouseOut","this.src='images/withoutunderline.png'");
		$("#u18_img").find("img").attr("src","images/withoutunderline.png");
		$("#u18_img").find("img").attr("onMouseOver","this.src='images/underline.png'");
		$("#u18_img").find("img").attr("onMouseOut","this.src='images/withoutunderline.png'");
	});
});
</script>

<title>��������</title>
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
							var dateString  = today.toLocaleDateString();
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
			<div id="u5">
				<img src="images/usercenter_state2.png" name="usercenter_pic" width="143" height="143" border="0" align="middle" > 
			</div>
			<!-- �鿴ͶƱ  -->
			<form action="checkVoteServlet" method="post">
				<input id="u6" name="Button1" type="submit" value="" width="143" height="143" align="middle">
			</form>
			<!-- ����ͶƱ  -->
			<a href="createvote.jsp"><img id="u7" value="" width="143" height="143" align="middle"></a>
		</div>
	</div>
	<div id="right">
		<div id="u8">
			<div id="u9">
				<img id="u9_img" class="img " src="images/userimage.png"/>
			</div>
			<div id="u10">
				����ͷ��
			</div>
			<div id="u11">
				������ <jsp:getProperty name="userCenterBean" property="stuName" />
			</div>
			<div id="u12">
				ѧ�ţ� <jsp:getProperty name="userCenterBean" property="userId" />
			</div>
			<div id="u13">
				ѧУ�� <jsp:getProperty name="userCenterBean" property="school" />
			</div>
			<div id="u14">
				ѧԺ�� <jsp:getProperty name="userCenterBean" property="college" />
			</div>
			<div id="u15">
				�༶�� <jsp:getProperty name="userCenterBean" property="stuClass" />
			</div>
		</div>
		<div id="u16">
			<div id="u17">
				�����ͶƱ
			</div>
			<div id="u17_img">
				<img src="images/underline.png" width="200" height="40" border="0" align="middle" />
			</div>
			<div id="u18">
				�����ͶƱ
			</div>
			<div id="u18_img">
				<img src="images/withoutunderline.png" width="200" height="40" border="0" align="middle" onMouseOver="this.src='images/underline.png'" onMouseOut="this.src='images/withoutunderline.png'"/>
			</div>
			<div id="u23">
				�����ѡ��
			</div>
			<div id="u23_img">
				<img src="images/withoutunderline.png" width="200" height="40" border="0" align="middle" onMouseOver="this.src='images/underline.png'" onMouseOut="this.src='images/withoutunderline.png'"/>
			</div>
		</div>
		<div id="u19">
		</div>
		<div id="u22">
		</div>
		<div id="u24">
		</div>
	</div>
</body>
</html>