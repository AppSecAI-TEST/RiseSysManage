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
  		<div style="margin-right:5px;">
 		<form id="qryFm">
  			<table class="search_tab">
  				<tr>
  					<td align="right" width="70px;">校区：</td>
  					<td width="100px;">
  					<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
						data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
			      		onLoadSuccess:function(data){$('#schoolId').combobox('setValue',data[0].schoolId);}"
			      		url="<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=5041&fieldId=schoolId">
		        		</select>
  					</td>
  					<td align="right" width="50px;">教师：</td>
  					<td width="100px;">
  						<input name="teacherId"  class="easyui-combobox vaildatebox" id="teacherId"
								style="width: 100px; height: 25px;"
								data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'"   />
  					</td>
  					<td align="right" width="50px;">职务：</td>
  					<td width="100px;">
  						<select name='postId' class="easyui-combobox" style="width:100px;height: 25px"
  						data-options="valueField: 'postId', textField: 'postName', panelHeight: 'auto',
			      		onLoadSuccess:function(data){$('#postId').combobox('setValue',data[0].postId);}"
			      		url="<%=path %>/pubData/qryPostList.do?postType=T"
  						></select>
  					</td>
  					<td>
  						教师状态：<input name="P" id="P" value="P" type="checkbox">在职 &nbsp;<input name="R_L" id="R_L" value="R_L" type="checkbox">待离职 &nbsp;<input value="L" name="L" id="L" type="checkbox">离职 &nbsp;
  					</td>
  				</tr>
  				<tr>
  				<td align="right">
						<span>日期：</span>
					</td>
				<td colspan="3">
						<input class="easyui-datebox" type="text" required="true" style="width:100px; height: 25px;" id="startTime" name="startTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input class="easyui-datebox" required="true" type="text" style="width:100px; height: 25px;" id="endTime" name="endTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
				</td>
  				<td align="left" colspan="6">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1000">查询</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
					</td>
  				</tr>
  			</table>
 		</form>
 		 
		<table   align="center" class="easyui-datagrid" title="查询结果"   id="list_data" toolbar="#toolbar" pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
			 
		</table>
		<div id="toolbar" style="padding:5px;">
   			<a href="javascript:void(0)" id="export"  class="easyui-linkbutton" style="width:100px;" iconCls="icon-add" ><span>导出全部</span></a>
 		</div>
		
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
	$("#export").click(function(){
		exportPage();
	});
});


function exportPage()
{
	if($("#list_data").datagrid("getData").rows.length>0)
	{
		var param={};
		param.name="课时计划";
		var columnArr =new Array();
		$(".datagrid-header-row").find("td").each(function(index){
			var columnObj ={};
			columnObj[index+1+""]=$(this).text();
			columnArr.push(columnObj);
		})
		param.cloumn =columnArr;
		var dataArr =new Array();
		$(".datagrid-body").find(".datagrid-btable").find(".datagrid-row").each(function(){
			var dataObj ={};
			$(this).find("td").each(function(index){
				dataObj[index+1+""]=$(this).find("div").html();
			})
			dataArr.push(dataObj);
		})
		param.data =dataArr;
		window.location.href="/sys/export/exportPageInfo.do?param="+JSON.stringify(param);

	}
	else
	{
		showMessage("提示","暂无数据进行导出",null);
		return false;
	}	
}

</script>
