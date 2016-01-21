<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String path = request.getContextPath();
	List postList = (List)request.getAttribute("postList");
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
  			<input type="hidden" name="staffId" value="${staffT.staffId}" />
  			<input type="hidden" name="handlerId" value="${sessionScope.StaffT.staffId}" />
  			<c:choose>
  				<c:when test="${pageFlag == 'NEW'}">
					<div data-options="region:'north',title:'新增用户',collapsible:false,maxHeight:600" style="min-width:1100px;width:99%;font-family:'微软雅黑';margin:0 auto;">
  				</c:when>
  				<c:otherwise>
  					<div data-options="region:'north',title:'修改用户',collapsible:false,maxHeight:600" style="min-width:1100px;width:99%;font-family:'微软雅黑';margin:0 auto;">
  				</c:otherwise>
  			</c:choose>
				<table align="center" class="tab" style="height:100%;width:100%;margin:0 auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td align="right" width="10%">*登录名:</td>
						<td width="23%"><input name="sysName" id="sysName" type="text" style="width:246px" class="easyui-validatebox easyui-textbox" missingMessage="请填写登录名" required="true" /></td>
						<td align="right" width="10%">*英文名:</td>
						<td width="23%"><input name="userName" id="userName" type="text" style="width:246px" class="easyui-validatebox easyui-textbox" missingMessage="请填写英文名" required="true" /></td>
						<td align="right" width="10%">*中文名:</td>
						<td width="23%"><input name="staffName" id="staffName" type="text" style="width:246px" class="easyui-textbox easyui-validatebox" missingMessage="请填写中文名" required="true" /></td>
					</tr>
					<tr>
						<td align="right" width="10%">*性别:</td>
						<td width="23%">
							<c:choose>
								<c:when test="${pageFlag == 'NEW'}">
									<input name="gender" id="genderMan" type="radio" value="男" checked="checked"/><label for="genderMan">男</label>
									<input name="gender" id="genderWoman" type="radio" value="女" /><label for="genderWoman">女</label>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${staffT.gender == '男'}">
											<input name="gender" id="genderMan" type="radio" value="男" checked="checked"/><label for="genderMan">男</label>
											<input name="gender" id="genderWoman" type="radio" value="女" /><label for="genderWoman">女</label>
										</c:when>
										<c:otherwise>
											<input name="gender" id="genderMan" type="radio" value="男" /><label for="genderMan">男</label>
											<input name="gender" id="genderWoman" type="radio" value="女" checked="checked"/><label for="genderWoman">女</label>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</td>
						<td align="right">*证件号码:</td>
						<td><select id="certType" name="certType" style="width:80px" ></select>　<input name="certNum" id="certNum" type="text" style="width:150px" class="easyui-textbox easyui-validatebox" missingMessage="请填写证件号码" required="true" /></td>
						<td align="right">*出生日期:</td>
						<td><input name="birthday" id="birthday" type="text" style="width:246px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" missingMessage="请填写出生日期" required="true" /></td>
					</tr>
					<tr>
						<td align="right">*手机:</td>
						<td><input name="phone" id="phone" type="text" style="width:246px" class="easyui-textbox easyui-validatebox" missingMessage="请填写手机号码" required="true" /></td>
						<td align="right">家庭地址:</td>
						<td><input name="familyAddr" id="familyAddr" type="text" style="width:246px" class="easyui-textbox" /></td>
						<td align="right">家庭电话:</td>
						<td><input name="familyPhone" id="familyPhone" type="text" style="width:246px" class="easyui-textbox" /></td>
					</tr>
					<tr>
						<td align="right">QQ号:</td>
						<td><input name="qq" id="qq" type="text" style="width:246px" class="easyui-textbox" /></td>
						<td align="right">毕业学校:</td>
						<td><input name="graduateSchool" id="graduateSchool" type="text" style="width:246px" class="easyui-textbox" /></td>
						<td align="right">学历:</td>
						<td><input name="educationDegree" id="educationDegree" type="text" style="width:246px" class="easyui-textbox" /></td>
					</tr>
					<tr>
						<td align="right">专业:</td>
						<td><input name="profession" id="profession" type="text" style="width:246px" class="easyui-textbox" /></td>
						<td align="right">*入职时间:</td>
						<td><input name="joinDate" id="joinDate" type="text" style="width:246px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" missingMessage="请填写入职时间" required="true" /></td>
						<td align="right">聘用时间:</td>
						<td><input name="hireDate" id="hireDate" type="text" style="width:246px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" required="true" /></td>
					</tr>
					<tr>
						<td align="right">合同到期时间:</td>
						<td><input name="agreementDate" id="agreementDate" type="text" style="width:246px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" required="true" /></td>
						<td align="right">*部门:</td>
						<td><select id="deptId" name="deptId" style="width:244px" ></select></td>
						<td align="right">国籍:</td>
						<td>
							<c:choose>
								<c:when test="${pageFlag == 'NEW'}">
									<input name="nationality" id="nationalityCn" type="radio" value="native" checked="checked"/><label for="nationalityCn">中国国籍</label>
									<input name="nationality" id="nationalityFor" type="radio" value="foreign" /><label for="nationalityFor">外国国籍</label>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${staffT.nationality == 'foreign'}">
											<input name="nationality" id="nationalityCn" type="radio" value="native" /><label for="nationalityCn">中国国籍</label>
											<input name="nationality" id="nationalityFor" type="radio" value="foreign" checked="checked"/><label for="nationalityFor">外国国籍</label>
										</c:when>
										<c:otherwise>
											<input name="nationality" id="nationalityCn" type="radio" value="native" checked="checked"/><label for="nationalityCn">中国国籍</label>
											<input name="nationality" id="nationalityFor" type="radio" value="foreign" /><label for="nationalityFor">外国国籍</label>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td align="right">*性质:</td>
						<td><select id="jobProperty" name="jobProperty" style="width:244px" ></select></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<c:if test="${pageFlag == 'NEW'}">
						<tr>
							<td align="right">*登录密码:</td>
							<td><input name="password" id="password" type="password" style="width:246px" validType="length[4,20]" missingMessage="请输入登录密码" class="easyui-textbox easyui-validatebox" required="true" /></td>
							<td align="right">*确认密码:</td>
							<td><input name="confirm" id="confirm" type="password" style="width:246px" validType="equalTo['#password']" missingMessage="请输入确认密码" invalidMessage="两次输入密码不匹配" class="easyui-textbox easyui-validatebox" required="true" /></td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					</c:if>
					<tr>
						<td align="right">担任:</td>
						<td colspan="5" style="padding:0 0;">
							<c:forEach items="${postList}" var="node" varStatus="i">
								<p style="float:left;width:150px;height:20px;margin:0 auto;padding:0 5px">
									<input name="post" id="post${i.count}" type="checkbox" value="${node.postId}" postType="${node.postType}" style="margin:0 auto;vertical-align:middle;" onclick="postClickFunc(this)" />
									<label for="post${i.count}" style="margin:0 0;vertical-align:middle;">${node.postName}</label>
								</p>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">教育经历:</td>
						<td colspan="5">
							<input name="educationExperience" id="educationExperience" type="text" style="width:1015px;height:50px" class="easyui-textbox" data-options="multiline:true" />
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">工作经验:</td>
						<td colspan="5">
							<input name="workExperience" id="workExperience" type="text" style="width:1015px;height:50px" class="easyui-textbox" data-options="multiline:true" />
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">备注:</td>
						<td colspan="5">
							<input name="remark" id="remark" type="text" style="width:1015px;height:50px" class="easyui-textbox" data-options="multiline:true" />
						</td>
					</tr>
				</table>
			</div>
			<div data-options="region:'south',border:false,collapsible:false" style="min-width:1100px;width:99%;font-family:'微软雅黑';margin:0 auto;height:42px;text-align:right;padding-top:10px;padding-right:50px;">
				<a href="javascript:void(0)" id="enterBtn" class="easyui-linkbutton" iconCls="icon-ok" style="width: 100px;" onclick="staffSubmit()">提交</a>　
				<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
			</div>
		</form>
		<script type="text/javascript">
			var postTeaTypeObj = null;
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
				$("#sysName").textbox("setValue",'${staffT.sysName}');
				if(!pageFlag)
				{
					$("#sysName").textbox("readonly", true);
				}
				$("#userName").textbox("setValue",'${staffT.userName}');
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
				var postArr = [${staffT.post}];
				for(var i = 0,n = postArr.length;i < n;i++)
				{
					$("#post"+postArr[i]).get(0).checked = true;
				}
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
			function postClickFunc(obj)
			{
				if($(obj).attr("postType") == "T")
				{
					if(postTeaTypeObj != obj)
					{
						if(postTeaTypeObj != null)
						{
							postTeaTypeObj.checked = false;
						}
						postTeaTypeObj = obj;
					}
				}
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
				window.location.href = "/sys/manage/userMan.jsp?funcNodeId=${funcNodeId}";
			}
		</script>
 	</body>
</html>