<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String studentId = request.getParameter("studentId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript">
			$(document).ready(function() {
				var studentId = $("#studentId").val();
				$("#course_list_data").datagrid({ 
					url:"/sys/pubData/qryDataListByPage.do?param={funcNodeId:'1016',studentId:'"+studentId+"'}",
					onLoadSuccess: function() { 
						var rows = $("#course_list_data").datagrid('getRows');
						if(parseInt(rows.length) <= 0) {
							$("#courseDiv").css("display", "none");
						}
					}
				});
				
				$("#international_list_data").datagrid({ 
					url:"/sys/pubData/qryDataListByPage.do?param={funcNodeId:'1038',studentId:'"+studentId+"'}",
					onLoadSuccess: function() { 
						var rows = $("#international_list_data").datagrid('getRows');
						if(parseInt(rows.length) <= 0) {
							$("#internationalDiv").css("display", "none");
						}
					}
				});
				
				$("#travel_list_data").datagrid({ 
					url:"/sys/pubData/qryDataListByPage.do?param={funcNodeId:'1039',studentId:'"+studentId+"'}",
					onLoadSuccess: function() { 
						var rows = $("#travel_list_data").datagrid('getRows');
						if(parseInt(rows.length) <= 0) {
							$("#travelDiv").css("display", "none");
						}
					}
				});
			});
		</script>
  	</head>  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="学员课程信息">
  			<input type="hidden" id="studentId" value="<%=studentId %>"/>
  			<div id="courseDiv">
	  			<table class="easyui-datagrid" title="常规课信息" style="height:auto;" id="course_list_data" 
					pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
					<thead>
						<tr>
							<th data-options="field:'stageId',width:100,align:'center'">课程阶段</th>
							<th data-options="field:'courseStateText',width:100,align:'center'">课程状态</th>
							<th data-options="field:'paySchoolName',width:100,align:'center'">校区</th>
							<th data-options="field:'payDate',width:120,align:'center'">缴费日期</th>
							<th data-options="field:'feeTypeText',width:100,align:'center'">业绩类型</th>
							<th data-options="field:'className',width:100,align:'center'">班级</th>
							<th data-options="field:'startDate',width:120,align:'center'">开课日期</th>
							<th data-options="field:'finishDate',width:120,align:'center'">结课日期</th>
							<th data-options="field:'classProgress',width:100,align:'center'">课时进度</th>
							<th data-options="field:'classTeacherName',width:100,align:'center'">带班老师</th>
							<th data-options="field:'adviserName',width:100,align:'center'">业绩顾问</th>
							<th data-options="field:'adviserTeacherName',width:100,align:'center'">业绩老师</th>
							<th data-options="field:'dutyAdvisterName',width:100,align:'center'">责任顾问</th>
							<th data-options="field:'carerName',width:100,align:'center'">客户关怀</th>
						</tr>
					</thead>
				</table>
  			</div>
  			<div id="internationalDiv">
				<table class="easyui-datagrid" title="短期课-国际班信息" style="height:auto;" id="international_list_data"
					pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
					<thead>
						<tr>
							<th data-options="field:'classType',width:100,align:'center'">国际班类型</th>
							<th data-options="field:'paySchoolName',width:100,align:'center'">报名校区</th>
							<th data-options="field:'schoolName',width:100,align:'center'">上课校区</th>
							<th data-options="field:'payDate',width:120,align:'center'">缴费日期</th>
							<th data-options="field:'courseStateText',width:100,align:'center'">课程状态</th>
							<th data-options="field:'className',width:100,align:'center'">班级</th>
							<th data-options="field:'openDate',width:120,align:'center'">开课日期</th>
							<th data-options="field:'finishDate',width:120,align:'center'">结课日期</th>
							<th data-options="field:'classProgress',width:100,align:'center'">课时进度</th>
							<th data-options="field:'adviserTeacherName',width:100,align:'center'">业绩老师</th>
							<th data-options="field:'adviserName',width:100,align:'center'">业绩顾问</th>
						</tr>
					</thead>
				</table>
  			</div>
  			<div id="travelDiv">
				<table class="easyui-datagrid" title="短期课-游学信息" style="height:auto;" id="travel_list_data"
					pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
					<thead>
						<tr>
							<th data-options="field:'classType',width:100,align:'center'">游学班类型</th>
							<th data-options="field:'className',width:100,align:'center'">班级</th>
							<th data-options="field:'paySchoolName',width:100,align:'center'">报名校区</th>
							<th data-options="field:'payDate',width:100,align:'center'">缴费日期</th>
							<th data-options="field:'courseStateText',width:120,align:'center'">课程状态</th>
							<th data-options="field:'openDate',width:100,align:'center'">出发日期</th>
							<th data-options="field:'finishDate',width:100,align:'center'">返回日期</th>
							<th data-options="field:'adviserTeacherName',width:120,align:'center'">业绩老师</th>
							<th data-options="field:'adviserName',width:120,align:'center'">业绩顾问</th>
						</tr>
					</thead>
				</table>
  			</div>
			<div style="height: 10px;"></div>
  		</div>
  	</body>
</html>
