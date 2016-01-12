<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/planManage/graPlanList.js"></script>
  	</head>
  	<body>
  		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<input id="planId" type="hidden" value=""/>
  		<div style="margin-right:5px">
 		<form id="qryFm">
  			<table class="search_tab">
  				<tr>
  					<td width="80px" align="right"><span>所属校区：</span></td>
  					<td width="110px">
  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:100px;height: 25px;"
  							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'，
  							onLoadSuccess:function(data){if(data.length > 0) $('#schoolId').combobox('setValue',data[0].schoolId);}"
  							url="<%=path%>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=707&fieldId=schoolId&headFlag=N">
  						</select>
  					</td>
  					<td width="40px" align="right"><span>年度：</span></td>
  					<td width="90px">
  						<select class="easyui-combobox" name="year" id="year" style="width:80px;height: 25px;"
  							data-options="valueField:'val',textField:'text', panelHeight: 'auto'">
  						</select>
  					</td>
  					<td width="40px" align="right"><span>月度：</span></td>
  					<td width="90px">
  						<select class="easyui-combobox" name="month" id="month" style="width:80px;height: 25px;"
  							data-options="valueField:'val',textField:'text', panelHeight: 'auto'">
  						</select>
  					</td>
  					<td>
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:100px" id="qryBtn" funcNodeId="3600"><span>查询</span></a>
  						&nbsp;&nbsp;
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:100px" id="resetBtn" ><span>重置</span></a>
  					</td>
  				</tr>
  			</table>
 		</form>
 		
 		<table class="easyui-datagrid" align="center" title="查询结果" id="list_data" data-options="height:450" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true" width="5%"></th>
					<th field="schoolName" align="center" width="20%"><span>校区</span></th>
					<th field="planYear" align="center" width="20%"><span>年度</span></th>
					<th field="monthVal" align="center" width="20%"><span>月度</span></th>
					<th field="firstValue" align="center" width="38%"><span>计划新招(个数)</span></th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px;height:auto;">
   			<a href="javascript:void(0)" id="addPlan" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;"><span>添加计划</span></a>
   			<a href="javascript:void(0)" id="updatePlan" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;"><span>修改计划</span></a>
   			<a href="javascript:void(0)" id="deletePlan" class="easyui-linkbutton" iconCls="icon-cancel" style="width: 100px;"><span>删除计划</span></a>
 		</div>
 		
 		<div id="dlg" class="easyui-dialog" style="width: 580px; height: 350px; padding: 10px 20px" closed="true" data-options="modal:true" buttons="#dlgBtn">
  			<form id="fm">
  				<table style="width: 100%;" cellSpacing='0' cellPadding='16'>
  					<tr>
  						<td style="text-align: right;"><span>校区：</span></td>
  						<td>
	  						<select class="easyui-combobox" name="schoolIds" id="schoolIds" style="width:205px;height:25px;"
	  							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
	  							url="<%=path%>/pubData/qrySchoolList.do?schoolId=">
  							</select>
  						</td>
  					</tr>
  					<tr>
  						<td style="text-align: right;"><span>月度：</span></td>
  						<td>
	  						<select class="easyui-combobox" name="planYear" id="planYear" style="width:100px;height:25px;"
	  							data-options="valueField:'val',textField:'text', panelHeight: 'auto',editable:false">
	  						</select>
	  						<select class="easyui-combobox" name="planMonth" id="planMonth" style="width:100px;height:25px;"
	  							data-options="valueField:'val',textField:'text', panelHeight: 'auto',editable:false">
	  						</select>
  						</td>
  					</tr>
  					<tr>
  						<td style="text-align: right;"><span>计划新招（个数）：</span></td>
  						<td>
	  						<input type="text" class="easyui-numberbox" id="firstValue" name="firstValue" style="width:205px;height:25px;" data-options="min:1,precision:0,max:100000000">
  						</td>
  					</tr>
  				</table>
  			</form>
  		</div>
  		<div id="dlgBtn">
    		<a href="javascript:void(0)" id="submitBtn" class="easyui-linkbutton" iconCls="icon-ok">保存</a> 
    		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
  		</div>
  		</div>
  	</body>
</html>
