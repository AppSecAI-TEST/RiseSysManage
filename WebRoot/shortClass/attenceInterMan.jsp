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
			$.post("<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=808&fieldId=schoolId",function(data){
				$("#schoolManId").combobox("loadData",data);
				$("#schoolHisId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=CLASS_STATE",function(data){
				var classManStateArr = [];
				for(var i = 0,n = data.length;i < n;i++)
				{
					if(data[i].codeFlag != '002')
					{
						if(data[i].codeFlag == '005')
						{
							data[i].codeName = "取消";
						}
						classManStateArr.push(data[i]);
					}
				}
				$("#classManState").combobox("loadData",classManStateArr);
			},"json");
			$.post("<%=path %>/shortBus/getShortClassTypeList.do?typeName="+encodeURI("国际班"),function(data){
				$("#interClassType").combobox("loadData",data);
				$("#interClassHisType").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pub/pageComboxList.do?funcNodeId=${param.funcNodeId}&fieldId=classMan",function(data){
				$("#classMan").combobox("loadData",data);
				$("#classHis").combobox("loadData",data);
				ajaxLoadEnd();
			},"json");
			$(document).ready(function(){
				$("#interClassType").combobox({
					formatter:function(data){
						return '<span>'+data.classType+'</span>';
					}, 
					valueField: 'classTypeId', 
					textField: 'classType',
					panelHeight: 'auto'
				});
				$("#interClassHisType").combobox({
					formatter:function(data){
						return '<span>'+data.classType+'</span>';
					}, 
					valueField: 'classTypeId', 
					textField: 'classType',
					panelHeight: 'auto'
				});
				$("#schoolManId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto',
					onLoadSuccess:function(data){
						if(data.length > 0)
						{
							$("#schoolManId").combobox("setValue",data[0].schoolId);
						}
					}
				});
				$("#classManState").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
				$("#classMan").combobox({
					formatter:function(row){
						return '<span>'+row.className+'</span>';
					},
					valueField: 'classInstId',
					textField: 'className',
					panelHeight: 'auto'
				});
				$("#schoolHisId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto',
					onLoadSuccess:function(data){
						if(data.length > 0)
						{
							$("#schoolHisId").combobox("setValue",data[0].schoolId);
						}
					}
				});
				$("#classHis").combobox({
					formatter:function(row){
						return '<span>'+row.className+'</span>';
					},
					valueField: 'classInstId',
					textField: 'className',
					panelHeight: 'auto'
				});
				$('#tab').tabs({
				    border:true,
				    onSelect:function(title){
						
				    }
				});
			});
			function queryManFunc()
			{
				var obj = $("#manFm").serializeObject();
				var openStartManTime = $("#openStartManTime").datebox("getValue");
				var openEndManTime = $("#openEndManTime").datebox("getValue");
				var classStartManTime = $("#classStartManTime").datebox("getValue");
				var classEndManTime = $("#classEndManTime").datebox("getValue");
				var overClassStartManTime = $("#overClassStartManTime").datebox("getValue");
				var overClassEndManTime = $("#overClassEndManTime").datebox("getValue");
				if(openStartManTime != "" && openEndManTime == "")
				{
					obj["openEndManTime"] = "3000-12-31";
				}
				else if(openStartManTime == "" && openEndManTime != "")
				{
					obj["openStartManTime"] = "1900-01-01";
				}
				if(classStartManTime != "" && classEndManTime == "")
				{
					obj["classEndManTime"] = "3000-12-31";
				}
				else if(classStartManTime == "" && classEndManTime != "")
				{
					obj["classStartManTime"] = "1900-01-01";
				}
				if(overClassStartManTime != "" && overClassEndManTime == "")
				{
					obj["overClassEndManTime"] = "3000-12-31";
				}
				else if(overClassStartManTime == "" && overClassEndManTime != "")
				{
					obj["overClassStartManTime"] = "1900-01-01";
				}
				obj["queryCode"] = "qryAttenceInterInfo";
				obj["funcNodeId"] = "38113";
				obj = JSON.stringify(obj);
				$("#manList").datagrid({
					url:"/sys/pubData/qryDataListByPage.do",
					queryParams:{
						param : obj
					}
				});
			}
			function resetManFunc()
			{
				var schoolData = $("#schoolManId").combobox("getData");
				if(schoolData != null && schoolData.length > 0)
				{
					$("#schoolManId").combobox("setValue",schoolData[0].schoolId);
				}
				$("#interClassType").combobox("setValue","");
				$("#classManState").combobox("setValue","");
				$("#classInfo").textbox("setValue","");
				$("#openStartManTime").datebox("setValue","");
				$("#openEndManTime").datebox("setValue","");
				$("#classStartManTime").datebox("setValue","");
				$("#classEndManTime").datebox("setValue","");
				$("#overClassStartManTime").datebox("setValue","");
				$("#overClassEndManTime").datebox("setValue","");
			}
			function manOperFunc()
			{
				var row = $('#manList').datagrid('getSelected');
				if (row)
				{
					ajaxLoading("正在处理，请稍待。。。");
					window.location.href = "/sys/shortBus/shortAttenceDetailPage.do?funcNodeId=${param.funcNodeId}&shortClassInstId="+row.shortClassInstId+"&pageName=shortAttenceInterDetail";
				}
				else
				{
					$.messager.alert('提示',"请先选择要考勤的班级");
				}
			}
			function manViewFunc()
			{
				var row = $("#manList").datagrid("getSelected");
				if(row)
				{
					ajaxLoading("正在处理，请稍待。。。");
					window.location.href = "/sys/shortBus/viewShortClassPage.do?funcNodeId=${param.funcNodeId}&shortClassInstId="+row.shortClassInstId+"&pageName=viewInterShortClass";
				}
				else
				{
					$.messager.alert('提示',"请选择要浏览的班级");
				}
			}
			function queryHisFunc()
			{
				var obj = $("#hisFm").serializeObject();
				var classHisStart = $("#classHisStart").datebox("getValue");
				var classHisEnd = $("#classHisEnd").datebox("getValue");
				if(classHisStart != "" && classHisEnd == "")
				{
					obj["classHisEnd"] = "3000-12-31";
				}
				else if(classHisStart == "" && classHisEnd != "")
				{
					obj["classHisStart"] = "1900-01-01";
				}
				obj["queryCode"] = "qryAttenceInterHisInfo";
				obj["funcNodeId"] = "38121";
				obj = JSON.stringify(obj);
				$("#hisList").datagrid({
					url:"/sys/pubData/qryDataListByPage.do",
					queryParams:{
						param : obj
					}
				});
			}
			function resetHisFunc()
			{
				var schoolData = $("#schoolHisId").combobox("getData");
				if(schoolData != null && schoolData.length > 0)
				{
					$("#schoolHisId").combobox("setValue",schoolData[0].schoolId);
				}
				$("#interClassHisType").combobox("setValue","");
				$("#classHisName").textbox("setValue","");
				$("#classHisStart").datebox("setValue","");
				$("#classHisEnd").datebox("setValue","");
			}
			function hisViewFunc()
			{
				var row = $("#hisList").datagrid("getSelected");
				if(row)
				{
					ajaxLoading("正在处理，请稍待。。。");
					window.location.href = "/sys/shortBus/viewShortClassPage.do?funcNodeId=${param.funcNodeId}&shortClassInstId="+row.shortClassInstId+"&pageName=viewInterShortClass";
				}
				else
				{
					$.messager.alert('提示',"请选择要浏览的班级");
				}
			}
		</script>
  	</head>
  	<body>
  		<div id="tab" class="easyui-tabs">
		    <div title="考勤管理" style="padding:5px">
				<form id="manFm">
					<table class="search_tab">
						<tr>
							<td align="right" width="80px">
								国际班类型：
							</td>
							<td width="100px">
								<select id="interClassType" name="interClassType" style="width:100px;height:25px;" ></select>								
							</td>
							<td align="right" width="70px">	
								班级：
							</td>
							<td align="left" width="225px">
								<input name="classInfo" id="classInfo" type="text" class="easyui-textbox" style="width:100px;height:25px;"/>
							</td>
							<td align="right" width="70px">
								放班日期：
							</td>
							<td width="225px">
								<input name="openStartManTime" id="openStartManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="openEndManTime" id="openEndManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
							</td>
							<td align="right" width="70px">
								班级状态：
							</td>
							<td align="left">
								<select id="classManState" name="classManState" style="width:100px;height:25px;" ></select>
							</td>
						</tr>
						<tr>
							<td align="right">
								上课校区：
							</td>
							<td>
								<select id="schoolManId" name="schoolManId" style="width:100px;height:25px;" ></select>
							</td>
							<td align="right">
								开课日期：
							</td>
							<td>
								<input name="classStartManTime" id="classStartManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="classEndManTime" id="classEndManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
							</td>
							<td align="right">
								结课日期：
							</td>
							<td>
								<input name="overClassStartManTime" id="overClassStartManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="overClassEndManTime" id="overClassEndManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
							</td>
							<td colspan="2" align="left">
								<a href="javascript:void(0)" id="queryManBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryManFunc()">查询</a>
								<a href="javascript:void(0)" id="resetManBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetManFunc()">重置</a>
							</td>
						</tr>
					</table>
				</form>
					<table class="easyui-datagrid" title="班级列表" id="manList" toolbar="#toolManbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
						<thead>
							<tr>
								<th data-options="field:'shortClassInstId',checkbox:true"></th>
								<th width="8%" field="schoolName">上课校区</th>
								<th width="8%" field="classType">国际班类型</th>
								<th width="8%" field="className">班级名称</th>
								<th width="8%" field="teacherNames">带班老师</th>
								<th width="8%" field="classStateName">班级状态</th>
								<th width="8%" field="totalLessionHours">总课时量</th>
								<th width="8%" field="classProgress">课时进度</th>
								<th width="8%" field="personNum">定班人数</th>
								<th width="8%" field="maxNum">班级人数上限</th>
								<th width="8%" field="putClassDate">放班日期</th>
								<th width="8%" field="openDate">开课日期</th>
								<th width="8%" field="finishDate">结课日期</th>
							</tr>
						</thead>
					</table>
				<div id="toolManbar" style="padding: 2px; height: auto">
					<a href="javascript:void(0)" id="manOperBtn" class="easyui-linkbutton" iconCls="icon-edit" style="width:90px;" onclick="manOperFunc()">考勤维护</a>
		   			<a href="javascript:void(0)" id="manViewBtn" class="easyui-linkbutton" iconCls="icon-search" style="width:90px;" onclick="manViewFunc()">浏览</a>
				</div>
		    </div>
		    <div title="历史考勤" style="padding:5px">
				<form id="hisFm">
					<table class="search_tab">
						<tr>
							<td align="right" width="80px">
								国际班类型：
							</td>
							<td width="100px">
								<select id="interClassHisType" name="interClassHisType" style="width:100px;height:25px;" ></select>								
							</td>
							<td align="right" width="70px">
								班级名称：
							</td>
							<td width="225px">
								<input name="classHisName" id="classHisName" type="text" class="easyui-textbox" style="width:100px;height:25px;"/>
							</td>
							<td align="right">&nbsp;</td>
						</tr>
						<tr>
							<td align="right">
								上课校区：
							</td>
							<td>
								<select id="schoolHisId" name="schoolHisId" style="width:100px;height:25px;" ></select>
							</td>
							<td align="right">
								上课日期：
							</td>
							<td>
								<input name="classHisStart" id="classHisStart" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="classHisEnd" id="classHisEnd" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />							
							</td>
							<td align="left">
								<a href="javascript:void(0)" id="queryHisBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryHisFunc()">查询</a>
								<a href="javascript:void(0)" id="resetHisBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetHisFunc()">重置</a>
							</td>
						</tr>
					</table>
				</form>
					<table class="easyui-datagrid" title="历史考勤列表" id="hisList" url="" toolbar="#toolHisbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
						<thead>
							<tr>
								<th data-options="field:'shortClassInstId',checkbox:true"></th>
								<th width="10%" field="schoolName">上课校区</th>
								<th width="10%" field="classType">国际班类型</th>
								<th width="10%" field="className">班级名称</th>
								<th width="10%" field="schooltime">上课时间</th>
								<th width="10%" field="attendNum">应到人数</th>
								<th width="10%" field="realNum">实到人数</th>
								<th width="10%" field="leaveNum">请假人数</th>
								<th width="10%" field="lateNum">迟到人数</th>
								<th width="10%" field="truantNum">旷课人数</th>
								<th width="9%" field="dressNum">穿校服人数</th>
							</tr>
						</thead>
					</table>
				<div id="toolHisbar" style="padding: 2px; height: auto">
		   			<a href="javascript:void(0)" id="hisViewBtn" class="easyui-linkbutton" iconCls="icon-search" style="width:100px;" onclick="hisViewFunc()">浏览</a>
				</div>
		    </div>
		</div>
 	</body>
</html>
