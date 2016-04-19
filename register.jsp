<%@ page language="java" contentType="text/html; charset=GB2312"%>
<%@ page import="web.bean.LoginBean" %>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="style/register.css" type="text/css" rel="stylesheet" rev="stylesheet"/>
<script src="http://api.geetest.com/get.php"></script>
<script src="http://libs.baidu.com/jquery/1.9.0/jquery.js"></script>
<title>Õã´«Í¶Æ±Íø-×¢²á</title>
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
<script src="resources/jquery.js"></script>
<script src="resources/jquery-form.js"></script>
<script src="http://api.geetest.com/get.php?callback=initCaptcha"></script>
<script type="text/javascript">
var wait=60;
var selectFlag = 1;
var flagFlag = 1;
var codeText = "";

var wait=60;
function time(o){
	if (wait == 0) {
		o.removeAttribute("disabled");   
		o.innerHTML="»ñÈ¡ÑéÖ¤Âë";
		wait = 60;
	}
	else { 
		o.setAttribute("disabled", true);
		o.innerHTML="ÖØÐÂ·¢ËÍ(" + wait + ")";
		wait--;
		setTimeout(function() {time(o)},1000);
	}
}
var nickNameFlag = 0;
var setPsdFlag = 0;
var confirmPsdFlag = 0;
var isVerifyFlag = 0;
var isPhoneFlag = 0;
var verificationFlag = 0;

function OnInput (event) {
	var value = event.target.value;
	checkphone(value);
}
function checkphone(value){
	var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
	if(myreg.test(value) == true){
		//¸ñÊ½ÕýÈ·
		document.getElementById("phonemark").innerHTML="<img style='width:20px;height:20px' src='images/check.png'>";
		isPhoneFlag = 1;
	}else{
		//¸ñÊ½´íÎó
		document.getElementById("phonemark").innerHTML="<img style='width:20px;height:20px' src='images/cross.png'>";
		isPhoneFlag = 0;
	}
}
function submitRegisterForm(){
	document.getElementById("registerinfoform").submit();
}
$(document).ready(function(){
	$("#phonetxt").blur(function(){
		$.post("checkPhoneServlet",
		{
			phone:$("#phonetxt").val(),
			type:1
		},
		function(data,status){
			if(data == 1){
				document.getElementById("phonemark").innerHTML="<img style='width:20px;height:20px' src='images/cross.png'>";
				document.getElementById("error").innerHTML="¸ÃÊÖ»úºÅÒÑ±»Õ¼ÓÃ";
				isPhoneFlag = 0;
			}
		});
	});
	$("#usernicknametxt").blur(function(){
		var standard = /^[a-zA-Z0-9_]{1,}$/;
		if(standard.test($("#usernicknametxt").val())){
			$.post("checkNickNameServlet",
			{name:$("#usernicknametxt").val()},
			function(data,status){
				if(data == 1){
					document.getElementById("usernicknametip").style.color = "green";
					document.getElementById("usernicknametip").innerHTML="¿ÉÒÔÊ¹ÓÃ";
					nickNameFlag = 1;
				}
				else if(data == 0){
					document.getElementById("usernicknametip").style.color = "red";
					document.getElementById("usernicknametip").innerHTML="¸ÃÓÃ»§ÓÃÒÑ±»Õ¼ÓÃ";
					nickNameFlag = 0;
				}
			});
		}
		else{
			document.getElementById("usernicknametip").style.color = "red";
			document.getElementById("usernicknametip").innerHTML="°üº¬·Ç·¨×Ö·û";
			nickNameFlag = 0;
		}
	});
	$("#setpsdtxt").blur(function(){
		var regex = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$/;
		var value = $("#setpsdtxt").val();
		if(regex.test(value)){
			document.getElementById("psdmark").innerHTML="<img style='width:20px;height:20px' src='images/check.png'>";
			setPsdFlag = 1;
		}
		else{
			document.getElementById("psdmark").innerHTML="<img style='width:20px;height:20px' src='images/cross.png'>";
			setPsdFlag = 0;
		}
	});
	$("#confirmpsdtxt").blur(function(){
		if($("#setpsdtxt").val() == $("#confirmpsdtxt").val()){
			document.getElementById("confirmpsdmark").innerHTML="<img style='width:20px;height:20px' src='images/check.png'>";
			confirmPsdFlag = 1;
		}
		else{
			document.getElementById("confirmpsdmark").innerHTML="<img style='width:20px;height:20px' src='images/cross.png'>";
			confirmPsdFlag = 0;
		}
	});
	$("#requestverification").click(function(){
		document.getElementById("error").innerHTML="";
		if(isPhoneFlag == 1){
			$("#captchaform").ajaxSubmit({
				type: "POST",
				url:"registerVerifyServlet",
				async:false,
				data: {
	                "phone": $("#phonetxt").val(),
	                "type": 1
	            },
				error: function (request) {
					alert("·¢ËÍÇëÇóÊ§°Ü£¡");
				},
				success: function (data,status) {
					var obj = JSON.parse(data);
					codeText = obj.codeText;
					if(obj.status == "1"){
						isVerifyFlag = 1;
						var o = document.getElementById("requestverification");
						time(o);
					}
					else if(data == 0){
						isVerifyFlag = 0;
						document.getElementById("error").innerHTML="ÇëÏÈ½øÐÐÑéÖ¤";
					}
	            }
			});
		}
		else if(isPhoneFlag == 0){
			document.getElementById("error").innerHTML="ÊÖ»úºÅ²»ÕýÈ·";
		}
	});
	$("#verificationtxt").blur(function(){
		if($("#verificationtxt").val() == codeText){
			document.getElementById("verificationmark").innerHTML="<img style='width:20px;height:20px' src='images/check.png'>";
			verificationFlag = 1;
		}
		else{
			document.getElementById("verificationmark").innerHTML="<img style='width:20px;height:20px' src='images/cross.png'>";
			verificationFlag = 0;
		}
	});
	$("#schoolselect").change(function(){
		$("#schoolentrancetimeselect").removeAttr("disabled");
		$.post("schoolChoiceChangeServlet",
		{school:$("#schoolselect").find("option:selected").attr("value")},
		function(data,status){
			$("#collegeselect").empty();
			$("#collegeselect").append("<option value=0>¶þ¼¶Ñ§Ôº</option>");
			$("#collegeselect").append(data);
		});
	});
	$("#schoolentrancetimeselect").change(function(){
		$("#collegeselect").removeAttr("disabled");
	});
	$("#collegeselect").change(function(){
		$("#departselect").removeAttr("disabled");
		$.post("collegeChoiceChangeServlet",
		{college:$("#collegeselect").find("option:selected").text()},
		function(data,status){
			$("#departselect").empty();
			$("#departselect").append("<option value=0>Ïµ</option>");
			$("#departselect").append(data);
		});
	});
	$("#departselect").change(function(){
		$("#classselect").removeAttr("disabled");
		$.post("departChoiceChangeServlet",
		{
			departNum:$("#departselect").find("option:selected").attr("value"),
			entranceTime:$("#schoolentrancetimeselect").find("option:selected").attr("value")
		},
		function(data,status){
			$("#classselect").empty();
			$("#classselect").append("<option value=0>°à¼¶</option>");
			$("#classselect").append(data);
		});
	});
	$("#submitbutton").click(function(){
		if(nickNameFlag == 0 || setPsdFlag == 0 || confirmPsdFlag == 0 || isVerifyFlag == 0 || isPhoneFlag == 0 || verificationFlag == 0){
			flagFlag = 0;
		}
		if($("#schoolselect").find("option:selected").attr("value") == 0 || $("#schoolentrancetimeselect").find("option:selected").attr("value") == 0 || $("#collegeselect").find("option:selected").attr("value") == 0 || $("#departselect").find("option:selected").attr("value") == 0 || $("#classselect").find("option:selected").attr("value") == 0 || $("#sexselect").find("option:selected").attr("value") == 0 || $("#politicaltypeselect").find("option:selected").attr("value") == 0 || $("#nationalitytypeselect").find("option:selected").attr("value") == 0){
			selectFlag = 0;
		}
		if($("#usernicknametxt").val() != "" && $("#setpsdtxt").val() != "" && $("#phonetxt").val() != "" && $("#stuIDtxt").val() != "" && $("#truenametxt").val() != 0 && selectFlag == 1 && flagFlag ==1){
			$.post("registerUserServlet",
			{
				usernickname:$("#usernicknametxt").val(),
				password:$("#setpsdtxt").val(),
				phone:$("#phonetxt").val(),
				school:$("#schoolselect").find("option:selected").attr("value"),
				entranceTime:$("#schoolentrancetimeselect").find("option:selected").attr("value"),
				college:$("#collegeselect").find("option:selected").attr("value"),
				depart:$("#departselect").find("option:selected").attr("value"),
				classnum:$("#classselect").find("option:selected").attr("value"),
				stuID:$("#stuIDtxt").val(),
				sex:$("#sexselect").find("option:selected").attr("value"),
				truename:$("#truenametxt").val(),
				political:$("#politicaltypeselect").find("option:selected").attr("value"),
				nationality:$("#nationalitytypeselect").find("option:selected").attr("value")
			},
			function(data,status){
				if(data == 1){
					alert("×¢²á³É¹¦£¡");
					window.location.href = 'login.jsp';
				}
				else if(data == 0){
					alert("×¢²áÊ§°Ü£¡");
				}
			});
		}
		else{
			alert("Çë½«ÐÅÏ¢ÌîÐ´ÍêÕû");
		}
	});
});
</script>
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
	<%
		Connection con;
		Statement sql;
		String uri = "jdbc:mysql://localhost:3306/evoting?"
				+"user=root&password=1234&characterEncoding=gb2312";
		con = DriverManager.getConnection(uri);
		String condition1 = "SELECT * FROM school";
		sql = con.createStatement();
	%>
		<img id="u4_img" class="img " src="images/registerbg.png"/>
		<div id="usernickname" class="question">
			<div class="questiontxt">ÓÃ»§Ãû£º</div>
			<input id="usernicknametxt" class="txt" />
		</div>
		<div id="setpsd" class="question">
			<div class="questiontxt">ÉèÖÃÃÜÂë£º</div>
			<input id="setpsdtxt" type="password" class="txt" />
			<div id="psdmark"></div>
		</div>
		<div id="confirmpsd" class="question">
			<div class="questiontxt">È·ÈÏÃÜÂë£º</div>
			<input id="confirmpsdtxt" type="password" class="txt" />
			<div id="confirmpsdmark"></div>
		</div>
		<div id="phone" class="question">
			<div class="questiontxt">ÊÖ»úºÅ£º</div>
			<input id="phonetxt" class="txt" oninput="OnInput (event)" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
			<div id="phonemark"></div>
			<div id="error"></div>
		</div>
		<form id="captchaform">
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
			                offline: !data.success,
			                width: "50%"
			            }, handler);
			        }
				});
			</script>
			<button type="button" class="button gray" id="requestverification">»ñÈ¡ÑéÖ¤Âë</button>
		</form>
		<div id="verification" class="question">
			<div class="questiontxt">ÊÖ»úÑéÖ¤Âë£º</div>
			<input id="verificationtxt" class="txt" />
			<div id="verificationmark"></div>
		</div>
		<div id="school" class="question">
			<div class="questiontxt">Ñ§Ð££º</div>
			<select id="schoolselect" class="select">
				<option value=0>Ñ§Ð£</option>
			<%
				ResultSet rs1 = sql.executeQuery(condition1);
				rs1.last();
				int rowCount1 = rs1.getRow();
				rs1.first();
				for(int i = 0;i < rowCount1;i++){
					out.print("<option value='"+rs1.getInt("school_num")+"'>");
					out.print(rs1.getString("school_name"));
					out.print("</option>");
					rs1.next();
				}
				rs1.close();
			%>
			</select>
		</div>
		<div id="schoolentrancetime" class="question">
			<div class="questiontxt">ÈëÑ§Äê·Ý£º</div>
			<select id="schoolentrancetimeselect" class="select" disabled="disabled">
				<option value=0>ÈëÑ§Äê·Ý</option>
				<option value=2012>2012</option>
				<option value=2013>2013</option>
				<option value=2014>2014</option>
				<option value=2015>2015</option>
			</select>
		</div>
		<div id="college" class="question">
			<div class="questiontxt">¶þ¼¶Ñ§Ôº£º</div>
			<select id="collegeselect" class="select" disabled="disabled">
				<option value=0>¶þ¼¶Ñ§Ôº</option>
			</select>
		</div>
		<div id="depart" class="question">
			<div class="questiontxt">Ïµ£º</div>
			<select id="departselect" class="select" disabled="disabled">
				<option value=0>Ïµ</option>
			</select>
		</div>
		<div id="class" class="question">
			<div class="questiontxt">°à¼¶£º</div>
			<select id="classselect" class="select" disabled="disabled">
				<option value=0>°à¼¶</option>
			</select>
		</div>
		<div id="stuID" class="question">
			<div class="questiontxt">Ñ§ºÅ£º</div>
			<input id="stuIDtxt" class="txt" />
		</div>
		<div id="sex" class="question">
			<div class="questiontxt">ÐÔ±ð£º</div>
			<select id="sexselect" class="select">
				<option value=0>ÐÔ±ð</option>
				<option value=1>ÄÐ</option>
				<option value=2>Å®</option>
			</select>
		</div>
		<div id="truename" class="question">
			<div class="questiontxt">ÕæÊµÐÕÃû£º</div>
			<input id="truenametxt" class="txt" />
		</div>
		<div id="politicaltype" class="question">
			<div class="questiontxt">ÕþÖÎÃæÃ²£º</div>
			<select id="politicaltypeselect" class="select">
				<option value=0>ÕþÖÎÃæÃ²</option>
				<option value=1>ÈºÖÚ</option>
				<option value=2>¹²ÇàÍÅÔ±</option>
				<option value=3>ÖÐ¹²Ô¤±¸µ³Ô±</option>
				<option value=4>ÖÐ¹²µ³Ô±</option>
			</select>
		</div>
		<div id="nationalitytype" class="question">
			<div class="questiontxt">Ãñ×å£º</div>
			<select id="nationalitytypeselect" class="select">
				<option value=0>Ãñ×å</option>
				<option value=1>ºº×å</option>
				<option value=2>ÉÙÊýÃñ×å</option>
			</select>
		</div>
		<div id="usernicknametip" class="tip">¿É×Ô¶¨Òå£¬½öÏÞÊý×Ö¡¢×ÖÄ¸ºÍ"_"</div>
		<div id="psdtip" class="tip">8-16Î»£¬°üº¬Êý×ÖºÍ×ÖÄ¸</div>
		<div id="schooltip" class="tip">* ÇëÎñ±ØÌîÐ´ÕæÊµÐÅÏ¢</div>
		<div id="schoolentrancetimetip" class="tip">* ÇëÎñ±ØÌîÐ´ÕæÊµÐÅÏ¢</div>
		<div id="collegetip" class="tip">* ÇëÎñ±ØÌîÐ´ÕæÊµÐÅÏ¢</div>
		<div id="departtip" class="tip">* ÇëÎñ±ØÌîÐ´ÕæÊµÐÅÏ¢</div>
		<div id="classtip" class="tip">* ÇëÎñ±ØÌîÐ´ÕæÊµÐÅÏ¢</div>
		<div id="stuIDtip" class="tip">* ÇëÎñ±ØÌîÐ´ÕæÊµÐÅÏ¢</div>
		<div id="sextip" class="tip">* ÇëÎñ±ØÌîÐ´ÕæÊµÐÅÏ¢</div>
		<div id="truenametip" class="tip">* ÇëÎñ±ØÌîÐ´ÕæÊµÐÅÏ¢</div>
		<div id="politicaltypetip" class="tip">* ÇëÎñ±ØÌîÐ´ÕæÊµÐÅÏ¢</div>
		<div id="nationalitytypetip" class="tip">* ÇëÎñ±ØÌîÐ´ÕæÊµÐÅÏ¢</div>
    </div>
    <input name="submitbutton" value="×¢&nbsp;&nbsp;²á" id="submitbutton" type="submit" onclick="submitRegisterForm();">
</body>
</html>