<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/classInstDetail.js"></script>
  	</head>
  
  	<body>
  		<div style="padding:5px 0;">
  			<form id="qryFm" style="margin:0 auto;">
	  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:80px;" cellspacing="2">
	  				<tr>
	  					<td align="right" width="100px"><span>校区：</span></td>
	  					<td width="130px">
							<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 130px; height: 25px;">
				        	</select>
						</td>
						<td align="right" width="100px"><span>课程阶段：</span></td>
	  					<td width="130px">
							<select id="stageId" name="stageId" class="easyui-combobox" style="width: 130px; height: 25px;">
				        	</select>
						</td>
						<td align="right" width="60px"><span>班级：</span></td>
	  					<td width="130px">
							<select id="classInstId" name="classInstId" class="easyui-combobox" style="width: 130px; height: 25px;">
				        	</select>
						</td>
						<td align="right" width="100px"><span>班级状态：</span></td>
						<td width="114px">
							<select id="classState" name="classState" class="easyui-combobox" style="width: 114px; height: 25px;"
								data-options="formatter:formatStageId, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
			      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=CLASS_STATE&codeFlag='003','004'">
				        	</select>
						</td>
						<td width="150px">&nbsp;</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="100px"><span>带班老师：</span></td>
	  					<td width="130px">
	  						<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 130px; height: 25px;">
	  						</select>
	  					</td>
	  					<td align="right" width="100px"><span>班级性质：</span></td>
	  					<td width="130px">
	  						<input type="checkbox" name="handType" value="'1'"/>&nbsp;<span>一手班</span>
							&nbsp;&nbsp;<input type="checkbox" name="handType" value="'2'"/>&nbsp;<span>二手班</span>
	  					</td>
	  					<td align="right" width="60px"><span>年度：</span></td>
						<td width="130px" colspan="4">
							<input class="easyui-datebox" type="text" style="width:130px; height: 25px;" id="year" name="year" data-options="formatter:yearFormatter, parser:yearParser"/>
						</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="100px"><span>开班人数：</span></td>
	  					<td width="130px">
							<input name="minOpenNum" id="minOpenNum" type="text" class="easyui-numberbox" style="width: 53px; height: 25px;"/>
							<span style="display: inline-block; text-align: center; width: 14px;">至</span>
							<input name="maxOpenNum" id="maxOpenNum" type="text" class="easyui-numberbox" style="width: 53px; height: 25px;"/>
						</td>
						<td align="right" width="100px"><span>在读人数：</span></td>
	  					<td width="130px">
							<input name="minStudyNum" id="minStudyNum" type="text" class="easyui-numberbox" style="width: 53px; height: 25px;"/>
							<span style="display: inline-block; text-align: center; width: 14px;">至</span>
							<input name="maxStudyNum" id="maxStudyNum" type="text" class="easyui-numberbox" style="width: 53px; height: 25px;"/>
						</td>
						<td align="right" width="60px"><span>升学率：</span></td>
						<td width="130px">
							<input name="minHigherRate" id="minHigherRate" type="text" class="easyui-numberbox" style="width: 39px; height: 25px;" data-options="min:0, max:100, precision:0"/>
							<span style="display: inline-block; text-align: center; width: 32px;">%&nbsp;至&nbsp;</span>
							<input name="maxHigherRate" id="maxHigherRate" type="text" class="easyui-numberbox" style="width: 39px; height: 25px;" data-options="min:0, max:100, precision:0"/>
							<span style="display: inline-block; text-align: center; width: 3px;">%</span>
						</td>
						<td colspan="2" width="214px" align="center">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1064">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
						<td width="150px">&nbsp;</td>
	  				</tr>
	  			</table>
  			</form>
			<div style="padding:5px 0;min-width:1100px; width:100%;">
				<table class="easyui-datagrid" style="height:auto;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th field="quarterText" align="center" width="5%">季度</th>
							<th field="seq" align="center" width="5%">序号</th>
							<th field="className" align="center" width="5%">结课班级</th>
							<th field="licenseRateText" align="center" width="6%">班级持证率</th>
							<th field="teacherName" align="center" width="8%">带班老师</th>
							<th field="finishMonth" align="center" width="5%">结课月</th>
							<th field="openClassNum" align="center" width="6%">开班人数</th>
							<th field="inSchoolNum" align="center" width="6%">转校转入</th>
							<th field="outSchoolNum" align="center" width="6%">转校转出</th>
							<th field="inClassNum" align="center" width="6%">转入转班</th>
							<th field="outClassNum" align="center" width="6%">转出转班</th>
							<th field="exceptionNum" align="center" width="5%">异常</th>
							<th field="leaveNum" align="center" width="5%">休学</th>
							<th field="lower12Refund" align="center" width="8%">12课时内退学</th>
							<th field="above12Refund" align="center" width="8%">12课时后退学</th>
							<th field="studyingNum" align="center" width="6%">在读人数</th>
							<th field="higherBaseNum" align="center" width="7%">升学率基数</th>
							<th field="higherNum" align="center" width="7%">已升学基数</th>
							<th field="higherRate" align="center" width="7%">当前升学率</th>
							<th field="90RateNum" align="center" width="9%">距90%升学缺口</th>
							<th field="handTypeText" align="center" width="6%">班级性质</th>
							<th field="changeRemark" align="center" width="15%">更换老师情况</th>
						</tr>
					</thead>
				</table>
			</div>
			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
			</div>
  		</div>
  	</body>
</html>
