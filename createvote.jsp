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
<link href="style/createvote.css" type="text/css" rel="stylesheet" rev="stylesheet"/>
<script src="resources/jquery.js"></script>
<script src="resources/jquery-form.js"></script>
<script src="resources/ajaxfileupload.js"></script>
<script type="text/javascript" src="lhgcalendar/lhgcore.js"></script>
<script type="text/javascript" src="lhgcalendar/lhgcalendar.js"></script>
<script type="text/javascript" charset="utf-8" src="ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript">
<%
	LoginBean lgnBean = null;
	lgnBean = (LoginBean)session.getAttribute("loginBean");
	if(lgnBean == null){
		response.sendRedirect("login.jsp");
	}
%>
var currNum = 3;
var optionMarginTop = 133;
var voteInfoFlag1 = 0;
var voteInfoFlag2 = 0;
var voteInfoFlag3 = 0;
function txtVote(e){
	if($(e).parent().prop("class")=="votechoicestate2 voteoption"){
		$(e).parent().prop("class","votechoicestate1 voteoption");
		$(e).siblings("#imgurl").remove();
		$(e).siblings(".btn_addPic").remove();
	}
	else if($(e).parent().prop("class")=="votechoicestate2 voteoption followoption"){
		$(e).parent().prop("class","votechoicestate1 voteoption followoption");
		$(e).siblings("#imgurl").remove();
		$(e).siblings(".btn_addPic").remove();
	}
}
function imgVote(e){
	if($(e).parent().prop("class")=="votechoicestate1 voteoption"){
		$(e).parent().prop("class","votechoicestate2 voteoption");
		$(e).siblings("#votechoicetxt").after("<input id='imgurl' urlmethod='0' class='imageurl' type='text' value='输入图片的URL'><a class='btn_addPic optionimg' ><em></em><span>添加图片</span><form class='form'><input class='filePrew' title='支持jpg、jpeg、gif、png格式，文件小于4M' type='file' size='3' name='pic'></form></a>");
		$(e).siblings("#imgurl").focus(function(){
			var	str = $(this).val();
			if(str == "输入图片的URL"){
				this.style.color="#000";
				$(this).val("");
			}
		});
		$(e).siblings("#imgurl").blur(function(){
			var	str = $(this).val();
			if(str == ""){
				this.style.color="#666666";
				$(this).val("输入图片的URL");
			}
		});
		$(e).siblings(".btn_addPic").children(".form").children(".filePrew").change(function(){
			
			$(this).parent().parent().siblings("#imgurl").val($(this).val());
			$(this).parent().parent().siblings("#imgurl").attr("readonly","readonly");
			$(this).parent().parent().siblings("#imgurl").attr("urlmethod","1");
			var flag = $(this).parent().parent().siblings("#imgurl").parent().attr("id");
			$(this).parent().attr("id",flag+"form");
		});
	}
	else if($(e).parent().prop("class")=="votechoicestate1 voteoption followoption"){
		$(e).parent().prop("class","votechoicestate2 voteoption followoption");
		$(e).siblings("#votechoicetxt").after("<input id='imgurl' urlmethod='0' class='imageurl' type='text' value='输入图片的URL'><a class='btn_addPic optionimg' ><em></em><span>添加图片</span><form class='form'><input class='filePrew' title='支持jpg、jpeg、gif、png格式，文件小于4M' type='file' size='3' name='pic'></form></a>");
		$(e).siblings("#imgurl").focus(function(){
			var	str = $(this).val();
			if(str == "输入图片的URL"){
				this.style.color="#000";
				$(this).val("");
			}
		});
		$(e).siblings("#imgurl").blur(function(){
			var	str = $(this).val();
			if(str == ""){
				this.style.color="#666666";
				$(this).val("输入图片的URL");
			}
		});
		$(e).siblings(".btn_addPic").children(".form").children(".filePrew").change(function(){
			var uploadedurl;
			$(this).parent().parent().siblings("#imgurl").val($(this).val());
			$(this).parent().parent().siblings("#imgurl").attr("readonly","readonly");
			$(this).parent().parent().siblings("#imgurl").attr("urlmethod","1");
			var flag = $(this).parent().parent().siblings("#imgurl").parent().attr("id");
			$(this).parent().attr("id",flag+"form");
		});
	}
}
function deleteVote(e){
	currNum = currNum - 1;
	if(currNum > 2){
		$(e).parent().prev().append("<div id='deletevote' style='cursor:pointer;' onclick='deleteVote(this)'>删除选项</div>");
	}
	$(e).parent().remove();
	var div1 = document.getElementById("u8");
	var div2 = document.getElementById("u11");
	var div3 = document.getElementById("u13");
	var div4 = document.getElementById("u22");
	var div5 = document.getElementById("right");
	var div6 = document.getElementById("left_bg");
	var div7 = document.getElementById("u23");
	var div8 = document.getElementById("addvote");
	var div9 = document.getElementById("submitbutton");
	var height10 = currNum*67 + 175;
	var height11 = div1.offsetHeight + div2.offsetHeight + height10 + div4.offsetHeight+260;
	var height12 = (currNum-3)*67 + 340;
	var height13 = (currNum-3)*67 + 355;
	if(currNum < 3){
		if(voteInfoFlag1 == 1){
			var height11 = div1.offsetHeight + div2.offsetHeight + 426 + div4.offsetHeight+660;
			div3.style.height = 816+"px";
			div6.style.height = height11+"px";
			div8.style.top = 740+"px";
			div9.style.top = 755+"px";
		}
		else{
			var height11 = div1.offsetHeight + div2.offsetHeight + 376 + div4.offsetHeight+260;
			div3.style.height = 416+"px";
			div6.style.height = height11+"px";
			div8.style.top = 340+"px";
			div9.style.top = 355+"px";
		}
	}
	else{
		if(voteInfoFlag1 == 1){
			height10 += 450;
			height11 += 400;
			height12 += 400;
			height13 += 400;
			div3.style.height = height10+"px";
			div6.style.height = height11+"px";
			div8.style.top = height12+"px";
			div9.style.top = height13+"px";
		}
		else{
			height10 += 50;
			div3.style.height = height10+"px";
			div6.style.height = height11+"px";
			div8.style.top = height12+"px";
			div9.style.top = height13+"px";
		}
	}
}
function voteinfoimgchange(e){
	$(e).parent().parent().next().val($(e).val());
}
<%!
	int voteNum = 3;
%>
$(document).ready(function(){
<%
for(int i = 1;i <= 3;i++){
	if(i == 1){
%>
		$("#u18").after("<div id='1' class='votechoicestate1 voteoption' style='top:"+optionMarginTop+"px'>选项1：<img class='pic1' src='images/votechoicepic1.png' width='27' height='27' align='middle' onclick='txtVote(this);'><img class='pic2' src='images/votechoicepic2.png' width='27' height='27' align='middle' onclick='imgVote(this);'><input id='votechoicetxt' name='votechoicetxt' type='text'><input id='allowtxt' name='allowtxt' type='checkbox' value='isallowtxt' /><div id='allowtxttittle'>添加自由回答区域</div><div id='maxvoted'>最多被投次数：</div><input id='maxvotedtxt' name='maxvotedtxt' type='text'></div>");
<%
	}
	else if(i == 2){
%>
		$("#"+"<%=i-1%>").after("<div id='"+"<%=i%>"+"' class='votechoicestate1 voteoption followoption' style='margin-top:"+optionMarginTop+"px;top:"+67*<%=i-1%>+"px'>选项"+"<%=i%>"+"：<img class='pic1' src='images/votechoicepic1.png' width='27' height='27' align='middle' onclick='txtVote(this);'><img class='pic2' src='images/votechoicepic2.png' width='27' height='27' align='middle' onclick='imgVote(this);'><input id='votechoicetxt' name='votechoicetxt' type='text'><input id='allowtxt' name='allowtxt' type='checkbox' value='isallowtxt' /><div id='allowtxttittle'>添加自由回答区域</div><div id='maxvoted'>最多被投次数：</div><input id='maxvotedtxt' name='maxvotedtxt' type='text'></div>");
<%
	}
	else if(i == 3){
%>
		$("#"+"<%=i-1%>").after("<div id='"+"<%=i%>"+"' class='votechoicestate1 voteoption followoption' style='margin-top:"+optionMarginTop+"px;top:"+67*<%=i-1%>+"px'>选项"+"<%=i%>"+"：<div id='deletevote' style='cursor:pointer;' onclick='deleteVote(this)'>删除选项</div><img class='pic1' src='images/votechoicepic1.png' width='27' height='27' align='middle' onclick='txtVote(this);'><img class='pic2' src='images/votechoicepic2.png' width='27' height='27' align='middle' onclick='imgVote(this);'><input id='votechoicetxt' name='votechoicetxt' type='text'><input id='allowtxt' name='allowtxt' type='checkbox' value='isallowtxt' /><div id='allowtxttittle'>添加自由回答区域</div><div id='maxvoted'>最多被投次数：</div><input id='maxvotedtxt' name='maxvotedtxt' type='text'></div>");
<%
	}
}
%>
	var div1 = document.getElementById("u8");
	var div2 = document.getElementById("u11");
	var div3 = document.getElementById("u13");
	var div4 = document.getElementById("u22");
	var div5 = document.getElementById("right");
	var div6 = document.getElementById("left_bg");
	var div7 = document.getElementById("u23");
	var div10 = document.getElementById("u28");
	var div8 = document.getElementById("addvote");
	var div9 = document.getElementById("submitbutton");
	var height1 = div1.offsetHeight + div2.offsetHeight + div3.offsetHeight + div4.offsetHeight+260;
	var height2 = div1.offsetHeight + div2.offsetHeight + div7.offsetHeight + div4.offsetHeight+260;
	var height3 = div1.offsetHeight + div2.offsetHeight + div10.offsetHeight + div4.offsetHeight+260;
	function reloadDiv1(){
		div6.style.height = height1+"px";
	}
	function reloadDiv2(){
		div6.style.height = height2+"px";
	}
	function reloadDiv3(){
		div6.style.height = height3+"px";
	}
	reloadDiv1();
	$("#u23").hide();
	$('#u28').hide();
	$("#addvote").click(function(){
		currNum = currNum + 1;
		var prevNum = currNum - 1;
		var height3 = currNum*67 + 215;
		var height4 = div1.offsetHeight + div2.offsetHeight + height3 + div4.offsetHeight+260;
		var height5 = (currNum-3)*67 + 340;
		var height6 = (currNum-3)*67 + 355;
		var currNumString = currNum.toString();
		var prevNumString = prevNum.toString();
		$("#"+prevNumString).after("<div id='"+currNumString+"' class='votechoicestate1 voteoption followoption' style='margin-top:"+optionMarginTop+"px;top:"+67*prevNum+"px'>选项"+currNumString+"：<div id='deletevote' style='cursor:pointer;' onclick='deleteVote(this)'>删除选项</div><img class='pic1' src='images/votechoicepic1.png' width='27' height='27' align='middle' onclick='txtVote(this);'><img class='pic2' src='images/votechoicepic2.png' width='27' height='27' align='middle' onclick='imgVote(this);'><input id='votechoicetxt' name='votechoicetxt' type='text'><input id='allowtxt' name='allowtxt' type='checkbox' value='isallowtxt' /><div id='allowtxttittle'>添加自由回答区域</div><div id='maxvoted'>最多被投次数：</div><input id='maxvotedtxt' name='maxvotedtxt' type='text'></div>");
		$("#"+prevNumString).children("#deletevote").remove();
		if(voteInfoFlag1 == 1){
			div3.style.height = height3+400+"px";
			div6.style.height = height4+400+"px";
			div8.style.top = height5+400+"px";
			div9.style.top = height6+400+"px";
		}
		else{
			div3.style.height = height3+"px";
			div6.style.height = height4+"px";
			div8.style.top = height5+"px";
			div9.style.top = height6+"px";
		}
		
	});
	$("#u9_img").click(function(){
		$("#u13").show();
		$("#u23").hide();
		$("#u28").hide();
		reloadDiv1();
	});
	$("#u10_img").click(function(){
		$("#u23").show();
		$("#u13").hide();
		$("#u28").hide();
		reloadDiv2();
	});
	$("#ucandidate_img").click(function(){
		$("#u23").hide();
		$("#u13").hide();
		$("#u28").show();
		reloadDiv3();
	});
	$("#u9_img").click(function(){
		$("#u9_img").find("img").attr("src","images/underline.png");
		$("#u9_img").find("img").removeAttr("onMouseOver");
		$("#u9_img").find("img").removeAttr("onMouseOut");
		$("#u10_img").find("img").attr("src","images/withoutunderline.png");
		$("#u10_img").find("img").attr("onMouseOver","this.src='images/underline.png'");
		$("#u10_img").find("img").attr("onMouseOut","this.src='images/withoutunderline.png'");
		$("#ucandidate_img").find("img").attr("src","images/withoutunderline.png");
		$("#ucandidate_img").find("img").attr("onMouseOver","this.src='images/underline.png'");
		$("#ucandidate_img").find("img").attr("onMouseOut","this.src='images/withoutunderline.png'");
	});
	$("#u10_img").click(function(){
		$("#u10_img").find("img").attr("src","images/underline.png");
		$("#u10_img").find("img").removeAttr("onMouseOver");
		$("#u10_img").find("img").removeAttr("onMouseOut");
		$("#u9_img").find("img").attr("src","images/withoutunderline.png");
		$("#u9_img").find("img").attr("onMouseOver","this.src='images/underline.png'");
		$("#u9_img").find("img").attr("onMouseOut","this.src='images/withoutunderline.png'");
		$("#ucandidate_img").find("img").attr("src","images/withoutunderline.png");
		$("#ucandidate_img").find("img").attr("onMouseOver","this.src='images/underline.png'");
		$("#ucandidate_img").find("img").attr("onMouseOut","this.src='images/withoutunderline.png'");
	});
	$("#ucandidate_img").click(function(){
		$("#ucandidate_img").find("img").attr("src","images/underline.png");
		$("#ucandidate_img").find("img").removeAttr("onMouseOver");
		$("#ucandidate_img").find("img").removeAttr("onMouseOut");
		$("#u9_img").find("img").attr("src","images/withoutunderline.png");
		$("#u9_img").find("img").attr("onMouseOver","this.src='images/underline.png'");
		$("#u9_img").find("img").attr("onMouseOut","this.src='images/withoutunderline.png'");
		$("#u10_img").find("img").attr("src","images/withoutunderline.png");
		$("#u10_img").find("img").attr("onMouseOver","this.src='images/underline.png'");
		$("#u10_img").find("img").attr("onMouseOut","this.src='images/withoutunderline.png'");
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
	
	$("#multichooseradio").change(function() {
		$("#multichooseradio").after("<div id='minvotenum'>最少选择数量：<input name='minvotenumtxt' id='minvotenumtxt' type='text' value=1></div><div id='maxvotenum'>最多选择数量：<input name='maxvotenumtxt' id='maxvotenumtxt' type='text'></div>");
		$("#minvotenumtxt").keyup(function(){
	        $(this).val($(this).val().replace(/\D|^0/g,''));
	    }).bind("paste",function(){  //CTR+V事件处理
	        $(this).val($(this).val().replace(/\D|^0/g,''));
	    }).css("ime-mode", "disabled");
		$("#maxvotenumtxt").keyup(function(){
	        $(this).val($(this).val().replace(/\D|^0/g,''));
	    }).bind("paste",function(){  //CTR+V事件处理
	        $(this).val($(this).val().replace(/\D|^0/g,''));
	    }).css("ime-mode", "disabled");
		$("#minvotenumtxt").blur(function(){
			var	str = $(this).val();
			if(str == ""){
				$(this).val(1);
			}
			if($(this).val() > currNum){
				$(this).val(1);
				alert("超出选项数量！");
			}
			if($("#maxvotenumtxt").val() != ""){
				if($(this).val() > $("#maxvotenumtxt").val()){
					$(this).val(1);
					alert("不得大于最大选项数量！");
				}
			}
		});
		$("#maxvotenumtxt").blur(function(){
			if($(this).val() != ""){
				if($(this).val() > currNum){
					$(this).val("");
					alert("超出选项数量！");
				}
				else if($(this).val() < $("#minvotenumtxt").val()){
					$(this).val("");
					alert("不得小于最小选项数量！");
				}
			}
			else{}
		});
	});
	$("#singlechooseradio").change(function() {
		$("#minvotenum").remove();
		$("#maxvotenum").remove();
	});
	$("#addvoteinfobtn1").click(function(){
		var div1 = document.getElementById("u8");
		var div2 = document.getElementById("u11");
		var div3 = document.getElementById("u13");
		var div4 = document.getElementById("u22");
		var div5 = document.getElementById("right");
		var div6 = document.getElementById("left_bg");
		var div7 = document.getElementById("u23");
		var div8 = document.getElementById("addvote");
		var div9 = document.getElementById("submitbutton");
		$("#1").before("<div id='txteditor'><form id='txteditorform1'><textarea id='container1' name='container'></textarea></form></div>");
		var ue = UE.getEditor('container1',{  
			autoFloatEnabled:false,
			scaleEnabled:false
        });
		optionMarginTop += 400;
		var firstOption = document.getElementById("1");
		firstOption.style.top = optionMarginTop+"px";
		var followOption = document.getElementsByClassName("followoption");
		var i;
		for (i = 0; i < followOption.length; i++) {
			followOption[i].style.marginTop = optionMarginTop+"px";
		}
		var height10 = currNum*67 + 660;
		var height11 = div1.offsetHeight + div2.offsetHeight + height10 + div4.offsetHeight+260;
		var height12 = (currNum-3)*67 + 760;
		var height13 = (currNum-3)*67 + 775;
		if(currNum < 3){
			var height11 = div1.offsetHeight + div2.offsetHeight + 426 + div4.offsetHeight+260;
			div3.style.height = 466+"px";
			div6.style.height = height11+"px";
			div8.style.top = 390+"px";
			div9.style.top = 405+"px";
		}
		else{
			var height3 = currNum*67 + 665;
			div3.style.height = height3+"px";
			div6.style.height = height11+"px";
			div8.style.top = height12+"px";
			div9.style.top = height13+"px";
		}
		voteInfoFlag1 = 1;
		$(this).remove();
	});
	$("#addvoteinfobtn2").click(function(){
		var div3 = document.getElementById("u23");
		var div6 = document.getElementById("left_bg");
		var div9 = document.getElementById("submitbutton2");
		$("#submitbutton2").before("<div id='txteditor'><form id='txteditorform2'><textarea id='container2' name='container'></textarea></form></div>");
		var ue = UE.getEditor('container2',{  
			autoFloatEnabled:false,
			scaleEnabled:false
        });
		var height10 = div3.offsetHeight + 400;
		var height11 = div6.offsetHeight + 400;
		var height12 = div9.offsetTop + 400;
		div3.style.height = height10+"px";
		div6.style.height = height11+"px";
		div9.style.top = height12+"px";
		voteInfoFlag2 = 1;
		$(this).remove();
	});
	$("#addvoteinfobtn3").click(function(){
		var div3 = document.getElementById("u28");
		var div6 = document.getElementById("left_bg");
		var div9 = document.getElementById("submitbutton3");
		$("#submitbutton3").before("<div id='txteditor'><form id='txteditorform3'><textarea id='container3' name='container'></textarea></form></div>");
		var ue = UE.getEditor('container3',{  
			autoFloatEnabled:false,
			scaleEnabled:false
        });
		var height10 = div3.offsetHeight + 400;
		var height11 = div6.offsetHeight + 400;
		var height12 = div9.offsetTop + 400;
		div3.style.height = height10+"px";
		div6.style.height = height11+"px";
		div9.style.top = height12+"px";
		voteInfoFlag3 = 1;
		$(this).remove();
	});
	$("#submitbutton").click(function(){
		var voteOptionNum = 0;
		var voteOptiontxt = new Array();
		var voteOptionStr = "";
		var maxVoteStr = "";
		var allowTxtStr = "";
		var optionCheck = 0;
		var voteOptionFlag = 1;
		var voteTittleFlag = 1;
		var deadlineFlag = 1;
		var voteUserFlag = 1;
		var uploadedurl;
		
		$("input[name='votechoicetxt']").each(function(){
			if($(this).val() == ""){
				optionCheck ++;
			}
			voteOptiontxt[voteOptionNum] = $(this).val();
			voteOptionNum++;
		});
		if(optionCheck != 0){
			voteOptionFlag = 0;
			alert("请输入选项内容！");
		}
		else{
			for(var n = 0;n < voteOptionNum;n++){
				if(n!=voteOptionNum-1){
					voteOptionStr=voteOptionStr+voteOptiontxt[n]+",";
			    }else{
			    	voteOptionStr=voteOptionStr+voteOptiontxt[n];
			    }
			}
		}
		var num = 1;
		$("input[name='maxvotedtxt']").each(function(){
			if(num < $("input[name='maxvotedtxt']").length){
				if($(this).val() == ""){
					maxVoteStr = maxVoteStr + "-1,";
					num ++;
				}
				else{
					maxVoteStr = maxVoteStr + $(this).val() + ",";
					num ++;
				}
			}
			else{
				if($(this).val() == ""){
					maxVoteStr = maxVoteStr + "-1";
					num ++;
				}
				else{
					maxVoteStr = maxVoteStr + $(this).val();
					num ++;
				}
			}
		});
		var allowTxtNum = 0;
		var allowTxtAll = $("input[name='allowtxt']").length;
		$("input[name='allowtxt']").each(function(){
			if($(this).is(':checked')){
				allowTxtNum++;
				if(allowTxtNum < allowTxtAll){
					allowTxtStr = allowTxtStr + "1,";
				}
				else{
					allowTxtStr = allowTxtStr + "1";
				}
			}
			else{
				allowTxtNum++;
				if(allowTxtNum < allowTxtAll){
					allowTxtStr = allowTxtStr + "0,";
				}
				else{
					allowTxtStr = allowTxtStr + "0";
				}
			}
		});
		
		var voteType = "";
		$("input[name='radiobutton']:checked").each(function(){
			if($(this).val() == "singlechoose"){
				voteType = voteType + "1";
			}
			else if($(this).val() == "multichoose"){
				voteType = voteType + "2";
			}
		});
		if($("#u16").val() == ""){
			voteTittleFlag = 0;
			alert("请输入投票标题！");
		}
		if($("#u18").val() == ""){
			deadlineFlag = 0;
			alert("请输入截止日期！");
		}
		var user = $("#select2 option").map(function(){return $(this).val();}).get().join(",");
		
		if($("#select2 option").length == 0){
			voteUserFlag = 0;
			alert("请选择可参与用户组！");
		}
		var voteInfo = "";
		if(voteOptionFlag == 1 && voteTittleFlag == 1 && deadlineFlag == 1 && voteUserFlag == 1){
			$(".imageurl").each(function(){
				if($(this).attr("urlmethod") == "1"){
					var uploadflag = $(this).siblings(".btn_addPic").children(".form").attr("id");
					$("#"+uploadflag).ajaxSubmit({
						type: "POST",
						url:"uploadImageServlet", //把表单数据发送到uploadImageServlet
						async:false,
						error: function (request) {
							alert("发送请求失败！");
						},
						success: function (data,status) {
							uploadedurl = data;
			            }
					});
					$(this).val(uploadedurl);
				}
			});
			var imageURL = $(".voteoption").map(function(){
				if($(this).has(".imageurl").length == 0){
					return "NoURL";
				}
				else{
					if($(this).children("#imgurl").val() == "输入图片的URL"){
						return "NoURL";
					}
					else{
						if($(this).children("#imgurl").attr("urlmethod") == "1"){
							return $(this).children("#imgurl").val();
						}
						else{
							return $(this).children("#imgurl").val();
						}
					}
				}
			}).get().join(",");
			if(voteInfoFlag1 = 1){
				$("#txteditorform1").ajaxSubmit({
					type: "POST",
					url:"uEditorServlet",
					async:false,
					error: function (request) {
						alert("发送请求失败！");
					},
					success: function (data,status) {
						voteInfo = data;
		            }
				});
			}
			if(voteType == "1"){
				$.post("createVoteServlet",
				{
					voteType:voteType,
					voteTittle:$("#u16").val(),
					voteDeadline:$("#u18").val(),
					voteOptionStr:voteOptionStr,
					maxVoteStr:maxVoteStr,
					allowTxtStr:allowTxtStr,
					user:user,
					voteInfo:voteInfo,
					imgURL:imageURL
				},
				function(data,status){
					if(data == "1"){
						alert('创建投票成功！');
						window.location.href = 'createvote.jsp';
					}
					else if(data == "0"){
						alert('创建投票失败！请稍后重试');
					}
				});
			}
			else if(voteType == "2"){
				$.post("createVoteServlet",
				{
					voteType:voteType,
					voteTittle:$("#u16").val(),
					voteDeadline:$("#u18").val(),
					voteOptionStr:voteOptionStr,
					maxVoteStr:maxVoteStr,
					allowTxtStr:allowTxtStr,
					user:user,
					voteInfo:voteInfo,
					minVoteNum:$("#minvotenumtxt").val(),
					maxVoteNum:$("#maxvotenumtxt").val(),
					imgURL:imageURL
				},
				function(data,status){
					if(data == "1"){
						alert('创建投票成功！');
						window.location.href = 'createvote.jsp';
					}
					else if(data == "0"){
						alert('创建投票失败！请稍后重试');
					}
				});
			} 
		}
	});
	$("#submitbutton2").click(function(){
		var voteTittleFlag = 1;
		var deadlineFlag = 1;
		var voteUserFlag = 1;
		var voteInfo = "";
		if($("#u25").val() == ""){
			voteTittleFlag = 0;
			alert("请输入投票标题！");
		}
		if($("#u27").val() == ""){
			deadlineFlag = 0;
			alert("请输入截止日期！");
		}
		var user = $("#select2 option").map(function(){return $(this).val();}).get().join(",");
		if($("#select2 option").length == 0){
			voteUserFlag = 0;
			alert("请选择可参与用户组！");
		}
		if(voteTittleFlag == 1 && deadlineFlag == 1 && voteUserFlag == 1){
			if(voteInfoFlag2 = 1){
				$("#txteditorform2").ajaxSubmit({
					type: "POST",
					url:"uEditorServlet",
					async:false,
					error: function (request) {
						alert("发送请求失败！");
					},
					success: function (data,status) {
						voteInfo = data;
		            }
				});
			}
			$.post("createTxtVoteServlet",
			{
				voteTittle:$("#u25").val(),
				voteDeadline:$("#u27").val(),
				voteInfo:voteInfo,
				user:user
			},
			function(data,status){
				if(data == "1"){
					alert('创建投票成功！');
					window.location.href = 'createvote.jsp';
				}
				else if(data == "0"){
					alert('创建投票失败！请稍后重试');
				}
			});
		}
	});
	$("#submitbutton3").click(function(){
		var voteTittleFlag = 1;
		var deadlineFlag = 1;
		var voteUserFlag = 1;
		var voteInfo = "";
		if($("#u30").val() == ""){
			voteTittleFlag = 0;
			alert("请输入投票标题！");
		}
		if($("#u32").val() == ""){
			deadlineFlag = 0;
			alert("请输入截止日期！");
		}
		var user = $("#select2 option").map(function(){return $(this).val();}).get().join(",");
		if($("#select2 option").length == 0){
			voteUserFlag = 0;
			alert("请选择可参与用户组！");
		}
		if(voteTittleFlag == 1 && deadlineFlag == 1 && voteUserFlag == 1){
			if(voteInfoFlag2 = 1){
				$("#txteditorform3").ajaxSubmit({
					type: "POST",
					url:"uEditorServlet",
					async:false,
					error: function (request) {
						alert("发送请求失败！");
					},
					success: function (data,status) {
						voteInfo = data;
		            }
				});
			}
			$.post("createCandidateServlet",
			{
				voteTittle:$("#u30").val(),
				candidateDeadline:$("#u32").val(),
				voteInfo:voteInfo,
				user:user
			},
			function(data,status){
				if(data == "1"){
					alert('创建投票成功！');
					window.location.href = 'createvote.jsp';
				}
				else if(data == "0"){
					alert('创建投票失败！请稍后重试');
				}
			});
		}
	});
});
</script>
<title>创建投票</title>
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
			<form action="checkVoteServlet" method="post">
				<input id="u6" name="Button1" type="submit" value="" width="143" height="143" align="middle">
			</form>
			<!-- 创建投票  -->
			<div id="u7">
				<img src="images/createvote_state2.png" name="createvote_pic" width="143" height="143" border="0" align="middle"> 
			</div>
		</div>
	</div>
	<div id="right">
		<div id="u8">
			<div id="u9">
				选择类
			</div>
			<div id="u9_img">
				<img src="images/underline.png" width="200" height="40" border="0" align="middle"/>
			</div>
			<div id="u10">
				文字类
			</div>
			<div id="u10_img">
				<img src="images/withoutunderline.png" width="200" height="40" border="0" align="middle" onMouseOver="this.src='images/underline.png'" onMouseOut="this.src='images/withoutunderline.png'"/>
			</div>
			<div id="ucandidate">
				选举类
			</div>
			<div id="ucandidate_img">
				<img src="images/withoutunderline.png" width="200" height="40" border="0" align="middle" onMouseOver="this.src='images/underline.png'" onMouseOut="this.src='images/withoutunderline.png'"/>
			</div>
		</div>
		<div id="u11">
			<div id="u12">
				选择可参与的用户：
			</div>
		</div>
		<div id="u22">
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
					if(lgnBean != null){
						Connection con;
						Statement sql;
						String uri = "jdbc:mysql://localhost:3306/evoting?"
								+"user=root&password=1234&characterEncoding=gb2312";
						con = DriverManager.getConnection(uri);
						String condition1 = "SELECT distinct entrance_time FROM class ORDER BY entrance_time";
						String condition2 = "SELECT college.college_name,college.college_num FROM school JOIN schoolcollege JOIN college ON school.school_num = schoolcollege.school_num AND schoolcollege.college_num = college.college_num WHERE school.school_name = '"+lgnBean.getSchoolName()+"'";
						String condition3 = "SELECT student.stu_num FROM school JOIN schoolcollege ON school.school_num = schoolcollege.school_num JOIN collegedepart ON schoolcollege.college_num = collegedepart.college_num JOIN departclass ON collegedepart.depart_num = departclass.depart_num JOIN classstu ON departclass.class_num = classstu.class_num JOIN student ON classstu.stu_num = student.stu_num WHERE school.school_name = '"
								+lgnBean.getSchoolName()+"' ORDER BY student.stu_num";
						
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
						}
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
					<select multiple="multiple" id="select2"></select>
				</div>	
			</div>
		</div>
		<div id="u13">
			<div id="u14">
				  标题：
			</div>
			<div id="u15">
				<input type="radio" name="radiobutton" id="singlechooseradio" value="singlechoose" checked>单选
				<input type="radio" name="radiobutton" id="multichooseradio" value="multichoose">多选
			</div>
			<input name="votetittle" id="u16" type="text">
			<div id="u17">
				截止日期：
			</div>
			<%
				String datetime=new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
			%> 
			<input name="deadline" id="u18" type="text" readonly="readonly" onclick="J.calendar.get({to:'<%=datetime%>,max'});">
			
			<input name="addvoteinfobtn1" value="添加投票描述" id="addvoteinfobtn1" type="button">
			<div id="addvote">
				添加选项
			</div>
			<div id="submitbutton">
				<img id="buttonimg" width="140" height="41" border="0" align="middle" src="images/createvote.png"/>
				<div id="buttontext">
					创建投票
				</div>
			</div>
		</div>
		<div id="u23">
			<div id="u24">
				  标题：
			</div>
			<input name="votetittle" id="u25" type="text">
			<div id="u26">
				截止日期：
			</div>
			<input name="deadline" id="u27" type="text" readonly="readonly" onclick="J.calendar.get({to:'<%=datetime%>,max'});">
			<input name="addvoteinfobtn2" value="添加投票描述" id="addvoteinfobtn2" type="button">
			<div id="submitbutton2">
				<img id="buttonimg2" width="140" height="41" border="0" align="middle" src="images/createvote.png"/>
				<div id="buttontext2">
					创建投票
				</div>
			</div>
		</div>
		<div id="u28">
			<div id="u29">
				  标题：
			</div>
			<input name="votetittle" id="u30" type="text">
			<div id="u31">
				候选人报名截止日期：
			</div>
			<input name="deadline" id="u32" type="text" readonly="readonly" onclick="J.calendar.get({to:'<%=datetime%>,max'});">
			<input name="addvoteinfobtn3" value="添加投票描述" id="addvoteinfobtn3" type="button">
			<div id="submitbutton3">
				<img id="buttonimg3" width="140" height="41" border="0" align="middle" src="images/createvote.png"/>
				<div id="buttontext3">
					创建投票
				</div>
			</div>
		</div>
	</div>
</body> 
</html>