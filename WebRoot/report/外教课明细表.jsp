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
		<form id="manFm">
			<input id="staffId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<input type="hidden" id="resourceId" value="853">
			<table class="search_tab">
				<tr>
					<td align="right" width="12%">
						校区：
					</td>
					<td width="12%">
	  					<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
					      		
				        </select>					
					</td>
					<td align="right" width="8%">	
						学员姓名：
					</td>
					<td width="12%">
      					<input name="staffName" id="staffName" type="text" class="easyui-textbox" style="width:100px;height:25px;"/>
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
						赠课状态：
					</td>
					<td>
						<select id="giftType" name="giftType" style="width:100px" ></select>								
					</td>
					<td align="right">
						消耗次数：
					</td>
					<td colspan="3">
						<input name="consTimesStart" id="consTimesStart" type="text" class="easyui-textbox" style="width:100px; height: 25px;" />&nbsp;至&nbsp;<input name="consTimesEnd" id="consTimesEnd" type="text" class="easyui-textbox" style="width:100px; height: 25px;" />									
					</td>
					<td colspan="2">
						<a href="javascript:void(0)" id="queryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;">重置</a>
					</td>
				</tr>
			</table>
		</form>
			<table class="easyui-datagrid" title="学员列表" style="height:390px" id="manList" toolbar="#toolManbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th width="9%" field="schoolName">校区</th>
						<th width="9%" field="name">学员姓名</th>
						<th width="9%" field="byName">英文名</th>
						<th width="10%" field="studentPhone">联系电话</th>
						<th width="9%" field="giftChannelDesc">赠课来源</th>
						<th width="9%" field="payDate">缴费日期</th>
						<th width="9%" field="amount">赠外教课金额</th>
						<th width="9%" field="giftNum">赠外教课课时</th>
						<th width="9%" field="giftJoinNum">已消耗次数</th>
						<th width="9%" field="giftStateName">赠课状态</th>
						<th width="9%" field="expDate">有效期截止时间</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="toolManbar" style="padding: 2px; height: auto">
			<a href="javascript:void(0)" id="exportBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="exportFunc()">导出全部</a>
		</div>
		<script type="text/javascript">
			ajaxLoading("正在处理，请稍待。。。");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_GIFT_T&codeType=COURSE_STATE",function(data){
				$("#giftType").combobox("loadData",data);
				ajaxLoadEnd();
			},"json");
			$(document).ready(function(){
				initReportButton("resetBtn","manFm","schoolId");
				$("#giftType").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
			});
			function queryFunc()
			{
				var obj = $("#manFm").serializeObject();
				var feeStartTime = $("#feeStartTime").datebox("getValue");
				var feeEndTime = $("#feeEndTime").datebox("getValue");
				var consTimesStart = $("#consTimesStart").textbox("getValue");
				var consTimesEnd = $("#consTimesEnd").textbox("getValue");
				if(feeStartTime != "" && feeEndTime == "")
				{
					obj["feeEndTime"] = "3000-12-31";
				}
				else if(feeStartTime == "" && feeEndTime != "")
				{
					obj["feeStartTime"] = "1900-01-01";
				}
				if(consTimesStart != "" && consTimesEnd == "")
				{
					obj["consTimesEnd"] = "99999999";
				}
				else if(consTimesStart == "" && consTimesEnd != "")
				{
					obj["consTimesStart"] = "0";
				}
				obj["queryCode"] = "qryForeignInfoList";
				obj["funcNodeId"] = "38141";
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