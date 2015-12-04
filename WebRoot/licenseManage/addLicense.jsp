<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String teacherId=request.getParameter("teacherId");
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/pub/js/json.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json2.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/css/style.css">
		<script type="text/javascript" src="<%=path %>/js/license/licenseManage.js"></script>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="添加新持证">
  			<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<input id="teacherId" type="hidden" value="<%=teacherId %>"/>
	 		<table id="licenseTab" width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="center" width="35%">课程阶段</td>
  					<td align="center" width="35%">持证开始时间</td>
  					<td align="center" width="20%">操作</td>
  				</tr>
  				<tr id="licenseModelTR">
	      	        <td align="center">
	      	        	<select id="stageId" name="stageId" class="easyui-combobox" style="width:200px;" editable='false' required="true" 
							data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'"
				      		url="<%=path %>/licenseManage/qryTeacherHasntLicense.do?teacherId=<%=teacherId %>">
        				</select>
        			</td>
	      	        <td align="center"><input id="startDate" name="startDate" style="width:200px" editable='false'  class="easyui-datebox" required="true" /></td>
	      	        <td align="center"><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px;" onclick="addRow()">添加</a></td>
      	     	</tr>
      	     	<tr style="display:none;" name="addLicense" id="addLicense" >
	      	        <td align="center"></td>
	      	        <td align="center"></td>
	      	        <td align="center"><a href='javascript:void(0)' class='linkmore' onclick='delRow(this)' ><span>删除</span></a></td>
     	       </tr>
	 		</table>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: right;">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;" onclick="addLicenseSubmit()">提交</a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
	   <script type="text/javascript">
	   		$(document).ready(function(){
	   			$('#startDate').datebox().datebox('calendar').calendar(
					{
						validator: function(date)
						{
							var now = new Date();
							var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
							return date <= d1;
						}
					});
	   			});
	   </script>
  	</body>
</html>
