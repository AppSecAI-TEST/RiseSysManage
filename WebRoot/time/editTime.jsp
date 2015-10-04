<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.rise.pub.util.StringUtil"%>
<%
	String path = request.getContextPath();
	String time = request.getParameter("time");
	JSONObject object=new JSONObject();
	object = JSONObject.fromObject(time);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  
  	<body>
		<table width="500px" cellpadding="5px" class="maintable" id="addActivityTd">
			<tr>
				<td align="right"><span>当前日期：</span></td>
				<td>
				<span width="100px"><%=object.get("schooltime") %></span>
				</td>
			</tr>
			<tr>
				<td align="right"><span>带课老师：</span></td>
				<td>
					<span><%=object.get("teacherName") %></span>
				</td>
			</tr>
			<tr>
			<td align="right"><span>老师类型：</span></td>
			<td>
				 <select class="easyui-combobox" style="width: 150px; height: 28px;"><option value="T">T</option><option value="TA">TA</option></select> 
			</td>
			</tr>
			<tr>
				<td align="right"><span>时间范围：</span></td>
				<td>
					<select name="hourRange" id="hourRange" class="easyui-combobox" style="width: 150px; height: 28px;"
					data-options="valueField: 'hourRange', textField: 'hourRangeVal', panelHeight: 'auto',
 				onLoadSuccess:function(data){$('#hourRange').combobox('setValue',data[0].hourRange);}" 
					url="/sys/pubData/qryHourRangeList.do?weekTime=一" required="true">
 					</select>
				</td>
			</tr>
			
			<tr>
				<td align="right"><span>班级名称：</span></td>
				<td>
					<select name="award" id="award" class="easyui-combobox" style="width: 150px; height: 28px;"
					url="<%=path %>/pubData/qryData.do?param={'queryCode':'Qry_School_Time','schoolId':'1001'}",
					data-options=" valueField: 'clasInstId', textField: 'className', panelHeight: 'auto'" >
 					</select>
				</td>
			</tr>
			<tr>
				<td align="right"><span>教室：</span></td>
				<td>
					<select id="roomId" class="easyui-combobox" style="width: 150px; height: 28px;"
 				data-options="formatter:formatRoom, valueField: 'roomId', textField: 'roomName', panelHeight: 'auto',
 				onLoadSuccess:function(data){$('#roomId').combobox('setValue',data[0].roomId);}" 
 				url="<%=path %>/pubData/qryRoomList.do?schoolId=${sessionScope.StaffT.schoolId}">
  				</select>
				</td>
			</tr>
			 
		</table>  		
      	<div style="margin-top: 20px;min-width:500px; width:500px;">
	      	<div style="float: left;margin-left: 150px;">
	      		<a href="javascript:void(0)" id="activitySubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 130px; height: 28px;">删除当前排课</a>
	      &nbsp;<a href="javascript:void(0)" id="activitySubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      &nbsp;<a href="javascript:void(0)" id="activityBack"   class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">取消</a>
	      	</div>
	    </div>
  	</body>
</html>
