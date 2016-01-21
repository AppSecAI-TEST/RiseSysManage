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
		<script type="text/javascript" src="<%=path %>/js/teacherManage.js"></script>
  	</head>
  	<body>
 		<form id="qryFm">
  			<table  align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:5px;font-family:'微软雅黑'" cellspacing="15">
  				<tr>
  					<td align="right">校　　区：</td>
  					<td>
  					<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
						data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
			      		onLoadSuccess:function(data){$('#schoolId').combobox('setValue',data[0].schoolId);}"
			      		url="<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=5041&fieldId=schoolId">
		        		</select>
  					</td>
  					<td align="right">教师：</td>
  					<td>
  						<input name="teacherId"  class="easyui-combobox vaildatebox" id="teacherId"
								style="width: 100px; height: 25px;"
								data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'" required="true" />
  					</td>
  					<td align="right">职务：</td>
  					<td>
  						<select name='postId' class="easyui-combobox" style="width:100px;height: 25px"
  						data-options="valueField: 'postId', textField: 'postName', panelHeight: 'auto',
			      		onLoadSuccess:function(data){$('#postId').combobox('setValue',data[0].postId);}"
			      		url="<%=path %>/pubData/qryPostList.do?postType=T"
  						></select>
  					</td>
  					<td>
  						教师状态：<input name="P" id="P" value="P" type="checkbox">在职 &nbsp;<input name="R_L" id="R_L" value="R_L" type="checkbox">待离职 &nbsp;<input value="L" name="L" id="L" type="checkbox">离职 &nbsp;
  					</td>
  						<td align="right">
						<span>日期：</span>
					</td>
					<td width="8px">
						<input class="easyui-datebox" type="text" required="true" style="width:100px; height: 25px;" id="startTime" name="startTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center" width="14px;">
						<span>至</span>
					</td>
					<td width="90px">
						<input class="easyui-datebox" required="true" type="text" style="width:100px; height: 25px;" id="endTime" name="endTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					
  				</tr>
  				<tr>
  				<td align="center" colspan="10">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1000">查询</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
					</td>
  				</tr>
  			</table>
 		</form>
 		 
		<table   align="center" title="查询结果" data-options="height:500" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			 
		</table>
  		</div>
  		
  	</body>
</html>
<script type="text/javascript">

 
initResetButton("reset","qryFm");
 
$("#schoolId").combobox({
		onChange:function(){
			var sId =$("#schoolId").combobox("getValue");
			var urls ="<%=path %>/pubData/qryTeacherList.do?schoolId="+sId;
			$("#teacherId").combobox({
				url:urls
			});
		}
	})

 
$("#qryBtn").click(function(){
	
	var startDate=$("#startTime").datebox("getValue");
	var endDate=$("#endTime").datebox("getValue");
	if(startDate=='' || endDate=='')
	{
		$.messager.alert('提示', "请您选择查询开始时间和结束时间");
		return;
	}
	var date=AddDays(startDate,6);
	startDate=AddDays(startDate,0);
	endDate=AddDays(endDate,0);
	if(endDate>date)
	{
		$.messager.alert('提示', "开始、结束时间间隔大于7天,请重新选择");
		return;
	}
	var obj = JSON.stringify($("#qryFm").serializeObject());
	$('#list_data').datagrid({  
		border:false,  
	    fitColumns:true,  
	    singleSelect: true,  
	    url: "/sys/time/getTeacherPlan.do?param="+obj,
	    columns:[[  
	        {field:'schoolName',title:'校区',align:'center',width:40},
	         {field:'teacherName',title:'教师英文名',align:'center',width:40},
	        {field:'tHours',title:'T课时量',align:'center',width:30},  
	        {field:'taHours',title:'Ta课时量',align:'center',width:30},  
	        {field:'day0',title:startDate,align:'center',width:80},  
	        {field:'day1',title:AddDays(startDate,1),align:'center',width:80},  
	        {field:'day2',title:AddDays(startDate,2),align:'center',width:80},  
	        {field:'day3',title:AddDays(startDate,3),align:'center',width:80},  
	        {field:'day4',title:AddDays(startDate,4),align:'center',width:80},  
	        {field:'day5',title:AddDays(startDate,5),align:'center',width:80},
	        {field:'day6',title:AddDays(startDate,6),align:'center',width:80} 
	    ]],  
	    onLoadSuccess:function(data)
	    {  
	         
	    }  
	});  
	
});


</script>
