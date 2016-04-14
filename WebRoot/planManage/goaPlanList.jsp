<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/planManage/goaPlanList.js"></script>
  	</head>
  	<body>
  		<input type="hidden" id="handlerId" value="${sessionScope.StaffT.staffId}"/>
  		<input id="planId" type="hidden" value=""/>
  		<div style="margin-right:5px">
	 		<form id="qryFm">
	  			<table class="search_tab">
	  				<tr>
	  					<td align="right" style="min-width: 60px"><span>所属校区：</span></td>
	  					<td style="min-width: 100px">
	  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:100px;height: 25px;"
	  							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
	  							onLoadSuccess:function(data){if(data.length > 0) $('#schoolId').combobox('setValue',data[0].schoolId);}"
	  							url="<%=path%>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=710&fieldId=schoolId&headFlag=N">
	  						</select>
	  					</td>
	  					<td align="right" style="min-width: 40px"><span>年度：</span></td>
	  					<td style="min-width: 100px">
	  						<select class="easyui-combobox" name="year" id="year" style="width:100px;height: 25px;"
	  							data-options="valueField:'val',textField:'text'">
	  						</select>
	  					</td>
	  					<td style="min-width: 220px;">
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:100px" id="qryBtn" funcNodeId="3603"><span>查询</span></a>
	  						&nbsp;&nbsp;
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:100px" id="resetBtn" ><span>重置</span></a>
	  					</td>
	  					<td style="min-width: 400px;">&nbsp;</td>
	  				</tr>
	  			</table>
	 		</form>
	 		<table class="easyui-datagrid" align="center" title="查询结果" id="list_data" 
	 			toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true" width="10%"></th>
						<th data-options="field:'schoolName', width:'20%', align:'center'"><span>校区</span></th>
						<th data-options="field:'planYear', width:'20%', align:'center'"><span>年度</span></th>
						<th data-options="field:'planQuarter', width:'20%', align:'center'"><span>季度</span></th>
						<th data-options="field:'valueVal', width:'30%', align:'center'"><span>升学目标</span></th>            
					</tr>
				</thead>
			</table>
			<div id="toolbar" style="padding: 2px;height:auto;">
	   			<a href="javascript:void(0)" id="addPlan" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;"><span>添加计划</span></a>
	   			<a href="javascript:void(0)" id="updatePlan" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;"><span>修改计划</span></a>
	   			<a href="javascript:void(0)" id="deletePlan" class="easyui-linkbutton" iconCls="icon-remove" style="width: 100px;"><span>删除计划</span></a>
	 		</div>
	 		<div id="dlg" class="easyui-dialog" style="width: 580px; height: 350px; padding: 10px 20px" closed="true" data-options="modal:true" buttons="#dlgBtn">
	  			<form id="fm">
	  				<input id="type" type="hidden"/>
	  				<input id="planId_1" type="hidden" value=""/>
	  				<input id="planId_2" type="hidden" value=""/>
	  				<input id="planId_3" type="hidden" value=""/>
	  				<input id="planId_4" type="hidden" value=""/>
	  				<input id="updateSchoolId" type="hidden" value=""/>
	  				<input id="updatePlanYear" type="hidden" value=""/>
	  				<table style="width: 100%;" cellSpacing='0' cellPadding='5'>
	  					<tr>
	  						<td style="text-align: right;"><span>校区：</span></td>
	  						<td>
		  						<select class="easyui-combobox" name="schoolIds" id="schoolIds" style="width:200px;height: 25px;"
		  							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
		  							url="<%=path%>/pubData/qrySchoolList.do?schoolId=">
	  							</select>
	  						</td>
	  					</tr>
	  					<tr>
	  						<td style="text-align: right;"><span>年度：</span></td>
	  						<td>
		  						<select class="easyui-combobox" name="planYear" id="planYear" style="width:200px;height: 25px;"
		  							data-options="valueField:'val',textField:'text', editable:false">
		  						</select>
	  						</td>
	  					</tr>
	  					<tr>
	  						<td style="text-align: right;"><span>一季度升学目标：</span></td>
	  						<td>
		  						<input type="text" class="easyui-numberbox" id="value_1" name="value" style="width:200px;height: 25px;" data-options="min:1,precision:0,max:100">（%）
	  						</td>
	  					</tr>
	  					<tr>
	  						<td style="text-align: right;"><span>二季度升学目标：</span></td>
	  						<td>
		  						<input type="text" class="easyui-numberbox" id="value_2" name="value" style="width:200px;height: 25px;" data-options="min:1,precision:0,max:100">（%）
	  						</td>
	  					</tr>
	  					<tr>
	  						<td style="text-align: right;"><span>三季度升学目标：</span></td>
	  						<td>
		  						<input type="text" class="easyui-numberbox" id="value_3" name="value" style="width:200px;height: 25px;" data-options="min:1,precision:0,max:100">（%）
	  						</td>
	  					</tr>
	  					<tr>
	  						<td style="text-align: right;"><span>四季度升学目标：</span></td>
	  						<td>
		  						<input type="text" class="easyui-numberbox" id="value_4" name="value" style="width:200px;height: 25px;" data-options="min:1,precision:0,max:100">（%）
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
