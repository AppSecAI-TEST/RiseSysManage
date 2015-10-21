<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/pub/js/json.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json2.js"></script>
		<script type="text/javascript" src="<%=path %>/js/genCourseConfig/stageConfig.js"></script>
  	</head>
  	<body>
  	<div id="tt" class="easyui-tabs" style="min-width:1110px;width:98%;height:auto;">
  		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<div title="课程阶段配置" style="padding:5px;display:block;">
			<table align="center" title="查询结果" data-options="height:600" id="stage_data">
				
			</table>
			<div id="stageToolbar">
	   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="addStage()">添加阶段</a>
	   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" onclick="updateStage()">修改阶段</a>
	   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" onclick="deleteStage()">删除阶段</a>
	   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="addClassType()">添加班级类型</a>
	 		</div>
	 		<div id="stageDlg" class="easyui-dialog" style="width:550px;height:300px;padding:0px 0px" modal="true" closed="true" buttons="#stage-buttons">
				<form id="stageFm" method="post">
					<input name="classId" type="hidden" />
					<table width="98%" style="margin:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
						<tr>
							<td align="right">阶段名称：</td>
							<td align="left"><input id="stageId" name="stageId" style="width:265px" class="easyui-textbox" required="true"/></td>
						</tr>
						<tr id="seqOrderTr">
							<td align="right">阶段顺序：</td>
							<td align="left"><input id="seqOrder" name="seqOrder" style="width:265px" class="easyui-numberbox"/></td>
						</tr>
						<tr>
							<td align="right">班级类型：</td>
							<td align="left"><input name="classType" style="width:265px" class="easyui-textbox" required="true" /></td>
						</tr>
						<tr>
							<td align="right">基础课时：</td>
							<td align="left"><input name="hours" style="width:265px" class="easyui-numberbox" required="true" /></td>
						</tr>
						<tr>
							<td align="right">毕业典礼课时：</td>
							<td align="left"><input name="gradHours" style="width:265px" class="easyui-numberbox" required="true" /></td>
						</tr>
						<tr>
							<td align="right">毕业典礼消耗时长：</td>
							<td align="left"><input name="gradRemark" style="width:265px" class="easyui-textbox" required="true"/></td>
						</tr>
						<tr>
							<td align="right">是否开放（班级）：</td>
							<td align="left"><input type="radio" value="Y" name="isOpen" checked="checked"/><span>是</span>&nbsp;<input type="radio" value="N" name="isOpen"/><span>否</span></td>
						</tr>
					</table>
				</form>
			</div>
			<div id="stage-buttons">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveSubmit()">提交</a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#stageDlg').dialog('close')">取消</a>
			</div>
			<div id="updateStageDlg" class="easyui-dialog" style="width:550px;height:150px;padding:0px 0px" modal="true" closed="true" buttons="#updateStage-buttons">
				<form id="updateStageFm" method="post">
					<input name="id" type="hidden" />
					<table width="98%" style="margin:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
						<tr>
							<td align="right">阶段名称：</td>
							<td align="left"><input name="stageId" style="width:265px" class="easyui-textbox" required="true"/></td>
						</tr>
						<tr>
							<td align="right">阶段顺序：</td>
							<td align="left"><input name="seqOrder" style="width:265px" class="easyui-numberbox" required="true"/></td>
						</tr>
					</table>
				</form>
			</div>
			<div id="updateStage-buttons">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="updateStageSubmit()">提交</a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#updateStageDlg').dialog('close')">取消</a>
			</div>
  		</div>
  		
	  </div>
  	</body>
</html>
