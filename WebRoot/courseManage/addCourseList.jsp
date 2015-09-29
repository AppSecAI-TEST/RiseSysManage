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
  		<div style="padding:5px 0;">
  			<form id="qryFm">
	  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="15">
	  				<tr>
	  					<td align="right">所属校区:</td>
	  					<td width="170px">
	  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td align="right">学员姓名:</td>
	  					<td width="170px">
	  						<input class="easyui-textbox"  name="studentName" id="studentName" style="width:150px;" />
	  					</td>
	  					<td align="right" width="60px">联系电话:</td>
	  					<td>
	  						<input class="easyui-textbox" name="telephone" id="telephone" style="width:150px;" />
	  					</td>
	  				</tr>
	  				<tr>
	  					
	  					<td align="right">证件号码:</td>
	  					<td>
	  						<input class="easyui-textbox" name="identityId" id="identityId" style="width:150px;" />
	  					</td>
	  					<td align="right">业绩顾问:</td>
	  					<td>
	  						<input class="easyui-textbox" name="recruitAdviser" id="recruitAdviser" style="width:150px;" />
	  					</td>
	  					<td align="right">责任顾问:</td>
	  					<td>
	  						<input class="easyui-textbox" name="dutyAdviser" id="dutyAdviser" style="width:150px;" />
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right">客户关怀:</td>
	  					<td>
	  						<input class="easyui-textbox" name="carer" id="carer" style="width:150px;" />
	  					</td>
	  					<td align="right">建档日期:</td>
	  					<td>
	  						<input class="easyui-datebox" name="startTime" id="startTime" style="width:150px;" />
	  					</td>
	  					<td align="right">至:</td>
	  					<td>	
	  						<input class="easyui-datebox" name="endTime" id="endTime"  style="width:150px;" />
	  					</td>
	  					<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:150px" id="qryBtn" onclick="">查询</a></td>
	  					<td align="left"> <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-redo" style="width:150px" id="reset" onclick="">重置</a></td>	
	  				</tr>	
	  			</table>
  			</form>
  			<div id="toolbar">
    			<a href="javascript:void(0)" id="addCourse" class="easyui-linkbutton" iconCls="icon-add" plain="true">单报</a>
    			<a href="javascript:void(0)" id="updateCourse" class="easyui-linkbutton" iconCls="icon-add" plain="true">连报</a>
    			<a href="javascript:void(0)" id="courseDetail" class="easyui-linkbutton" iconCls="icon-back" plain="true">返回</a>
  			</div>
			<div style="padding:5px 0;">
				<table class="easyui-datagrid" title="查询结果" style="height:300px" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
					<thead>
						<tr>
							<th field="ck" checkbox="true" width="2%"></th>
							<th field="schoolId" align="center" width="10%">校区</th>
							<th field="name" align="center" width="10%">学员姓名</th>
							<th field="byName" align="center" width="7%">英文名</th>
							<th field="sex" align="center" width="5%">性别</th>
							<th field="identityId" align="center" width="15%">证件号码</th>
							<th field="birthday" align="center" width="12%">出生日期</th>
							<th field="phone" align="center" width="12%">联系电话</th>
							<th field="createDate" align="center" width="12%">建档日期</th>
							<th field="recruitAdviser" align="center" width="10%">招生顾问</th>
							<th field="dutyAdviser" align="center" width="10%">责任顾问</th>
							<th field="carer" align="center" width="10%">客户关怀</th>
							<th field="parents" align="center" width="10%">家长</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
