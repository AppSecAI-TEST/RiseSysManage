<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
		<script type="text/javascript" src="<%=path %>/js/shortCourseConfig/shortCourseMain.js"></script>
		<script type="text/javascript" src="<%=path %>/js/shortCourseConfig/priceConfig.js"></script>
		<script type="text/javascript" src="<%=path %>/js/shortCourseConfig/favorConfig.js"></script>
  	</head>
  	<body>
  	<div id="tt" class="easyui-tabs" style="min-width:1110px;width:98%;height:auto;">
  		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<div title="短期课课程配置" style="padding:5px;display:block;">
			<table align="center" title="查询结果" data-options="height:600" id="course_data">
				
			</table>
			<div id="courseToolbar">
	   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="addShortCourse()">添加短期课</a>
	 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" onclick="removeShortClass()">删除短期课</a>
	   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="addShortClassType()">添加班级类型</a>
	 		</div>
	 		<div id="courseDlg" class="easyui-dialog" style="width:550px;height:275px;padding:0px 0px" modal="true" closed="true" buttons="#course-buttons">
				<form id="courseFm" method="post">
					<input name="shortClassId" type="hidden" />
					<input name="classTypeId" type="hidden" />
					<table width="98%" style="margin:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
						<tr>
							<td align="right">短期课名称：</td>
							<td align="left"><input name="className" id="className" style="width:265px" class="easyui-textbox" required="true"/></td>
						</tr>
						<tr>
							<td align="right">管理类型：</td>
							<td align="left"><input type="radio" value="Y" name="isTeaching" checked="checked"/><span>授课管理</span>&nbsp;<input type="radio" value="N" name="isTeaching"/><span>非授课管理</span></td>
						</tr>
						<tr>
							<td align="right">班级类型：</td>
							<td align="left"><input name="classType" id="classType" style="width:265px" class="easyui-textbox" required="true"/></td>
						</tr>
						<tr>
							<td align="right">最高开班人数：</td>
							<td align="left"><input name="maxNum" style="width:265px" class="easyui-numberbox" required="true" />个</td>
						</tr>
						<tr>
							<td align="right">最低开班人数：</td>
							<td align="left"><input name="minNum" style="width:265px" class="easyui-numberbox" required="true" />个</td>
						</tr>
						<tr>
							<td align="right">是否开放（班级）：</td>
							<td align="left"><input type="radio" value="Y" name="isOpen" checked="checked"/><span>是</span>&nbsp;<input type="radio" value="N" name="isOpen"/><span>否</span></td>
						</tr>
					</table>
				</form>
			</div>
			<div id="course-buttons">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveCourseSubmit()">提交</a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#courseDlg').dialog('close')">取消</a>
			</div>
  		</div>
  		<div title="短期课价格配置" style="padding:5px;display:block;">
  			<div id="ttab" class="easyui-tabs" style="min-width:1110px;width:100%;height:auto;">
  				<div title="短期课价格配置" style="padding:5px;display:block;">
					<table align="center" title="查询结果" data-options="height:550" id="price_data">
						
					</table>
					<div id="priceToolbar">
			   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="locatShortCourse()">添加新价格</a>
		 			</div>
				</div>
				<div title="短期课优惠配置" style="padding:5px;display:block;">
					<table align="center" title="查询结果" data-options="height:550" id="favor_data">
						
					</table>
					<div id="favorToolbar">
			   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="locatShortFavor()">添加新优惠</a>
		 			</div>
				</div>
  			</div>
  		</div>
	  </div>
  	</body>
</html>
