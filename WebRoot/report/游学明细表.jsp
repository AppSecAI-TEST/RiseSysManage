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
  		<div style="margin-right:5px;">
		<input id="staffId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<input type="hidden" id="resourceId" value="854">
		<form id="manFm">
			<table class="search_tab">
				<tr>
					<td align="right" width="7%">
						校区：
					</td>
					<td width="10%">
  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				      		
			        	</select>
					</td>
					<td align="right" width="7%">	
						学员姓名：
					</td>
					<td width="10%">
      					<input name="staffName" id="staffName" type="text" class="easyui-textbox" style="width:100px;height:25px;"/>
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
						<input name="feeStartTime" id="feeStartTime" type="text" style="width:100px; height: 25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
						至
						<input name="feeEndTime" id="feeEndTime" type="text" style="width:100px; height: 25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
					</td>
				</tr>
				<tr>
					<td align="right">
						是否退费：
					</td>
					<td>
						<select id="feeReturn" name="feeReturn" style="width:100px; height: 25px;" ></select>										
					</td>
					<td align="right">	
						业绩老师：
					</td>
					<td>
      					<input name="adviserTeacherName" id="adviserTeacherName" type="text" class="easyui-textbox" style="width:100px;height:25px;"/>
					</td>
					<td align="right">	
						业绩顾问：
					</td>
					<td colspan="2">
      					<input name="adviserName" id=""adviserName"" type="text" class="easyui-textbox" style="width:100px;height:25px;"/>
					</td>
					<td>
						<a href="javascript:void(0)" id="qryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()" funcNodeId="38114">查询</a>
						&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" id="resetBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;">重置</a>
					</td>
				</tr>
			</table>
		</form>
			<table class="easyui-datagrid" title="学员列表" style="height:420px" id="manList" toolbar="#toolManbar" 
				pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th width="6%" field="schoolName">校区</th>
						<th width="6%" field="name">学员姓名</th>
						<th width="6%" field="byName">英文名</th>
						<th width="6%" field="classType">游学课程类型</th>
						<th width="9%" field="studentIdentity">本人证件号码</th>
						<th width="8%" field="studentPhone">联系电话</th>
						<th width="6%" field="className">班级</th>
						<th width="6%" field="adviserTeacher">业绩老师</th>
						<th width="6%" field="adviser">业绩顾问</th>
						<th width="7%" field="payDate">缴费日期</th>
						<th width="6%" field="totalAmount">实际缴费金额</th>
						<th width="7%" field="favorType">优惠方式</th>
						<th width="6%" field="feeStateName">是否退费</th>
						<th width="6%" field="isChoiceClass">是否选班</th>
						<th width="7%" field="shortClassName">游学班级</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="toolManbar" style="padding: 2px; height: auto">
			<a href="javascript:void(0)" id="exportBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="exportFunc()">导出全部</a>
		</div>
		<script type="text/javascript">
			$(document).ready(function(){
				initReportButton("resetBtn","manFm","schoolId");
				$("#feeReturn").combobox({
					formatter:function(data){
						return '<span>'+data.text+'</span>';
					}, 
					data:[{
						text:"全部",
						value:""
					},{
						text:"是",
						value:"是"
					},{
						text:"否",
						value:"否"
					}],
					panelHeight: 'auto'
				});
			});
			function queryFunc()
			{
				initPageNumber("manList");
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
			function exportFunc()
			{
				exportLink("exportBtn","manList");
			}
		</script>
 	</body>
</html>
