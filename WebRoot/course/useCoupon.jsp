<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<html>
	<head>
	<%@ include file="../common/head.jsp" %>
	<%@ include file="../common/formvalidator.jsp" %>
	</head>
	<body>
	<div id="base">
  			<div id="u0">
        		<div id="u1">
          			<p><span></span></p>
        		</div>
      		</div>
      		 
			<div class="easyui-panel" style="width:99%;" title="使用现金抵扣券">
	      		<form id="studentFm">
	      		  <table width="100%" cellpadding="5px" class="maintable" id="addStudentTd">
   				    <tr>
   				      <td width="13%" align="right"><div align="center">
   				        <input type="checkbox" name="checkbox" id="checkbox">
			          </div></td>
	      					<td width="13%" align="right"><div align="center"><span  >序号</span> </div></td>
	      					<td width="25%">
	      						<div align="center"><span>条码</span>
   						    </div></td>
	      					<td width="13%" align="right">
	      						<div align="center"><span>金额</span>
   						    </div></td>
	      					<td width="15%">
	      						<div align="center"><span>赠送时间</span>
   						    </div></td>
	      					<td align="right"><div align="center"><span>有效期</span></div></td>
	      					<td><div align="center"><span>状态</span></div></td>
      					</tr>
	      			</table>
                </form>
	      	</div>
	      	
	      	<div style="padding:5px 0;min-width:1100px; width:100%;">
			<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="list_data" url="/sys/course/getStuCourses.do?queryCode=Qry_Course_Gift&studentId=2" 
				toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'schoolName',width:80,align:'center'">校区</th>
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
		
		<div style="margin-top: 20px;">
      		  <div style="float: left;margin-left: 900px;">
	      			<a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      			&nbsp;<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onClick="javascript:window.history.back()">返回</a>
	      		</div>
	     </div>
	     </div>
	</body>

</html>
<script type="text/javascript">

	var studentCourses=[];//提交课程
	var linkCourses=[];//选择关联已有连报课程
	
 
	</script>