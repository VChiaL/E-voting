<%@ page language="java" contentType="text/html; charset=GB2312"%>
<%@ page import="web.bean.LoginBean" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="style/updatepsd.css" type="text/css" rel="stylesheet" rev="stylesheet"/>
<script src="http://api.geetest.com/get.php"></script>
<script src="resources/jquery.js"></script>
<script src="resources/jquery-form.js"></script>
<script>
var wait=60;
var codeText = "";
var isPhoneFlag = 0;
var verificationFlag = 0;
var setPsdFlag = 0;
var confirmPsdFlag = 0;

function OnInput (event) {
	var value = event.target.value;
	checkphone(value);
	document.getElementById("phonemarktip").innerHTML="";
}
function checkphone(value){
	var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
	if(myreg.test(value) == true){
		//格式正确
		document.getElementById("phonemark").innerHTML="<img style='width:20px;height:20px' src='images/check.png'>";
		isPhoneFlag = 1;
	}else{
		//格式错误
		document.getElementById("phonemark").innerHTML="<img style='width:20px;height:20px' src='images/cross.png'>";
		isPhoneFlag = 0;
	}
}
function time(o){
	if (wait == 0) {
		o.removeAttribute("disabled");   
		o.innerHTML="获取验证码";
		wait = 60;
	}
	else { 
		o.setAttribute("disabled", true);
		o.innerHTML="重新发送(" + wait + ")";
		wait--;
		setTimeout(function() {time(o)},1000);
	}
}
$(document).ready(function(){
	$("#phone").blur(function(){
		$.post("checkPhoneServlet",
		{
			phone:$("#phone").val(),
			type:2
		},
		function(data,status){
			if(data == 0){
				document.getElementById("phonemark").innerHTML="<img style='width:20px;height:20px' src='images/cross.png'>";
				document.getElementById("phonemarktip").innerHTML="该手机号尚未注册";
				isPhoneFlag = 0;
			}
		});
	});
	$("#requestverification").click(function(){
		document.getElementById("error").innerHTML="";
		if(isPhoneFlag == 1){
			$("#captchaform").ajaxSubmit({
				type: "POST",
				url:"registerVerifyServlet",
				async:false,
				data: {
	                "phone": $("#phone").val(),
	                "type": 2
	            },
				error: function (request) {
					alert("发送请求失败！");
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
						document.getElementById("error").innerHTML="请先进行验证";
					}
	            }
			});
		}
		else if(isPhoneFlag == 0){
			document.getElementById("error").innerHTML="手机号不正确";
		}
	});
	$("#verificationcode").blur(function(){
		if($("#verificationcode").val() == codeText){
			document.getElementById("verificationmark").innerHTML="<img style='width:20px;height:20px' src='images/check.png'>";
			verificationFlag = 1;
		}
		else{
			document.getElementById("verificationmark").innerHTML="<img style='width:20px;height:20px' src='images/cross.png'>";
			verificationFlag = 0;
		}
	});
	$("#Button1").click(function(){
		if(isPhoneFlag == 1 && verificationFlag == 1){
			$("#tip2").remove();
			$("#captchaform").remove();
			$("#error").remove();
			$("#tip4").remove();
			$("#verificationcode").remove();
			$("#verificationmark").remove();
			$("#Button1").remove();
			$("#phonemark").after("<div id='tip5' class='tip'>请输入新的密码：</div><input id='setpsd' type='password'/><div id='psdmark'></div><div id='psdtip' class='tip'>8-16位，包含数字和字母</div><div id='tip6' class='tip'>请重新输入新的密码：</div><input id='confirmpsd' type='password'/><div id='confirmpsdmark'></div><input name='Button2' value='确&nbsp;&nbsp;认' id='Button2' type='submit'>");
			$("#setpsd").blur(function(){
				var regex = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$/;
				var value = $("#setpsd").val();
				if(regex.test(value)){
					document.getElementById("psdmark").innerHTML="<img style='width:20px;height:20px' src='images/check.png'>";
					setPsdFlag = 1;
				}
				else{
					document.getElementById("psdmark").innerHTML="<img style='width:20px;height:20px' src='images/cross.png'>";
					setPsdFlag = 0;
				}
			});
			$("#confirmpsd").blur(function(){
				if($("#setpsd").val() == $("#confirmpsd").val()){
					document.getElementById("confirmpsdmark").innerHTML="<img style='width:20px;height:20px' src='images/check.png'>";
					confirmPsdFlag = 1;
				}
				else{
					document.getElementById("confirmpsdmark").innerHTML="<img style='width:20px;height:20px' src='images/cross.png'>";
					confirmPsdFlag = 0;
				}
			});
			$("#Button2").click(function(){
				if(setPsdFlag == 1 && confirmPsdFlag == 1){
					$.post("updatePsdServlet",
					{
						phone:$("#phone").val(),
						password:$("#setpsd").val()
					},
					function(data,status){
						if(data == 1){
							alert("密码修改成功！");
							window.location.href = 'login.jsp';
						}
						else if(data == 0){
							alert("密码修改失败！");
						}
					});
				}
				else{
					alert("所填信息不正确！");
				}
			});
		}
	});
	
});
</script>
<title>浙江传媒学院投票网</title>
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
		<img id="u4_img" class="img " src="images/updatepsdbg.png"/>
		<div id="tip1" class="tip">①&nbsp;&nbsp;请输入注册时的手机号：</div>
		<input id="phone" oninput="OnInput (event)" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
		<div id="phonemark"></div>
		<div id="phonemarktip"></div>
		<div id="tip2" class="tip">②&nbsp;&nbsp;滑动滑块进行验证：</div>
		<form id="captchaform">
			<div id="captcha"></div>
			<script src="http://static.geetest.com/static/tools/gt.js"></script>
			<script>
				var handler = function (captchaObj) {
			         // 将验证码加到id为captcha的元素里
			         captchaObj.appendTo("#captcha");
			     };
			     $.ajax({
			        // 获取id，challenge，success（是否启用failback）
			        url: "StartCaptchaServlet",
			        type: "get",
			        dataType: "json", // 使用jsonp格式
			        success: function (data) {
			            // 使用initGeetest接口
			            // 参数1：配置参数，与创建Geetest实例时接受的参数一致
			            // 参数2：回调，回调的第一个参数验证码对象，之后可以使用它做appendTo之类的事件
			            initGeetest({
			                gt: data.gt,
			                challenge: data.challenge,
			                product: "float", // 产品形式
			                offline: !data.success
			            }, handler);
			        }
				});
			</script>
			<div id="tip3" class="tip">③</div>
			<button type="button" class="button gray" id="requestverification">获取验证码</button>
		</form>
		<div id="error"></div>
		<div id="tip4" class="tip">④&nbsp;&nbsp;请输入验证码：</div>
		<input id="verificationcode" />
		<div id="verificationmark"></div>
		<input name="Button1" value="确&nbsp;&nbsp;认" id="Button1" type="submit">
		
    </div>
</body>
</html>