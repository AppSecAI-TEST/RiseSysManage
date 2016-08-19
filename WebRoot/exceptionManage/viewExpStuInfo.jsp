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
		<script type="text/javascript" src="<%=path %>/js/exceptionManage/exceptionManage.js"></script>
  	</head>
  	<body>
  	<div id="tt" class="easyui-tabs" style="min-width:1110px;width:99%;overflow:auto;height:auto;">
  		<div title="基础信息" style="padding:5px;display:block;">
  			<div class="easyui-panel" style="min-width:1100px; width:100%;height:auto;" title="学员基础信息">
  				<table width="100%" cellpadding="5px" class="maintable">
	      			<tr>
	      				<td width="20%" align="right"><span>学员姓名：</span></td>
	      				<td width="25%" align="left"><span>${obj.studentObj.name}</span></td>
	      				<td width="20%" align="right"><span>出生日期：</span></td>
	      				<td width="35%"colspan="3" align="left"><span>${obj.studentObj.birthday}</span></td>
	      			</tr>
	      			<tr>
	      				<td align="right"><span>性别：</span></td>
	      				<td align="left"><span>${obj.studentObj.sexVal}</span></td>
	      				<td align="right"><span>证件号码：</span></td>
	      				<td colspan="3" align="left"><span>${obj.studentObj.identity}</span></td>
	      			</tr>
	      			<tr>
	      				<td align="right"><span>英文名：</span></td>
	      				<td align="left"><span>${obj.studentObj.byName}</span></td>
	      				<td align="right"><span>家庭地址：</span></td>
	      				<td colspan="3" align="left"><span>${obj.studentObj.address}</span></td>
	      			</tr>
	      			<c:forEach items="${obj.realSchoolObj}" var="realSchoolObj">
	      				<tr>
	      					<td width="20%" align='right'><span>学校类型：</span></td>
	      					<td width="15%" align="left"><span>${realSchoolObj.schoolTypeText}</span></td>
	      					<td width="20%" align='right'><span>学校名称：</span></td>
	      					<td width="15%" align="left"><span>${realSchoolObj.realSchoolName}</span></td>
	      					<td width="15%" align='right'><span>添加时间：</span></td>
	      					<td width="20%"align="left"><span>${realSchoolObj.createDate}</span></td>
	      				</tr>
	      			</c:forEach>
	      			<tr>
	      				<td align="right" width="100px"><span>建档日期：</span></td>
		      			<td><span>${obj.studentObj.entranceDate}</span></td>
		  				<td align="right" width="100px"><span>录入时间：</span></td>
		  				<td colspan="3"><span>${obj.studentObj.createDate}</span></td>
	      			</tr>
	      			<tr>
	      				<td align="right"><span>招生顾问A：</span></td>
	      				<td align="left"><span>${obj.studentObj.advisterNameA}</span></td>
	      				<td align="right"><span>招生顾问B：</span></td>
	      				<td colspan="3" align="left"><span>${obj.studentObj.advisterNameB}</span></td>
	      			</tr>
	      			<tr>
	      				<td align="right"><span>责任顾问：</span></td>
	      				<td align="left"><span>${obj.studentObj.dutyAdvisterName}</span></td>
	      				<td align="right"><span>客户关怀：</span></td>
	      				<td colspan="3" align="left"><span>${obj.studentObj.carerName}</span></td>
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
	      	<div class="easyui-panel" style="min-width:1100px; width:100%;height:auto;" title="联系人信息">
			   <table width="100%" cellpadding="5px" class="maintable">
					<tr>
						<td align="center"><span>关系</span></td>
						<td align="center"><span>姓名</span></td>
						<td align="center"><span>职业</span></td>
						<td align="center"><span>常用联系人</span></td>
						<td align="center"><span>证件号码</span></td>
						<td align="center"><span>联系电话</span></td>
					</tr>
					<c:forEach items="${obj.contactObj}" var="contactObj">
						<tr>
							<td align="center"><span>${contactObj.relationTypeVal}</span></td>
							<td align="center"><span>${contactObj.name}</span></td>
							<td align="center"><span>${contactObj.job}</span></td>
							<c:if test="${contactObj.used == 'Y'}">
								<td align="center"><span>√</span></td>
							</c:if>
							<c:if test="${contactObj.used != 'Y'}">
								<td align="center"></td>
							</c:if>
							<td align="center"><span>${contactObj.identity}</span></td>
							<td align="center"><span>${contactObj.phone}</span></td>
						</tr>
					</c:forEach>
				</table>
	      	</div>
  		</div>
  	  	<div title="当前异动维护" style="padding:5px;display:block;">
  			<div class="easyui-panel" style="min-width:1100px; width:100%;height:auto;" title="常规课">
  				<input type="hidden" id="studentId" value="${obj.courseInfo.studentId}" />
  				<input type="hidden" id="studentCourseId" value="${obj.courseInfo.studentCourseId}" />
  				<input type="hidden" id="expType" value="${expType}" />
  				<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  				<table width="100%" cellpadding="5px" class="maintable">
	      			<tr>
	      				<td width="20%" align="right"><span>课程阶段：</span></td>
	      				<td width="30%" align="left"><span>${obj.courseInfo.stageId}</span></td>
	      				<td width="20%" align="right"><span>班级类型：</span></td>
	      				<td width="30%" align="left"><span>${obj.courseInfo.classType}</span></td>
	      			</tr>
	      			<tr>
	      				<td align="right"><span>业绩类型：</span></td>
	      				<td align="left"><span>${obj.courseInfo.feeTypeVal}</span></td>
	      				<td align="right"><span>业绩顾问：</span></td>
	      				<td align="left"><span>${obj.courseInfo.adviser}</span></td>
	      			</tr>
	      			<tr>
	      				<td align="right"><span>缴费日期：</span></td>
	      				<td align="left"><span>${obj.courseInfo.payDate}</span></td>
	      				<td align="right"><span>客户关怀：</span></td>
	      				<td align="left"><span>${obj.courseInfo.carer}</span></td>
	      			</tr>
	      		</table>
	      	</div>
	      	<div style="height: 10px;"></div>
	      	<div class="easyui-panel" style="min-width:1100px; width:100%;height:auto;" title="异动信息">
			   <table width="100%" cellpadding="5px" class="maintable">
			   		<tr id="expTr">
	      				<td width="20%" align="right"><span>异动类型：</span></td>
	      				<td width="30%" align="left"><span>${expInfo.expTypeVal}</span></td>
	      				<td width="20%" align="right"><span>异动开始时间：</span></td>
	      				<td width="30%" align="left"><span>${expInfo.expDate}</span></td>
	      			</tr>
				</table>
	      	</div>
	      	<div style="height: 10px;"></div>
	      	<div class="easyui-panel" style="min-width:1100px; width:100%;height:auto;" title="跟进记录">
			   <table width="100%" cellpadding="5px" class="maintable">
			   		<tr>
	      				<td width="20%" align="right"><span>跟进时间：</span></td>
	      				<td width="30%" align="left"><input class="easyui-datebox" name="createDate" id="createDate" style="width:120px;" /></td>
	      				<td width="50%" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" style="width:150px; height: 25px;" onclick="viewFollowHis('${obj.courseInfo.studentId}','${expType}','${obj.courseInfo.studentCourseId}')" >查看跟进历史</a></td>
	      			</tr>
	      			<tr>
	      				<td align="right"><span>跟进记录：</span></td>
	      				<td colspan="2" align="left"><textarea rows="3" cols="100" id="remark" name="remark" class="easyui-validatebox textbox"></textarea></td>
	      			</tr>
				</table>
	      	</div>
	      	<iframe id="dlg" class="easyui-dialog" style="width:750px; height: 400px;" closed="true" modal="true"></iframe>
  			<div style="margin-top: 5px;min-width:1100px; width:100%;">
		      	<div style="text-align:right">
		      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="addStuExpFollowInfo()"><span>提交</span></a>
		      		&nbsp;
		      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
		      	</div>
	 		</div>
  		</div>
  	  	<div title="异动历史" style="padding:5px;display:block;">
  			<div class="easyui-panel" style="min-width:1100px; width:100%;height:auto;" title="历史异动信息">
			   <table width="100%" cellpadding="5px" class="maintable">
					<tr>
						<td align="center"><span>维护人</span></td>
						<td align="center"><span>跟进时间</span></td>
						<td align="center"><span>异动类型</span></td>
						<td align="center"><span>跟进记录</span></td>
					</tr>
					<c:forEach items="${obj.expAllInfo}" var="expAllInfo">
						<tr>
							<td align="center"><span>${expAllInfo.handlerName}</span></td>
							<td align="center"><span>${expAllInfo.createDate}</span></td>
							<td align="center"><span>${expAllInfo.exceptionTypeVal}</span></td>
							<td align="center"><span>${expAllInfo.remark}</span></td>
						</tr>
					</c:forEach>
				</table>
	      	</div>
	  	</div>
	  </div>
	   <script type="text/javascript">
	   		$(document).ready(function(){
				ajaxLoadEnd();
	   			//初始化页面值
	   			var content = "";
	   			var expType = "${expType}";
	   			if(expType == "new_not_in_class"){
	   				content += "<tr><td width='20%' align='right'><span>所属校区：</span></td><td width='30%' align='left'><span>${obj.expInfo.schoolName}</span></td><td width='20%' align='right'><span>定班次数：</span></td><td width='30%' align='left'><span>${obj.expInfo.classCount}</span></td></tr>";
	   				content += "<tr><td width='20%' align='right'><span>最新定班班级：</span></td><td width='30%' align='left'><span>${obj.expInfo.className}</span></td><td width='20%' align='right'><span>课程状态：</span></td><td width='30%' align='left'><span>${obj.expInfo.courseStateVal}</span></td></tr>";
	   				content += "<tr><td width='20%' align='right'><span>带班老师：</span></td><td width='30%' align='left'><span>${obj.expInfo.teacherNames}</span></td><td width='20%' align='right'></td><td width='30%' align='left'></td></tr>";
	   			}
	   			if(expType == "higher_not_in_class" || expType == "reread_not_in_class"){
	   				content += "<tr><td width='20%' align='right'><span>所属校区：</span></td><td width='30%' align='left'><span>${obj.expInfo.schoolName}</span></td><td width='20%' align='right'><span>定班次数：</span></td><td width='30%' align='left'><span>${obj.expInfo.classCount}</span></td></tr>";
	   				content += "<tr><td width='20%' align='right'><span>最新定班班级：</span></td><td width='30%' align='left'><span>${obj.expInfo.className}</span></td><td width='20%' align='right'><span>课程状态：</span></td><td width='30%' align='left'><span>${obj.expInfo.courseStateVal}</span></td></tr>";
	   				content += "<tr><td width='20%' align='right'><span>已完成课程：</span></td><td width='30%' align='left'><span>${obj.expInfo.readStageIds}</span></td><td width='20%' align='right'><span>缴费未读课程：</span></td><td width='30%' align='left'><span>${obj.expInfo.notReadStageIds}</span></td></tr>";
	   				content += "<tr><td width='20%' align='right'><span>带班老师：</span></td><td width='30%' align='left'><span>${obj.expInfo.teacherNames}</span></td><td width='20%' align='right'></td><td width='30%' align='left'></td></tr>";
	   			}
	   			if(expType == "new_not_in_change_school" || expType == "higher_not_in_change_school" || expType == "reread_not_in_change_school" || expType == "study_change_school"){
	   				content += "<tr><td width='20%' align='right'><span>转出校区：</span></td><td width='30%' align='left'><span>${obj.expInfo.outSchoolName}</span></td><td width='20%' align='right'><span>转入校区：</span></td><td width='30%' align='left'><span>${obj.expInfo.inSchoolName}</span></td></tr>";
	   				content += "<tr><td width='20%' align='right'><span>转出班级：</span></td><td width='30%' align='left'><span>${obj.expInfo.outClassName}</span></td><td width='20%' align='right'><span>转入班级：</span></td><td width='30%' align='left'><span>${obj.expInfo.inClassName}</span></td></tr>";
	   				content += "<tr><td width='20%' align='right'><span>转出时间：</span></td><td width='30%' align='left'><span>${obj.expInfo.outDate}</span></td><td width='20%' align='right'><span>转入时间：</span></td><td width='30%' align='left'><span>${obj.expInfo.inDate}</span></td></tr>";
	   				content += "<tr><td width='20%' align='right'><span>课程状态：</span></td><td width='30%' align='left'><span>${obj.expInfo.courseStateText}</span></td><td width='20%' align='right'><span>课程进度：</span></td><td width='30%' align='left'><span>${obj.expInfo.outClassProgress}</span></td></tr>";
	   				content += "<tr><td width='20%' align='right'><span>带班老师：</span></td><td width='30%' align='left'><span>${obj.expInfo.outClassTeacherName}</span></td><td width='20%' align='right'></td><td width='30%' align='left'></td></tr>";
	   			}
	   			if(expType == "study_change_class"){
	   				content += "<tr><td width='20%' align='right'><span>转出班级：</span></td><td width='30%' align='left'><span>${obj.expInfo.outClassName}</span></td><td width='20%' align='right'><span>转入班级：</span></td><td width='30%' align='left'><span>${obj.expInfo.inClassName}</span></td></tr>";
	   				content += "<tr><td width='20%' align='right'><span>转出时间：</span></td><td width='30%' align='left'><span>${obj.expInfo.outDate}</span></td><td width='20%' align='right'><span>转入时间：</span></td><td width='30%' align='left'><span>${obj.expInfo.inDate}</span></td></tr>";
	   				content += "<tr><td width='20%' align='right'><span>课程状态：</span></td><td width='30%' align='left'><span>${obj.expInfo.courseStateText}</span></td><td width='20%' align='right'><span>课程进度：</span></td><td width='30%' align='left'><span>${obj.expInfo.outClassProgress}</span></td></tr>";
	   				content += "<tr><td width='20%' align='right'><span>带班老师：</span></td><td width='30%' align='left'><span>${obj.expInfo.outClassTeacherName}</span></td><td width='20%' align='right'></td><td width='30%' align='left'></td></tr>";
	   			}
	   			if(expType == "exception"){
	   				content += "<tr><td width='20%' align='right'><span>课程状态：</span></td><td width='30%' align='left'><span>${obj.expInfo.courseStateVal}</span></td><td width='20%' align='right'><span>课程进度：</span></td><td width='30%' align='left'><span>${obj.expInfo.hours}</span></td></tr>";
	   				content += "<tr><td width='20%' align='right'><span>带班老师：</span></td><td width='30%' align='left'><span>${obj.expInfo.teacherName}</span></td><td width='20%' align='right'><span>异常原因：</span></td><td width='30%' align='left'><span>${obj.expInfo.remark}</span></td></tr>";
	   			}
	   			if(expType == "leave"){
	   				content += "<tr><td width='20%' align='right'><span>就读班级：</span></td><td width='30%' align='left'><span>${obj.expInfo.orignClassName}</span></td><td width='20%' align='right'><span>休学时间：</span></td><td width='30%' align='left'><span>${obj.expInfo.createDate}</span></td></tr>";
	   				content += "<tr><td width='20%' align='right'><span>休学时长：</span></td><td width='30%' align='left'><span>${obj.expInfo.leaveTime}个月</span></td><td width='20%' align='right'><span>课程进度：</span></td><td width='30%' align='left'><span>${obj.expInfo.hours}</span></td></tr>";
	   				content += "<tr><td width='20%' align='right'><span>带班老师：</span></td><td width='30%' align='left'><span>${obj.expInfo.teacherNames}</span></td><td width='20%' align='right'><span>休学原因：</span></td><td width='30%' align='left'><span>${obj.expInfo.leaveReason}</span></td></tr>";
	   			}
   				content += "<tr><td width='20%' align='right'><span>跟进次数：</span></td><td width='30%' align='left'><span>${expInfo.followCount}</span></td><td width='20%' align='right'><span>异动时长：</span></td><td width='30%' align='left'><span>${expInfo.expedTime}</span></td></tr>";
	   			$("#expTr").after(content);
	   		});
	   </script>
  	</body>
</html>
