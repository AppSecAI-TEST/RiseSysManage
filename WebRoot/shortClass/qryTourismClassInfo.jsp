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
		<script type="text/javascript">
			ajaxLoading("正在处理，请稍待。。。");
			$.post("<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=821&fieldId=schoolId",function(data){
				$("#schoolId").combobox("loadData",data);
				ajaxLoadEnd();
			},"json");
			$(document).ready(function(){
				$("#schoolId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto',
					onLoadSuccess:function(data){
						if(data.length > 0)
						{
							$("#schoolId").combobox("setValue",data[0].schoolId);
						}
					}
				});
			});
			function queryFunc()
			{
				var obj = $("#manFm").serializeObject();
				var feeStartTime = $("#feeStartTime").datebox("getValue");
				var feeEndTime = $("#feeEndTime").datebox("getValue");
				if(feeStartTime != "" && feeEndTime == "")
				{
					obj["feeEndTime"] = "3000-12-31";
				}
				else if(feeStartTime == "" && feeEndTime != "")
				{
					obj["feeStartTime"] = "1900-01-01";
				}
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
				var schoolData = $("#schoolId").combobox("getData");
				if(schoolData != null && schoolData.length > 0)
				{
					$("#schoolId").combobox("setValue",schoolData[0].schoolId);
				}
				$("#staffName").textbox("setValue","");
				$("#contactPhone").textbox("setValue","");
				$("#feeStartTime").datebox("setValue","");
				$("#feeEndTime").datebox("setValue","");
			}
		</script>
  	</head>
  	<body>
		<form id="manFm">
			<table class="search_tab">
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
      					<input name="staffName" id="staffName" type="text" class="easyui-textbox" style="width:100px; height: 25px;"/>
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
		<table class="easyui-datagrid" title="学员列表" id="manList" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
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
 	</body>
</html>