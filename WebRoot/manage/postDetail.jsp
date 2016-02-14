<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#deptId").combotree({animate:true});
				$("#postType").combobox({
					url:"<%=path %>/pub/pageComboxList.do?funcNodeId=${param.funcNodeId}&fieldId=postType",
					formatter:function(row){
						return '<span>'+row.codeName+'</span>';
					},
					editable:false, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto',
					onLoadSuccess:function(data){
						if(data.length > 0)
							$('#postType').combobox('setValue','${PostT.postType}');
					}
				});
				$("#postName").textbox("setValue",'${PostT.postName}');
				$("#postRemark").textbox("setValue",'${PostT.postRemark}');
				var schoolArr = "${PostT.schoolIds}";
				var isAllSelect = true;
				$("input[name='schoolIds']").each(function(i,node){
					if(schoolArr.indexOf(node.value) != -1){
						node.checked = true;
					}
					else{
						isAllSelect = false;
					}
				});
				$("#checkAll").attr("checked",isAllSelect);
				ajaxLoading("正在处理，请稍待。。。");
				$.ajax({
					url:"/sys/orgDept/getRootOrgDept.do",
					type:"POST",
					dataType:"json",
					complete:function(){
						ajaxLoadEnd();
					},
					success:function(data){
						$("#deptId").combotree("loadData",data);
						$("#deptId").combotree("setValue",'${PostT.deptId}');
					}	
				});
			});
			function choiceSchoolFunc(obj)
			{
				$("input[name='schoolIds']").each(function(i,node){
					node.checked = obj.checked;
				});
			}
			<c:choose>
				<c:when test="${empty PostT}">
					var url = "/sys/post/addPost.do";
					var pageFlag = true;
				</c:when>
				<c:otherwise>
					var url = "/sys/post/updatePost.do";
					var pageFlag = false;
				</c:otherwise>
			</c:choose>
			function postSubmit(){
				$('#fm').form('submit',{
					url: url,
					onSubmit: function(){
						var validateFlag = $(this).form('validate');
						if(!validateFlag)
						{
							$.messager.alert('提示',"输入职务信息不全,请核实后重新尝试");
						}
						return validateFlag;
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
							$.messager.alert('提示',pageStr+"职务成功","info",function(){
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
				window.location.href = "/sys/manage/postMan.jsp?funcNodeId=${funcNodeId}";
			}
		</script>
  	</head>
  	<body class="easyui-layout manage">
  		<form id="fm" method="post" novalidate>
  			<input type="hidden" name="postId" value="${PostT.postId}" />
			<div data-options="region:'north',title:'基础信息',collapsible:false" style="min-width:1100px;width:99%;font-family:'微软雅黑';margin:0 auto;text-align:center;height:500px;padding-top:90px">
				<div class="fitem">
					<label style="text-align:right">职位名称:</label>
					<input name="postName" id="postName" type="text" style="width:565px" class="easyui-textbox easyui-validatebox" required="true" />
				</div>
				<div class="fitem">
					<label style="text-align:right">职位类型:</label>
					<select id="postType" name="postType" style="width:565px" ></select>
				</div>
				<div class="fitem">
					<label style="text-align:right">归属部门:</label>
					<select class="easyui-combotree" animate="true" id="deptId" name="deptId" style="width:565px" ></select>
				</div>
				<div class="fitem">
					<label style="text-align:right;vertical-align:top;">职位描述:</label>
					<input name="postRemark" id="postRemark" type="text" style="width:565px;height:150px" class="easyui-textbox" data-options="multiline:true" />
				</div>
			</div>
			<div style="display:none;">
				<div data-options="region:'center',title:'数据范围',collapsible:false" style="min-width:1100px;width:99%;font-family:'微软雅黑';margin:0 auto;height:50px;padding-top:20px;padding-left:40px">
					<div class="fitem">
						<input id="checkAll" type="checkbox" value="0" onclick="choiceSchoolFunc(this)" />
						<label for="checkAll">全选</label>
					</div>
					<div class="fitem">
						<c:forEach items="${SchoolList}" var="node" varStatus="i">
							<input name="schoolIds" id="schoolIds${i.count}" type="checkbox" value="${node.schoolId}" />
							<label for="schoolIds${i.count}">${node.schoolName}</label>
							<c:if test="${i.count%10 == 0}">
								<br />
							</c:if>
						</c:forEach>
					</div>
				</div>
			</div>
			<div data-options="region:'south',border:false,collapsible:false" style="min-width:1100px;width:99%;font-family:'微软雅黑';margin:0 auto;height:100px;text-align:right;padding-top:0px;padding-right:30px;">
				<a href="javascript:void(0)" id="enterBtn" class="easyui-linkbutton" iconCls="icon-ok" style="width: 100px;" onclick="postSubmit()">提交</a>
				<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
			</div>
		</form>
 	</body>
</html>
