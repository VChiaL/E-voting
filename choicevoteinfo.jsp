<%@ page language="java" contentType="text/html; charset=GB2312"%>
<%@ page import="web.bean.*" %>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="style/templates.css" type="text/css" rel="stylesheet" rev="stylesheet"/>
<link href="style/choicevoteinfo.css" type="text/css" rel="stylesheet" rev="stylesheet"/>
<script src="resources/jquery.js"></script>
<script type="text/javascript">
<%
	CheckVoteDetailBean bean = null;
	bean = (CheckVoteDetailBean)session.getAttribute("checkVoteDetailBean");
	LoginBean loginBean = null;
	loginBean = (LoginBean)session.getAttribute("loginBean");
	String userID = loginBean.getUserID();
	int num = bean.getOptionNum();
	String recommendCandidate = bean.getRecommendCandidate();
	String voteTittle = bean.getVoteTittle();
	String voteCreator = bean.getVoteCreator();
	String voteInfo = bean.getVoteinfo();
	String optionStr = bean.getOptionStr();
	int isOutOfDate = bean.getIsOutOfDate();
	int candidateVoteState = bean.getCandidateVoteState();
	String[] voteOptionTxt = bean.getVoteOptionTxt();
	String[] userChoiceArr = bean.getUserChoice();
	String[] imageURL = bean.getImageURL();
	float[] maxVoted = bean.getMaxVoted();
	float[] currentVoted = bean.getCurrentVoted();
	int voteType = bean.getVoteType();
	int voteState = bean.getVoteState();
	int[] votedPercent = new int[num];
	String voteOptionInfo = "";
	int maxOptionVoted = 0;
	int minOptionVoted = 0;
	int voteID = bean.getVoteID();
	if(voteType == 2){
		voteOptionInfo = bean.getVoteOptionInfo();
		maxOptionVoted = bean.getMaxOptionVoted();
		minOptionVoted = bean.getMinOptionVoted();
	}
	for(int n = 0;n < num - 1;n++){
		votedPercent[n] = (int)((currentVoted[n]/maxVoted[n])*100);
	}
	System.out.println(num);
%>
function toVoteAnalyze(){
	window.location = "voteAnalyzeServlet?voteID=<%=voteID%>";
}
function toVoteAnalyze2(){
	window.location = "candidateAnalyzeServlet?voteID=<%=voteID%>";
}
$(document).ready(function(){
<%
	if(voteType == 2){
%>
		$("#votetittle").text("<%=voteTittle%>"+" （"+"<%=voteOptionInfo%>"+"）");
<%
	}
	else{
%>
		$("#votetittle").text("<%=voteTittle%>");
<%
	}
	if(voteInfo != ""){
%>
		$("#voteinfo").text("投票描述：");
		$("#voteinfo").append("<%=voteInfo%>");
<%
	}
%>
	
	var div1 = document.getElementById("votetittle");
	var div2 = document.getElementById("voteinfo");
	var height1 = div1.offsetTop + div1.offsetHeight + 10;
	var optionHeight = 0;
	var chooseNum = 0;
	var currOption;
	div2.style.top = height1 + "px";
	var height2 = div1.offsetTop + div1.offsetHeight + div2.offsetHeight + 19;
<%
	if(isOutOfDate == 1){
%>
		$("#votestateinfo").attr("class","votestateinfo2");
		$("#recomend").attr("disabled","disabled");
<%
	}
	else if(isOutOfDate == 0){
%>
		$("#votestateinfo").attr("class","votestateinfo1");
<%
	}
	int num2 = num;
	if(candidateVoteState == 2){
		num2 = num - 1;
	}
	for(int i = 0;i < num2;i++){
		if(maxVoted[i] != -1){
			if(votedPercent[i] == 100){
%>
				$("#votechoice").append("<div id='votechoice"+<%=i+1%>+"' class='votechoicetemplate' style='margin-top:"+height2+"px;top:"+optionHeight+"px'><input type='radio' name='option' id='choice' class='optionclass' disabled='disabled'/><div id='choicetxt'>"+"<%=voteOptionTxt[i]%>"+"</div><div class='circle'><div class='pie_left'><div class='circle_left'></div></div><div class='pie_right'><div class='circle_right'></div></div><div class='mask'><span>"+<%=votedPercent[i]%>+"</span>%</div></div></div>");
<%				
			}
			else{
%>
				$("#votechoice").append("<div id='votechoice"+<%=i+1%>+"' class='votechoicetemplate' style='margin-top:"+height2+"px;top:"+optionHeight+"px'><input type='radio' name='option' id='choice' class='optionclass' /><div id='choicetxt'>"+"<%=voteOptionTxt[i]%>"+"</div><div class='circle'><div class='pie_left'><div class='circle_left'></div></div><div class='pie_right'><div class='circle_right'></div></div><div class='mask'><span>"+<%=votedPercent[i]%>+"</span>%</div></div></div>");
<%	
			}
		}
		else{
%>
			$("#votechoice").append("<div id='votechoice"+<%=i+1%>+"' class='votechoicetemplate' style='margin-top:"+height2+"px;top:"+optionHeight+"px'><input type='radio' name='option' id='choice' class='optionclass' /><div id='choicetxt'>"+"<%=voteOptionTxt[i]%>"+"</div></div>");
<%
		}
		if(!imageURL[i].equals("NoURL")){
%>
			$("#votechoice"+<%=i+1%>+" #choicetxt").after("<img src='<%=imageURL[i]%>' style='max-width:1200px;max-height:600px' />");
<%
		}
%>
		currOption = document.getElementById("votechoice"+<%=i+1%>);
		optionHeight = optionHeight + currOption.offsetHeight + 10;
<%
	}
	if(candidateVoteState == 1 || candidateVoteState == 2){
%>
		$("#votechoice").append("<div id='othercandidate' class='votechoicetemplate' style='margin-top:"+height2+"px;top:"+optionHeight+"px'><input type='radio' name='option' id='othercandidatechoice' class='optionclass' /><div id='choicetxt'>另外推荐：<input name='recomend' id='recomend' type='text'></div></div>");
		currOption = document.getElementById("othercandidate");
		optionHeight = optionHeight + currOption.offsetHeight + 10;
		$("#recomend").attr("disabled","disabled");
		$(".optionclass").change(function(){
			if($('input:radio[name="option"]:checked').parent(".votechoicetemplate").attr("id") == "othercandidate"){
				$("#recomend").removeAttr("disabled");
			}
			else{
				$("#recomend").val("");
				$("#recomend").attr("disabled","disabled");
			}
		});
<%
	}

	if(voteType == 2){
%>
		$("input[name='option']").each(function(){
			$(this).attr("type","checkbox");
		});
<%
	}
	if(voteState == 1){
		if(candidateVoteState == 1 || candidateVoteState == 2){
			for(int i = 0;i < num;i++){
				if(i == num - 1){
					if(userChoiceArr[i].equals("1")){
%>
						$("#othercandidatechoice").attr("checked","checked");
						$("#recomend").val("<%=recommendCandidate%>");
<%		
					}
				}
				else {
					if(userChoiceArr[i].equals("1")){
%>
						$("#votechoice"+<%=i+1%>+" #choice").attr("checked","checked");
						
<%		
					}
				}
			}
		}
		else{
			for(int i = 0;i < num;i++){
				if(userChoiceArr[i].equals("1")){
%>
					$("#votechoice"+<%=i+1%>+" #choice").attr("checked","checked");
						
<%		
				}
			}
		}
%>
		$("#recomend").attr("disabled","disabled");
<%
	}
%>
	if($("#votestateinfo").attr("class") == "votestateinfo1"){
		$("#votestatetxt").text("投票进行中");
		$("#submitbutton #buttontxt").text("提交");
	};
	if($("#votestateinfo").attr("class") == "votestateinfo2"){
		$("#votestatetxt").text("投票已结束");
		$(".optionclass").attr("disabled","disabled");
		$("#submitbutton").attr("class","return");
		$("#submitbutton #buttontxt").text("返回");
	};
<%
	if(voteState == 1){
%>
		$(".optionclass").attr("disabled","disabled");
		$("#submitbutton").attr("class","return");
		$("#submitbutton #buttontxt").text("返回");
<%
	}
	if(voteState == 0 && voteType == 2){
%>
		$("input[name='option']").each(function(){
			$(this).change(function() {
				chooseNum = 0;
				$("input[name='option']:checked").each(function(){
					chooseNum ++;
				});
				if(chooseNum < <%=minOptionVoted%> || chooseNum > <%=maxOptionVoted%>){
					alert("已选选项数量不正确！")
				}
			});
		});
<%	
	}
%>
	var height3 = height2 + optionHeight+ 15;
	var height4 = height3 + 65;
	var height5 = height4 + 260;
	var div3 = document.getElementById("submitbutton");
	var div4 = document.getElementById("u8");
	var div6 = document.getElementById("left_bg");
	div3.style.top = height3+"px";
	div3.style.left = "1020px";
	div4.style.height = height4+"px";
	div6.style.height = height5+"px";
<%
	if(userID.equals(voteCreator)){
%>
		$("#votechoice").after("<div id='updateusersbutton'><div id='submit_img'><img src='images/loginbutton.png' width='100' height='30' border='0' align='middle'/></div><div id='buttontxt'>修改用户组</div></div>");
<%
			if(candidateVoteState == 2){
%>
				$("#updateusersbutton").after("<div id='resultanalysebutton' onclick='toVoteAnalyze2();'><div id='submit_img'><img src='images/loginbutton.png' width='100' height='30' border='0' align='middle'/></div><div id='buttontxt'>查看投票结果</div></div>");
<%
			}
			else{
%>
				$("#updateusersbutton").after("<div id='resultanalysebutton' onclick='toVoteAnalyze();'><div id='submit_img'><img src='images/loginbutton.png' width='100' height='30' border='0' align='middle'/></div><div id='buttontxt'>查看投票结果</div></div>");
<%
			}
%>
		var div5 = document.getElementById("resultanalysebutton");
		var div7 = document.getElementById("updateusersbutton");
		div5.style.top = height3+"px";
		div5.style.left = "900px";
		div7.style.top = height3+"px";
		div7.style.left = "780px";
<%
	}
%>
	$(function() {
		$('.circle').each(function(index, el) {
			var rotatenum = $(this).find('span').text() * 3.6;
			if (rotatenum<=180) {
				$(this).find('.circle_right').css('transform', "rotate(" + rotatenum + "deg)");
			} else {
				$(this).find('.circle_right').css('transform', "rotate(180deg)");
				$(this).find('.circle_left').css('transform', "rotate(" + (rotatenum - 180) + "deg)");
			};
		});
	});
	$("#updateusersbutton").click(function(){
		var baseText=null;
		var popUp=document.getElementById("popupcontent");
		popUp.style.display='block';
		popUp.style.top="100px";
		popUp.style.left="0px";
		popUp.style.width="1124px";
		popUp.style.height="300px";
		if(baseText==null)
			baseText=popUp.innerHTML;
		popUp.style.visibility="visible";
	});
	$(".return").click(function(){
		window.location.href="checkvote.jsp";
	});
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
				$("#classchoice").append("<option value='0'>全部</option>");
				$("#classchoice").append(data);
			}
		});
	});
	$("#collegechoice").change(function(){
		$.post("collegeChoiceChangeServlet",
		{college:$("#collegechoice").find("option:selected").text()},
		function(data,status){
			$("#departchoice").empty();
			$("#departchoice").append("<option value='0'>全部</option>");
			$("#departchoice").append(data);
		});
		if($("#collegechoice").find("option:selected").text() == "全部"){
			$("#departchoice").attr("disabled","disabled");
		}
		else{
			$("#departchoice").removeAttr("disabled");
		}
		$("#classchoice").empty();
		$("#classchoice").append("<option value='0'>全部</option>");
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
			$("#classchoice").append("<option value='0'>全部</option>");
			$("#classchoice").append(data);
		});
		if($("#departchoice").find("option:selected").text() == "全部"){
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
	//移到右边
	$("#add").click(function(){
		//先判断是否有选中
		if(!$("#select1 option").is(":selected")){			
			alert("请选择需要移动的选项")
		}
		//获取选中的选项，删除并追加给对方
		else{
			$("#select1 option:selected").appendTo("#select2");
			$("#select2 option").each(function () {
		        var text = $(this).text();
		        if ($("#select2 option:contains('" + text + "')").length > 1)
		            $("#select2 option:contains('" + text + "'):gt(0)").remove();
		    });
		}	
	});
	
	//移到左边
	$("#remove").click(function(){
		//先判断是否有选中
		if(!$("#select2 option").is(":selected")){			
			alert("请选择需要移动的选项")
		}
		else{
			$("#select2 option:selected").appendTo('#select1');
			$("#select1 option").each(function () {
		        var text = $(this).text();
		        if ($("#select1 option:contains('" + text + "')").length > 1)
		            $("#select1 option:contains('" + text + "'):gt(0)").remove();
		    });
		}
	});
	
	//全部移到右边
	$("#add_all").click(function(){
		//获取全部的选项,删除并追加给对方
		$("#select1 option").appendTo("#select2");
		$("#select2 option").each(function () {
	        var text = $(this).text();
	        if ($("#select2 option:contains('" + text + "')").length > 1)
	            $("#select2 option:contains('" + text + "'):gt(0)").remove();
	    });
	});
	
	//全部移到左边
	$("#remove_all").click(function(){
		$("#select2 option").appendTo("#select1");
		$("#select1 option").each(function () {
	        var text = $(this).text();
	        if ($("#select1 option:contains('" + text + "')").length > 1)
	            $("#select1 option:contains('" + text + "'):gt(0)").remove();
	    });
	});
	
	//双击选项
	$("#select1").dblclick(function(){ //绑定双击事件
		//获取全部的选项,删除并追加给对方
		$("option:selected",this).appendTo("#select2"); //追加给对方
		$("#select2 option").each(function () {
	        var text = $(this).text();
	        if ($("#select2 option:contains('" + text + "')").length > 1)
	            $("#select2 option:contains('" + text + "'):gt(0)").remove();
	    });
	});
	
	//双击选项
	$("#select2").dblclick(function(){
		$("option:selected",this).appendTo("#select1");
		$("#select1 option").each(function () {
	        var text = $(this).text();
	        if ($("#select1 option:contains('" + text + "')").length > 1)
	            $("#select1 option:contains('" + text + "'):gt(0)").remove();
	    });
	});
	$("#submitupdateduser").click(function(){
		var user = $("#select2 option").map(function(){return $(this).val();}).get().join(",");
		alert(1);
		var popUp=document.getElementById("popupcontent");
		$.post("updateVotedUsers",
		{
			voteID:<%=voteID%>,
			user:user
		},
		function(data,status){
			if(data == "1"){
				alert('修改成功！');
				popUp.style.visibility="hidden";
			}
			else if(data == "0"){
				alert('修改失败！');
				popUp.style.visibility="hidden";
			}
		});
	});
	$("#closewindow").click(function(){
		var popUp=document.getElementById("popupcontent");
		popUp.style.visibility="hidden";
	});
	$(".submit").click(function(){
		var recomendFlag = 0;
		var otherCandidateFlag = 0;
		var userChoice = $("input[name='option']").map(function(){
			if($(this).is(':checked')) {
				return "1";
			}
			else{
				return "0";
			}
		}).get().join(",");
<%
		if(candidateVoteState == 2){
%>
			$("input[name='option']:checked").each(function(){
				if($(this).attr("id") == "othercandidatechoice"){
					otherCandidateFlag = 1;
				}
			});
			if(otherCandidateFlag == 1){
				
				if($("#recomend").val() != ""){
					recomendFlag = 1;
				}
			}
<%
		}
%>
 		if(chooseNum < <%=minOptionVoted%> || chooseNum > <%=maxOptionVoted%>){
			alert("已选选项数量不正确！")
		}
		else{
<%
			if(candidateVoteState == 2){
%>
				alert(recomendFlag);
				$.post("submitChoiceVoteServlet",
				{
					userID:<%=userID%>,
					voteID:<%=voteID%>,
					optionStr:"<%=optionStr%>",
					userChoice:userChoice,
					candidateVoteState:<%=candidateVoteState%>,
					recomendFlag:recomendFlag,				
					otherCandidate:$("#recomend").val()
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
<%
			}
			else{
%>
				$.post("submitChoiceVoteServlet",
				{
					userID:<%=userID%>,
					voteID:<%=voteID%>,
					optionStr:"<%=optionStr%>",
					userChoice:userChoice,
					candidateVoteState:<%=candidateVoteState%>
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
<%
			}
%>
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
		<div id="votestateinfo" class="">
			<div id="votestatetxt" style="margin-left:45px"></div>
			<div id="voteimg"></div>
		</div>
		<div id="u8">
			<div id="votetittle"></div>
			<div id="voteinfo"></div>
			<div id="votechoice">
			</div>
			<div id="submitbutton" class="submit">
				<div id="submit_img">
					<img src="images/loginbutton.png" width="100" height="30" border="0" align="middle"/>
				</div>
				<div id="buttontxt"></div>
			</div>
			<div id="popupcontent">
				<div id="usergroup">
					<div id="school">
						<div id="txt">
							学校：
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
							String condition4 = "SELECT user_id FROM voteuser WHERE vote_id = "+voteID;
							sql = con.createStatement();
					%>
					<div id="entrancetime">
						<div id="txt">
							入学年份：
						</div>
						<select id="entrancetimechoice">
							<option value="0">全部</option>
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
							学院：
						</div>
						<select id="collegechoice">
							<option value="0">全部</option>
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
							系：
						</div>
						<select id="departchoice" disabled="disabled">
							<option value="0">全部</option>
						</select>
					</div>
					<div id="class">
						<div id="txt">
							班级：
						</div>
						<select id="classchoice" disabled="disabled">
							<option value="0">全部</option>
						</select>
					</div>
					<div id="politicalstatus">
						<div id="txt">
							政治面貌：
						</div>
						<input name="politicalstatusoption" type="checkbox" id="politicaloption1" value="1" /><div id="politicaloption1txt">群众</div>
						<input name="politicalstatusoption" type="checkbox" id="politicaloption2" value="2" /><div id="politicaloption2txt">共青团员</div>
						<input name="politicalstatusoption" type="checkbox" id="politicaloption3" value="3" /><div id="politicaloption3txt">中共预备党员</div>
						<input name="politicalstatusoption" type="checkbox" id="politicaloption4" value="4" /><div id="politicaloption4txt">中共党员</div>
					</div>
					<div id="nationality">
						<div id="txt">
							民族：
						</div>
						<select id="nationalitychoice">
							<option value="0">全部</option>
							<option value="1">汉族</option>
							<option value="2">少数民族</option>
						</select>
					</div>
					<button id="chooseuserbutton">选择用户组</button>
				</div>
				<div id="selectboxid" class="selectbox">
					<div id="tip1">待选用户学号/工号</div>
					<div id="tip2">已选用户学号/工号</div>
					<div class="select-bar">
						<select multiple="multiple" id="select1">
						</select>
					</div>
					<div class="btn-bar">
						<p><span id="add"><input type="button" class="btn" value=">" title="移动选择项到右侧" /></span></p>
						<p><span id="add_all"><input type="button" class="btn" value=">>" title="全部移到右侧" /></span></p>
						<p><span id="remove"><input type="button" class="btn" value="<" title="移动选择项到左侧" /></span></p>
						<p><span id="remove_all"><input type="button" class="btn" value="<<" title="全部移到左侧" /></span></p>
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
				<button id="submitupdateduser">提交</button>
				<button id="closewindow">关闭窗口</button>
			</div>
		</div>
	</div>
</body>
</html>