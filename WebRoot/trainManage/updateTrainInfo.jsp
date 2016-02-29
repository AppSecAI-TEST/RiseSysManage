<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/train/trainManage.js"></script>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="修改培训">
  			<form id="updateTrainForm">
  			<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<input id="trainId" type="hidden" value="${obj.train.trainId}"/>
	 		<table id="trainTab" width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="right"><span>教师姓名：</span></td>
  					<td align="left">${name}</td>
  					<td align="right"><span>教师英文名：</span></td>
  					<td align="left">${byName}</td>
  					<td align="right"><span>教师状态：</span></td>
  					<td align="left">${stateVal}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>培训开始时间：</span></td>
  					<td align="left"><input class="easyui-datebox" name="trainStartDate" id="trainStartDate" style="width:100px;" required="true"/></td>
  					<td align="right"><span>培训结束时间：</span></td>
  					<td align="left"><input class="easyui-datebox" name="trainEndDate" id="trainEndDate" style="width:100px;" required="true"/></td>
  					<td align="right"><span>培训费用：</span></td>
  					<td align="left"><input class="easyui-numberbox" name="trainAmount" id="trainAmount" style="width:100px;" precision = "2" required="true"/></td>
  				</tr>
  				<tr>
  					<td align="right"><span>协议有效期：</span></td>
  					<td align="left"><input class="easyui-numberbox" name="trainDeadline" id="trainDeadline" style="width:100px;" required="true"/>年</td>
  					<td align="right"><span>培训地点：</span></td>
  					<td align="left"><input class="easyui-textbox" name="trainPlace" id="trainPlace" style="width:100px;" required="true"/></td>
  					<td align="right"><span>培训类型：</span></td>
  					<td align="left">
  						<select name="trainType" id="trainType" class="easyui-combobox" style="width:100px" required="true" editable='false'
						 >
						</select>
  					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>备注：</span></td>
  					<td colspan="5" align="left"><textarea rows="5" cols="100" id="remark" name="remark" class="easyui-validatebox textbox">${obj.train.remark}</textarea></td>
  				</tr>
	 		</table>
	 		</form>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="text-align:center">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="updateTrainSubmit()"><span>提交</span></a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
	   <script type="text/javascript">
	   		$(document).ready(function(){
	   			//初始化页面值
	   			$("#trainStartDate").datebox('setValue',"${obj.train.trainStartDate}");
	   			$("#trainEndDate").datebox('setValue',"${obj.train.trainEndDate}");
	   			$("#trainAmount").numberbox('setValue',"${obj.train.trainAmount}");
	   			$("#trainDeadline").numberbox('setValue',"${obj.train.trainDeadline}");
	   			$("#trainPlace").textbox('setValue',"${obj.train.trainPlace}");
	   			$('#trainType').combobox({
					url:"<%=path %>/pubData/qryStage.do",
					valueField: 'stageId', 
					textField: 'stageId', 
					panelHeight: 'auto',
					onLoadSuccess:function(){
						var data = $('#trainType').combobox('getData');
						if(data.length > 0)
			            {
				       		for(var i = 0;i < data.length;i++)
				       		{
				       			
				       			 if("${obj.train.trainType}" == data[i].stageId)
				       			 {
				       				 $('#trainType').combobox('select',data[i].stageId);
				       			 }
				       		}
				       	}
					}
				});
	   		});
	   </script>
  	</body>
</html>
