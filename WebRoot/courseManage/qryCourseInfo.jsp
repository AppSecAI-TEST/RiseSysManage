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
		<script type="text/javascript" src="<%=path %>/js/courseManage.js"></script>
  	</head>
  	<body>
  		<div style="padding:5px 0;">
  			<form id="qryFm">
	  			<table>
	  				<tr>
	  					<td>所属校区:</td>
	  					<td>
	  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td align="right">学生姓名:</td>
	  					<td>
	  						<input class="easyui-textbox"  name="studentName" id="studentName" style="width:150px;" />
	  					</td>
	  					<td align="right">联系电话:</td>
	  					<td>
	  						<input class="easyui-textbox" name="telephone" id="telephone" style="width:150px;" />
	  					</td>
	  					<td>缴费时间:</td>
	  					<td>
	  						<input class="easyui-datebox" name="payStartTime" id="payStartTime" style="width:150px;" />
	  					</td>
	  					<td>至:</td>
	  					<td>
	  						<input class="easyui-datebox" name="payEndTime" id="payEndTime"  style="width:150px;" />
	  					</td>
	  				</tr>
	  				<tr>
	  					<td>招生顾问:</td>
	  					<td>
	  						<input class="easyui-textbox" name="recruitAdviser" id="recruitAdviser" style="width:150px;" />
	  					</td>
	  					<td align="right">责任顾问:</td>
	  					<td>
	  						<input class="easyui-textbox" name="dutyAdviser" id="dutyAdviser" style="width:150px;" />
	  					</td>
	  					<td align="right">证件号码:</td>
	  					<td>
	  						<input class="easyui-textbox" name="identityId" id="identityId" style="width:150px;" />
	  					</td>
	  					<td>退费时间:</td>
	  					<td>
	  						<input class="easyui-datebox" name="feeBackStartTime" id="feeBackStartTime" style="width:150px;" />
	  					</td>
	  					<td>至:</td>
	  					<td>
	  						<input class="easyui-datebox" name="feeBackEndTime" id="feeBackEndTime" style="width:150px" />
	  					</td>
	  				</tr>
	  				<tr>
	  					<td>业绩类型:</td>
	  					<td>
	  						<select class="easyui-combobox" name="feeType" id="feeType" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td align="right">课程状态:</td>
	  					<td>
	  						<input class="easyui-combobox"  name="courseState" id="courseState" style="width:150px;" />
	  					</td>
	  					<td align="right">赠品信息:</td>
	  					<td>
	  						<input class="easyui-combobox" name="giftType" id="giftType" style="width:150px;" />
	  					</td>
	  					<td>结课时间:</td>
	  					<td>
	  						<input class="easyui-datebox" name="classOverStartTime" id="classOverStartTime" style="width:150px;" />
	  					</td>
	  					<td>至:</td>
	  					<td>
	  						<input class="easyui-datebox" name="classOverEndTime" id="classOverEndTime"  style="width:150px;" />
	  					</td>
	  				</tr>
	  				<tr>
	  					<td>课程类型:</td>
	  					<td>
	  						<select class="easyui-combobox" name="courseType" id="courseType" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>
	  						<select class="easyui-combobox"  name="courseTypeDetail" id="courseTypeDetail" style="width:150px;" />
	  						
	  						</select>
	  					</td>
	  					<td align="right">口碑类型:</td>
	  					<td>
	  						<select class="easyui-combobox"  name="womType" id="womType" style="width:150px;" />
	  						
	  						</select>
	  					</td>
	  					<td>
	  						<select class="easyui-combobox"  name="womTypeDetail" id="womTypeDetail" style="width:150px;" />
	  						
	  						</select>
	  					</td>
	  					<td>赠课信息:</td>
	  					<td>
	  						<select class="easyui-combobox"  name="giftClassType" id="giftClassType" style="width:150px;" />
	  						
	  						</select>
	  					</td>
	  					<td></td>
	  					<td style="text-align: right;">
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:75px" id="qryBtn" onclick="qryData()">查询</a>  <a href="javascript:void(0)" class="easyui-linkbutton" style="width:75px" id="reset" onclick="">重置</a>
	  					</td>
	  				</tr>
	  			</table>
  			</form>
  			<div id="toolbar">
    			<a href="javascript:void(0)" id="addCourse" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addCourse()">添加课程</a>
    			<a href="javascript:void(0)" id="updateCourse" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="updateCourse()">修改</a>
    			<a href="javascript:void(0)" id="courseDetail" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="courseDetail()">浏览</a>
  			</div>
			<div style="padding:5px 0;">
				<table class="easyui-datagrid" title="查询结果" style="width:100%;height:250px" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
					<thead>
						<tr>
							<th field="ck" checkbox="true" width="2%"></th>
							<th field="schoolId" align="center" width="8%">所属校区</th>
							<th field="studentName" align="center" width="7%">学员姓名</th>
							<th field="identityId" align="center" width="10%">证件号码</th>
							<th field="feeType" align="center" width="7%">业绩类型</th>
							<th field="classType" align="center" width="8%">班级类型</th>
							<th field="payTime" align="center" width="8%">缴费时间</th>
							<th field="recruitAdviserA" align="center" width="7%">招生顾问A</th>
							<th field="recruitAdviserB" align="center" width="7%">招生顾问B</th>
							<th field="dutyAdviser" align="center" width="7%">责任顾问</th>
							<th field="courseState" align="center" width="7%">课程状态</th>
							<th field="currentClass" align="center" width="8%">当前班级</th>
							<th field="womType" align="center" width="7%">口碑类型</th>
							<th field="telephone" align="center" width="7%">联系电话</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>