<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
				<script type="text/javascript" src="<%=path %>/js/finishClass/finishClassList.js"></script>
  	</head>
  
  	<body style="padding-top:5px">
  		<form id="qryFm" style="margin:0 auto;">
  			<table align="center" style="min-width:1100px;width:100%;border:1px solid #95B8E7;margin:0 auto;height:80px;">
  				<tr>
  					<td align="right"><span>校区：</span></td>
	  				<td width="114px">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 117px; height: 25px;" editable="false"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
			      			url="<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=506&fieldId=schoolId">
		        		</select>
					</td>
					<td align="right"><span>课程阶段：</span></td>
					<td width="130px">
						<select id="stageId" name="stageId" class="easyui-combobox" style="width: 117px; height: 25px;">
		        		</select>
					</td>
					<td align="right"><span>班级：</span></td>
					<td width="130px">
						<input id="className" name="className" type="text" class="easyui-textbox validatebox"  style="width: 117px; height: 23px;"/>
					</td>
				
				
					<td align="center">&nbsp;</td>
  				</tr>
  				<tr>
					<td align="right"><span>带班老师：</span></td>
					<td width="114px">
						<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 117px; height: 25px;">
		        		</select>
					</td>
					 	
					<td align="right"><span>班级状态 ：</span></td>
	  				<td width="130px">
						<select id="classState" name="classState" class="easyui-combobox" style="width: 117px; height: 25px;"
							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=FINISH_CLASS_STATE">
		        		</select>
					</td>
						<td align="right"><span>开课日期：</span></td>
					<td width="117px">
						<input class="easyui-datebox" type="text" style="width:117px; height: 25px;" id="startTimeOpenClass" name="startTimeOpenClass" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center" width="14px"><span>至</span></td>
					<td width="117px">
						<input class="easyui-datebox" type="text" style="width:117px; height: 25px;" id="endTimeOpenClass" name="endTimeOpenClass" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center">&nbsp;</td>
  				</tr>
  			 
  				<tr>
  					<td align="center" colspan="12">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1022">查询</a>
						&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
					</td>
  				</tr>
  			</table>
  		</form>
  		<div style="padding:5px 0;min-width:1100px; width:100%;">
  			<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="list_data" 
		  		toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
		  		<thead>
		  			<tr>
		  				<th data-options="field:'ck',checkbox:true"></th>
		  				<th data-options="field:'schoolName',width:80,align:'center'">校区</th>
		  				<th data-options="field:'className',width:100,align:'center'">班级名称</th>
		  				<th data-options="field:'openDate',width:100,align:'center'">开班时间</th>
		  				<th data-options="field:'classProgress',width:100,align:'center'">课时进度</th>
		  				<th data-options="field:'teacherName',width:150,align:'center'">带班老师</th>
		  				<th data-options="field:'handTypeText',width:100,align:'center'">班级性质</th>
		  				<th data-options="field:'openClassNum',width:100,align:'center'">开班人数</th>
		  				<th data-options="field:'classStudentNum',width:80,align:'center'">在读人数</th>
		  				<th data-options="field:'classStudentNum',width:80,align:'center'">升学基数</th>
		  				<th data-options="field:'higherStudentNum',width:80,align:'center'">已升学人数</th>
		  				<th data-options="field:'higherRateText',width:100,align:'center'">升学率</th>
		  			</tr>
		  		</thead>
		  	</table>
  		</div>
  		<div id="toolbar">
   			<a href="javascript:void(0)" id="changeBase" class="easyui-linkbutton" iconCls="icon-edit" plain="true">基数调整</a>
   			<a href="javascript:void(0)" id="viewChange" class="easyui-linkbutton" iconCls="icon-redo" plain="true">查看调整历史</a>
 		</div>
  	</body>
</html>
<script type="text/javascript">
	//调整基数
	$("#changeBase").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) 
		{
			if(row.classState!='003')
			{
			    $.messager.alert('提示', "该班级不能调整基数！");
			    return;
			}
		 
		    var classState = row.classState;
			var classInstId = row.classInstId;
			window.location.href = "/sys/attendClass/qryAttendClass.do?classInstId="+classInstId+"&type=numChange";
			 
		} else {
			$.messager.alert('提示', "请先选择您要调整的班级！");
		}
	});
	
	//调整历史
	$("#viewChange").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) 
		{
		    var classState = row.classState;
			var classInstId = row.classInstId;
			window.location.href = "/sys/attendClass/qryAttendClass.do?classInstId="+classInstId+"&type=changeHist";
			 
		} else {
			$.messager.alert('提示', "请选择班级！");
		}
	});
	
</script>