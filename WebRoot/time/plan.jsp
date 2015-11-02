<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<%@ include file="../common/pub.jsp" %>
		 
  	</head>
  
  	<body>
		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
		 
		<form id="qryFm" style="margin:0 auto;">
			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:30px;" cellspacing="2">
				<tr>
					<td align="right"><span>校区：</span></td>
	  				<td width="114px">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 114px; height: 25px;" editable="false"
						data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
			      		onLoadSuccess:function(data){$('#schoolId').combobox('setValue',data[0].schoolId);}"
			      		url="<%=path %>/pubData/qrySchoolList.do?schoolId=${sessionScope.StaffT.schoolId}">
		        		</select>
					</td>
					<td align="right">
						<span>排课月份：</span>
					</td>
					<td width="8px">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTime" name="startTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center" width="14px;">
						<span>至</span>
					</td>
					<td width="90px">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTime" name="endTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center" colspan="2">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="50014">查询</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
					</td>
				</tr>
			</table>
		</form>
		<div style="padding:5px 0;min-width:1100px; width:100%;">
			<table class="easyui-datagrid" title="排课列表" style="height:435px;" id="list_data"   
				toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false">
				 <thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'schoolName',width:80,align:'center'">校区</th>
						<th data-options="field:'month',width:100,align:'center'">排课月份</th>
						<th data-options="field:'staffName',width:100,align:'center'">创建人</th>
						<th data-options="field:'createDate',width:50,align:'center'">创建时间</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="toolbar" style="padding: 2px; height: auto">
   			<a href="javascript:void(0)" id="createPlan" href="" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;" funcNodeId="50014">创建排课</a>
   			<a href="javascript:void(0)" id="updatePlan" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;" >维护排课</a>
   			<a href="javascript:void(0)" id="viewPlan" class="easyui-linkbutton" iconCls="icon-redo" style="width: 100px;">浏览排课</a>
		</div>
  		
 	</body>
</html>
<script type="text/javascript">
   
    
    $("#qryBtn").click(function()
    {
    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
	    var startTime= $("#startTime").datebox('getValue');
	    var endTime= $("#endTime").datebox('getValue');;
	    if(startTime=='')
	    {
	    	startTime='2014-01-01';
	    }
	    if(endTime=='')
	    {
	    	endTime='2036-01-01';
	    }
	    var obj={};
	    obj.funcNodeId=funcNodeId;
	    obj.startTime=startTime;
	    obj.endTime=endTime;
	    obj.schoolId=$("#schoolId").combobox('getValue');
	    params=JSON.stringify(obj);
    		$('#list_data').datagrid(
    		{
    		url : "/sys/pubData/qryDataListByPage.do",
    		queryParams:
    		{
    			param : params
    		},
    		onLoadSuccess:function(){
    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
    			$('#list_data').datagrid('clearSelections');
    		}
    	});
     });
 
    $("#createPlan").click(function() {
    	 
    		window.location.href = "/sys/time/createPlan.jsp";
    	}
    );
    
      $("#updatePlan").click(function()
      {
    	 	var row = $('#list_data').datagrid('getSelected');
    	 	var createMonthId=row.createMonthId;
    	 	var month=row.month;
    	 	var schoolId=row.schoolId;
    		window.location.href = "/sys/time/updatePlan.jsp?time="+month+"&createMonthId="+createMonthId+"&schoolId="+schoolId;
      }
    );
    

</script>
