<%@ page language="java" contentType="text/html; charset=GB2312"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "web.bean.*" %>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="style/templates.css" type="text/css" rel="stylesheet" rev="stylesheet"/>
<link href="style/checkcandidates.css" type="text/css" rel="stylesheet" rev="stylesheet"/>
<script type="text/javascript" src="lhgcalendar/lhgcore.js"></script>
<script type="text/javascript" src="lhgcalendar/lhgcalendar.js"></script>
<script src="resources/jquery.js"></script>
<script type="text/javascript">
<%
	CheckCandidateBean bean = null;
	bean = (CheckCandidateBean)session.getAttribute("checkCandidateBean");
	LoginBean loginBean = null;
	loginBean = (LoginBean)session.getAttribute("loginBean");
	String userID = loginBean.getUserID();
	String voteInfo = bean.getVoteInfo();
	String voteTittle = bean.getVoteTittle();
	int isOutOfDate = bean.getIsOutOfDate();
	int candidateNum = bean.getCandidateNum();
	int candidateVoteState = bean.getCandidateVoteState();
	int voteID = bean.getVoteID();
	String[] candidates = bean.getCandidates();
	String[] candName = bean.getCandName();
	int[] uploadState = bean.getUploadState();
%>
function toVoteAnalyze(){
	window.location = "voteAnalyzeServlet?voteID=<%=voteID%>";
}
$(document).ready(function(){
	var currNum = <%=candidateNum%>;
	$("#votetittle").text("<%=voteTittle%>");
<%
	if(voteInfo != ""){
%>
		$("#voteinfo").text("ѡ��˵����");
		$("#voteinfo").append("<%=voteInfo%>");
<%
	}
%>
	var div1 = document.getElementById("votetittle");
	var div2 = document.getElementById("voteinfo");
	var div8 = document.getElementById("chooseuser");
	var div9 = document.getElementById("u15");
	var height1 = div1.offsetTop + div1.offsetHeight + 10;
	var optionHeight = 0;
	var chooseNum = 0;
	var currOption;
	div2.style.top = height1 + "px";
	var height2 = height1 + div2.offsetHeight + 10;
	div8.style.top = height2 + "px";
	var height6 = height2 + div8.offsetHeight + 10;
	div9.style.top = height6 + "px";
	var height7 = height6 + div9.offsetHeight + 10;
<%
	if(isOutOfDate == 1){
%>
		$("#votestateinfo").attr("class","votestateinfo2");
<%
		if(candidateVoteState == 1){
%>
			$("#submitbutton").attr("disabled","disabled");
<%
		}
		else if(candidateVoteState == 2){
%>
			$("#submitbutton").attr("class","analyze");
			$("#submitbutton").attr("onclick","toVoteAnalyze();");
			$("#submitbutton #buttontxt").text("�鿴���");
<%
		}
	}
	else if(isOutOfDate == 0){
		if(candidateVoteState == 1){
%>
			$("#votestateinfo").attr("class","votestateinfo1");
<%
		}
		else if(candidateVoteState == 2){
%>
			$("#submitupdateduser").attr("disabled","disabled");
			$("#votestateinfo").attr("class","votestateinfo3");
			$("#submitbutton").attr("class","analyze");
			$("#submitbutton").attr("onclick","toVoteAnalyze();");
			$("#submitbutton #buttontxt").text("�鿴���");
<%
		}
	}
	for(int i = 0;i < candidateNum;i++){
		if(uploadState[i] == 0){
%>
			$("#candidates").append("<div id='<%=candidates[i]%>' class='candidatetemplate' style='margin-top:"+height7+"px;top:"+optionHeight+"px'><div id='choicetxt'>"+"<%=candName[i]%>&nbsp;&nbsp;&nbsp;&nbsp;<%=candidates[i]%>&nbsp;&nbsp;&nbsp;&nbsp;δ�༭"+"</div></div>");
<%				
		}
		else if(uploadState[i] == 1){
%>
			$("#candidates").append("<div id='<%=candidates[i]%>' class='candidatetemplate' style='margin-top:"+height7+"px;top:"+optionHeight+"px'><div id='choicetxt'>"+"<%=candName[i]%>&nbsp;&nbsp;&nbsp;&nbsp;<%=candidates[i]%>&nbsp;&nbsp;&nbsp;&nbsp;�ѱ༭"+"</div></div>");
<%	
		}
%>
		currOption = document.getElementById("<%=candidates[i]%>");
		optionHeight = optionHeight + currOption.offsetHeight + 10;
<%
	}
%>
	if($("#votestateinfo").attr("class") == "votestateinfo1"){
		$("#votestatetxt").text("��ѡ������");
	};
	if($("#votestateinfo").attr("class") == "votestateinfo2"){
		$("#votestatetxt").text("�����ѽ���");
	};
	if($("#votestateinfo").attr("class") == "votestateinfo3"){
		$("#votestatetxt").text("ѡ�ٿ�����");
	};
	var height3 = height7 + optionHeight+ 15;
	var height4 = height3 + 65;
	var height5 = height4 + 260;
	var height6 = height2 + 135;
	var div3 = document.getElementById("submitbutton");
	var div4 = document.getElementById("u8");
	var div5 = document.getElementById("returnbutton");
	var div6 = document.getElementById("left_bg");
	
	div3.style.top = height3+"px";
	div3.style.left = "1020px";
	div5.style.top = height3+"px";
	div5.style.left = "900px";
	div4.style.height = height4+"px";
	div6.style.height = height5+"px";

	
	$("#entrancetimechoice").change(function(){
		$.post("entranceTimeChoiceChangeServlet",
		{
			entranceTime:$("#entrancetimechoice").find("option:selected").attr("value"),
			collegeNum:$("#collegechoice").find("option:selected").attr("value"),
			departNum:$("#departchoice").find("option:selected").attr("value")
		},
		function(data,status){
			if($("#classchoice").attr("disabled") != "disabled"){
				$("#classchoice").empty();
				$("#classchoice").append("<option value='0'>ȫ��</option>");
				$("#classchoice").append(data);
			}
		});
	});
	$("#collegechoice").change(function(){
		$.post("collegeChoiceChangeServlet",
		{college:$("#collegechoice").find("option:selected").text()},
		function(data,status){
			$("#departchoice").empty();
			$("#departchoice").append("<option value='0'>ȫ��</option>");
			$("#departchoice").append(data);
		});
		if($("#collegechoice").find("option:selected").text() == "ȫ��"){
			$("#departchoice").attr("disabled","disabled");
		}
		else{
			$("#departchoice").removeAttr("disabled");
		}
		$("#classchoice").empty();
		$("#classchoice").append("<option value='0'>ȫ��</option>");
		$("#classchoice").attr("disabled","disabled");
	});
	$("#departchoice").change(function(){
		$.post("departChoiceChangeServlet",
		{
			departNum:$("#departchoice").find("option:selected").attr("value"),
			entranceTime:$("#entrancetimechoice").find("option:selected").attr("value")
		},
		function(data,status){
			$("#classchoice").empty();
			$("#classchoice").append("<option value='0'>ȫ��</option>");
			$("#classchoice").append(data);
		});
		if($("#departchoice").find("option:selected").text() == "ȫ��"){
			$("#classchoice").attr("disabled","disabled");
		}
		else{
			$("#classchoice").removeAttr("disabled");
		}
	});
	$("#chooseuserbutton").click(function(){
		var i = 0;
		var myArray = new Array();
		var s="";
		$("input[name='politicalstatusoption']:checked").each(function(){
			myArray[i] = $(this).val();
			i++;
		});
		if(i == 0){
			s = "0";
		}
		else{
			for(var n = 0;n < myArray.length;n++){
				if(n!=myArray.length-1){
			         s=s+myArray[n]+",";
			    }else{
			        s=s+myArray[n];
			    }
			}
		}
		$.post("selectedChoiceChangeServlet",
		{
			schoolName:$("#schoolchoice").find("option:selected").text(),
			entranceTime:$("#entrancetimechoice").find("option:selected").attr("value"),
			collegeNum:$("#collegechoice").find("option:selected").attr("value"),
			departNum:$("#departchoice").find("option:selected").attr("value"),
			classNum:$("#classchoice").find("option:selected").attr("value"),
			politicalStatus:s,
			nationality:$("#nationalitychoice").find("option:selected").attr("value")
		},
		function(data,status){
			$("#select1").empty();
			$("#select1").append(data);
		});
	});
	//�Ƶ��ұ�
	$("#add").click(function(){
		//���ж��Ƿ���ѡ��
		if(!$("#select1 option").is(":selected")){			
			alert("��ѡ����Ҫ�ƶ���ѡ��")
		}
		//��ȡѡ�е�ѡ�ɾ����׷�Ӹ��Է�
		else{
			$("#select1 option:selected").appendTo("#select2");
			$("#select2 option").each(function () {
		        var text = $(this).text();
		        if ($("#select2 option:contains('" + text + "')").length > 1)
		            $("#select2 option:contains('" + text + "'):gt(0)").remove();
		    });
		}	
	});
	
	//ȫ���Ƶ��ұ�
	$("#add_all").click(function(){
		//��ȡȫ����ѡ��,ɾ����׷�Ӹ��Է�
		$("#select1 option").appendTo("#select2");
		$("#select2 option").each(function () {
	        var text = $(this).text();
	        if ($("#select2 option:contains('" + text + "')").length > 1)
	            $("#select2 option:contains('" + text + "'):gt(0)").remove();
	    });
	});
	
	//˫��ѡ��
	$("#select1").dblclick(function(){ //��˫���¼�
		//��ȡȫ����ѡ��,ɾ����׷�Ӹ��Է�
		$("option:selected",this).appendTo("#select2"); //׷�Ӹ��Է�
		$("#select2 option").each(function () {
	        var text = $(this).text();
	        if ($("#select2 option:contains('" + text + "')").length > 1)
	            $("#select2 option:contains('" + text + "'):gt(0)").remove();
	    });
	});
	
	$("#submitupdateduser").click(function(){
		var user = $("#select2 option").map(function(){return $(this).val();}).get().join(",");
		$.post("updateCandidatesServlet",
		{
			voteID:<%=voteID%>,
			user:user
		},
		function(data,status){
			if(data == "1"){
				alert('�޸ĳɹ���');
				window.location.href="userCenterServlet";
			}
			else if(data == "0"){
				alert('�޸�ʧ�ܣ�');
			}
		});
	});
	$("#multichooseradio").change(function() {
		$("#multichooseradio").after("<div id='minvotenum'>���ٺ�ѡ������<input name='minvotenumtxt' id='minvotenumtxt' type='text' value=1></div><div id='maxvotenum'>����ѡ������<input name='maxvotenumtxt' id='maxvotenumtxt' type='text'></div>");
		$("#minvotenumtxt").keyup(function(){
	        $(this).val($(this).val().replace(/\D|^0/g,''));
	    }).bind("paste",function(){  //CTR+V�¼�����
	        $(this).val($(this).val().replace(/\D|^0/g,''));
	    }).css("ime-mode", "disabled");
		$("#maxvotenumtxt").keyup(function(){
	        $(this).val($(this).val().replace(/\D|^0/g,''));
	    }).bind("paste",function(){  //CTR+V�¼�����
	        $(this).val($(this).val().replace(/\D|^0/g,''));
	    }).css("ime-mode", "disabled");
		$("#minvotenumtxt").blur(function(){
			var	str = $(this).val();
			if(str == ""){
				$(this).val(1);
			}
			if($(this).val() > currNum){
				$(this).val(1);
				alert("������ѡ��������");
			}
			if($("#maxvotenumtxt").val() != ""){
				if($(this).val() > $("#maxvotenumtxt").val()){
					$(this).val(1);
					alert("���ô�������ѡ������");
				}
			}
		});
		$("#maxvotenumtxt").blur(function(){
			if($(this).val() != ""){
				if($(this).val() > currNum){
					$(this).val("");
					alert("������ѡ��������");
				}
				else if($(this).val() < $("#minvotenumtxt").val()){
					$(this).val("");
					alert("����С����С��ѡ������");
				}
			}
			else{}
		});
	});
	$("#singlechooseradio").change(function() {
		$("#minvotenum").remove();
		$("#maxvotenum").remove();
	});
	$("#returnbutton").click(function(){
		window.location.href="userCenterServlet";
	});
	$(".analyze").click(function(){
		
	});
	$(".submit").click(function(){
		var candidates = $(".candidatetemplate").map(function(){return $(this).attr("id");}).get().join(",");
		var voteType = "";
		$("input[name='radiobutton']:checked").each(function(){
			if($(this).val() == "singlechoose"){
				voteType = voteType + "1";
			}
			else if($(this).val() == "multichoose"){
				voteType = voteType + "2";
			}
		});
		alert(1);
		if($("#u18").val() == ""){
			alert("����д��ֹ���ڣ�");
		}
		else{
			if(voteType == "1"){
				$.post("candidatePublishServlet",
				{
					voteID:<%=voteID%>,
					voteType:voteType,
					candidates:candidates,
					deadline:$("#u18").val()
				},
				function(data,status){
					if(data == "1"){
						alert('�����ɹ���');
						window.location.href = 'userCenterServlet';
					}
					else if(data == "0"){
						alert('����ʧ�ܣ����Ժ�����');
					}
				});
			}
			else if(voteType == "2"){
				$.post("candidatePublishServlet",
				{
					voteID:<%=voteID%>,
					voteType:voteType,
					minVoteNum:$("#minvotenumtxt").val(),
					maxVoteNum:$("#maxvotenumtxt").val(),
					candidates:candidates,
					deadline:$("#u18").val()
				},
				function(data,status){
					if(data == "1"){
						alert('�����ɹ���');
						window.location.href = 'userCenterServlet';
					}
					else if(data == "0"){
						alert('����ʧ�ܣ����Ժ�����');
					}
				});
			}
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
				<img id="logo_img" class="img " src="images/index_logo.png"/>
			</div>
		</div>
		<div id="u2">
			<img id="logo_img" class="img " src="images/u3_line.png"/>
		</div>
		<div id="u3">
			<div id="u3_1">
				<p>��ӭ ${sessionScope.loginBean.logName} �û���¼��ϵͳ&nbsp;&nbsp;<a id="likTc" href="Exit.jsp">�˳�</a></p>
				
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
		<div id="votestateinfo" class="">
			<div id="votestatetxt" style="margin-left:45px"></div>
			<div id="voteimg"></div>
		</div>
		<div id="u8">
			<div id="votetittle"></div>
			<div id="voteinfo"></div>
			<div id="chooseuser">
				<div id="usergroup">
					<div id="school">
						<div id="txt">
							ѧУ��
						</div>
						<select id="schoolchoice" disabled="disabled">
							<option>${sessionScope.loginBean.schoolName}</option>
						</select>
					</div>
					<%
						if(loginBean != null){
							Connection con;
							Statement sql;
							String uri = "jdbc:mysql://localhost:3306/evoting?"
									+"user=root&password=1234&characterEncoding=gb2312";
							con = DriverManager.getConnection(uri);
							String condition1 = "SELECT distinct entrance_time FROM class ORDER BY entrance_time";
							String condition2 = "SELECT college.college_name,college.college_num FROM school JOIN schoolcollege JOIN college ON school.school_num = schoolcollege.school_num AND schoolcollege.college_num = college.college_num WHERE school.school_name = '"+loginBean.getSchoolName()+"'";
							String condition3 = "SELECT student.stu_num FROM school JOIN schoolcollege ON school.school_num = schoolcollege.school_num JOIN collegedepart ON schoolcollege.college_num = collegedepart.college_num JOIN departclass ON collegedepart.depart_num = departclass.depart_num JOIN classstu ON departclass.class_num = classstu.class_num JOIN student ON classstu.stu_num = student.stu_num WHERE school.school_name = '"
									+loginBean.getSchoolName()+"' ORDER BY student.stu_num";
							String condition4 = "SELECT user_id FROM candidate WHERE vote_id = "+voteID;
							sql = con.createStatement();
					%>
					<div id="entrancetime">
						<div id="txt">
							��ѧ��ݣ�
						</div>
						<select id="entrancetimechoice">
							<option value="0">ȫ��</option>
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
					</div>
					<div id="college">
						<div id="txt">
							ѧԺ��
						</div>
						<select id="collegechoice">
							<option value="0">ȫ��</option>
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
					</div>
					<div id="depart">
						<div id="txt">
							ϵ��
						</div>
						<select id="departchoice" disabled="disabled">
							<option value="0">ȫ��</option>
						</select>
					</div>
					<div id="class">
						<div id="txt">
							�༶��
						</div>
						<select id="classchoice" disabled="disabled">
							<option value="0">ȫ��</option>
						</select>
					</div>
					<div id="politicalstatus">
						<div id="txt">
							������ò��
						</div>
						<input name="politicalstatusoption" type="checkbox" id="politicaloption1" value="1" /><div id="politicaloption1txt">Ⱥ��</div>
						<input name="politicalstatusoption" type="checkbox" id="politicaloption2" value="2" /><div id="politicaloption2txt">������Ա</div>
						<input name="politicalstatusoption" type="checkbox" id="politicaloption3" value="3" /><div id="politicaloption3txt">�й�Ԥ����Ա</div>
						<input name="politicalstatusoption" type="checkbox" id="politicaloption4" value="4" /><div id="politicaloption4txt">�й���Ա</div>
					</div>
					<div id="nationality">
						<div id="txt">
							���壺
						</div>
						<select id="nationalitychoice">
							<option value="0">ȫ��</option>
							<option value="1">����</option>
							<option value="2">��������</option>
						</select>
					</div>
					<button id="chooseuserbutton">ѡ���û���</button>
				</div>
				<div id="selectboxid" class="selectbox">
					<div id="tip1">��ѡ�û�ѧ��/����</div>
					<div id="tip2">��ѡ�û�ѧ��/����</div>
					<div class="select-bar">
						<select multiple="multiple" id="select1">
						</select>
					</div>
					<div class="btn-bar">
						<p><span id="add"><input type="button" class="btn" value=">" title="�ƶ�ѡ����Ҳ�" /></span></p>
						<p><span id="add_all"><input type="button" class="btn" value=">>" title="ȫ���Ƶ��Ҳ�" /></span></p>
					</div>
					<div class="select-bar">
						<select multiple="multiple" id="select2">
							<%
								ResultSet rs4 = sql.executeQuery(condition4);
								rs4.last();
								int rowCount4 = rs4.getRow();
								rs4.first();
								for(int i = 0;i < rowCount4;i++){
									out.print("<option value='"+rs4.getString("user_id")+"'>");
									out.print(rs4.getString("user_id"));
									out.print("</option>");
									rs4.next();
								}
								rs4.close();
							}
							%>
						</select>
					</div>
				</div>
				<button id="submitupdateduser">ָ����ѡ��</button>
			</div>
			<div id="u15">
				<input type="radio" name="radiobutton" id="singlechooseradio" value="singlechoose" checked>��ѡ
				<input type="radio" name="radiobutton" id="multichooseradio" value="multichoose">��ѡ
				<div id="u17">
					��ֹ���ڣ�
				</div>
				<%
					String datetime=new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
				%>
				<input name="deadline" id="u18" type="text" readonly="readonly" onclick="J.calendar.get({to:'<%=datetime%>,max'});">
			</div>
			<div id="candidates">
			</div>
			<div id="returnbutton" class="submit">
				<div id="submit_img">
					<img src="images/loginbutton.png" width="100" height="30" border="0" align="middle"/>
				</div>
				<div id="buttontxt">����</div>
			</div>
			<div id="submitbutton" class="submit">
				<div id="submit_img">
					<img src="images/loginbutton.png" width="100" height="30" border="0" align="middle"/>
				</div>
				<div id="buttontxt">����ѡ��</div>
			</div>
		</div>
	</div>
</body>
</html>