<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/baseChange/change.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:98%;height:auto;" title="基数调整">
  			<form id="baseNumFm">
  				<input type="hidden" id="handlerId" value="${sessionScope.StaffT.staffId}"/>
  				<input type="hidden" id="classInstId" value="${obj.attendClassObj.classInstId }"/>
  				<div class="easyui-panel" style="min-width:1100px; width:100%; height:auto;">
	  				<table width="100%" cellpadding="5px" class="maintable">
	  					<tr>
		  					<td align="right" width="10%"><span>课程阶段：</span></td>
		  					<td width="20%"><span>${obj.attendClassObj.stageId }</span></td>
		  					<td align="right" width="10%"><span>班级类型：</span></td>
		  					<td width="20%"><span>${obj.attendClassObj.classType }</span></td>
		  					<td align="right" width="10%"><span>班级名称：</span></td>
		  					<td width="30%"><span>${obj.attendClassObj.className }</span></td>
		  				</tr>
		  				<tr>
		  					<td align="right" width="10%"><span>结课日期：</span></td>
		  					<td width="20%"><span>${obj.attendClassObj.finishDate }</span></td>
		  					<td align="right" width="10%"><span>学员来源类型：</span></td>
		  					<td width="20%"><span>${obj.attendClassObj.studentChannelTypeText }</span></td>
		  					<td align="right" width="10%"><span>来源班级：</span></td>
		  					<td width="30%"><span>${obj.attendClassObj.higherSchoolName }</span></td>
		  				</tr>
		  				<tr>
		  					<td align="right" width="10%"><span>开课日期：</span></td>
		  					<td width="20%"><span>${obj.attendClassObj.startDate }</span></td>
		  					<td align="right" width="10%"><span>开班类型：</span></td>
		  					<td width="20%"><span>${obj.attendClassObj.openClassTypeText }</span></td>
		  					<td align="right" width="10%"><span>开班人数：</span></td>
		  					<td width="30%"><span>${obj.attendClassObj.openClassNum }</span></td>
		  				</tr>
		  				<tr>
		  					<td align="right" width="10%"><span>在读人数：</span></td>
		  					<td width="20%"><span>${obj.attendClassObj.classStudentNum }</span></td>
		  					<td align="right" width="10%"><span>已升学人数：</span></td>
		  					<td width="20%"><span>${obj.attendClassObj.higherStudentNum }</span></td>
		  					<td align="right" width="10%"><span>升学率：</span></td>
		  					<td width="30%"><span>${obj.attendClassObj.higherRateText }</span></td>
		  				</tr>
		  				<tr>
		  					<td align="right" width="10%"><span>课时进度：</span></td>
		  					<td width="20%"><span>${obj.attendClassObj.classProgress }</span></td>
		  					<td align="right" width="10%"><span>持证率：</span></td>
		  					<td width="20%"><span>${obj.attendClassObj.licenseRateText }</span></td>
		  					<td align="right" width="10%"><span>班级性质： </span></td>
		  					<td width="30%"><span>${obj.attendClassObj.handTypeText }</span></td>
		  				</tr>
		  				<tr>
	  						<td colspan="6" align="right">
		  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
			      				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  						</td>
	  					</tr>
	  				</table>
			  		<div style="height: 5px;"></div>
			  		<div style="padding:5px 0;min-width:1100px; width:100%;">
			  			<table class="easyui-datagrid" title="班级学员基数" style="height:auto;" id="list_data" fitColumns="true" singleSelect="false"
			  				url="<%=path %>/pubData/qryDataListByPage.do?param={'classInstId':'${obj.attendClassObj.classInstId }','funcNodeId':'1085'}"
			  				autoRowHeight="true" data-options="onLoadSuccess:function(data) {$('.edit').linkbutton({text:'修改基数', iconCls:'icon-edit'});},rowStyler:function(){return 'height: 32px';}">
					  		<thead>
					  			<tr>
					  				<th data-options="field:'name',width:80,align:'center'">学员姓名</th>
					  				<th data-options="field:'byName',width:80,align:'center'">英文名</th>
					  				<th data-options="field:'payDate',width:100,align:'center'">缴费日期</th>
					  				<th data-options="field:'attendDate',width:100,align:'center'">进班上课日期</th>
					  				<th data-options="field:'phone',width:180,align:'center'">联系方式</th>
					  				<th data-options="field:'courseStateText',width:80,align:'center'">课程状态</th>
					  				<th data-options="field:'className',width:100,align:'center'">在读班级</th>
					  				<th data-options="field:'isChange',width:100,align:'center'">是否当前班级</th>
					  				<th data-options="field:'higherStageId',width:100,align:'center'">已升学阶段</th>
					  				<th data-options="field:'studyingNum',width:80,align:'center'">在读人数</th>
					  				<th data-options="field:'higherBaseNum',width:80,align:'center'">升学基数</th>
					  				<th data-options="field:'higherNum',width:80,align:'center'">已升学人数</th>
					  				<th data-options="field:'option', width:140, align:'center', formatter:formatChangeBaseNum">操作</th>
					  			</tr>
					  		</thead>
					  	</table>
			  		</div>
  				</div>
  			</form>
  		</div>
  		
  		<div id="dlg" class="easyui-dialog" style="width: 600px;height: 300px;" closed="true" data-options="modal:true" buttons="#dlgBtn">
  			<form id="baseNumStudentFm" method="post">
  				<input type="hidden" id="baseNumId" name="baseNumId"/>
  				<input type="hidden" id="studentId" name="studentId"/>
  				<input type="hidden" id="studentCourseId" name="studentCourseId"/>
  				<input type="hidden" id="baseNumStudentId" name="baseNumStudentId"/>
  				<input type="hidden" id="originStudentHigherNum" name="originStudentHigherNum"/>
  				<input type="hidden" id="originStudentStudyingNum" name="originStudentStudyingNum"/>
  				<input type="hidden" id="originStudentHigherBaseNum" name="originStudentHigherBaseNum"/>
  				<table width="100%" cellpadding="5px" class="maintable">
  					<tr>
	  					<td align="right" width="15%"><span>学员姓名：</span></td>
	  					<td width="20%"><span id="name"></span></td>
	  					<td align="right" width="20%"><span>英文名：</span></td>
	  					<td width="40%"><span id="byName"></span></td>
  					</tr>
  					<tr>
	  					<td align="right" width="15%"><span>在读人数：</span></td>
	  					<td width="20%"><span id="studyingNumText"></span></td>
	  					<td align="right" width="25%"><span>在读人数调整为：</span></td>
	  					<td width="40%">
	  						<input id="studentStudyingNum" name="studentStudyingNum" type="text" class="easyui-numberbox validatebox" data-options="min:0,max:1,precision:0" required="true" style="width: 100px; height: 25px;"/>
	  					</td>
  					</tr>
  					<tr>
	  					<td align="right" width="15%"><span>升学基数：</span></td>
	  					<td width="20%"><span id="higherBaseNumText"></span></td>
	  					<td align="right" width="25%"><span>升学基数调整为：</span></td>
	  					<td width="40%">
	  						<input id="studentHigherBaseNum" name="studentHigherBaseNum" type="text" class="easyui-numberbox validatebox" data-options="min:0,max:1,precision:0" required="true" style="width: 100px; height: 25px;"/>
	  					</td>
  					</tr>
  					<tr>
	  					<td align="right" width="15%"><span>已升学人数：</span></td>
	  					<td width="20%"><span id="higherNumText"></span></td>
	  					<td align="right" width="25%"><span>已升学人数调整为：</span></td>
	  					<td width="40%"><input id="studentHigherNum" name="studentHigherNum" type="text" class="easyui-numberbox validatebox" data-options="min:0,max:1,precision:0" required="true" style="width: 100px; height: 25px;"/></td>
  					</tr>
  				</table>
  			</form>
  		</div>
  		<div id="dlgBtn">
    		<a href="javascript:void(0)" id="changeStudentNumBtn" class="easyui-linkbutton" iconCls="icon-ok">提交</a> 
    		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
  		</div>
  	</body>
</html>