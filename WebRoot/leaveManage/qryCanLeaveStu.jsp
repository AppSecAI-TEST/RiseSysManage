<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/leaveManage/leaveManage.js"></script>
  	</head>
  	<body>
  		<div style="margin-right:5px">
 		<form id="qryStuFm">
  			<table class="search_tab">
  				<tr>
  					<td align="right" width="10%"><span>所属校区：</span></td>
  					<td align="left" width="5%">
  						<select id="stuSchoolId" name="schoolId" class="easyui-combobox" style="width:100px;height:25px;" editable="false">
        				</select>
  					</td>
  					<td align="right" width="10%"><span>学员姓名：</span></td>
  					<td align="left" width="5%">
  						<input class="easyui-textbox" name="studentName" id="studentName" style="width:100px;height:25px;" />
  					</td>
  					<td align="right" width="10%"><span>联系电话：</span></td>
  					<td align="left" width="5%">
  						<input class="easyui-numberbox"  name="phone" id="phone" style="width:100px;height: 25px;" />
  					</td>
  					<td align="right" width="10%"><span>课程状态：</span></td>
  					<td align="left" width="5%">
  						<select class="easyui-combobox" name="courseState" id="courseState" style="width:100px;height: 25px;"
  						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_LEAVE_T&codeType=COURSE_STATE">
  						</select>
  					</td>
  					<td align="right" width="10%"><span>班级老师：</span></td>
  					<td align="left" width="5%">
  						<select class="easyui-combobox" name="teacherId" id="teacherId" style="width:100px;height:25px;">
  						</select>
  					</td>
  					<td></td>
  				</tr>
  				<tr>
  					<td colspan="10" align="center">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px" id="qryStuBtn" funcNodeId="4005"><span>查询</span></a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px" id="stuResetBtn" ><span>重置</span></a>
					</td>
  				</tr>
  			</table>
 		</form>
 		
		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:450" id="stuList_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="name" align="center" width="10%"><span>学员姓名</span></th>
					<th field="byName" align="center" width="10%"><span>英文名</span></th>
					<th field="phone" align="center" width="15%"><span>联系电话</span></th>
					<th field="stageLevel" align="center" width="10%"><span>已升学阶段</span></th>
					<th field="className" align="center" width="10%"><span>在读班级</span></th>
					<th field="courseStateVal" align="center" width="10%"><span>课程状态</span></th>
					<th field="teacherName" align="center" width="11%"><span>带班老师</span></th>
					<th field="carerName" align="center" width="10%"><span>客户关怀</span></th>
					<th field="classProgress" align="center" width="11%"><span>在读班级课时</span></th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px;height:auto;">
   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width: 100px;" onclick="addLeaveInfo()"><span>提交</span></a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
 		</div>
 		</div>
 		<script type="text/javascript">
	   		$(document).ready(function(){
	   			//初始化页面值
	   				$("#stuSchoolId").combobox({
						url : "/sys/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=501&fieldId=schoolId&headFlag=N",//返回json数据的url
						valueField : "schoolId",
						textField : "schoolName",
						panelHeight : "auto",
						formatter : formatSchool,
						onLoadSuccess : function(data) {
							$("#stuSchoolId").combobox('setValue',data[0].schoolId);
						},
						onChange : function(n, o) {
							if(n != "" && n != null && n != undefined) {
								$("#teacherId").combobox({
									url : "/sys/pubData/qryData.do?param={'queryCode':'qryClassTeacherInfo','schoolId':'"+n+"'}",//返回json数据的url
									valueField : "teacherId",
									textField : "byname",
									panelHeight : "auto",
									formatter : function(data) {
										return "<span>" + data.byname + "</span>";
									}
								});
							} else {
								$("#stuSchoolId").combobox("setText", "");
								$("#teacherId").combobox('clear');
								$("#teacherId").combobox("loadData", new Array());
							}
						}
					});
	   		});
	   </script>
  	</body>
</html>
