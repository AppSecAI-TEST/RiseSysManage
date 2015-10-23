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
		<script type="text/javascript" src="<%=path %>/js/student/student.js"></script>
  	</head>
  
  	<body>
		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
		<form id="qryFm" style="margin:0 auto;">
			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:80px;" cellspacing="2">
				<tr>
					<td width="90" align="right">
						<span>校区：</span>
					</td>
					<td width="212">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false" 
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto', 
							onLoadSuccess:function(data){if(data.length > 0)$('#schoolId').combobox('setValue',data[0].schoolId);}"	
							url="<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&funcNodeId=${param.funcNodeId}&fieldId=schoolId">
     					</select>
					</td>
					 
					
					<td width="100" align="right">
						<span>学员姓名：</span>
					</td>
					<td width="114">
						<select id="staffName" name="staffName" class="easyui-combobox" style="width: 114px; height: 25px;" data-options="formatter:function(data){return '<span>'+data.staffName+'</span>';}, valueField: 'staffId', textField: 'staffName', panelHeight: 'auto', onLoadSuccess:function(data){if(data.length > 0)$('#schoolId').combobox('setValue',data[0].schoolId);}"	url="<%=path %>/pub/paramComboxList.do?staffId=${sessionScope.StaffT.staffId}&funcNodeId=${param.funcNodeId}&fieldId=staffName">
      					</select>
					</td>
					<td width="95" align="right">
						<span>联系电话：</span>
					</td>
					<td >
						<input name="phone" id="phone" type="text" class="easyui-textbox" style="width: 120px; height: 25px;"/>
					</td>
					 
				</tr>
				<tr>
					<td align="right">
						<span>课程类型：</span>
					</td>
					<td width="212">
						<select id="advisterId" name="advisterId" class="easyui-combobox" style="width: 100px; height: 25px;"
							data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', panelHeight: 'auto',
      						 onLoadSuccess:function(data){$('#advisterId').combobox('setValue',data[0].staffId);}"
      						url="<%=path %>/pubData/qryStaffList.do?schoolId=${sessionScope.StaffT.schoolId}">
     						</select>
						<select id="classInstId" name="classInstId" class="easyui-combobox" style="width: 100px; height: 25px;">
					  </select>
					<td align="right"><span>退费类型：</span></td>
					<td><select id="dutyAdvister" name="dutyAdvister" class="easyui-combobox" style="width: 100px; height: 25px;"
							data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', panelHeight: 'auto',
      						 onLoadSuccess:function(data){$('#dutyAdvister').combobox('setValue',data[0].staffId);}"
      						url="<%=path %>/pubData/qryStaffList.do?schoolId=${sessionScope.StaffT.schoolId}">
					  </select></td>
					<td align="right">&nbsp;</td>
					<td width="119"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1000">查询</a> <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a></td>
				 
					
					<td align="center" colspan="7">&nbsp;</td>
				</tr>
			</table>
</form>
		<div style="padding:5px 0;min-width:1100px; width:100%;">
			<table class="easyui-datagrid" title="学员列表" style="height:435px;" id="list_data" url="<%=path %>/pubData/qryDataListByPage.do?funcNodeId=5001" 
				toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'schoolName',width:80,align:'center'">校区</th>
						<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
						<th data-options="field:'byName',width:100,align:'center'">英文名</th>
						<th data-options="field:'classType',width:100,align:'center'">班级类型</th>
						<th data-options="field:'payDate',width:200,align:'center'">缴费时间</th>
						<th data-options="field:'classState',width:100,align:'center'">原课程状态</th>
						<th data-options="field:'classId',width:150,align:'center'">当前班级</th>
						<th data-options="field:'hoursProcess',width:100,align:'center'">课时进度</th>
						<th data-options="field:'state',width:250,align:'center'">退费类型</th>
						<th data-options="field:'tacheName',width:150,align:'center'">退费状态</th>
						<th data-options="field:'isAcademic',width:150,align:'center'">学术退费</th>
						<th data-options="field:'createDate',width:150,align:'center'">申请时间</th>
						<th data-options="field:'approveDate',width:120,align:'center'">审批通过时间</th>
						<th data-options="field:'successDate',width:120,align:'center'">成功退费时间</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="toolbar" style="padding: 2px; height: auto">
   			<a href="javascript:void(0)" id="refundFee" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">退费申请</a>
   			<a href="javascript:void(0)" id="approve" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;" funcNodeId="1002">退费审批</a>
   			<a href="javascript:void(0)" id="viewStudent" class="easyui-linkbutton" iconCls="icon-redo" style="width: 100px;">浏览</a>
   			<a href="javascript:void(0)" id="addActivity" class="easyui-linkbutton" iconCls="icon-add" style="width: 120px;">短期课退费申请</a>
			<a href="javascript:void(0)" id="batchUpdate" class="easyui-linkbutton" iconCls="icon-edit" style="width: 120px;">短期课退费审批</a>
			<a href="javascript:void(0)" id="batchUpdate" class="easyui-linkbutton" iconCls="icon-edit" style="width: 120px;">短期课退费浏览</a>
		</div>
		
  		<div id="dlgBtn">
    		<a href="javascript:void(0)" id="batchUpdateSubmit" class="easyui-linkbutton" iconCls="icon-ok">提交</a> 
    		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onClick="javascript:$('#dlg').dialog('close')">取消</a>
  		</div>
 	</body>
</html>

<script type="text/javascript">

 
	 $("#refundFee").click(function() {
    	window.location.href = "/sys/fee/apply.jsp";
    });
	 
	 //判断登陆用户是否能够退费审批
	 $("#approve").click(function()
	 {
	    var row = $('#list_data').datagrid('getSelected');
	 	var processInstId=row.processInstanceId;
	 	var approveId="100002";
	 	$.ajax(
	 	{
   			url: "/sys/fee/isApprove.do?processInstId="+processInstId+"&approveId="+approveId,
   			data: "param=" + "",
   			dataType: "json",
   			async: false,
   			beforeSend: function()
   	    	{
   	    		$.messager.progress({title : '验重', msg : '正在验重，请稍等……'});
   	    	},
   	    	success: function (data)
   	    	{
   	    		var id = data.processInstanceId;
   	            if(id=='')
   	            {
   	            	$.messager.alert('提示', "不能审批");
   	            } else
   	            {
   	            	window.location.href = "/sys/fee/apply.jsp?processInstId="+processInstId+"&approveId="+approveId; 
   	            }
   	    		$.messager.progress('close'); 
   	        } 
   		});
	 });
 
</script>