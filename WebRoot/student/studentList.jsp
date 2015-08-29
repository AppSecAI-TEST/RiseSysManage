<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/js/easyui/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/js/easyui/themes/icon.css">
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/css/demo.css">
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/css/student/style.css">
		<script type="text/javascript" src="<%=path %>/pub/js/jquery.min.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/jquery.cookie.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/easyui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json2.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/util.js"></script>
		<script type="text/javascript" src="<%=path %>/js/student.js"></script>
  	</head>
  
  	<body>
  		<div id="base">
  			<div id="u0">
        		<div id="u1">
          			<p><span></span></p>
        		</div>
      		</div>
			<form id="qryFm">
				<div class="easyui-panel" style="width:1101px;height:100px;padding:10px;">
					<div id="u2">
	        			<div id="u3">
	          				<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">所属校区：</span></p>
	        			</div>
	      			</div>
	      			<div id="u4">
        				<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 114px; height: 25px;">
	          					
        				</select>
      				</div>
      				
      				<div id="u5">
        				<div id="u6">
          					<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">学员姓名：</span></p>
        				</div>
      				</div>
      				<div id="u7">
        				<input name="name" id="name" type="text" class="easyui-textbox" style="width: 114px; height: 25px;"/>
      				</div>
      				
      				<div id="u11">
        				<div id="u12">
          					<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">联系电话：</span></p>
        				</div>
      				</div>

      				<div id="u13">
        				<input name="phone" id="phone" type="text" class="easyui-textbox" style="width: 114px; height: 25px;"/>
      				</div>
      				
      				<div id="u8">
        				<div id="u9">
          					<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">证件号码：</span></p>
        				</div>
      				</div>
      				<div id="u10">
        				<input name="identityId" id="identityId" type="text" class="easyui-textbox" style="width: 114px; height: 25px;"/>
      				</div>
      				
      				<div id="u164">
        				<div id="u165">
        					<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">招生顾问：</span></p>
        				</div>
      				</div>
      				
      				<div id="u168">
        				<select id="advisterId" name="advisterId" class="easyui-combobox" style="width: 114px; height: 25px;">
	          					
        				</select>
      				</div>
      				
      				<div id="u169">
        				<div id="u170">
        					<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">责任顾问：</span></p>
        				</div>
      				</div>
      				
      				<div id="u171">
        				<select id="dutyAdvister" name="dutyAdvister" class="easyui-combobox" style="width: 114px; height: 25px;">
	          					
        				</select>
      				</div>
      				
      				<div id="u172">
        				<div id="u173">
        					<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">客户关怀：</span></p>
        				</div>
      				</div>
      				
      				<div id="u174">
        				<select id="carer" name="carer" class="easyui-combobox" style="width: 114px; height: 25px;">
	          					
        				</select>
      				</div>
      				
      				<div id="u14">
        				<div id="u15">
          					<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">建档时间：</span></p>
        				</div>
      				</div>
      				<div id="u16">
        				<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="startTime" name="startTime" editable="false" required="true" missingMessage="必填项" data-options="formatter:myformatter, parser:myparser"/>
      				</div>
      				<div id="u17">
        				<div id="u18">
          					<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">至</span></p>
        				</div>
      				</div>
      				<div id="u19">
        				<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="endTime" name="endTime" editable="false" required="true" missingMessage="必填项" data-options="formatter:myformatter, parser:myparser"/>
      				</div>
      				
      				<div id="u20">
      					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn">查询</a>
      				</div>
      				
      				<div id="u21">
      					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
      				</div>
				</div>
			</form>
			
			<div id="toolbar" style="padding: 2px 15px; height: auto">
    			<a href="javascript:void(0)" id="addStudent" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">学员注册</a>
    			<a href="javascript:void(0)" id="updateStudent" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;">修改档案</a>
    			<a href="javascript:void(0)" id="viewStudent" class="easyui-linkbutton" iconCls="icon-redo" style="width: 100px;">浏览</a>
    			<a href="javascript:void(0)" id="addActivity" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">活动奖项</a>
  			</div>
  			
			<div style="padding:5px 0;">
				<table class="easyui-datagrid" title="查询结果" style="width:100%;height:250px" id="list_data" url="<%=path %>/student/qryStudentList.do"  
					toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
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
  		</div>
 	</body>
</html>
