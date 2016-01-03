<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String shortClassInstId =request.getParameter("shortClassInstId");
	String classState =request.getParameter("classState");
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  	<body>
 		<input id="shortClassInstId" type="hidden" value="<%=shortClassInstId %>"/>
 		<input id="classState" type="hidden" value="<%=classState %>"/>
 		<div  class="easyui-panel" title="反馈信息" style="width:1100px;">
 			<table id="infoTab" width="100%;" class="maintable">
 				<tr>
 					<td width="110px;" align="right"><span>上课日期：</span></td><td align="left"><span></span></td>
 				</tr>
 				<tr>
 					<td align="right"><span>教室：</span></td><td align="left"><span></span></td>
 				</tr>
 				<tr>
 					<td align="right"><span>课时：</span></td><td align="left"><span></span></td>
 				</tr>
	 			<tr id="modelTr1" style="display:none;">
	 				<td align="right"><span>老师：</span></td>
	 				<td align="left"><span></span></td>
	 			</tr>		
 			</table>
 		</div>
 		<div id="stuDiv" class="easyui-panel" title="学生反馈信息" style="width:1100px;">
 			<table id="stuTab" width="100%;" class="maintable">
				<tr>
					<td align="center"><span>姓名</span></td><td align="center"><span>缴费情况</span></td><td align="center"><span>缴费日期</span></td><td align="center"><span>是否定金转全费</span></td>
					<td align="center"><span>定金转全费日期</span></td><td align="center"><span>是否补缴全费</span></td><td align="center"><span>补缴全费日期</span></td>
				</tr>
				<tr id="modelTr2" style="display:none">
					<td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td>
					<td align="center"></td><td align="center"></td><td align="center"></td>
				</tr>
 			</table>
 		</div>
 		<div style="width:1100px;text-align:center;margin-top:30px;">
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:150px" id="backBtn" onclick="window.history.back();" >返回</a>	
  		</div>	
  	</body>
</html>
<script>
	$(document).ready(function(){
		$.ajax( {
			type : "POST",
			url : "/sys/demoClass/qryDemoDetailInfo.do",
			data :"shortClassInstId="+$("#shortClassInstId").val()+"&classState="+$("#classState").val(),
			async : false,
			dataType:"json",
			beforeSend : function()
			{
				showProgressLoader("正在加载数据,请稍等...", 400);
			},
			success : function(data) 
			{
				hideProgressLoader()
				if(data.baseInfo!=undefined&&data.baseInfo!="")
				{
					$("#infoTab").find("tr:eq(0)").find("td:eq(1)").find("span").html(data.baseInfo.openDate+" "+data.baseInfo.rangeVal);
					$("#infoTab").find("tr:eq(1)").find("td:eq(1)").find("span").html(data.baseInfo.roomName);
					$("#infoTab").find("tr:eq(2)").find("td:eq(1)").find("span").html(data.baseInfo.lessionHours);
				}
				if(data.teacherInfo!=undefined&&data.teacherInfo.length>0)
				{
					$.each(data.teacherInfo,function(i, obj) 
					{
						var tr = $("#modelTr1").clone();
						tr.find("td:eq(1)").find("span").html(obj.schoolName+"  "+obj.teacherName+"  "+obj.teacherType+"  "+obj.lessionHours);
						tr.css("display","table-row")
						$("#infoTab").append(tr);
					});
				}
				if(data.studentInfo!=undefined&&data.studentInfo.length>0)
				{
					$.each(data.studentInfo,function(i,obj){
						var tr =$("#modelTr2").clone();
						tr.find("td:eq(0)").html(obj.studentName);
						var fee1=fee2=fee3="";
						if(obj.fee1=="Y")
						{
							fee1="全费";
						}
						else if(obj.fee1=="N")
						{
							fee1="定金";
						}
						if(obj.fee2=="Y")
						{
							fee2="是";
						}
						else if(obj.fee2=="N")
						{
							fee2="否";
						}
						if(obj.fee3=="Y")
						{
							fee3="是";
						}
						else if(obj.fee3=="N")
						{
							fee3="否";
						}
						tr.find("td:eq(1)").html(fee1);
						tr.find("td:eq(2)").html(obj.date1);
						tr.find("td:eq(3)").html(fee2);
						tr.find("td:eq(4)").html(obj.date2);
						tr.find("td:eq(5)").html(fee3);
						tr.find("td:eq(6)").html(obj.date3);
						tr.css("display","table-row");
						$("#stuTab").append(tr);
					});
				}
				else
				{
					$("#stuDiv").panel("close");
				}	
			},
			error : function() {
				hideProgressLoader();
				showMessage('提示', "调用录入反馈服务失败！", null);
			}
		});
	})
</script>