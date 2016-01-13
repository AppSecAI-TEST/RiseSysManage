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
 		<form id="qryTeaFm">
  			<table class="search_tab">
  				<tr>
  					<td align="right" width="8%"><span>组织：</span></td>
  					<td align="left" width="8%">
  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width:100px;height:25px;" editable="false">
        				</select>
  					</td>
  					<td align="right" width="10%"><span>教师英文名：</span></td>
  					<td align="left" width="8%">
  						<select name="byName" id="byName" class="easyui-combobox" style="width:100px;height:25px;">
						</select>
  					</td>
  					<td align="right" width="8%"><span>入职时间：</span></td>
  					<td align="left" width="8%">
  						<input class="easyui-datebox" name="joinStartDate" id="joinStartDate" style="width:100px;height:25px;" />
  					</td>
  					<td align="center" width="2%"><span>至</span></td>
  					<td align="left" width="8%">
  						<input class="easyui-datebox" name="joinEndDate" id="joinEndDate" style="width:100px;height:25px;" />
  					</td>
  					<td></td>
  				</tr>
  				<tr>
  					<td align="right"><span>职务：</span></td>
  					<td align="left">
  						<select id="post" name="post" class="easyui-combobox" style="width:100px;height:25px;" editable="false"
							data-options="formatter:formatPost, valueField: 'postId', textField: 'postName', panelHeight: 'auto'"
				      		url="<%=path %>/pubData/qryPostList.do?postType=T">
        				</select>
  					</td>
  					<td align="right"><span>工作性质：</span></td>
  					<td align="left">
  						<select id="jobProperty" name="jobProperty" class="easyui-combobox" style="width:100px;height:25px;"
	  						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=STAFF_T&codeType=JOB_PROPERTY">
        				</select>
  					</td>
  					<td align="right"><span>入职时长：</span></td>
  					<td align="left">
  						<input class="easyui-numberbox" name="joinStartTime" id="joinStartTime" style="width:100px;height:25px;" />
  					</td>
  					<td align="center"><span>至</span></td>
  					<td align="left">
  						<input class="easyui-numberbox" name="joinEndTime" id="joinEndTime" style="width:100px;height:25px;" />
  					</td>
  					<td align="left">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px;" id="qryTeaBtn" funcNodeId="4100">查询</a>
						&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px;" id="reset" >重置</a>
					</td>
  				</tr>
  			</table>
 		</form>
 		
		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:570" id="teacher_list" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="schoolName" align="center" width="7%"><span>组织</span></th>
					<th field="teacherName" align="center" width="8%"><span>教师姓名</span></th>
					<th field="byname" align="center" width="9%"><span>教师英文名</span></th>
					<th field="stateVal" align="center" width="8%"><span>教师状态</span></th>
					<th field="phone" align="center" width="9%"><span>联系电话</span></th>
					<th field="postVal" align="center" width="8%"><span>职务</span></th>
					<th field="joinDate" align="center" width="10%"><span>入职时间</span></th>
					<th field="joinTime" align="center" width="10%"><span>入职时长（月）</span></th>
					<th field="licenses" align="center" width="11%"><span>持证阶段</span></th>
					<th field="stageIds" align="center" width="19%"><span>在读带班阶段</span></th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px;height:auto;">
   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="addTrain()"><span>提交</span></a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
 		</div>
 		</div>
 		<script type="text/javascript">
	   		$(document).ready(function(){
	   			//定位教师页面查询
			    $("#qryTeaBtn").click(function() {
			    	var json = $("#qryTeaFm").serializeObject();
			    	json.byName = $("#byName").combobox('getText');
					var obj = JSON.stringify(json);
					obj = obj.substring(0, obj.length - 1);
					var funcNodeId = $("#qryTeaBtn").attr("funcNodeId");
					obj += ",\"teacherState\":\"P\",\"funcNodeId\":\""+funcNodeId+"\"}";
					$('#teacher_list').datagrid({
						url : "/sys/pubData/qryDataListByPage.do",
						queryParams:{
							param : obj
						},
						onLoadSuccess:function(){
							//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
							$('#teacher_list').datagrid('clearSelections');
						}
					});
			    });
	   			var staffId = $("#staffId").val();
				$("#schoolId").combobox({
					url : "/sys/pub/pageCategory.do?staffId="+staffId+"&resourceId=509&fieldId=schoolId&headFlag=N",//返回json数据的url 
					valueField : "schoolId",
					textField : "schoolName",
					panelHeight : "auto",
					formatter : formatSchool,
					onLoadSuccess : function(data) {
						$("#schoolId").combobox('setValue',data[0].schoolId);
					},
					onChange : function(n, o) {
						if(n != "" && n != null && n != undefined) {
							//$("#byName").combobox({disabled: false});
							$("#byName").combobox({
								url : "/sys/pubData/qryTeacherList.do?schoolId="+n,//返回json数据的url
								valueField : "teacherId",
								textField : "byname",
								panelHeight : "auto",
								formatter : function(data) {
									return "<span>" + data.byname + "</span>";
								}
							});
						} else {
							$("#schoolId").combobox("setText", "");
							$("#byName").combobox('clear');
							$("#byName").combobox("loadData", new Array());
							//$("#byName").combobox({disabled: true});
						}
					}
				});
	   		});
			//跳转新增培训页面
			function addTrain()
			{
				if(validateSelect("teacher_list")) {
					var row = $("#teacher_list").datagrid('getSelected');
					var teacherId = row.teacherId;
					var name = row.teacherName;
					var byName = row.byname;
					var stateVal = row.stateVal;
					window.location.href = "/sys/trainManage/addTrain.jsp?teacherId="+teacherId+"&name="+name+"&byName="+byName+"&stateVal="+stateVal;
				}
			}
			function validateSelect(object)
			{
				var flag = false;
				var obj = $("#"+object+"").datagrid('getSelections');
				if(obj.length > 0) {
					if(obj.length > 1) {
						$.messager.alert('提示', "只能选择一个教师进行操作！");
					} else {
						flag = true;
					}
				} else {
					$.messager.alert('提示', "请先选择您要操作的教师！");
				}
				return flag;
			}
	   	</script>
  	</body>
</html>
