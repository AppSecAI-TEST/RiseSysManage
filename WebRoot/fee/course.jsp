<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/courseManage.js"></script>
  	</head>
  	<body>
  		<div style="padding:5px 0;">
  			<form id="qryFm">
	  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="15">
	  				<tr>
	  					<td align="right">所属校区:</td>
	  					<td>
	  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td align="right">学生姓名:</td>
	  					<td>
	  						<input class="easyui-textbox"  name="studentName" id="studentName" style="width:150px;" />
	  					</td>
	  					<td align="right">课程状态:</td>
	  					<td>
	  						<input class="easyui-combobox"  name="courseState" id="courseState" style="width:150px;" />
	  					</td>
	  					<td align="right">缴费时间:</td>
	  					<td>
	  						<input class="easyui-datebox" name="payStartTime" id="payStartTime" style="width:150px;" />
	  						&nbsp;至:&nbsp;
	  						<input class="easyui-datebox" name="payEndTime" id="payEndTime"  style="width:150px;" />
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right">联系电话:</td>
	  					<td>
	  						<input class="easyui-textbox" name="telephone" id="telephone" style="width:150px;" />
	  					</td>
	  					<td align="right">证件号码:</td>
	  					<td>
	  						<input class="easyui-textbox" name="identityId" id="identityId" style="width:150px;" />
	  					</td>
	  					<td align="right">赠品信息:</td>
	  					<td>
	  						<input class="easyui-combobox" name="giftType" id="giftType" style="width:150px;" />
	  					</td>
	  					<td align="right">退费时间:</td>
	  					<td>
	  						<input class="easyui-datebox" name="feeBackStartTime" id="feeBackStartTime" style="width:150px;" />
	  					&nbsp;至:&nbsp;
	  						<input class="easyui-datebox" name="feeBackEndTime" id="feeBackEndTime" style="width:150px" />
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right">招生顾问:</td>
	  					<td>
	  						<input class="easyui-textbox" name="recruitAdviser" id="recruitAdviser" style="width:150px;" />
	  					</td>
	  					<td align="right">责任顾问:</td>
	  					<td>
	  						<input class="easyui-textbox" name="dutyAdviser" id="dutyAdviser" style="width:150px;" />
	  					</td>
	  					<td align="right">赠课信息:</td>
	  					<td>
	  						<select class="easyui-combobox"  name="giftClassType" id="giftClassType" style="width:150px;" />
	  						
	  						</select>
	  					</td>
	  					<td align="right">结课时间:</td>
	  					<td>
	  						<input class="easyui-datebox" name="classOverStartTime" id="classOverStartTime" style="width:150px;" />
	  					&nbsp;至:&nbsp;
	  						<input class="easyui-datebox" name="classOverEndTime" id="classOverEndTime"  style="width:150px;" />
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right">课程类型:</td>
	  					<td>
	  						<select class="easyui-combobox" name="courseType" id="courseType" style="width:75px;">
	  							
	  						</select>
	  						<select class="easyui-combobox"  name="courseTypeDetail" id="courseTypeDetail" style="width:75px;" />
	  						
	  						</select>
	  					</td>
	  					<td align="right">口碑类型:</td>
	  					<td>
	  						<select class="easyui-combobox"  name="womType" id="womType" style="width:75px;" />
	  						
	  						</select>
	  						<select class="easyui-combobox"  name="womTypeDetail" id="womTypeDetail" style="width:75px;" />
	  						
	  						</select>
	  					</td>
	  					<td align="right">业绩类型:</td>
	  					<td>
	  						<select class="easyui-combobox" name="feeType" id="feeType" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td colspan="2"> <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:150px" id="qrybt" onclick="">查询</a>
	  					&nbsp;&nbsp; <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:150px" id="reset" onclick="">重置</a></td>	
	  				</tr>	
	  			</table>
  			</form>
  			<div id="toolbar">
    			<a href="javascript:void(0)" id="refundFee" class="easyui-linkbutton" iconCls="icon-add" plain="true">常规课退费</a>
    			<a href="javascript:void(0)" id="updateSingleCourse" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="">短期课退费</a>
  			</div>
			<div style="padding:5px 0;">
				<table class="easyui-datagrid" title="查询结果" style="height:450px" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true"
				 url="<%=path %>/pubData/qryDataListByPage.do?funcNodeId=5000"
				>
					<thead>
						<tr>
							<th field="ck" checkbox="true" width="2%"></th>
							<th field="schoolName" align="center" width="8%">所属校区</th>
							<th field="name" align="center" width="7%">学员姓名</th>
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
<script type="text/javascript">

	 $("#refundFee").click(function() {
    	window.location.href = "/sys/fee/apply.jsp";
    });
</script>
