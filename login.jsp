<%@ page language="java" contentType="text/html; charset=GB2312"%>
<%@ page import="web.bean.LoginBean" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="style/login.css" type="text/css" rel="stylesheet" rev="stylesheet"/>
<script src="http://api.geetest.com/get.php"></script>
<script src="resources/jquery.js"></script>
<script src="resources/jquery-form.js"></script>
<script>
<%
	LoginBean lgnBean = null;
	lgnBean = (LoginBean)session.getAttribute("loginBean");
	if(lgnBean != null){
		response.sendRedirect("usercenter.jsp");
	}
	else{}
%>
var userNameChangeFlag = 0;
$(document).ready(function(){
	$("#u8_input").focus(function(){
		if(userNameChangeFlag == 0){
			var	str = $(this).val();
			this.style.color="#000";
			$(this).val("");
			userNameChangeFlag = 1;
		}
	});
	$("#Button1").click(function(){
		$("#loginform").ajaxSubmit({
			type: "POST",
			url:"VerifyLoginServlet",
			async:false,
			data: {
                "user": $("#u8_input").val(),
                "password": $("#u10_input").val()
            },
			error: function (request) {
				alert("·¢ËÍÇëÇóÊ§°Ü£¡");
			},
			success: function (data,status) {
				if(data == 1){
					window.location.href = "userCenterServlet";
				}
				else if(data == 2){
					document.getElementById("backnews").innerHTML="ÓÃ»§Ãû»òÃÜÂë´íÎó";
				}
				else if(data == 3){
					document.getElementById("backnews").innerHTML="ÇëÊäÈëÓÃ»§ÃûºÍÃÜÂë";
				}
				else{
					document.getElementById("backnews").innerHTML=""+data;
				}
            }
		});
	});
});
</script>
<title>Õã½­´«Ã½Ñ§ÔºÍ¶Æ±Íø</title>
<style>
a{font-size:13px}
a:link {color: black; text-decoration:none;}
a:visited {color:black;text-decoration:none;}
a:hover{color: #990000;text-decoration:none;}
#u11 a{font-size:12px}
#u11 a:link{color:#666666;text-decoration:none;}
#u11 a:visited {color:#666666;text-decoration:none;}
#u11 a:hover{color: #990000;text-decoration:none;}
</style>
</head>
<body>
	<div id="u0">
		<div id="u20">
			<img id="u20_img" class="img " src="images/login_web_logo.png"/>
		</div>
	</div>
	<div id="u3">
		<img id="u3_line" class="img " src="images/u3_line.png"/>
	</div>
	<div id="u4">
	<img id="u4_img" class="img " src="images/u4.png"/>
		<form id="loginform">
			<div id="u7" class="text">
		    	<p>ÓÃ»§Ãû£º</p>
		    </div>
		    <div id="u8">
	    		<input name="txtUserName" id="u8_input" type="text" value="ÓÃ»§Ãû/ÊÖ»úºÅ"/>
			</div>
			<div id="u9" class="text">
		    	<p>ÃÜ&nbsp;&nbsp;Âë£º</p>
		    </div>
		    <div id="u10">
	    		<input name="txtUserPassword" id="u10_input" type="password" value=""/>
			</div>
			<div id="backnews"></div>
			<div id="captcha"></div>
			<script src="http://static.geetest.com/static/tools/gt.js"></script>
			<script>
				var handler = function (captchaObj) {
			         // ½«ÑéÖ¤Âë¼Óµ½idÎªcaptchaµÄÔªËØÀï
			         captchaObj.appendTo("#captcha");
			     };
			     $.ajax({
			        // »ñÈ¡id£¬challenge£¬success£¨ÊÇ·ñÆôÓÃfailback£©
			        url: "StartCaptchaServlet",
			        type: "get",
			        dataType: "json", // Ê¹ÓÃjsonp¸ñÊ½
			        success: function (data) {
			            // Ê¹ÓÃinitGeetest½Ó¿Ú
			            // ²ÎÊý1£ºÅäÖÃ²ÎÊý£¬Óë´´½¨GeetestÊµÀýÊ±½ÓÊÜµÄ²ÎÊýÒ»ÖÂ
			            // ²ÎÊý2£º»Øµ÷£¬»Øµ÷µÄµÚÒ»¸ö²ÎÊýÑéÖ¤Âë¶ÔÏó£¬Ö®ºó¿ÉÒÔÊ¹ÓÃËü×öappendToÖ®ÀàµÄÊÂ¼þ
			            initGeetest({
			                gt: data.gt,
			                challenge: data.challenge,
			                product: "float", // ²úÆ·ÐÎÊ½
			                offline: !data.success
			            }, handler);
			        }
				});
			</script>
			<div id="u11">
				<p><a href="updatepsd.jsp">Íü¼ÇÃÜÂë£¿</a></p>
			</div>
			<input name="Button1" value="µÇ&nbsp;&nbsp;Â½" id="Button1" type="button">
			<div id="u12" class="register">
				<p>Ã»ÓÐÕËºÅ£¿&nbsp;&nbsp;<a href="register.jsp">×¢²á</a></p>
			</div>
		</form>
    </div>
</body>
</html>