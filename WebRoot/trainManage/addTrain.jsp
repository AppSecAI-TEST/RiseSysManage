<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String teacherId = request.getParameter("teacherId");
	String name = request.getParameter("name");
	String byName = request.getParameter("byName");
	String stateVal = request.getParameter("stateVal");
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/train/trainManage.js"></script>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="新增培训">
  			<form id="addTrainForm">
  			<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<input id="teacherId" type="hidden" value="<%=teacherId %>"/>
	 		<table id="trainTab" width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="right"><span>教师姓名：</span></td>
  					<td align="left"><%=name %></td>
  					<td align="right"><span>教师英文名：</span></td>
  					<td align="left"><%=byName %></td>
  					<td align="right"><span>教师状态：</span></td>
  					<td align="left"><%=stateVal %></td>
  				</tr>
  				<tr>
  					<td align="right"><span>培训开始时间：</span></td>
  					<td align="left"><input class="easyui-datebox" name="trainStartDate" id="trainStartDate" style="width:200px;" required="true"/></td>
  					<td align="right"><span>培训结束时间：</span></td>
  					<td align="left"><input class="easyui-datebox" name="trainEndDate" id="trainEndDate" style="width:200px;" required="true"/></td>
  					<td align="right"><span>培训费用：</span></td>
  					<td align="left"><input class="easyui-numberbox" name="trainAmount" id="trainAmount" style="width:200px;" precision = "2" required="true"/></td>
  				</tr>
  				<tr>
  					<td align="right"><span>协议有效期：</span></td>
  					<td align="left"><input class="easyui-numberbox" name="trainDeadline" id="trainDeadline" style="width:200px;" required="true"/>年</td>
  					<td align="right"><span>培训地点：</span></td>
  					<td align="left"><input class="easyui-textbox" name="trainPlace" id="trainPlace" style="width:200px;" required="true"/></td>
  					<td align="right"><span>培训类型：</span></td>
  					<td align="left">
  						<select name="trainType" id="trainType" class="easyui-combobox" style="width:200px" required="true" editable='false'
							data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'"
     						url="<%=path %>/pubData/qryStage.do">
						</select>
  					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>备注：</span></td>
  					<td colspan="5" align="left"><textarea rows="5" cols="100" id="remark" name="remark" class="easyui-validatebox textbox"></textarea></td>
  				</tr>
	 		</table>
	 		</form>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="text-align:center">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="addTrainSubmit()"><span>提交</span></a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
  	</body>
</html>
