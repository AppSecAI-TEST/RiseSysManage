<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/pub/js/json.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json2.js"></script>
		<script type="text/javascript" src="<%=path %>/js/teacherManage.js"></script>
  	</head>
  	<body>
  		<div style="padding:5px 0;">
  			<form id="qryFm">
	  			<table>
	  				<tr>
	  					<td>校区：</td>
	  					<td>
	  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>教师中文名：</td>
	  					<td>
	  						<input class="easyui-textbox"  name="chineseName" id="chineseName" style="width:150px;" />
	  					</td>
	  					<td>教师英文名：</td>
	  					<td>
	  						<input class="easyui-textbox" name="englishName" id="englishName" style="width:150px;" />
	  					</td>
	  					<td>持证阶段：</td>
	  					<td>
	  						<select class="easyui-combobox" name="permitteeLevel" id="permitteeLevel" style="width:150px;">
	  						
	  						</select>
	  					</td>
	  					<td>持证数量:</td>
	  					<td>
	  						<input class="easyui-textbox" name="permitteeNum" id="permitteeNum"  style="width:150px;" />
	  					</td>
	  					<td></td>
	  				</tr>
	  				<tr>
	  					<td>入职时长/月:</td>
	  					<td>
	  						<input class="easyui-textbox" name="workMonth" id="workMonth" style="width:150px;" />
	  					</td>
	  					<td>入职年数:</td>
	  					<td>
	  						<input class="easyui-textbox" name="workYear" id="workYear" style="width:150px;" />
	  					</td>
	  					<td>入职时间:</td>
	  					<td>
	  						<input class="easyui-datebox" name="workTime" id="workTime" style="width:150px;" />
	  					</td>
	  					<td>带班阶段:</td>
	  					<td>
	  						<select class="easyui-combobox" name="leadClassLevel" id="leadClassLevel" style="width:150px;">
	  						
	  						</select>
	  					</td>
	  					<td>待培训阶段:</td>
	  					<td>
	  						<select class="easyui-combobox" name="trainingLevel" id="trainingLevel" style="width:150px">
	  						
	  						</select>
	  					</td>
	  					<td style="text-align: right;">
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:150px" id="qryBtn" onclick="qryData()">查询</a>
	  					</td>
	  				</tr>
	  			</table>
  			</form>
  			<div id="cc" class="easyui-calendar"></div>
  			<div id="toolbar">
    			<a href="javascript:void(0)" id="addArchives" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addArchives()">新增教师档案</a>
    			<a href="javascript:void(0)" id="updateArchives" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="updateArchives()">修改教师档案</a>
    			<a href="javascript:void(0)" id="deleteArchives" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteArchives()">删除教师档案</a>
  			</div>
			<div style="padding:5px 0;">
				<table class="easyui-datagrid" title="查询结果" style="width:100%;height:250px" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
					<thead>
						<tr>
							<th field="schoolId" align="center" width="10%">校区</th>
							<th field="chineseName" align="center" width="10%">教师中文名</th>
							<th field="englishName" align="center" width="10%">教师英文名</th>
							<th field="permitteeLevel" align="center" width="12%">持证阶段</th>
							<th field="permitteeNum" align="center" width="8%">持证数量</th>
							<th field="workMonth" align="center" width="10%">入职时长/月</th>
							<th field="workYear" align="center" width="8%">入职年数</th>
							<th field="workTime" align="center" width="12%">入职时间</th>
							<th field="leadClassLevel" align="center" width="10%">带班阶段</th>
							<th field="trainingLevel" align="center" width="10%">待培训阶段</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  		<div id="dlg" class="easyui-dialog" style="width: 580px; height: 450px; padding: 10px 20px" closed="true" modal="true" buttons="#dlgBtn">
  			<form id="fm" method="post">
  				<input type="hidden" name="teacherId" id="teacherId" />
  				<table style="width: 100%;" cellSpacing='0' cellPadding='5px'>
  					<tr>
  						<td style="text-align: right;width: 40%">校区：</td>
  						<td>
	  						<select class="easyui-combobox" style="width:155px;" name="schoolId" id="schoolId" data-options="panelHeight:'auto'">
	  						
	  						</select>
  						</td>
  					</tr>
  					<tr>
  						<td style="text-align: right;width: 40%">教师中文名：</td>
  						<td>
	  						<input class="easyui-textbox" style="width:155px;" name="chineseName" id="chineseName" data-options="panelHeight:'auto'" />
  						</td>
  					</tr>
  					<tr>
  						<td style="text-align: right;width: 40%">教师英文名：</td>
  						<td>
	  						<input class="easyui-textbox" style="width:155px;" name="englishName" id="englishName" data-options="panelHeight:'auto'" />
  						</td>
  					</tr>
  					<tr>
  						<td style="text-align: right;width: 40%">持证阶段：</td>
  						<td>
	  						<select class="easyui-combobox" style="width:155px;" name="permitteeLevel" id="permitteeLevel" data-options="panelHeight:'auto'">
  							
  							</select>
  						</td>
  					</tr>
  					<tr>
  						<td style="text-align: right;width: 40%">持证数量：</td>
  						<td>
	  						<input class="easyui-textbox" style="width:155px;" id="permitteeNum" name="permitteeNum" />
  						</td>
  					</tr>
  					<tr>
  						<td style="text-align: right;width: 40%">入职时长/月：</td>
  						<td>
	  						<input class="easyui-textbox" style="width:155px;" id="workMonth" name="workMonth">
  						</td>
  					</tr>
  					<tr>
  						<td style="text-align: right;width: 40%">入职年数：</td>
  						<td>
	  						<input class="easyui-textbox" style="width:155px;" id="workYear" name="workYear">
  						</td>
  					</tr>
  					<tr>
  						<td style="text-align: right;width: 40%">入职时间：</td>
  						<td>
	  						<input class="easyui-datebox" data-options="sharedCalendar:'#cc'" style="width:155px;" id="workTime" name="workTime">
  						</td>
  					</tr>
  					<tr>
  						<td style="text-align: right;width: 40%">带班阶段：</td>
  						<td>
	  						<input class="easyui-combobox" style="width:155px;" id="leadClassLevel" name="leadClassLevel">
  						</td>
  					</tr>
  					<tr>
  						<td style="text-align: right;width: 40%">待培训阶段：</td>
  						<td>
	  						<input class="easyui-combobox" style="width:155px;" id="trainingLevel" name="trainingLevel">
  						</td>
  					</tr>
  				</table>
  			</form>
  		</div>
  		<div id="dlgBtn">
    		<a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveArchives()">确认</a> 
    		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
  		</div>
  	</body>
</html>
