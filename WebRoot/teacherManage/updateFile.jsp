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
		<script type="text/javascript" src="<%=path %>/js/teacherManage/teacherManage.js"></script>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="教师档案信息">
  		<form id="updateFm">	
  			<table width="100%" cellpadding="5px" class="maintable" id="teacherTd">
  				<input type="hidden" id="teacherId" value="${obj.teacherId}" />
  				<tr>
  					<td align="right"><span>校区：</span></td>
  					<td align="left">${obj.schoolName}</td>
  					<td align="right"><span>教师姓名：</span></td>
  					<td align="left">${obj.teacherName}</td>
  					<td align="right"><span>英文名：</span></td>
  					<td align="left"><input class="easyui-textbox" name="byName" id="byName" style="width:125px;" required="true"/></td>
  				</tr>
  				<tr>
  					<td align="right"><span>联系电话：</span></td>
  					<td align="left"><input class="easyui-numberbox" name="phone" id="phone" validType="length[0,11]" invalidMessage="不能超过11个字符！" style="width:125px;" required="true"/></td>
  					<td align="right"><span>入职日期：</span></td>
  					<td align="left">${obj.joinDate}</td>
  					<td align="right"><span>入职时长（月）：</span></td>
  					<td align="left">${obj.joinTime}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>教师状态：</span></td>
  					<td align="left">${obj.stateVal}</td>
  					<td align="right"><span>职务：</span></td>
  					<td align="left">${obj.postVal}</td>
  					<td align="right"><span>国籍：</span></td>
  					<td align="left">${obj.nationality}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>持证情况：</span></td>
  					<c:if test="${obj.licenses == ''}">
  						<td align="left">无</td>
  					</c:if>
  					<c:if test="${obj.licenses != ''}">
	  					<td align="left">${obj.licenses}</td>
  					</c:if>
  					<td align="right"><span>持证数量：</span></td>
  					<td align="left">${licenseNum}</td>
  					<td align="right"><span>在读带班班级：</span></td>
  					<c:if test="${obj.classNames == ''}">
  						<td align="left">无</td>
  					</c:if>
  					<c:if test="${obj.classNames != ''}">
	  					<td align="left">${obj.classNames}</td>
  					</c:if>
  				</tr>
  				<tr>
  					<td align="right"><span>在读带班阶段：</span></td>
  					<c:if test="${obj.stageIds == ''}">
  						<td align="left">无</td>
  					</c:if>
  					<c:if test="${obj.stageIds != ''}">
	  					<td align="left">${obj.stageIds}</td>
  					</c:if>
  					<td align="right"><span>待培训阶段：</span></td>
  					<c:if test="${obj.trainingStageIds == ''}">
  						<td align="left">无</td>
  					</c:if>
  					<c:if test="${obj.trainingStageIds != ''}">
	  					<td align="left">${obj.trainingStageIds}</td>
  					</c:if>
  					<td align="right"><span>在读带班持证率：</span></td>
  					<td align="left">${rate}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>年级组：</span></td>
  					<td align="left"><select id="gradeTeam" style="width:125px;" required="true"></select></td>
  					<td></td>
  					<td></td>
  					<td></td>
  					<td></td>
  				</tr>
  			</table>
  			</form>
  		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="text-align:center">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="updateFileSubmit()"><span>提交</span></a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
	   <script type="text/javascript">
	   		$(document).ready(function(){
	   			//初始化页面值
	   			$("#byName").textbox('setValue','${obj.byname}');
	   			$("#phone").textbox('setValue','${obj.phone}');
	//   		$('#post').combobox({
	//				 url:"/sys/pubData/qryPostList.do?postType=T",
	//				 formatter:formatPost, 
	//			     valueField: 'postId', 
	//				 textField: 'postName', 
	//				 panelHeight: 'auto',
	//				 onLoadSuccess:function(){
	//				 	var data = $('#post').combobox('getData');
	//					if (data.length > 0)
	//		            {
	//			       		for(var i = 0;i < data.length;i++){
	//			       			 if("${obj.post}" == data[i].postId){
	//			       			 	$('#post').combobox('select',data[i].postId);
	//			       			 }
	//			       		}
	//			       	}
	//				 }
	//			});
				$('#gradeTeam').combobox({
					 url:"/sys/pubData/qryCodeNameList.do?tableName=TEACHER_T&codeType=GRADE_TEAM",
					 formatter:formatItem, 
					 valueField: 'codeFlag', 
					 textField: 'codeName', 
					 panelHeight: 'auto',
					 onLoadSuccess:function(){
					 	var data = $('#gradeTeam').combobox('getData');
						if (data.length > 0)
			            {
				       		for(var i = 0;i < data.length;i++){
				       			 if("${obj.gradeTeam}" == data[i].codeFlag){
				       			 	$('#gradeTeam').combobox('select',data[i].codeFlag);
				       			 }
				       		}
				       	}
					 }
				});
	   		});
	   </script>
  	</body>
</html>
