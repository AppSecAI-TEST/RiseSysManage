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
		<script type="text/javascript" src="<%=path %>/js/giftManage/goodsGiftManage.js"></script>
		<script type="text/javascript" src="<%=path %>/js/giftManage/couponGiftManage.js"></script>
		<script type="text/javascript" src="<%=path %>/js/giftManage/courseGiftManage.js"></script>
  	</head>
  	<body>
  	<div id="tt" class="easyui-tabs" style="min-width:1110px;width:98%;height:auto;">
  	<div title="实物&教材赠品" style="padding:5px;display:block;">
 		<form id="qryGoodsFm">
  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="5">
  				<tr>
  					<td align="right" width="8%">所属校区：</td>
  					<td align="left" width="5%">
  						<select name="schoolId" class="easyui-combobox" style="width:100px;" editable="false"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
      						 onLoadSuccess:function(data){$('#schoolId').combobox('setValue',data[0].schoolId);}"
      						url="<%=path %>/pubData/qrySchoolList.do?schoolId=${sessionScope.StaffT.schoolId}">
        				</select>
  					</td>
  					<td align="right" width="8%">学员姓名：</td>
  					<td align="left" width="5%">
  						<select class="easyui-combobox" name="studentId" style="width:100px;">
  							
  						</select>
  					</td>
  					<td align="right" width="8%">联系电话：</td>
  					<td align="left" width="5%">
  						<input class="easyui-textbox"  name="phone" style="width:100px;" />
  					</td>
  					<td align="right" width="5%">班级：</td>
  					<td align="left" width="16%">
  						<input class="easyui-textbox"  name="class" style="width:100px;" />
  					</td>
  					<td width="40%" colspan="2"></td>
  				</tr>
  				<tr>
  					<td align="right">来源类型：</td>
  					<td align="left">
  						<select class="easyui-combobox"  name="giftChannel" style="width:100px;" ></select>
  					</td>
  					<td align="left"><select class="easyui-combobox"  name="giftChannelDetail" style="width:100px;" ></select></td>
  					<td align="center" colspan="2">赠品类型：
  						<select class="easyui-combobox"  name="giftType" style="width:100px;" ></select>
  					</td>
  					<td align="center" colspan="2" >赠品：
  						<select class="easyui-combobox"  name="giftId" style="width:100px;" ></select>
  					</td>
  					<td align="center">是否领取：&nbsp;
  						<input type="radio" value="Y" name="isGet"/><span>是</span>
	      				&nbsp;<input type="radio" value="N" name="isGet"/><span>否</span>
	      			</td>
	      			<td align="left" width="18%">
  						是否退回：&nbsp;
  						<input type="radio" value="Y" name="isRtn"/><span>是</span>
	      				&nbsp;<input type="radio" value="N" name="isRtn"/><span>否</span>
	      			</td>
	      			<td></td>
  				</tr>
  				<tr>
				  <td align="right">赠送日期：</td>
				  <td align="left" colspan="2">
					<input class="easyui-datebox"  name="sendStartTime" style="width:90px;" />
				  &nbsp;至&nbsp;<input class="easyui-datebox"  name="sendEndTime" style="width:90px;" /></td>
				  <td align="left" style="padding-left:5px" colspan="6">领取日期：
				  <input class="easyui-datebox"  name="getStartTime" style="width:90px;" />
				  	&nbsp;至&nbsp;
					<input class="easyui-datebox"  name="getEndTime" style="width:90px;" />
				 	&nbsp;&nbsp;退回日期：
					<input class="easyui-datebox"  name="returnStartTime" style="width:90px;" />
					&nbsp;至&nbsp;
					<input class="easyui-datebox"  name="returnEndTime" style="width:90px;" />
					</td>
					<td colspan="2">
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:90px; height: 25px;" id="qryGoodsGift" funcNodeId="4010">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:90px; height: 25px;" id="reset" >重置</a>
				  </td>
  				</tr>
  			</table>
 		</form>
		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:400" id="goodsGift_data" toolbar="#goodsToolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="fasle">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="schoolName" align="center" width="6%">校区</th>
					<th field="name" align="center" width="6%">学员姓名</th>
					<th field="byName" align="center" width="5%">英文名</th>
					<th field="phone" align="center" width="11%">联系电话</th>
					<th field="giftChannel" align="center" width="8%">来源类型</th>
					<th field="giftChannelDesc" align="center" width="11%">赠品来源</th>
					<th field="giftName" align="center" width="11%">赠品名称</th>
					<th field="isGet" align="center" width="6%">是否领取</th>
					<th field="isRtn" align="center" width="6%">是否退回</th>
					<th field="createDate" align="center" width="9%">赠送时间</th>
					<th field="getDate" align="center" width="9%">领取时间</th>
					<th field="rtnDate" align="center" width="9%">退回时间</th>
				</tr>
			</thead>
		</table>
		<div id="goodsToolbar">
   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="locateStu('goods')">实物赠品赠送</a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="getGoodsGift()">赠品领取</a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" onclick="rtnGoodsGift()">赠品退回</a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-redo" onclick="viewGoodsGift()">浏览</a>
 		</div>
  	</div>
  	  	<div title="劵类赠品" style="padding:5px;display:block;">
 		 <form id="qryCouponFm">
  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="5">
  				<tr>
  					<td align="right" width="8%">所属校区：</td>
  					<td align="left" width="5%">
  						<select name="schoolId" class="easyui-combobox" style="width:100px;" editable="false"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
      						 onLoadSuccess:function(data){$('#schoolId').combobox('setValue',data[0].schoolId);}"
      						url="<%=path %>/pubData/qrySchoolList.do?schoolId=${sessionScope.StaffT.schoolId}">
        				</select>
  					</td>
  					<td align="right" width="8%">学员姓名：</td>
  					<td align="left" width="5%">
  						<select class="easyui-combobox" name="studentId" style="width:100px;">
  							
  						</select>
  					</td>
  					<td align="right" width="8%">联系电话：</td>
  					<td align="left" width="5%">
  						<input class="easyui-textbox"  name="phone" style="width:100px;" />
  					</td>
  					<td align="right" width="6%">班级：</td>
  					<td align="left" width="5%">
  						<input class="easyui-textbox"  name="class" style="width:100px;" />
  					</td>
  					<td align="right" width="8%">赠券状态：</td>
  					<td align="left" width="5%">
  						<select class="easyui-combobox" name="giftState" style="width:100px;">
  							
  						</select>
  					</td>
  					<td></td>
  				</tr>
  				<tr>
  					<td align="right">来源类型：</td>
  					<td align="left">
  						<select class="easyui-combobox"  name="giftChannel" style="width:100px;" ></select>
  					</td>
  					<td align="left"><select class="easyui-combobox"  name="giftChannelDetail" style="width:100px;" ></select></td>
  					<td align="center" colspan="3">赠券类型：
  						<select class="easyui-combobox"  name="giftType" style="width:100px;" ></select>
  						&nbsp;<select class="easyui-combobox"  name="giftId" style="width:100px;" ></select>
  					</td>
  					<td align="right">赠券编号：</td>
  					<td>
  						<input class="easyui-textbox"  name="giftCode" style="width:100px;" />
	      			</td>
	      			<td align="right">是否领取：</td>
	      			<td>
  						<input type="radio" value="Y" name="isGet"/><span>是</span>
	      				&nbsp;<input type="radio" value="N" name="isGet"/><span>否</span>
	      			</td>
	      			<td></td>
  				</tr>
  				<tr>
				  <td align="right">赠送日期：</td>
				  <td align="left" colspan="2">
					<input class="easyui-datebox"  name="sendStartTime" style="width:90px;" />
				  	&nbsp;至&nbsp;<input class="easyui-datebox"  name="sendEndTime" style="width:90px;" /></td>
				  <td align="center" colspan="3">领取日期：
				 	<input class="easyui-datebox"  name="getStartTime" style="width:90px;" />
				  	&nbsp;至&nbsp;
					<input class="easyui-datebox"  name="getEndTime" style="width:90px;" />
				  </td>
				  <td align="right">退回日期：</td>
				  <td align="left" colspan="4">
					<input class="easyui-datebox"  name="returnStartTime" style="width:90px;" />
					&nbsp;至&nbsp;
					<input class="easyui-datebox"  name="returnEndTime" style="width:90px;" />
				  </td>
				</tr>
				<tr>
					<td align="right">几天内过期：</td>
					<td align="left"><input class="easyui-textbox"  name="expDate" style="width:100px;" /></td>
					<td colspan="9" align="right">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:90px; height: 25px;" id="qryCouponGift" funcNodeId="4015">查询</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:90px; height: 25px;" id="reset" >重置</a>
				  	</td>
				</tr>
  			</table>
 		</form>
 		
		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:400" id="couponGift_data" toolbar="#couponToolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="false">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="schoolName" align="center" width="6%">校区</th>
					<th field="name" align="center" width="7%">学员姓名</th>
					<th field="byName" align="center" width="6%">英文名</th>
					<th field="phone" align="center" width="11%">联系电话</th>
					<th field="giftChannel" align="center" width="8%">来源类型</th>
					<th field="giftChannelDesc" align="center" width="11%">赠品来源</th>
					<th field="giftTypeVal" align="center" width="8%">赠券类型</th>
					<th field="totalAmount" align="center" width="6%">面值</th>
					<th field="amount" align="center" width="6%">可用金额</th>
					<th field="usableAmount" align="center" width="6%">剩余金额</th>
					<th field="giftCode" align="center" width="9%">赠券编号</th>
					<th field="giftState" align="center" width="8%">赠券状态</th>
					<th field="isGet" align="center" width="6%">是否领取</th>
					<th field="effDate" align="center" width="9%">有效开始日期</th>
					<th field="expDate" align="center" width="9%">有效结束日期</th>
					<th field="createDate" align="center" width="9%">赠送时间</th>
					<th field="getDate" align="center" width="9%">领取时间</th>
					<th field="rtnDate" align="center" width="9%">作废时间</th>
				</tr>
			</thead>
		</table>
		<div id="couponToolbar">
   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="locateStu('coupon')">券类赠品赠送</a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="getCouponGift()">券类领取</a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="couponExchange()">券类兑换</a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" onclick="couponInvalidate()">券类作废</a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" onclick="couponDelay()">券类延期</a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-redo" onclick="viewCouponGiftInfo()">浏览</a>
 		</div>
  	</div>
  	  	<div title="赠课" style="padding:5px;display:block;">
 		<form id="qryCourseFm">
  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="5">
  				<tr>
  					<td align="right" width="8%">所属校区：</td>
  					<td align="left" width="5%">
  						<select name="schoolId" class="easyui-combobox" style="width:100px;" editable="false"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
      						 onLoadSuccess:function(data){$('#schoolId').combobox('setValue',data[0].schoolId);}"
      						url="<%=path %>/pubData/qrySchoolList.do?schoolId=${sessionScope.StaffT.schoolId}">
        				</select>
  					</td>
  					<td align="right" width="8%">学员姓名：</td>
  					<td align="left" width="5%">
  						<select class="easyui-combobox" name="studentId" style="width:100px;">
  							
  						</select>
  					</td>
  					<td align="right" width="8%">联系电话：</td>
  					<td align="left" width="5%">
  						<input class="easyui-textbox"  name="phone" style="width:100px;" />
  					</td>
  					<td align="right" width="10%">班级：</td>
  					<td align="left" width="16%">
  						<input class="easyui-textbox"  name="class" style="width:100px;" />
  					</td>
  					<td width="35%"></td>
  				</tr>
  				<tr>
  					<td align="right">来源类型：</td>
  					<td align="left">
  						<select class="easyui-combobox"  name="giftChannel" style="width:100px;" ></select>
  					</td>
  					<td align="left"><select class="easyui-combobox"  name="giftChannelDetail" style="width:100px;" ></select></td>
  					<td align="center" colspan="3">赠课类型：
  						<select class="easyui-combobox"  name="giftType" style="width:100px;" ></select>
  						&nbsp;<select class="easyui-combobox"  name="giftId" style="width:100px;" ></select>
  					</td>
  					<td align="right">赠券状态：</td>
  					<td>
  						<input class="easyui-combobox"  name="giftState" style="width:100px;" />
	      			</td>
	      			<td></td>
  				</tr>
  				<tr>
				  <td align="right">赠送日期：</td>
				  <td align="left" colspan="2">
					<input class="easyui-datebox"  name="sendStartTime" style="width:90px;" />
				 	 &nbsp;至&nbsp;<input class="easyui-datebox"  name="sendEndTime" style="width:90px;" /></td>
				  <td align="center" colspan="3">终止日期：
				 	<input class="easyui-datebox"  name="breakStartTime" style="width:90px;" />
				  	&nbsp;至&nbsp;
					<input class="easyui-datebox"  name="breakEndTime" style="width:90px;" />
				  </td>
				  <td align="right">几天内过期：</td>
				  <td>
  					<input class="easyui-textbox"  name="expDate" style="width:100px;" />
	      		  </td>
				  <td align="right">
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:90px; height: 25px;" id="qryCourseGift" funcNodeId="4022">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:90px; height: 25px;" id="reset" >重置</a>
				  </td>
  				</tr>
  			</table>
 		</form>
 		
		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:400" id="courseGift_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="schoolName" align="center" width="6%">校区</th>
					<th field="name" align="center" width="6%">学员姓名</th>
					<th field="byName" align="center" width="5%">英文名</th>
					<th field="phone" align="center" width="10%">联系电话</th>
					<th field="giftChannel" align="center" width="7%">来源类型</th>
					<th field="giftChannelDesc" align="center" width="10%">赠品来源</th>
					<th field="giftTypeVal" align="center" width="8%">赠课类型</th>
					<th field="giftNum" align="center" width="6%">赠送课时</th>
					<th field="giftState" align="center" width="6%">赠课状态</th>
					<th field="classProgress" align="center" width="6%">课程进度</th>
					<th field="effDate" align="center" width="7%">有效开始日期</th>
					<th field="expDate" align="center" width="7%">有效结束日期</th>
					<th field="createDate" align="center" width="7%">赠送时间</th>
					<th field="rtnDate" align="center" width="7%">终止时间</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" onclick="courseFinish()">终止</a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-redo" onclick="viewCourseGiftInfo()">浏览</a>
 		</div>
	  	</div>
	  </div>
  	</body>
</html>
