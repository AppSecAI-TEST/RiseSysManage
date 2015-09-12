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
  	</head>
  	<body>
  		<div style="padding:5px 0;">基本信息
  			<table align="center" style="min-width:1100px;width:97%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="1">
  				<tr>
  					<td>学员姓名:</td>
  					<td>
  					</td>
  					<td align="right">学生姓名:</td>
  					<td>
  						<input class="easyui-textbox"  name="studentName" id="studentName" style="width:150px;" />
  					</td>
  					<td align="right">联系电话:</td>
  					<td>
  						<input class="easyui-textbox" name="telephone" id="telephone" style="width:150px;" />
  					</td>
  					<td>缴费时间:</td>
  					<td>
  						<input class="easyui-datebox" name="payStartTime" id="payStartTime" style="width:150px;" />
  					</td>
  					<td>至:</td>
  					<td>
  						<input class="easyui-datebox" name="payEndTime" id="payEndTime"  style="width:150px;" />
  					</td>
  				</tr>
  				<tr>
  					<td>招生顾问:</td>
  					<td>
  						<input class="easyui-textbox" name="recruitAdviser" id="recruitAdviser" style="width:150px;" />
  					</td>
  					<td align="right">责任顾问:</td>
  					<td>
  						<input class="easyui-textbox" name="dutyAdviser" id="dutyAdviser" style="width:150px;" />
  					</td>
  					<td align="right">证件号码:</td>
  					<td>
  						<input class="easyui-textbox" name="identityId" id="identityId" style="width:150px;" />
  					</td>
  					<td>退费时间:</td>
  					<td>
  						<input class="easyui-datebox" name="feeBackStartTime" id="feeBackStartTime" style="width:150px;" />
  					</td>
  					<td>至:</td>
  					<td>
  						<input class="easyui-datebox" name="feeBackEndTime" id="feeBackEndTime" style="width:150px" />
  					</td>
  				</tr>
  				<tr>
  					<td>业绩类型:</td>
  					<td>
  						<select class="easyui-combobox" name="feeType" id="feeType" style="width:150px;">
  							
  						</select>
  					</td>
  					<td align="right">课程状态:</td>
  					<td>
  						<input class="easyui-combobox"  name="courseState" id="courseState" style="width:150px;" />
  					</td>
  					<td align="right">赠品信息:</td>
  					<td>
  						<input class="easyui-combobox" name="giftType" id="giftType" style="width:150px;" />
  					</td>
  					<td>结课时间:</td>
  					<td>
  						<input class="easyui-datebox" name="classOverStartTime" id="classOverStartTime" style="width:150px;" />
  					</td>
  					<td>至:</td>
  					<td>
  						<input class="easyui-datebox" name="classOverEndTime" id="classOverEndTime"  style="width:150px;" />
  					</td>
  				</tr>
  				<tr>
  					<td>课程类型:</td>
  					<td>
  						<select class="easyui-combobox" name="courseType" id="courseType" style="width:150px;">
  							
  						</select>
  					</td>
  					<td>
  						<select class="easyui-combobox"  name="courseTypeDetail" id="courseTypeDetail" style="width:150px;" />
  						
  						</select>
  					</td>
  					<td align="right">口碑类型:</td>
  					<td>
  						<select class="easyui-combobox"  name="womType" id="womType" style="width:150px;" />
  						
  						</select>
  					</td>
  					<td>
  						<select class="easyui-combobox"  name="womTypeDetail" id="womTypeDetail" style="width:150px;" />
  						
  						</select>
  					</td>
  					<td>赠课信息:</td>
  					<td>
  						<select class="easyui-combobox"  name="giftClassType" id="giftClassType" style="width:150px;" />
  						
  						</select>
  					</td>
  					<td></td>
  					<td style="text-align: right;">
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:75px" id="qryBtn" onclick="qryData()">查询</a>  <a href="javascript:void(0)" class="easyui-linkbutton" style="width:75px" id="reset" onclick="">重置</a>
  					</td>
  				</tr>
  			</table>
  		</div>
  	</body>
</html>
