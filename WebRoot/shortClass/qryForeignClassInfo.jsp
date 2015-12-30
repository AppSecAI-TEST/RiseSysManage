<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<style type="text/css">
			td{
				font-size:14px;
				font-family:"微软雅黑";
			}
		</style>
  	</head>
  	<body>
		<form id="manFm" style="margin:0 auto;">
			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:5px auto;height:80px;" cellspacing="2">
				<tr>
					<td align="right" width="12%">
						校区：
					</td>
					<td width="12%">
						<select id="schoolId" name="schoolId" style="width:100px;height:25px;" ></select>
					</td>
					<td align="right" width="8%">	
						学员姓名：
					</td>
					<td width="12%">
						<select id="staffName" name="staffName" style="width:100px;height:25px;">
      					</select>
					</td>
					<td align="right" width="8%">
						缴费日期：
					</td>
					<td width="22%">
						<input name="feeStartTime" id="feeStartTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="feeEndTime" id="feeEndTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
					</td>
					<td align="right" width="8%">
						联系电话：
					</td>
					<td>
						<input name="contactPhone" id="contactPhone" type="text" class="easyui-textbox" style="width:100px; height: 25px;"/>
					</td>
				</tr>
				<tr>
					<td align="right">
						外教课状态：
					</td>
					<td>
						<select id="classManState" name="classManState" style="width:100px" ></select>								
					</td>
					<td align="right">
						是否过期：
					</td>
					<td>
						<input name="feeReturn" id="feeReturnYes" type="radio" value="是" /><label for="feeReturnYes">是</label>&nbsp;
						<input name="feeReturn" id="feeReturnNo" type="radio" value="否" /><label for="feeReturnNo">否</label>										
					</td>
					<td align="right">
						几天内过期：
					</td>
					<td>
						<input name="contactPhone" id="contactPhone" type="text" class="easyui-textbox" style="width:100px; height: 25px;"/>						
					</td>
					<td colspan="2">
						<a href="javascript:void(0)" id="queryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetFunc()">重置</a>
					</td>
				</tr>
			</table>
		</form>
		<div style="padding:5px 0;min-width:1100px; width:100%">
			<table class="easyui-datagrid" title="学员列表" style="height:390px" id="manList" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th data-options="field:'classInstId',checkbox:true"></th>
						<th width="7%" field="schoolName">校区</th>
						<th width="7%" field="name">学员姓名</th>
						<th width="7%" field="byname">英文名</th>
						<th width="10%" field="studentPhone">联系电话</th>
						<th width="7%" field="classType">赠课来源</th>
						<th width="7%" field="className">赠课来源开始日期</th>
						<th width="10%" field="adviserTeacher">关联课状态</th>
						<th width="7%" field="adviser">外教课状态</th>
						<th width="7%" field="payDate">赠送课时</th>
						<th width="7%" field="totalAmount">已消耗课时</th>
						<th width="7%" field="favorType">有效期开始日期</th>
						<th width="7%" field="feeStateName">有效期结束日期</th>
						<th width="7%" field="isChoiceClass">距过期天数</th>
					</tr>
				</thead>
			</table>
		</div>
		<script type="text/javascript">
			ajaxLoading("加载中...");
			$.post("<%=path %>/pubData/qrySchoolList.do",function(data){
				$("#schoolId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pub/paramComboxList.do?staffId=${sessionScope.StaffT.staffId}&funcNodeId=${param.funcNodeId}&fieldId=staffName",function(data){
				$("#staffName").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=CLASS_STATE",function(data){
				$("#classManState").combobox("loadData",data);
				ajaxLoadEnd();
			},"json");
			$(document).ready(function(){
				$("#classManState").combobox({
					formatter:function(data){
						return '<span>'+data.classType+'</span>';
					}, 
					valueField: 'classTypeId', 
					textField: 'classType',
					panelHeight: 'auto'
				});
				$("#staffName").combobox({
					formatter:function(data){
						return '<span>'+data.staffName+'</span>';
					},
					valueField: 'staffId', 
					textField: 'staffName', 
					panelHeight: 'auto'
				});
				$("#schoolId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto'
				});
			});
			function queryFunc()
			{
				var obj = $("#manFm").serializeObject();
				obj["queryCode"] = "qryInterInfoList";
				obj["funcNodeId"] = "38112";
				obj = JSON.stringify(obj);
				$("#manList").datagrid({
					url:"/sys/pubData/qryDataListByPage.do",
					queryParams:{
						param : obj
					}
				});
			}
			function resetFunc()
			{
				$("#schoolId").combobox("setValue","");
				$("#staffName").combobox("setValue","");
				$("#contactPhone").textbox("setValue","");
				$("#interClassType").combobox("setValue","");
				$("#feeStartTime").datebox("setValue","");
				$("input[name='feeReturn']").each(function(i,node){
					node.checked = false; 
				});
				$("input[name='selectClass']").each(function(i,node){
					node.checked = false; 
				});
			}
		</script>
 	</body>
</html>