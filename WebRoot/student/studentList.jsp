<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/css/style.css">
		<script type="text/javascript" src="<%=path %>/js/student.js"></script>
  	</head>
  
  	<body>
  		<div id="base">
  			<div id="u0">
        		<div id="u1">
          			<p><span></span></p>
        		</div>
      		</div>
			<div class="easyui-panel" style="min-width:1101px;width:97%;padding:10px;">
				<form id="qryFm">
					<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
					<table width="100%" cellspacing="2">
						<tr>
							<td align="right">
								<span>所属校区：</span>
							</td>
							<td width="114px">
								<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 114px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#schoolId').combobox('setValue',data[0].schoolId);}"
	      						url="<%=path %>/pubData/qrySchoolList.do?schoolId=${sessionScope.StaffT.schoolId}">
        						</select>
							</td>
							<td align="right">
								<span>学员姓名：</span>
							</td>
							<td width="114px">
								<select id="name" name="name" class="easyui-combobox" style="width: 114px; height: 25px;">
        						</select>
							</td>
							<td align="right">
								<span>联系电话：</span>
							</td>
							<td width="114px">
								<input name="phone" id="phone" type="text" class="easyui-textbox" style="width: 114px; height: 25px;"/>
							</td>
							<td align="right">
								<span>证件号码：</span>
							</td>
							<td colspan="2">
								<input name="identityId" id="identityId" type="text" class="easyui-textbox" style="width: 150px; height: 25px;"/>
							</td>
							<td align="center">
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1000">查询</a>
							</td>
							<td align="center">
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
							</td>
						</tr>
						<tr>
							<td align="right">
								<span>招生顾问：</span>
							</td>
							<td width="114px">
								<select id="advisterId" name="advisterId" class="easyui-combobox" style="width: 114px; height: 25px;"
								data-options="formatter:formatStaff, valueField: 'staffId', textField: 'staffName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#advisterId').combobox('setValue',data[0].staffId);}"
	      						url="<%=path %>/pubData/qryStaffList.do?post=001&schoolId=${sessionScope.StaffT.schoolId}">
        						</select>
							</td>
							<td align="right">
								<span>责任顾问：</span>
							</td>
							<td width="114px">
								<select id="dutyAdvister" name="dutyAdvister" class="easyui-combobox" style="width: 114px; height: 25px;"
								data-options="formatter:formatStaff, valueField: 'staffId', textField: 'staffName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#dutyAdvister').combobox('setValue',data[0].staffId);}"
	      						url="<%=path %>/pubData/qryStaffList.do?post=002&schoolId=${sessionScope.StaffT.schoolId}">
        						</select>
							</td>
							<td align="right">
								<span>客户关怀：</span>
							</td>
							<td width="114px">
								<select id="carer" name="carer" class="easyui-combobox" style="width: 114px; height: 25px;"
								data-options="formatter:formatStaff, valueField: 'staffId', textField: 'staffName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#carer').combobox('setValue',data[0].staffId);}"
	      						url="<%=path %>/pubData/qryStaffList.do?post=003&schoolId=${sessionScope.StaffT.schoolId}">
        						</select>
							</td>
							<td align="right">
								<span>建档时间：</span>
							</td>
							<td width="8px">
								<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="startTime" name="startTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="center" width="16px;">
								<span>至</span>
							</td>
							<td width="90px">
								<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="endTime" name="endTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
							</td>
						</tr>
					</table>
				</form>
			</div>
			
			<div id="toolbar" style="padding: 2px 15px; height: auto">
    			<a href="javascript:void(0)" id="addStudent" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">学员注册</a>
    			<a href="javascript:void(0)" id="updateStudent" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;" funcNodeId="1002">修改档案</a>
    			<a href="javascript:void(0)" id="viewStudent" class="easyui-linkbutton" iconCls="icon-redo" style="width: 100px;">浏览</a>
    			<a href="javascript:void(0)" id="addActivity" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">活动奖项</a>
  				<a href="javascript:void(0)" id="batchUpdate" class="easyui-linkbutton" iconCls="icon-edit" style="width: 200px;">批量修改客户关怀和责任顾问</a>
  			</div>
  			
			<div style="padding:5px 0;">
				<table class="easyui-datagrid" title="查询结果" style="width:100%;height:250px" id="list_data" url="<%=path %>/student/qryStudentList.do?funcNodeId=1000"  
					toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th data-options="field:'ck',checkbox:true"></th>
							<th data-options="field:'schoolName',width:80,align:'center'">所属校区</th>
							<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
							<th data-options="field:'sexVal',width:50,align:'center'">性别</th>
							<th data-options="field:'identityId',width:200,align:'center'">证件号码</th>
							<th data-options="field:'birthday',width:100,align:'center'">出生日期</th>
							<th data-options="field:'phone',width:250,align:'center'">联系电话</th>
							<th data-options="field:'createDate',width:100,align:'center'">建档时间</th>
							<th data-options="field:'advisterNameA',width:100,align:'center'">招生顾问A</th>
							<th data-options="field:'advisterNameB',width:100,align:'center'">招生顾问B</th>
							<th data-options="field:'dutyAdvisterName',width:100,align:'center'">责任顾问</th>
							<th data-options="field:'carerName',width:100,align:'center'">客户关怀</th>
							<th data-options="field:'parentsName',width:150,align:'center'">家长</th>
						</tr>
					</thead>
				</table>
			</div>
			
			<div id="dlg" class="easyui-dialog" style="width: 900px; height: auto; padding: 10px 20px" closed="true" data-options="modal:true" buttons="#dlgBtn">
	  			<form id="batchUpdateFm" method="post">
	  				<input type="hidden" id="updateStudentId" name="updateStudentId"/>
	  				<input type="hidden" id="handlerId" name="handlerId"/>
	  				<h2 style="text-align: center;">客户关怀和责任顾问批量调整单</h1>
	  				<table width="100%" cellspacing="2">
	  					<tr>
	  						<td width="15%">&nbsp;</td>
	  						<td align="right" width="20%"><span>责任顾问统一调整：</span></td>
	  						<td width="15%">
	  							<select id="updateAdvisterId" name="updateAdvisterId" class="easyui-combobox" style="width: 114px; height: 25px;"
								data-options="formatter:formatStaff, valueField: 'staffId', textField: 'staffName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#updateAdvisterId').combobox('setValue',data[0].staffId);}"
	      						url="<%=path %>/pubData/qryStaffList.do?post=002&schoolId=${sessionScope.StaffT.schoolId}">
        						</select>
	  						</td>
	  						<td align="right" width="20%"><span>客户关怀统一调整：</span></td>
	  						<td width="15%">
	  							<select id="updateCarer" name="updateCarer" class="easyui-combobox" style="width: 114px; height: 25px;"
								data-options="formatter:formatStaff, valueField: 'staffId', textField: 'staffName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#updateCarer').combobox('setValue',data[0].staffId);}"
	      						url="<%=path %>/pubData/qryStaffList.do?post=003&schoolId=${sessionScope.StaffT.schoolId}">
        						</select>
	  						</td>
	  						<td width="15%">&nbsp;</td>
	  					</tr>
	  				</table>
	  				
	  				<div style="padding:5px 0;">
						<table class="easyui-datagrid" style="width:100%;height:auto" id="batch_update_data">
							<thead>
								<tr>
									<th data-options="field:'schoolName',width:80,align:'center'">所属校区</th>
									<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
									<th data-options="field:'sexVal',width:50,align:'center'">性别</th>
									<th data-options="field:'phone',width:250,align:'center'">联系电话</th>
									<th data-options="field:'createDate',width:100,align:'center'">建档时间</th>
									<th data-options="field:'dutyAdvisterName',width:100,align:'center'">责任顾问</th>
									<th data-options="field:'carerName',width:100,align:'center'">客户关怀</th>
								</tr>
							</thead>
						</table>
					</div>
	  			</form>
	  		</div>
	  		<div id="dlgBtn">
	    		<a href="javascript:void(0)" id="batchUpdateSubmit" class="easyui-linkbutton" iconCls="icon-ok">提交</a> 
	    		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
	  		</div>
  		</div>
 	</body>
</html>
