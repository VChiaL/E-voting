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
<title>�㴫ͶƱ��-ע��</title>
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
		//��ʽ��ȷ
		document.getElementById("phonemark").innerHTML="<img style='width:20px;height:20px' src='images/check.png'>";
		isPhoneFlag = 1;
	}else{
		//��ʽ����
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
				document.getElementById("error").innerHTML="���ֻ����ѱ�ռ��";
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
					document.getElementById("usernicknametip").innerHTML="����ʹ��";
					nickNameFlag = 1;
				}
				else if(data == 0){
					document.getElementById("usernicknametip").style.color = "red";
					document.getElementById("usernicknametip").innerHTML="���û����ѱ�ռ��";
					nickNameFlag = 0;
				}
			});
		}
		else{
			document.getElementById("usernicknametip").style.color = "red";
			document.getElementById("usernicknametip").innerHTML="�����Ƿ��ַ�";
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
			$("#collegeselect").append("<option value=0>����ѧԺ</option>");
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
			$("#departselect").append("<option value=0>ϵ</option>");
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
			$("#classselect").append("<option value=0>�༶</option>");
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
					alert("ע��ɹ���");
					window.location.href = 'login.jsp';
				}
				else if(data == 0){
					alert("ע��ʧ�ܣ�");
				}
			});
		}
		else{
			alert("�뽫��Ϣ��д����");
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
			<div class="questiontxt">�û�����</div>
			<input id="usernicknametxt" class="txt" />
		</div>
		<div id="setpsd" class="question">
			<div class="questiontxt">�������룺</div>
			<input id="setpsdtxt" type="password" class="txt" />
			<div id="psdmark"></div>
		</div>
		<div id="confirmpsd" class="question">
			<div class="questiontxt">ȷ�����룺</div>
			<input id="confirmpsdtxt" type="password" class="txt" />
			<div id="confirmpsdmark"></div>
		</div>
		<div id="phone" class="question">
			<div class="questiontxt">�ֻ��ţ�</div>
			<input id="phonetxt" class="txt" oninput="OnInput (event)" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
			<div id="phonemark"></div>
			<div id="error"></div>
		</div>
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
			                offline: !data.success,
			                width: "50%"
			            }, handler);
			        }
				});
			</script>
			<button type="button" class="button gray" id="requestverification">��ȡ��֤��</button>
		</form>
		<div id="verification" class="question">
			<div class="questiontxt">�ֻ���֤�룺</div>
			<input id="verificationtxt" class="txt" />
			<div id="verificationmark"></div>
		</div>
		<div id="school" class="question">
			<div class="questiontxt">ѧУ��</div>
			<select id="schoolselect" class="select">
				<option value=0>ѧУ</option>
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
			<div class="questiontxt">��ѧ��ݣ�</div>
			<select id="schoolentrancetimeselect" class="select" disabled="disabled">
				<option value=0>��ѧ���</option>
				<option value=2012>2012</option>
				<option value=2013>2013</option>
				<option value=2014>2014</option>
				<option value=2015>2015</option>
			</select>
		</div>
		<div id="college" class="question">
			<div class="questiontxt">����ѧԺ��</div>
			<select id="collegeselect" class="select" disabled="disabled">
				<option value=0>����ѧԺ</option>
			</select>
		</div>
		<div id="depart" class="question">
			<div class="questiontxt">ϵ��</div>
			<select id="departselect" class="select" disabled="disabled">
				<option value=0>ϵ</option>
			</select>
		</div>
		<div id="class" class="question">
			<div class="questiontxt">�༶��</div>
			<select id="classselect" class="select" disabled="disabled">
				<option value=0>�༶</option>
			</select>
		</div>
		<div id="stuID" class="question">
			<div class="questiontxt">ѧ�ţ�</div>
			<input id="stuIDtxt" class="txt" />
		</div>
		<div id="sex" class="question">
			<div class="questiontxt">�Ա�</div>
			<select id="sexselect" class="select">
				<option value=0>�Ա�</option>
				<option value=1>��</option>
				<option value=2>Ů</option>
			</select>
		</div>
		<div id="truename" class="question">
			<div class="questiontxt">��ʵ������</div>
			<input id="truenametxt" class="txt" />
		</div>
		<div id="politicaltype" class="question">
			<div class="questiontxt">������ò��</div>
			<select id="politicaltypeselect" class="select">
				<option value=0>������ò</option>
				<option value=1>Ⱥ��</option>
				<option value=2>������Ա</option>
				<option value=3>�й�Ԥ����Ա</option>
				<option value=4>�й���Ա</option>
			</select>
		</div>
		<div id="nationalitytype" class="question">
			<div class="questiontxt">���壺</div>
			<select id="nationalitytypeselect" class="select">
				<option value=0>����</option>
				<option value=1>����</option>
				<option value=2>��������</option>
			</select>
		</div>
		<div id="usernicknametip" class="tip">���Զ��壬�������֡���ĸ��"_"</div>
		<div id="psdtip" class="tip">8-16λ���������ֺ���ĸ</div>
		<div id="schooltip" class="tip">* �������д��ʵ��Ϣ</div>
		<div id="schoolentrancetimetip" class="tip">* �������д��ʵ��Ϣ</div>
		<div id="collegetip" class="tip">* �������д��ʵ��Ϣ</div>
		<div id="departtip" class="tip">* �������д��ʵ��Ϣ</div>
		<div id="classtip" class="tip">* �������д��ʵ��Ϣ</div>
		<div id="stuIDtip" class="tip">* �������д��ʵ��Ϣ</div>
		<div id="sextip" class="tip">* �������д��ʵ��Ϣ</div>
		<div id="truenametip" class="tip">* �������д��ʵ��Ϣ</div>
		<div id="politicaltypetip" class="tip">* �������д��ʵ��Ϣ</div>
		<div id="nationalitytypetip" class="tip">* �������д��ʵ��Ϣ</div>
    </div>
    <input name="submitbutton" value="ע&nbsp;&nbsp;��" id="submitbutton" type="submit" onclick="submitRegisterForm();">
</body>
</html>