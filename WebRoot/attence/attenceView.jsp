<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<style type="text/css">
			.tab td{
				font-size:14px;
				height:30px;
				border-right:1px solid #ccc;
				border-bottom:1px solid #ccc;
			}
			.tab tr td:nth-last-child(2n+1){
				padding-left:4px;
			}
			.tab tr td:nth-last-child(2n){
				padding-right:4px;
			}
		</style>
  	</head>
  
  	<body class="easyui-layout manage">
  		<form id="fm" method="post">
  			<input type="hidden" name="classInstId" value="${staffT.staffId}" />
			<div data-options="region:'north',title:'考勤信息',collapsible:false,height:200,maxHeight:180,border:false" style="min-width:1100px;width:99%;font-family:'微软雅黑';margin:0 auto;">
				<table align="center" class="tab" style="height:100%;width:99%;margin:0 auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td align="right" width="10%">课程阶段：</td>
						<td width="23%">${classInstT.stageId}</td>
						<td align="right" width="10%">班级类型：</td>
						<td width="23%">${classInstT.classType}</td>
						<td align="right" width="10%">班级名称：</td>
						<td width="23%">${classInstT.className}</td>
					</tr>
					<tr>
						<td align="right">开课日期：</td>
						<td><fmt:formatDate value="${classInstT.openDate}" pattern="yyyy-MM-dd" /></td>
						<td align="right">学员来源类型：</td>
						<td>${classInstT.studentChannelTypeName}</td>
						<td align="right">升学班级：</td>
						<td>${classInstT.higherSchoolName}</td>
					</tr>
					<tr>
						<td align="right">班级性质：</td>
						<td>${classInstT.handTypeName}</td>
						<td align="right">开班类型：</td>
						<td>${classInstT.openClassTypeName}</td>
						<td align="right">课时进度：</td>
						<td>${classInstT.hours}</td>
					</tr>
					<tr>
						<td align="right">开班人数：</td>
						<td>${classInstT.openClassNum}</td>
						<td align="right">在读人数：</td>
						<td>${classInstT.openClassNum}</td>
						<td align="right">持证率：</td>
						<td><fmt:formatNumber value="${classInstT.licenseRate}" type="percent" /></td>
					</tr>
					<tr>
						<td align="right">升学基数：</td>
						<td>5</td>
						<td align="right">已升学人数：</td>
						<td>10</td>
						<td align="right">升学率：</td>
						<td>100%</td>
					</tr>
				</table>
			</div>
			<div data-options="region:'center',collapsible:false,maxHeight:100,height:150,border:false" style="min-width:1100px;width:99%;font-family:'微软雅黑';margin:0px auto;">
				<table align="center" class="tab" style="height:100%;width:99%;margin:0 auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
					<c:forEach items="${classInstT.schooltimeList}" var="node">
						<tr>
							<td align="right" width="10%">上课时段：</td>
							<td width="23%">周${node.weekTime} ${node.hourRangeName}</td>
							<td align="right" align="right" width="5%">教室：</td>
							<td width="12%">${node.roomName}</td>
							<td align="right" align="right" width="5%">课时：</td>
							<td width="12%">${node.lessionHours}</td>
							<td align="right" width="10%">带班老师：</td>
							<td width="23%">
								<c:forEach items="${node.classTeacherList}" var="item">
									${item.schoolName}&nbsp;${item.teacherName}&nbsp;${item.hasLicense}&nbsp;课时量&nbsp;${item.hours}
								</c:forEach>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</form>
		<script type="text/javascript">
			<c:choose>
				<c:when test="${pageFlag == 'NEW'}">
					var url = "/sys/staff/addStaff.do";
					var pageFlag = true;
				</c:when>
				<c:otherwise>
					var url = "/sys/staff/updateStaff.do";
					var pageFlag = false;
				</c:otherwise>
			</c:choose>
			$("#deptId").combotree({animate:true,required:true,missingMessage:"请选择部门"});
			$("#certType").combobox({
				url:"<%=path %>/pub/pageComboxList.do?funcNodeId=${funcNodeId}&fieldId=certType",
				formatter:function(row){
					return '<span>'+row.codeName+'</span>';
				},
				editable:false, 
				valueField: 'codeFlag', 
				textField: 'codeName', 
				panelHeight: 'auto',
				required:true,
				missingMessage:"请选择证件类型",
				onLoadSuccess:function(data){
					$("#certType").combobox("setValue",'${staffT.certType}');
				}
			});
			$("#jobProperty").combobox({
				url:"<%=path %>/pub/pageComboxList.do?funcNodeId=${funcNodeId}&fieldId=jobProperty",
				formatter:function(row){
					return '<span>'+row.codeName+'</span>';
				},
				editable:false, 
				valueField: 'codeFlag', 
				textField: 'codeName', 
				panelHeight: 'auto',
				required:true,
				missingMessage:"请选择工作性质",
				onLoadSuccess:function(data){
					$("#jobProperty").combobox("setValue",'${staffT.jobProperty}');
				}
			});
			$(document).ready(function(){
				$("#userName").textbox("setValue",'${staffT.userName}');
				if(!pageFlag)
				{
					$("#userName").textbox("readonly", true);
				}
				$("#staffName").textbox("setValue",'${staffT.staffName}');
				$("#certNum").textbox("setValue",'${staffT.certNum}');
				$("#birthday").datebox("setValue",'<fmt:formatDate value="${staffT.birthday}" pattern="yyyy-MM-dd" />');
				$("#phone").textbox("setValue",'${staffT.phone}');
				$("#familyAddr").textbox("setValue",'${staffT.familyAddr}');
				$("#familyPhone").textbox("setValue",'${staffT.familyPhone}');
				$("#qq").textbox("setValue",'${staffT.qq}');
				$("#graduateSchool").textbox("setValue",'${staffT.graduateSchool}');
				$("#educationDegree").textbox("setValue",'${staffT.educationDegree}');
				$("#profession").textbox("setValue",'${staffT.profession}');
				$("#joinDate").datebox("setValue",'<fmt:formatDate value="${staffT.joinDate}" pattern="yyyy-MM-dd" />');
				$("#hireDate").datebox("setValue",'<fmt:formatDate value="${staffT.hireDate}" pattern="yyyy-MM-dd" />');
				$("#agreementDate").datebox("setValue",'<fmt:formatDate value="${staffT.agreementDate}" pattern="yyyy-MM-dd" />');
				$("#educationExperience").textbox("setValue",'${staffT.educationExperience}');
				$("#workExperience").textbox("setValue",'${staffT.workExperience}');
				$("#remark").textbox("setValue",'${staffT.remark}');
				var postArr = "${staffT.post}";
				$("input[name='post']").each(function(i,node){
					if(postArr.indexOf(node.value) != -1){
						node.checked = true;
					}
				});
				ajaxLoading("加载中...");
				$.ajax({
					url:"/sys/orgDept/getRootOrgDept.do",
					type:"POST",
					dataType:"json",
					complete:function(){
						ajaxLoadEnd();
					},
					success:function(data){
						$("#deptId").combotree("loadData",data);
						$("#deptId").combotree("setValue",'${staffT.deptId}');
					}	
				});
			});
			function choicePostFunc(obj)
			{
				$("input[name='post']").each(function(i,node){
					node.checked = obj.checked;
				});
			}
			function staffSubmit(){
				$('#fm').form('submit',{
					url: url,
					onSubmit: function(){
						return $(this).form('validate');
					},
					success: function(result){
						if (result == "success"){
							var pageStr = null;
							if(pageFlag)
							{
								pageStr = "新增";
							}
							else
							{
								pageStr = "修改";
							}
							$.messager.alert('提示',pageStr+"人员成功","info",function(){
								backFunc();
							});
						} else {
							$.messager.alert('提示',result);
						}
					}
				});
			}
			
			function backFunc()
			{
				window.location.href = "/sys/attence/attenceMan.jsp?funcNodeId=${funcNodeId}";
			}
		</script>
 	</body>
</html>