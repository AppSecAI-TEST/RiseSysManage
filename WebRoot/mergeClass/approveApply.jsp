<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String applyId =request.getParameter("applyId");
	String comboState =request.getParameter("comboState");
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/mergeClass/approve.js"></script>
  	</head>
  	<body>
  		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<input id="applyId" type="hidden" value="<%=applyId%>"/>
  		<input id="comboState" type="hidden" value="<%=comboState%>"/>
  		<div class="easyui-panel" title="班级信息" style="width:1293px;">
  			<table id="tab1" width="100%;" class="maintable">
	  			<tr>
	  				<td align="center" width="6%">校区</td>
	  				<td align="center" width="7%">班级名称</td>
	  				<td align="center" width="15%">结课日期</td>
	  				<td align="center"  width="29%">上课时间段</td>
	  				<td align="center" width="7%">在读人数</td>
	  				<td align="center" width="7%">已升学人数</td>
	  				<td align="center" width="7%">升学率</td>
	  				<td align="center" width="14%">可升学人数</td>
	  				<td align="center" width="7%">升学缺口</td>
	  			</tr>
	  			<tr id="modelTr1" style="display:none">
	  				<td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td>
	  				<td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td>
	  			</tr>
  			</table>
  		</div>
  		<div class="easyui-panel" title="合并班计划" style="width:1293px;">
  			<table id="tab2" width="100%;" class="maintable">
  				<tr>
  					<td align="center" width="4%">校区</td>
  					<td align="center" width="5%">班级名称</td>
  					<td align="center" width="9%">开始日期</td>
  					<td align="center" width="4%">开始课时</td>
  					<td align="center" width="4%">合并时长(周)</td>
  					<td align="center" width="8%">合并形式</td>
  					<td align="center" width="8%">合并后结课日期</td>
  					<td align="center" width="5%">合并后班级</td>
  					<td align="center" width="4%">定班人数</td>
  					<td align="center" width="4%">定班率</td>
  					<td align="center" width="18%">合并后上课时段</td>
  					<td align="center" width="14%">带班老师</td>
  					<td align="center" width="9%">开课日期</td>
  				</tr>
  				<tr id="modelTr2" style="display:none">
  					<td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td>
  					<td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td>
  				</tr>
  				<tr id="modelTr21" style="display:none">
  					<td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td>
  				</tr>
  			</table>
  		</div>
  		<div id="courseChangePlan"  class="easyui-panel" title="课程调整计划" style="width:1293px;">  			
  		</div>
  		<div class="easyui-panel" id="applyRemark" style="width:1293px;padding:20px">
  		</div>
  		<div class="easyui-panel" id="approveChoose" style="width:1293px;">
  			<table width="100%" class="maintable" align="center" cellpadding="">
  				<tr>
  					<td width="10%" align="right" id="approveName"></td>
  					<td align="left">&nbsp;&nbsp;
	  					<input type="radio" name="approveType" value="Y">&nbsp;<lable id="text1"></lable>
	  					&nbsp;&nbsp;&nbsp;&nbsp;
	  					<input type="radio" name="approveType" value="N">&nbsp;<lable id="text2"></lable>
  					</td>
  				</tr>
  				<tr>
  					<td align="right">审批意见：</td><td><textarea id="remark" style="border:0;width:99.5%;height:90px;resize:none;overflow-y:hidden"></textarea></td>
  				</tr>
  			</table>
  		</div>
  		<div style="width:1293px;text-align:right;margin:50px 0;">
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px" id="submitBtn"><span>提交</span></a>
  				&nbsp;&nbsp;&nbsp;&nbsp;
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px" id="backBtn" ><span>返回</span></a>	
  		</div>		
  	</body>
</html>