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
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/css/student/addStudent.css">
		<script type="text/javascript" src="<%=path %>/pub/js/jquery.min.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/jquery.cookie.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/easyui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/formvalidator/formValidator.min.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/formvalidator/formValidatorRegex.js"></script>
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
      		
      		<form id="studentFm">
	      		<div class="easyui-panel" style="width:1101px;height:343px;padding:10px;">
	      			<div id="u2">
        				<div id="u3">
          					<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">学员基础信息</span></p>
        				</div>
      				</div>
      				
      				<!-- 学员基础信息的表格 -->
      				<div id="u4">
      					<!-- 学员姓名 -->
      					<div id="u5">
          					<div id="u6">
          						<p><span style="color: red;font-size:14px;">*</span><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">学员姓名：</span></p>
          					</div>
        				</div>
        				<div id="u7">
	            			<input name="name" id="name" type="text" class="easyui-textbox" style="width: 200px; height: 28px;"/>
        				</div>
        				
        				<!-- 出生日期 -->
        				<div id="u9">
          					<div id="u10">
          						<p><span style="color: red;font-size:14px;">*</span><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">出生日期：</span></p>
          					</div>
        				</div>
        				<div id="u11">
        					<input name="birthday" id="birthday" type="text" class="easyui-textbox" style="width: 200px; height: 28px;"/>
        				</div>
        				
        				<!-- 性别 -->
        				<div id="u13">
          					<div id="u14">
          						<p><span style="color: red;font-size:14px;">*</span><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">性别：</span></p>
          					</div>
        				</div>

        				<!-- 证件号码 -->
        				<div id="u17">
          					<div id="u18">
          						<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">证件号码：</span></p>
          					</div>
        				</div>
        				<div id="u19">
        					<select name="identityType" id="identityType" class="easyui-combobox" style="width: 100px; height: 28px;">
        						
        					</select>
        					<input name="identityId" id="identityId" type="text" class="easyui-textbox" style="width: 200px; height: 28px;"/>
        				</div>
        				
        				<!-- 英文名 -->
        				<div id="u21">
          					<div id="u22">
          						<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">英文名：</span></p>
          					</div>
        				</div>
        				<div id="u23">
        					<input name="byName" id="byName" type="text" class="easyui-textbox" style="width: 200px; height: 28px;"/>
        				</div>
        				
        				<!-- 家庭地址 -->
        				<div id="u25">
          					<div id="u26">
            					<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">家庭地址：</span></p>
          					</div>
        				</div>
        				<div id="u27">
        					<input name="address" id="address" type="text" class="easyui-textbox" style="width: 200px; height: 28px;"/>
        				</div>
        				
        				<!-- 就读学校 -->
        				<div id="u29">
          					<div id="u30">
            					<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">就读学校：</span></p>
          					</div>
        				</div>
        				<div id="u31">
        					<input type="hidden" name="schoolRealId" id="schoolRealId"/>
        					<input id="schoolRealName" type="text" editable="false" class="easyui-textbox" style="width: 200px; height: 28px;"/>
        				</div>
        				
        				<!-- 现年级 -->
        				<div id="u33">
          					<div id="u34">
          						<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">现年级：</span></p>
          					</div>
        				</div>
        				<div id="u35">
        					<select id="schoolClassId" name="schoolClassId" class="easyui-combobox" style="width: 200px; height: 28px;">
        						
        					</select>
        				</div>
        				
        				<!-- 报名时间 -->
        				<div id="u37">
          					<div id="u38">
          						<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">报名时间：</span></p>
          					</div>
        				</div>
        				<div id="u39">
        					<input id="schoolRealName" type="text" editable="false" class="easyui-textbox" style="width: 200px; height: 28px;"/>
        				</div>
        				
        				<!-- 录入时间 -->
        				<div id="u41">
          					<div id="u42">
            					<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">录入时间：</span></p>
          					</div>
        				</div>
        				<div id="u43">
          					<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">2015-06-01</span></p>
        				</div>
        				
        				<!-- 招生顾问A -->
        				<div id="u45">
          					<div id="u46">
          						<p><span style="color: red;font-size:14px;">*</span><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">招生顾问A：</span></p>
          					</div>
        				</div>
        				<div id="u47">
        					<select name="schoolId" id="schoolId" class="easyui-combobox" style="width: 100px; height: 28px;">
        						
        					</select>
        					<select name="advisterIdA" id="advisterIdA" class="easyui-combobox" style="width: 150px; height: 28px;">
        						
        					</select>
        				</div>
        				
        				<!-- 招生顾问B -->
        				<div id="u49">
          					<div id="u50">
            					<p><span style="color: red;font-size:14px;">*</span><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">招生顾问B：</span></p>
          					</div>
        				</div>
        				<div id="u51">
        					<select name="schoolId" id="schoolId" class="easyui-combobox" style="width: 100px; height: 28px;">
        						
        					</select>
        					<select name="advisterIdB" id="advisterIdB" class="easyui-combobox" style="width: 150px; height: 28px;">
        						
        					</select>
        				</div>
        				
        				<!-- 责任顾问 -->
        				<div id="u53">
          					<div id="u54">
          						<p><span style="color: red;font-size:14px;">*</span><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">责任顾问：</span></p>
          					</div>
        				</div>
        				<div id="u55">
        					<select name="dutyAdvister" id="dutyAdvister" class="easyui-combobox" style="width: 150px; height: 28px;">
        						
        					</select>
        				</div>
        				
        				<!-- 客户关怀 -->
        				<div id="u57">
          					<div id="u58">
          						<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">客户关怀：</span></p>
          					</div>
        				</div>
        				<div id="u59">
        					<select name="carer" id="carer" class="easyui-combobox" style="width: 150px; height: 28px;">
        						
        					</select>
        				</div>
      				</div>
      				
      				<!-- 男女单选按钮 -->
      				<div id="u65">
        				<label for="u65_input">
          					<div id="u66">
            					<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">男</span></p>
          					</div>
        				</label>
        				<input id="u65_input" type="radio" value="1" name="sex"/>
      				</div>
      				<div id="u67">
        				<label for="u67_input">
          					<div id="u68" class="text">
            					<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">女</span></p>
          					</div>
        				</label>
        				<input id="u67_input" type="radio" value="0" name="sex"/>
      				</div>
      				
      				<!-- 学员备注 -->
      				<div id="u164">
        				<div id="u165">
          					<div id="u166" class="text">
          						<p><span style="font-family:Arial,微软雅黑,宋体;font-size:14px;">学员备注：</span></p>
          					</div>
        				</div>
        				<div id="u167">
         					<input id="remark" name="remark" type="text" editable="false" class="easyui-textbox" style="width: 969px; height: 28px;"/>
        				</div>
      				</div>
      				
      				<div id="u72">
      					<a href="javascript:void(0)" id="addStudent" class="easyui-linkbutton" style="width: 80px; height: 28px;">验重</a>
      				</div>
      				
      				<div id="u170">
      					<a href="javascript:void(0)" id="addStudent" class="easyui-linkbutton" style="width: 100px; height: 28px;">添加学校</a>
      				</div>
	      		</div>
      		</form>
      		
      		<form id="contactFm">
      			<div class="easyui-panel" style="width:1101px;height:200px;">
			      	<table class="easyui-datagrid" title="联系人信息" style="width:100%;height:auto;" id="add_contact" fitColumns="true">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th data-options="field:'relationType',width:80,align:'center'">关系</th>
								<th data-options="field:'name',width:100,align:'center'">姓名</th>
								<th data-options="field:'job',width:150,align:'center'">职业</th>
								<th data-options="field:'used',width:100,align:'center'">常用联系人</th>
								<th data-options="field:'identityType',width:150,align:'center'">证件类型</th>
								<th data-options="field:'identityId',width:250,align:'center'">证件号码</th>
								<th data-options="field:'phone',width:200,align:'center'">联系电话</th>
								<th data-options="field:'option',width:100,align:'center'">操作</th>
							</tr>
						</thead>
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th data-options="field:'relationType',width:80,align:'center',editor:'combobox'"></th>
								<th data-options="field:'name',width:100,align:'center',editor:'textbox'"></th>
								<th data-options="field:'job',width:150,align:'center',editor:'textbox'"></th>
								<th data-options="field:'used',checkbox:true, width:100,align:'center'"></th>
								<th data-options="field:'identityType',width:150,align:'center',editor:'combobox'"></th>
								<th data-options="field:'identityId',width:250,align:'center',editor:'textbox'"></th>
								<th data-options="field:'phone',width:200,align:'center',editor:'textbox'"></th>
								<th data-options="field:'option',width:100,align:'center'"></th>
							</tr>
						</thead>
					</table>
      			</div>
      		</form>
      		
	      	
	      	<div style="margin-top: 50px;">
		      	<div id="u148">
	      			<a href="javascript:void(0)" id="addStudent" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      		</div>
	
	      		<div id="u149">
	      			<a href="javascript:void(0)" id="addStudent" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;">返回</a>
	      		</div>
	      	</div>
  		</div>
  	</body>
</html>
