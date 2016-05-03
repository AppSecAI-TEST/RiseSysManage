

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  	<body>
  		 <input id="staffId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<input type="hidden" id="resourceId" value="733">
  		<div style="margin-right:5px;">
 		<form id="qryFm">
  			<table class="search_tab">
  				<tr>
  					<td width="80px" align="right"><span>校区：</span></td>
  					<td width="120px" >
  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false" 
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        </select>
  					</td>
  					<td width="50px" align="right"><span>日期：</span></td>
  					<td width="270px">
  						<input class="easyui-datebox" name="startTime" id="startTime"  style="width:120px;height: 25px;" />
  							至
  						<input class="easyui-datebox" name="endTime" id="endTime"  style="width:120px;height: 25px;" />
  					</td>
  					<td align="left">
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:100px" id="qryBtn" funcNodeId ="3910" onclick="qryData()" ><span>查询</span></a>
  						&nbsp;&nbsp;
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:100px" id="resetBtn" ><span>重置</span></a>
  					</td>
  				</tr>
  			</table>
 		</form>
 		
 		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:450" id="list_data" 
 			toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true">
			<thead>
				<tr>
					<th field="schoolName" align="center" width="7%">校区</th>
					<th field="planNum" align="center" width="6%">计划个数</th>
					<th field="tNum" align="center" width="7%">老师转介绍</th>
					<th field="cNum" align="center" width="6%">CC转介绍</th>
					<th field="aNum" align="center" width="5%">活动邀约</th>
					<th field="tNumX" align="center" width="8%">老师转介绍退费</th>
					<th field="cNumX" align="center" width="8%">CC转介绍退费</th>
					<th field="aNumX" align="center" width="8%">活动邀约退费</th>
					<th field="tNumReal" align="center" width="11%">老师转介绍实际报名</th>
					<th field="cNumReal" align="center" width="11%">CC转介绍实际报名</th>
					<th field="aNumReal" align="center" width="11%">活动邀约实际报名</th>
					<th field="totalReal" align="center" width="8%">实际完成个数</th>
					<th field="per" align="center" width="5%">完成率</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px; height: auto">
	   		<a href="javascript:void(0)" id="export" class="easyui-linkbutton" onclick="exportData()" iconCls="icon-add" style="width: 100px;">导出全部</a>
		</div>
		</div>
  	</body>
</html>
<script>
	$(document).ready(function(){
		initReportButton("resetBtn","qryFm","schoolId");
		$("#startTime").datebox({
			onChange:function(val){
				if(val!="")
				{
					var start = new Date(Date.parse(val.replace(/-/g,  "/")));
					$("#endTime").datebox('calendar').calendar({
						validator: function(date){
							
								var d1 = new Date(start.getFullYear(), start.getMonth(),start.getDate());
								var d2 = new Date(start.getFullYear(), start.getMonth(),new Date(start.getFullYear(), start.getMonth()+1,0).getDate());
								return d1<=date && date<=d2;
							
						},
						year:start.getFullYear(),
						month:start.getMonth()+1	
					});
				}
			}
		})
	});
	
	
	function qryData()
	{
		if($("#startTime").datebox("getValue")==""||$("#endTime").datebox("getValue")=="")
		{
			showMessage("提示","请填写起止日期",null);
			return false
		}	
		var obj = JSON.stringify($("#qryFm").serializeObject());
	    	obj = obj.substring(0, obj.length - 1);
	    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
	    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
	    	$("#list_data").datagrid({
	    		url : "/sys/pubData/qryDataListByPage.do",
	    		queryParams:{
	    			param : obj
	    		},
	    		onLoadSuccess:function(){
	    			dealWithData($("#list_data").datagrid('getData'))
	    		}
	    	}); 
	}
	
	function dealWithData(obj)
	{
		if(obj.total!=undefined&&obj.total>0)
		{
			var addObj ={};
			addObj.schoolId ="";
			addObj.schoolName ="总计";
			var arr =obj.rows;
			var cl1=0, cl2=0,cl3=0,cl4=0,cl5=0,cl6=0,cl7=0,cl8=0,cl9=0,cl10=0,cl11=0;
			for(var i=0;i<obj.total;i++)
			{
				cl1+=parseInt(arr[i].tNum);
				cl2+=parseInt(arr[i].aNum);
				cl3+=parseInt(arr[i].cNum);
				cl4+=parseInt(arr[i].tNumX);
				cl5+=parseInt(arr[i].aNumX);
				cl6+=parseInt(arr[i].cNumX);
				cl7+=parseInt(arr[i].tNumReal);
				cl8+=parseInt(arr[i].aNumReal);
				cl9+=parseInt(arr[i].cNumReal);
				cl10+=parseInt(arr[i].planNum);
				cl11+=parseInt(arr[i].totalReal);
			}	
			addObj.tNum =cl1;
			addObj.aNum =cl2;
			addObj.cNum =cl3;
			addObj.tNumX =cl4;
			addObj.aNumX =cl5;
			addObj.cNumX =cl6;
			addObj.tNumReal =cl7;
			addObj.aNumReal =cl8;
			addObj.cNumReal =cl9;
			addObj.planNum =cl10;
			addObj.totalReal =cl11;
			if(addObj.planNum==0||addObj.totalReal==0)
			{
				addObj.per =0
			}
			else
			{
				addObj.per =(cl11/cl10).toFixed(4)*100+"%";
			}
			$('#list_data').datagrid('insertRow',{
				row: addObj
			});
		}	
	}
	
	function exportData()
	{
		if($("#list_data").datagrid("getData").total>0)
		{
			var fileName =parent.$("li.tabs-selected").find("span.tabs-title").html();
			var array =JSON.stringify($("#list_data").datagrid("getData").rows);
			try
			{
				window.location.href="/sys/export/exportData.do?fileName="+fileName+"&array="+array;
			}
			catch(e)
			{
				$.messager.alert('提示', "模版不存在！",function(){
					window.history.back();
				});
			}
		}
		else
		{
			$.messager.alert('提示', "没有数据可以导出！");
		}	
	}
	
</script>