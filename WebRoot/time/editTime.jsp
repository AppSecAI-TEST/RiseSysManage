<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.rise.pub.util.StringUtil"%>
<%
	String path = request.getContextPath();
	String time = request.getParameter("time");
	String schooltime = request.getParameter("schooltime");
	String weekTime = request.getParameter("weekTime");
	String weekSeq = request.getParameter("weekSeq");
	String schoolId=request.getParameter("schoolId");
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
  
  	<form id="timeFm">
		<table width="500px" cellpadding="5px" class="maintable" id="addActivityTd">
		    <input type="hidden" name="weekTime" value="<%=weekTime%>"/>
			<input type="hidden" name="weekSeq" value="<%=weekSeq%>"/>
			<input type="hidden" name="schooltime" value="<%=schooltime %>"/>
			<input type="hidden" name="teacherName" value="<%=StringUtil.getJSONObjectKeyVal(object,"teacherName") %>"/>
			<input type="hidden" name="teacherId" value="<%=StringUtil.getJSONObjectKeyVal(object,"teacherId") %>"/>
			<input type="hidden" name="schoolId" value="<%=schoolId%>"/>
			<input type="hidden" id="schooltimeInstId" value="<%=StringUtil.getJSONObjectKeyVal(object,"schooltimeInstId")%>"/>
			<tr>
				<td align="right"><span>当前日期：</span></td>
				<td>
				<span width="100px"><%=schooltime%></span>
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
				 <select name="teacherType" class="easyui-combobox" style="width: 150px; height: 28px;"><option value="T">T</option><option value="TA">TA</option></select> 
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
					<select name="classInstId" id="classInstId" class="easyui-combobox" style="width: 150px; height: 28px;"
					url="<%=path %>/pubData/qryData.do?param={'queryCode':'Qry_School_Time','schoolId':'1001'}",
					data-options=" valueField: 'classInstId', textField: 'className', panelHeight: 'auto'" >
 					</select>
				</td>
			</tr>
			<tr>
				<td align="right"><span>教室：</span></td>
				<td>
					<select name="roomId" id="roomId" class="easyui-combobox" style="width: 150px; height: 28px;"
 				data-options="formatter:formatRoom, valueField: 'roomId', textField: 'roomName', panelHeight: 'auto',
 				onLoadSuccess:function(data){$('#roomId').combobox('setValue',data[0].roomId);}" 
 				url="<%=path %>/pubData/qryRoomList.do?schoolId=${sessionScope.StaffT.schoolId}">
  				</select>
				</td>
			</tr>
		</table>  	
		</form>	
      	<div style="margin-top: 20px;min-width:500px; width:500px;">
	      	<div style="float: left;margin-left: 150px;">
	      		<a href="javascript:void(0)" id="delete" class="easyui-linkbutton" iconCls="icon-ok" style="width: 130px; height: 28px;">删除当前排课</a>
	      &nbsp;<a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      &nbsp;<a href="javascript:void(0)" id="back"   class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">取消</a>
	      	</div>
	    </div>
  	</body>
</html>
<script type="text/javascript">

	$("#submit").click(function ()
	{
			var time = $("#timeFm").serializeObject();
			var className=$("#classInstId").combobox('getText');
			time.className=className;
			var obj = JSON.stringify(time);
		 	$.ajax({
			type : "POST",
			url: "/sys/time/add.do",
			data: "param="+obj,
			async: false,
			dataType:"json",
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '系统消息', msg : '正在提交数据，请稍等……'});
	    	},
	    	success: function(data) {
	    		$.messager.progress('close');
	    		 
	        },
	        error:function(){
	        	$.messager.progress('close'); 
	        }
	    	
		});
	});
	
	$("#delete").click(function()
	{
		var schooltimeId=$("#schooltimeInstId").val();
		var param="{schooltimeInstId="+schooltimeId+"}";
		$.ajax({
			type : "POST",
			url: "/sys/time/delete.do",
			data: "param="+param,
			async: false,
			dataType:"json",
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '系统消息', msg : '正在提交数据，请稍等……'});
	    	},
	    	success: function(data) {
	    		$.messager.progress('close');
	    		 
	        },
	        error:function(){
	        	$.messager.progress('close'); 
	        }
	    	
		});
		
	});

</script>
