<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<style type="text/css">
			.tab td{
				font-size:14px;
				height:30px;
				border-right:1px solid #ccc;
				border-bottom:1px solid #ccc;
			}
			.tab tr td:nth-last-child(2n+1){
				padding-left:4px;
			}
			.tab tr td:nth-last-child(2n){
				padding-right:4px;
			}
		</style>
  	</head>
  
  	<body class="easyui-layout manage">
  		<form id="fm" method="post">
  			<input type="hidden" name="classInstId" value="${classInstT.classInstId}" />
			<div data-options="region:'north',title:'考勤信息',collapsible:false,height:200,maxHeight:180,border:false" style="min-width:1100px;width:99%;font-family:'微软雅黑';margin:0 auto;">
				<table align="center" class="tab" style="height:100%;width:99%;margin:0 auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td align="right" width="10%">课程阶段：</td>
						<td width="23%">${classInstT.stageId}</td>
						<td align="right" width="10%">班级类型：</td>
						<td width="23%">${classInstT.classType}</td>
						<td align="right" width="10%">班级名称：</td>
						<td width="23%">${classInstT.className}</td>
					</tr>
					<tr>
						<td align="right">开课日期：</td>
						<td><fmt:formatDate value="${classInstT.openDate}" pattern="yyyy-MM-dd" /></td>
						<td align="right">学员来源类型：</td>
						<td>${classInstT.studentChannelTypeName}</td>
						<td align="right">升学班级：</td>
						<td>${classInstT.higherSchoolName}</td>
					</tr>
					<tr>
						<td align="right">班级性质：</td>
						<td>${classInstT.handTypeName}</td>
						<td align="right">开班类型：</td>
						<td>${classInstT.openClassTypeName}</td>
						<td align="right">课时进度：</td>
						<td>${classInstT.hours}</td>
					</tr>
					<tr>
						<td align="right">开班人数：</td>
						<td>${classInstT.openClassNum}</td>
						<td align="right">在读人数：</td>
						<td>${classInstT.openClassNum}</td>
						<td align="right">持证率：</td>
						<td><fmt:formatNumber value="${classInstT.licenseRate}" type="percent" /></td>
					</tr>
					<tr>
						<td align="right">升学基数：</td>
						<td>5</td>
						<td align="right">已升学人数：</td>
						<td>10</td>
						<td align="right">升学率：</td>
						<td>100%</td>
					</tr>
				</table>
			</div>
			<div data-options="region:'center',collapsible:false,maxHeight:100,height:150,border:false" style="min-width:1100px;width:99%;font-family:'微软雅黑';margin:0px auto;">
				<table align="center" class="tab" style="height:100%;width:99%;margin:0 auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
					<c:forEach items="${classInstT.schooltimeList}" var="node">
						<tr>
							<td align="right" width="10%">上课时段：</td>
							<td width="23%">周${node.weekTime} ${node.hourRangeName}</td>
							<td align="right" align="right" width="5%">教室：</td>
							<td width="12%">${node.roomName}</td>
							<td align="right" align="right" width="5%">课时：</td>
							<td width="12%">${node.lessionHours}</td>
							<td align="right" width="10%">带班老师：</td>
							<td width="23%">
								<c:forEach items="${node.classTeacherList}" var="item">
									${item.schoolName}&nbsp;${item.teacherName}&nbsp;${item.hasLicense}&nbsp;课时量&nbsp;${item.hours}
								</c:forEach>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div data-options="region:'south',collapsible:false,maxHeight:500,height:265,border:false" style="min-width:1100px;width:99%;font-family:'微软雅黑';margin:0px auto;">
				<table region="center" id="attendList" class="easyui-datagrid" title="" style="height:99%;" toolbar="#toolbar" pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
					<thead>
						<tr>
							<th data-options="field:'ck',checkbox:true"></th>
							<th field="monthName" width="9%">月份</th>
							<th field="monthPlan" width="9%">本月计划课时</th>
							<th field="monthRow" width="9%">本月排课课时</th>
							<th field="monthReal" width="9%">本月实际课时</th>
							<th field="schedulePlan" width="9%">本月计划进度</th>
							<th field="scheduleRow" width="9%">本月排课进度</th>
							<th field="scheduleReal" width="9%">本月实际进度</th>
							<th field="isTieOff" width="9%">是否已扎帐</th>
							<th field="absentClassNum" width="9%">缺课课时量</th>
							<th field="markupClassNum" width="9%">已补课课时量</th>
							<th field="attendance" width="9%">本月总出勤率</th>
						</tr>
					</thead>
				</table>
				<div id="toolbar">
					<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
		   			<a href="javascript:void(0)" id="addStaff" class="easyui-linkbutton" iconCls="icon-add" onclick="attendMan()" style="width: 100px;">考勤维护</a>
		   			<a href="javascript:void(0)" id="updateStaff" class="easyui-linkbutton" iconCls="icon-edit" onclick="attendView()" style="width: 100px;">考勤浏览</a>
				</div>
			</div>
		</form>
		<script type="text/javascript">
			$(document).ready(function(){
				var statistics = '${statistics}';
				var dataObj = null;
				if(statistics != "[]")
				{
					dataObj = eval("("+statistics+")");
				}
				else
				{
					dataObj = new Array();
				}
				$("#attendList").datagrid("loadData",dataObj);
			});
			function attendMan()
			{
				var row = $('#attendList').datagrid('getSelected');
				if (row)
				{
					window.location.href = "/sys/attend/getAttendOperate.do?funcNodeId=${funcNodeId}&classInstId=${classInstT.classInstId}&selDateStr="+row.monthName;
				}
				else
				{
					$.messager.alert('提示',"请先选择要维护的考勤");
				}
			}
			function attendView()
			{
				var row = $('#attendList').datagrid('getSelected');
				if (row)
				{
					window.location.href = "/sys/attend/getAttendView.do?funcNodeId=${funcNodeId}&classInstId=${classInstT.classInstId}&selDateStr="+row.monthName;
				}
				else
				{
					$.messager.alert('提示',"请先选择要浏览的考勤");
				}
			}
			function backFunc()
			{
				window.location.href = "/sys/attence/attenceMan.jsp?funcNodeId=${funcNodeId}";
			}
		</script>
 	</body>
</html>