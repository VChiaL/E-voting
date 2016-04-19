<%@ page language="java" contentType="text/html; charset=GB2312"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "web.bean.*" %>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
				<p>»¶Ó­ ${sessionScope.loginBean.logName} ÓÃ»§µÇÂ¼±¾ÏµÍ³&nbsp;&nbsp;<a id="likTc" href="Exit.jsp">ÍË³ö</a></p>
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
		</div>
	</div>
</body>
</html>