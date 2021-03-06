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
			$.post("<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=820&fieldId=schoolId",function(data){
				$("#schoolId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_GIFT_T&codeType=COURSE_STATE",function(data){
				$("#classState").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/shortBus/getGiftTypeList.do",function(data){
				$("#classType").combobox("loadData",data);
				ajaxLoadEnd();
			},"json");
			$(document).ready(function(){
				$("#classType").combobox({
					formatter:function(data){
						return '<span>'+data.typeName+'</span>';
					}, 
					valueField: 'giftType', 
					textField: 'typeName',
					panelHeight: 'auto'
				});
				$("#classState").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
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
				$("#isExpire").combobox({
					formatter:function(data){
						return "<span>"+data.text+"</span>";
					},
					data:[{
						text:"全部",
						value:""
					},{
						value:"是",
						text:"是"
					},{
						value:"否",
						text:"否"
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
				obj["queryCode"] = "qrySummerInfoList";
				obj["funcNodeId"] = "38136";
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
				$("#classType").combobox("setValue","");
				$("#classState").combobox("setValue","");
				$("#feeStartTime").datebox("setValue","");
				$("#feeEndTime").datebox("setValue","");
				$("#expireDate").textbox("setValue","");
				$("#isExpire").combobox("setValue","");
			}
		</script>
  	</head>
  	<body>
		<form id="manFm">
			<table class="search_tab">
				<tr>
					<td align="right" width="80px;">
						所属校区：
					</td>
					<td width="100px;">
						<select id="schoolId" name="schoolId" style="width:100px;height:25px;" ></select>
					</td>
					<td align="right" width="70px;">	
						学员姓名：
					</td>
					<td width="100px;">
      					<input name="staffName" id="staffName" type="text" class="easyui-textbox" style="width:100px;height:25px;"/>
					</td>
					<td align="right" width="80px;">
						联系电话：
					</td>
					<td width="100px;">
						<input name="contactPhone" id="contactPhone" type="text" class="easyui-textbox" style="width:100px;height:25px;"/>
					</td>
					<td align="right">
						是否过期：
					</td>
					<td align="left">
						<select id="isExpire" name="isExpire" style="width:100px;height:25px;" ></select>				
					</td>
					<td align="right" width="80px">
						缴费日期：
					</td>
					<td width="225px;">
						<input name="feeStartTime" id="feeStartTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="feeEndTime" id="feeEndTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
					</td>
				</tr>
				<tr>
					<td align="right">
						赠课类型：
					</td>
					<td>
						<select id="classType" name="classType" style="width:100px;height:25px;" ></select>								
					</td>
					<td align="right">
						赠课状态：
					</td>
					<td>
						<select id="classState" name="classState" style="width:100px;height:25px;" ></select>				
					</td>
					<td align="right">
						几天内过期：
					</td>
					<td colspan="4">
						<input name="expireDate" id="expireDate" type="text" class="easyui-textbox" style="width:100px;height:25px;"/>
					</td>
					<td>
						<a href="javascript:void(0)" id="queryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" id="resetBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetFunc()">重置</a>
					</td>
				</tr>
			</table>
		</form>
		<div style="padding:5px 0;min-width:1100px; width:100%">
			<table class="easyui-datagrid" title="学员列表" id="manList" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th width="6%" field="schoolName">校区</th>
						<th width="6%" field="name">学员姓名</th>
						<th width="6%" field="byName">英文名</th>
						<th width="7%" field="studentPhone">联系电话</th>
						<th width="7%" field="giftChannelDesc">赠课来源</th>
						<th width="7%" field="payDate">关联课缴费日期</th>
						<th width="7%" field="courseStateName">关联课程状态</th>
						<th width="6%" field="typeName">赠课类型</th>
						<th width="6%" field="className">赠课班级</th>
						<th width="6%" field="giftStateName">赠课状态</th>
						<th width="6%" field="giftNum">赠送课时</th>
						<th width="6%" field="giftJoinNum">已消耗课时</th>
						<th width="7%" field="effDate">有效期开始日期</th>
						<th width="7%" field="expDate">有效期结束日期</th>
						<th width="7%" field="disExpDate">距过期天数</th>
					</tr>
				</thead>
			</table>
		</div>
 	</body>
</html>