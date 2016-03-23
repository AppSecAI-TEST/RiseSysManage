<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript">
	   		$(document).ready(function(){
				$("#regionName").textbox("setValue",'${region.regionName}');
				$("#managerName").textbox("setValue",'${region.managerName}');
				$("#phone").numberbox("setValue",'${region.phone}');
				var schoolArr = "${region.schoolIds}";
				$("input[name='schoolIds']").each(function(i,node){
					if(schoolArr.indexOf(node.value) != -1){
						node.checked = true;
					}
				});
			});
			function updateRegionSubmit()
			{
				if($("#updateRegionForm").form('validate')){
					var json = $("#updateRegionForm").serializeObject();
					var remark = json.remark;
					remark = string2Json(remark);
					remark = encodeURI(remark);
					json.remark = remark;
					var schoolIds = "";
					 $("input[name='schoolIds']:checked").each(function(){
				        schoolIds += $(this).val() + ",";
    				});
    				if(schoolIds != ""){
    					schoolIds = schoolIds.substring(0,schoolIds.length-1);
    				}
    				json.schoolIds = schoolIds;
					var obj = JSON.stringify(json);
					$.ajax({
						type : "POST",
						url: "/sys/regionManage/updateRegion.do",
						data: "json="+obj,
						async: false,
						beforeSend: function()
				    	{
				    		$.messager.progress({title : '修改片区', msg : '修改片区中，请稍等……'});
				    	},
				    	success: function(state) {
				    		$.messager.progress('close'); 
				    		if(state == "1"){
				    			$.messager.alert('提示', "修改片区成功！","info",function(){
					    			window.location.href = "/sys/manage/regionMan.jsp";
								});
				    		}else if(state == "3"){
				    			$.messager.alert('提示', "修改片区失败！");
				    		}else{
				    			$.messager.alert('提示', state+"校区已经属于其他片区！");
				    		}
				        } 
					});
				}
			}
		</script>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="修改片区">
  			<form id="updateRegionForm">
  			<input type="hidden" name="regionId" value="${region.regionId}" />
	 		<table id="regionTab" width="98%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td width="20%" align="right"><span>*片区名称：</span></td>
  					<td width="80%" align="left"><input class="easyui-textbox" name="regionName" id="regionName" style="width:150px;" required="true"/></td>
  				</tr>
  				<tr>
  					<td align="right"><span>校区负责人：</span></td>
  					<td align="left"><input class="easyui-textbox" name="managerName" id="managerName" style="width:150px;" /></td>
  				</tr>
  				<tr>
  					<td align="right"><span>联系电话：</span></td>
  					<td align="left"><input class="easyui-numberbox" name="phone" id="phone" style="width:150px;" /></td>
  				</tr>
  				<tr>
  					<td align="right"><span>选择校区：</span></td>
  					<td align="left">
  						<c:forEach items="${schoolList}" var="node" varStatus="i">
							<input name="schoolIds" id="schoolIds${i.count}" type="checkbox" value="${node.schoolId}" style="margin:0 auto;vertical-align:middle;" />
							<label for="schoolIds${i.count}" style="margin:0 0;vertical-align:middle;">${node.schoolName}</label>
							<c:if test="${i.count%10 == 0}">
								<br />
							</c:if>
						</c:forEach>
  					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>备注：</span></td>
  					<td colspan="5" align="left"><textarea rows="5" cols="100" id="remark" name="remark" class="easyui-validatebox textbox">${region.remark}</textarea></td>
  				</tr>
	 		</table>
	 		</form>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: right;">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="updateRegionSubmit()"><span>提交</span></a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
  	</body>
</html>
