<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<script type="text/javascript" src="<%=path %>/js/exceptionManage/exceptionManage.js"></script>
  	</head>
  	<body>
  	<div id="tt" class="easyui-tabs" style="min-width:1110px;width:98%;height:auto;">
  		<div title="基础信息" style="padding:5px;display:block;">
  			<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="学员基础信息">
  				<table width="100%" cellpadding="5px" class="maintable">
	      			<tr>
	      				<td width="20%" align="right">学员姓名：</td>
	      				<td width="25%" align="left">${obj.studentObj.name}</td>
	      				<td width="20%" align="right">出生日期：</td>
	      				<td width="35%"colspan="3" align="left">${obj.studentObj.birthday}</td>
	      			</tr>
	      			<tr>
	      				<td align="right">性别：</td>
	      				<td align="left">${obj.studentObj.sexVal}</td>
	      				<td align="right">证件号码：</td>
	      				<td colspan="3" align="left">${obj.studentObj.identity}</td>
	      			</tr>
	      			<tr>
	      				<td align="right">英文名：</td>
	      				<td align="left">${obj.studentObj.byName}</td>
	      				<td align="right">家庭地址：</td>
	      				<td colspan="3" align="left">${obj.studentObj.address}</td>
	      			</tr>
	      			<c:forEach items="${obj.realSchoolObj}" var="realSchoolObj">
	      				<tr>
	      					<td width="20%" align='right'>学校类型：</td>
	      					<td width="15%" align="left">${realSchoolObj.schoolTypeText}</td>
	      					<td width="20%" align='right'>学校名称：</td>
	      					<td width="15%" align="left">${realSchoolObj.realSchoolName}</td>
	      					<td width="15%" align='right'>添加时间：</td>
	      					<td width="20%"align="left">${realSchoolObj.createDate}</td>
	      				</tr>
	      			</c:forEach>
	      			<tr>
	      				<td align="right">招生顾问A：</td>
	      				<td align="left">${obj.studentObj.advisterNameA}</td>
	      				<td align="right">招生顾问B：</td>
	      				<td colspan="3" align="left">${obj.studentObj.advisterNameB}</td>
	      			</tr>
	      			<tr>
	      				<td align="right">责任顾问：</td>
	      				<td align="left">${obj.studentObj.dutyAdvisterName}</td>
	      				<td align="right">客户关怀：</td>
	      				<td colspan="3" align="left">${obj.studentObj.carerName}</td>
	      			</tr>
	      			<tr>
	      				<td align="right"><span>学员备注：</span></td>
	      				<td colspan="5" align="left">
	      					<textarea rows="3" cols="100" readonly="readonly" class="easyui-validatebox textbox">${obj.studentObj.remark}</textarea>
	      				</td>
	      			</tr>
	      		</table>
	      	</div>
	      	<div style="height: 10px;"></div>
	      	<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="联系人信息">
			   <table width="100%" cellpadding="5px" class="maintable">
					<tr>
						<td align="center">关系</td>
						<td align="center">姓名</td>
						<td align="center">职业</td>
						<td align="center">常用联系人</td>
						<td align="center">证件号码</td>
						<td align="center">联系电话</td>
					</tr>
					<c:forEach items="${obj.contactObj}" var="contactObj">
						<tr>
							<td align="center">${contactObj.relationTypeVal}</td>
							<td align="center">${contactObj.name}</td>
							<td align="center">${contactObj.job}</td>
							<c:if test="${contactObj.used == 'Y'}">
								<td align="center"><span>√</span></td>
							</c:if>
							<c:if test="${contactObj.used != 'Y'}">
								<td align="center"></td>
							</c:if>
							<td align="center">${contactObj.identity}</td>
							<td align="center">${contactObj.phone}</td>
						</tr>
					</c:forEach>
				</table>
	      	</div>
  		</div>
  	  	<div title="当前异动维护" style="padding:5px;display:block;">
  			<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="常规课">
  				<input type="hidden" id="studentId" value="${obj.courseInfo.studentId}" />
  				<input type="hidden" id="studentCourseId" value="${obj.courseInfo.studentCourseId}" />
  				<input type="hidden" id="expType" value="${expType}" />
  				<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  				<table width="100%" cellpadding="5px" class="maintable">
	      			<tr>
	      				<td width="20%" align="right">课程阶段：</td>
	      				<td width="30%" align="left">${obj.courseInfo.stageId}</td>
	      				<td width="20%" align="right">班级类型：</td>
	      				<td width="30%" align="left">${obj.courseInfo.classType}</td>
	      			</tr>
	      			<tr>
	      				<td align="right">业绩类型：</td>
	      				<td align="left">${obj.courseInfo.feeTypeVal}</td>
	      				<td align="right">业绩顾问：</td>
	      				<td align="left">${obj.courseInfo.adviser}</td>
	      			</tr>
	      			<tr>
	      				<td align="right">缴费日期：</td>
	      				<td align="left">${obj.courseInfo.payDate}</td>
	      				<td align="right">客户关怀：</td>
	      				<td align="left">${obj.courseInfo.carer}</td>
	      			</tr>
	      		</table>
	      	</div>
	      	<div style="height: 10px;"></div>
	      	<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="异动信息">
			   <table width="100%" cellpadding="5px" class="maintable">
			   		<tr id="expTr">
	      				<td width="20%" align="right">异动类型：</td>
	      				<td width="30%" align="left">${expInfo.expTypeVal}</td>
	      				<td width="20%" align="right">异动开始时间：</td>
	      				<td width="30%" align="left">${expInfo.expDate}</td>
	      			</tr>
				</table>
	      	</div>
	      	<div style="height: 10px;"></div>
	      	<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="跟进记录">
			   <table width="100%" cellpadding="5px" class="maintable">
			   		<tr>
	      				<td width="20%" align="right">跟进时间：</td>
	      				<td width="30%" align="left"><input class="easyui-datebox" name="createDate" id="createDate" style="width:120px;" /></td>
	      				<td width="50%" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" style="width:150px; height: 25px;" onclick="viewFollowHis('${obj.courseInfo.studentId}','${expType}','${obj.courseInfo.studentCourseId}')" >查看跟进历史</a></td>
	      			</tr>
	      			<tr>
	      				<td align="right">跟进记录：</td>
	      				<td colspan="2" align="left"><textarea rows="3" cols="100" id="remark" name="remark" class="easyui-validatebox textbox"></textarea></td>
	      			</tr>
				</table>
	      	</div>
	      	<iframe id="dlg" class="easyui-dialog" style="width:800px; height: 420px; padding: 10px 20px" closed="true" modal="true"></iframe>
  			<div style="margin-top: 20px;min-width:1100px; width:99%;">
		      	<div style="float: right;">
		      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:80px; height: 28px;" onclick="addStuExpFollowInfo()">提交</a>
		      	</div>
	 		</div>
  		</div>
  	  	<div title="异动历史" style="padding:5px;display:block;">
  			<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="历史异动信息">
			   <table width="100%" cellpadding="5px" class="maintable">
					<tr>
						<td align="center">维护人</td>
						<td align="center">跟进时间</td>
						<td align="center">异动类型</td>
						<td align="center">跟进记录</td>
					</tr>
					<c:forEach items="${obj.expAllInfo}" var="expAllInfo">
						<tr>
							<td align="center">${expAllInfo.handlerName}</td>
							<td align="center">${expAllInfo.createDate}</td>
							<td align="center">${expAllInfo.exceptionTypeVal}</td>
							<td align="center">${expAllInfo.remark}</td>
						</tr>
					</c:forEach>
				</table>
	      	</div>
	  	</div>
	  </div>
	   <script type="text/javascript">
	   		$(document).ready(function(){
	   			//初始化页面值
	   			var content = "";
	   			var expType = "${expType}";
	   			if(expType == "001"){
	   				
	   			}
   				content += "<tr><td width='20%' align='right'>跟进次数：</td><td width='30%' align='left'>${expInfo.followCount}</td><td width='20%' align='right'>异动时长：</td><td width='30%' align='left'>${expInfo.expedTime}</td></tr>";
	   			$("#expTr").after(content);
	   		});
	   </script>
  	</body>
</html>
