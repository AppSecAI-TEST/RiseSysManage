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
			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:5px auto;height:60px;" cellspacing="2">
				<tr>
					<td align="right" width="7%">
						所属校区：
					</td>
					<td width="10%">
						<select id="schoolId" name="schoolId" style="width:100px;height:25px;" ></select>
					</td>
					<td align="right" width="7%">	
						学员姓名：
					</td>
					<td width="10%">
						<select id="staffName" name="staffName" style="width:100px;height:25px;">
      					</select>
					</td>
					<td align="right" width="7%">
						联系电话：
					</td>
					<td width="10%">
						<input name="contactPhone" id="contactPhone" type="text" class="easyui-textbox" style="width:100px; height: 25px;"/>
					</td>
					<td align="right" width="7%">
						缴费日期：
					</td>
					<td width="22%">
						<input name="feeStartTime" id="feeStartTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="feeEndTime" id="feeEndTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
					</td>
					<td colspan="2">
						<a href="javascript:void(0)" id="queryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetFunc()">重置</a>
					</td>
				</tr>
			</table>
		</form>
		<div style="padding:5px 0;min-width:1100px; width:100%">
			<table class="easyui-datagrid" title="学员列表" style="height:420px" id="manList" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th data-options="field:'classInstId',checkbox:true"></th>
						<th width="6%" field="schoolName">校区</th>
						<th width="7%" field="name">学员姓名</th>
						<th width="7%" field="classType">游学课程类型</th>
						<th width="10%" field="studentIdentity">本人证件号码</th>
						<th width="10%" field="studentPhone">联系电话</th>
						<th width="7%" field="className">班级</th>
						<th width="7%" field="adviserTeacher">业绩老师</th>
						<th width="7%" field="adviser">业绩顾问</th>
						<th width="7%" field="payDate">缴费日期</th>
						<th width="7%" field="totalAmount">实际缴费金额</th>
						<th width="6%" field="favorType">优惠方式</th>
						<th width="6%" field="feeStateName">是否退费</th>
						<th width="6%" field="isChoiceClass">是否选班</th>
						<th width="7%" field="shortClassName">游学班级</th>
					</tr>
				</thead>
			</table>
		</div>
		<script type="text/javascript">
			ajaxLoading("加载中...");
			$.post("<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=821&fieldId=schoolId",function(data){
				$("#schoolId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pub/paramComboxList.do?staffId=${sessionScope.StaffT.staffId}&funcNodeId=${param.funcNodeId}&fieldId=staffName",function(data){
				$("#staffName").combobox("loadData",data);
				ajaxLoadEnd();
			},"json");
			$(document).ready(function(){
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
				obj["queryCode"] = "qryTourismInfoList";
				obj["funcNodeId"] = "38114";
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
				$("#feeStartTime").datebox("setValue","");
				$("#feeEndTime").datebox("setValue","");
			}
		</script>
 	</body>
</html>