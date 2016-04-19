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
		//��ʽ��ȷ
		document.getElementById("phonemark").innerHTML="<img style='width:20px;height:20px' src='images/check.png'>";
		isPhoneFlag = 1;
	}else{
		//��ʽ����
		document.getElementById("phonemark").innerHTML="<img style='width:20px;height:20px' src='images/cross.png'>";
		isPhoneFlag = 0;
	}
}
function time(o){
	if (wait == 0) {
		o.removeAttribute("disabled");   
		o.innerHTML="��ȡ��֤��";
		wait = 60;
	}
	else { 
		o.setAttribute("disabled", true);
		o.innerHTML="���·���(" + wait + ")";
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
				document.getElementById("phonemarktip").innerHTML="���ֻ�����δע��";
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
					alert("��������ʧ�ܣ�");
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
						document.getElementById("error").innerHTML="���Ƚ�����֤";
					}
	            }
			});
		}
		else if(isPhoneFlag == 0){
			document.getElementById("error").innerHTML="�ֻ��Ų���ȷ";
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
			$("#phonemark").after("<div id='tip5' class='tip'>�������µ����룺</div><input id='setpsd' type='password'/><div id='psdmark'></div><div id='psdtip' class='tip'>8-16λ���������ֺ���ĸ</div><div id='tip6' class='tip'>�����������µ����룺</div><input id='confirmpsd' type='password'/><div id='confirmpsdmark'></div><input name='Button2' value='ȷ&nbsp;&nbsp;��' id='Button2' type='submit'>");
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
							alert("�����޸ĳɹ���");
							window.location.href = 'login.jsp';
						}
						else if(data == 0){
							alert("�����޸�ʧ�ܣ�");
						}
					});
				}
				else{
					alert("������Ϣ����ȷ��");
				}
			});
		}
	});
	
});
</script>
<title>�㽭��ýѧԺͶƱ��</title>
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
		<div id="tip1" class="tip">��&nbsp;&nbsp;������ע��ʱ���ֻ��ţ�</div>
		<input id="phone" oninput="OnInput (event)" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
		<div id="phonemark"></div>
		<div id="phonemarktip"></div>
		<div id="tip2" class="tip">��&nbsp;&nbsp;�������������֤��</div>
		<form id="captchaform">
			<div id="captcha"></div>
			<script src="http://static.geetest.com/static/tools/gt.js"></script>
			<script>
				var handler = function (captchaObj) {
			         // ����֤��ӵ�idΪcaptcha��Ԫ����
			         captchaObj.appendTo("#captcha");
			     };
			     $.ajax({
			        // ��ȡid��challenge��success���Ƿ�����failback��
			        url: "StartCaptchaServlet",
			        type: "get",
			        dataType: "json", // ʹ��jsonp��ʽ
			        success: function (data) {
			            // ʹ��initGeetest�ӿ�
			            // ����1�����ò������봴��Geetestʵ��ʱ���ܵĲ���һ��
			            // ����2���ص����ص��ĵ�һ��������֤�����֮�����ʹ������appendTo֮����¼�
			            initGeetest({
			                gt: data.gt,
			                challenge: data.challenge,
			                product: "float", // ��Ʒ��ʽ
			                offline: !data.success
			            }, handler);
			        }
				});
			</script>
			<div id="tip3" class="tip">��</div>
			<button type="button" class="button gray" id="requestverification">��ȡ��֤��</button>
		</form>
		<div id="error"></div>
		<div id="tip4" class="tip">��&nbsp;&nbsp;��������֤�룺</div>
		<input id="verificationcode" />
		<div id="verificationmark"></div>
		<input name="Button1" value="ȷ&nbsp;&nbsp;��" id="Button1" type="submit">
		
    </div>
</body>
</html>