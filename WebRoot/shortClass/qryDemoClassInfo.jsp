<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  	<body>
  		<div style="margin-right:5px">
  		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
		<form id="manFm" >
			<table class="search_tab">
				<tr>
					<td align="right" width="8%">
						<span>所属校区：</span>
					</td>
					<td align="left" width="8%">
						<select id="schoolId" name="schoolId" style="width:100px;height:25px;" ></select>
					</td>
					<td align="right" width="8%">	
						<span>班级状态：</span>
					</td>
					<td align="left" width="8%">
						<select id="classState" name="classState" class="easyui-combobox" style="width:100px;height:25px;">
      					</select>
					</td>
					<td align="right" width="8%">
						<span>上课日期：</span>
					</td>
					<td width="8%">
						<input name="schoolStartTime" id="schoolStartTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
					</td>
					<td width="2%"><span>至</span></td>
					<td width="8%">
						<input name="schoolendTime" id="schoolendTime" type="text" style="width:120px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
					</td>
					<td></td>
				</tr>
				<tr>
					<td align="right">
						<span>DEMO T：</span>
					</td>
					<td align="left">
						<select id="demoT" name="demoT" class="easyui-combobox" style="width:100px;height:25px;" ></select>								
					</td>
					<td align="right">
						<span>DEMO Ta：</span>
					</td>
					<td align="left">
						<select id="demoTa" name="demoTa" class="easyui-combobox" style="width:100px;height:25px;" ></select>				
					</td>
					<td align="right" colspan="4">
						<a href="javascript:void(0)" id="queryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width:100px;" onclick="queryFunc()"><span>查询</span></a>
						&nbsp;<a href="javascript:void(0)" id="resetBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width:100px;" id="resetBtn"><span>重置</span></a>
					</td>
					<td></td>
				</tr>
			</table>
		</form>
		<table class="easyui-datagrid" title="排课列表" style="height:550px" id="manList" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th width="1%" align="center" data-options="field:'shortClassInstId',checkbox:true"></th>
					<th width="12%" align="center" field="schoolName"><span>校区</span></th>
					<th width="18%" align="center" field="schoolDate"><span>上课时间</span></th>
					<th width="14%" align="center" field="classStateVal"><span>班级状态</span></th>
					<th width="14%" align="center" field="demoT"><span>计划Demo T</span></th>
					<th width="14%" align="center" field="demoTa"><span>计划Demo TA</span></th>
					<th width="15%" align="center" field="createDate"><span>创建时间</span></th>
					<th width="12%" align="center" field="handlerName"><span>创建人</span></th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px;height:auto;">
   			<a href="javascript:void(0)" id="manage" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="addClassManage()"><span>排课管理</span></a>
 			<a href="javascript:void(0)" id="cancel"class="easyui-linkbutton" iconCls="icon-remove" style="width:100px;" onclick="cancleDemoClass()"><span>取消排课</span></a>
			</div>
		</div>
		<script type="text/javascript">
			ajaxLoading("正在处理，请稍待。。。");
			$.post("<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=513&fieldId=schoolId&headFlag=N",function(data){
				$("#schoolId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=DEMO&codeType=CLASS_STATE",function(data){
				$("#classState").combobox("loadData",data);
				ajaxLoadEnd();
			},"json");
			$(document).ready(function(){
				$("#schoolId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto',
					formatter : formatSchool,
					onLoadSuccess : function(data) {
						if(data.length > 0)
						{
							$("#schoolId").combobox('setValue',data[0].schoolId);
						}
					},
					onChange : function(n, o) {
						if(n != "" && n != null && n != undefined) {
							$("#demoT").combobox({
								url : "/sys/pubData/qryData.do?param={'queryCode':'qryDemoTeacherInfo','teacherType':'T','schoolId':'"+n+"'}",//返回json数据的url
								valueField : "teacherId",
								textField : "byname",
								panelHeight : "auto",
								formatter : function(data) {
									return "<span>" + data.byname + "</span>";
								}
							});
							$("#demoTa").combobox({
								url : "/sys/pubData/qryData.do?param={'queryCode':'qryDemoTeacherInfo','teacherType':'TA','schoolId':'"+n+"'}",//返回json数据的url
								valueField : "teacherId",
								textField : "byname",
								panelHeight : "auto",
								formatter : function(data) {
									return "<span>" + data.byname + "</span>";
								}
							});
						} else {
							$("#schoolId").combobox("setText", "");
							$("#demoT").combobox('clear');
							$("#demoT").combobox("loadData", new Array());
							$("#demoTa").combobox('clear');
							$("#demoTa").combobox("loadData", new Array());
						}
					}
				});
				$("#classState").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
				
				//首页面重置
			    $("#resetBtn").click(function() 
			    {
			    	$("#manFm").form('clear');//清空窗体数据  
			    	//校区赋默认值
			    	if($("#schoolId").combobox("getData").length>0){
			    		$("#schoolId").combobox("select",$("#schoolId").combobox("getData")[0].schoolId);
			    	}
			    });
			});
			function queryFunc()
			{
				var schoolId = $("#schoolId").combobox("getValue");
	   			if(schoolId != ""){
					var obj = $("#manFm").serializeObject();
					obj["queryCode"] = "qryDemoClassInfo";
					obj["funcNodeId"] = "4620";
					obj = JSON.stringify(obj);
					$("#manList").datagrid({
						url:"/sys/pubData/qryDataListByPage.do",
						queryParams:{
							param : obj
						}
					});
	   			}else{
					showMessage("提示","没有有效的校区可供查询",null);
				}
			}
			function addClassManage()
			{
				ajaxLoading("正在处理，请稍待。。。");
				window.location.href = "/sys/shortClass/addDemoClass.jsp";
			}
			function cancleDemoClass()
			{
				if(validateSelect("manList")) {
					var row = $("#manList").datagrid('getSelected');
					var classStateVal = row.classStateVal;
					if(classStateVal == "取消"){
						 $.messager.alert('提示', "该DEMO课已经取消排课！");
						   return;
					}
					$.messager.confirm("提示", "您确定要取消该DEMO课吗？", function (data) {
			            if(data){
			            	ajaxLoading("正在处理，请稍待。。。");
			            	$.post("/sys/shortBus/cancelShortClassFunc.do",{shortClassInstId:row.shortClassInstId,remark:"",handleId:${sessionScope.StaffT.staffId}},function(data){
			                	ajaxLoadEnd();
			                	if(data == "success")
			                	{
			                		window.location.reload();
			                	}
			                	else
			                	{
			                		$.messager.alert('提示',"取消DEMO课失败:"+data,"error");
			                	}
			                });
			            }
		       	 	});
				}
			}
			function validateSelect(object)
			{
				var flag = false;
				var obj = $("#"+object+"").datagrid('getSelections');
				if(obj.length > 0) {
					if(obj.length > 1) {
						$.messager.alert('提示', "只能选择一个DEMO课操作！");
					} else {
						flag = true;
					}
				} else {
					$.messager.alert('提示', "请先选择您要操作的DEMO课！");
				}
				return flag;
			}
		</script>
 	</body>
</html>
