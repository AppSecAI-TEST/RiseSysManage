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
  		<div id="tab" class="easyui-tabs" style="min-width:1100px;width:99%;height:530px;font-family:'微软雅黑';margin:0 auto;padding:0 0">
		    <div title="考勤管理">
				<form id="manFm" style="margin:0 auto;">
					<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:5px auto;height:80px;" cellspacing="2">
						<tr>
							<td align="right">
								国际班类型：
							</td>
							<td>
								<select id="interClassType" name="interClassType" style="width:100px;height:25px;" ></select>								
							</td>
							<td align="right" width="8%">	
								班级：
							</td>
							<td width="22%">
								<select id="classInfo" name="classInfo" style="width:100px;height:25px;" ></select>
							</td>
							<td align="right" width="8%">
								放班日期：
							</td>
							<td width="22%">
								<input name="openStartManTime" id="openStartManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="openEndManTime" id="openEndManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
							</td>
							<td align="right" width="8%">
								班级状态：
							</td>
							<td width="12%">
								<select id="classManState" name="classManState" style="width:100px;height:25px;" ></select>
							</td>
						</tr>
						<tr>
							<td align="right" width="8%">
								上课校区：
							</td>
							<td width="12%">
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
							<td colspan="2" align="center">
								<a href="javascript:void(0)" id="queryManBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryManFunc()">查询</a>
								<a href="javascript:void(0)" id="resetManBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetManFunc()">重置</a>
							</td>
						</tr>
					</table>
				</form>
				<div style="padding:5px 0;min-width:1100px; width:100%">
					<table class="easyui-datagrid" title="班级列表" style="height:390px" id="manList" toolbar="#toolManbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
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
				</div>
				<div id="toolManbar" style="padding: 2px; height: auto">
					<a href="javascript:void(0)" id="manOperBtn" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="manOperFunc()">考勤维护</a>
		   			<a href="javascript:void(0)" id="manViewBtn" class="easyui-linkbutton" iconCls="icon-search" style="width:100px;" onclick="manViewFunc()">浏览</a>
				</div>
		    </div>
		    <div title="历史考勤">
				<form id="hisFm" style="margin:0 auto;">
					<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:5px auto;height:80px;" cellspacing="2">
						<tr>
							<td align="right" width="15%">
								国际班类型：
							</td>
							<td width="15%">
								<select id="interClassHisType" name="interClassHisType" style="width:100px;height:25px;" ></select>								
							</td>
							<td align="right" width="10%">
								班级名称：
							</td>
							<td width="30%">
								<select id="classHisName" name="classHisName" style="width:100px;height:25px;" ></select>
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
				<div style="padding:5px 0;min-width:1100px; width:100%;">
					<table class="easyui-datagrid" title="历史考勤列表" style="height:390px;" id="hisList" url="" toolbar="#toolHisbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
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
								<th width="10%" field="dressNum">穿校服人数</th>
							</tr>
						</thead>
					</table>
				</div>
				<div id="toolHisbar" style="padding: 2px; height: auto">
		   			<a href="javascript:void(0)" id="hisViewBtn" class="easyui-linkbutton" iconCls="icon-search" style="width:100px;" onclick="hisViewFunc()">浏览</a>
				</div>
		    </div>
		</div>
		<blockquote><br></blockquote><script type="text/javascript">
			ajaxLoading("加载中...");
			$.post("<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=808&fieldId=schoolId",function(data){
				$("#schoolManId").combobox("loadData",data);
				$("#schoolHisId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=CLASS_STATE",function(data){
				$("#classManState").combobox("loadData",data);
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
					panelHeight: 'auto'
				});
				$("#classInfo").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
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
					panelHeight: 'auto'
				});
				$("#classHisName").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
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
						console.log(title+' is selected');
				    }
				});
			});
			function queryManFunc()
			{
				var obj = $("#manFm").serializeObject();
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
				$("#schoolManId").combobox("setValue","");
				$("#interClassType").combobox("setValue","");
				$("#classManState").combobox("setValue","");
				$("#classInfo").combobox("setValue","");
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
					ajaxLoading("加载中...");
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
					ajaxLoading("加载中...");
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
				$("#interClassHisType").combobox("setValue","");
				$("#classHisName").combobox("setValue","");
				$("#schoolHisId").combobox("setValue","");
				$("#classHisStart").datebox("setValue","");
				$("#classHisEnd").datebox("setValue","");
			}
			function hisViewFunc()
			{
				var row = $("#hisList").datagrid("getSelected");
				if(row)
				{
					ajaxLoading("加载中...");
					window.location.href = "/sys/shortBus/viewShortClassPage.do?funcNodeId=${param.funcNodeId}&shortClassInstId="+row.shortClassInstId+"&pageName=viewInterShortClass";
				}
				else
				{
					$.messager.alert('提示',"请选择要浏览的班级");
				}
			}
		</script>
 	</body>
</html>
