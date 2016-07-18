<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/giftManage/goodsGiftManage.js"></script>
		<script type="text/javascript" src="<%=path %>/js/giftManage/couponGiftManage.js"></script>
		<script type="text/javascript" src="<%=path %>/js/giftManage/courseGiftManage.js"></script>
  	</head>
  	<body>
  	<div id="tt" class="easyui-tabs" style="min-width:1110px;width:100%;height:auto;">
  	<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
  	<div title="实物&教材赠品" style="padding:5px;display:block;">
 		<form id="qryGoodsFm">
  			<table class="search_tab">
  				<tr>
  					<td align="right" width="80px"><span>所属校区：</span></td>
  					<td align="left" width="110px">
  						<select id="goodsSchoolId" editable="false" name="schoolId" class="easyui-combobox" style="width:100px;height:25px;">
        				</select>
  					</td>
  					<td align="right" width="70px"><span>学员姓名：</span></td>
  					<td align="left" width="110px">
  						<input class="easyui-textbox" name="studentName" id="goodsStudentName" style="width:100px;height:25px;" />
  					</td>
  					<td align="right" width="70px"><span>联系电话：</span></td>
  					<td align="left" width="110px">
  						<input class="easyui-textbox"  name="phone" style="width:100px;height:25px;" />
  					</td>
  					<td align="right" width="50px"><span>班级：</span></td>
  					<td align="left" width="110px">
  						<input id="goodsClassInstId" name="className" class="easyui-textbox" style="width:100px;height:25px;" />
  					</td>
  					<td></td>
  					<td></td>
  				</tr>
  				<tr>
  					<td align="right"><span>来源类型：</span></td>
  					<td align="left">
  						<select class="easyui-combobox" id="goodsGiftChannel" name="giftChannel" style="width:100px;height:25px;" ></select>
  					</td>
  					<td align="left"><select class="easyui-combobox" id="goodsStageId"  name="channelVal" style="width:100px;height:25px;" disabled="disabled"></select></td>
  					<td align="center" colspan="2"><span>赠品类型：</span>
  						<select class="easyui-combobox" id="goodsGiftType"  name="giftType" style="width:100px;height:25px;" 
	  						 data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	   					 	 url="<%=path %>/pubData/qryCodeNameList.do?tableName=GIFT_TYPE_T&codeType=PARENT_TYPE&codeFlag=GOODS,TEXTBOOK" >
   					    </select>
  					</td>
  					<td align="center" colspan="2" ><span>赠品：</span>
  						<select class="easyui-combobox" id="goodsGiftId" name="giftId" style="width:100px;height:25px;" ></select>
  					</td>
  					<td align="left" colspan="2"><span>是否领取：</span>
  						<input type="radio" value="Y" name="isGet"/><span>是</span>
	      				<input type="radio" value="N" name="isGet"/><span>否</span>
	      				&nbsp;&nbsp;<span>是否退回：</span>
  						<input type="radio" value="Y" name="isRtn"/><span>是</span>
	      				<input type="radio" value="N" name="isRtn"/><span>否</span>
	      			</td>
	      			<td></td>
  				</tr>
  				<tr>
				  <td align="right"><span>赠送日期：</span></td>
				  <td align="left" colspan="2">
					<input class="easyui-datebox"  name="sendStartTime" style="width:90px;height:25px;" />
				   <span>至&nbsp;</span><input class="easyui-datebox"  name="sendEndTime" style="width:90px;height:25px;" /></td>
				  <td align="left" style="padding-left:5px" colspan="7"><span>领取日期：</span>
				  <input class="easyui-datebox"  name="getStartTime" style="width:90px;height:25px;" />
				  	<span>至</span>
					<input class="easyui-datebox"  name="getEndTime" style="width:90px;height:25px;" />
				 	<span>退回日期：</span>
					<input class="easyui-datebox"  name="returnStartTime" style="width:90px;height:25px;" />
					<span>至</span>
					<input class="easyui-datebox"  name="returnEndTime" style="width:90px;height:25px;" />
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px;" id="qryGoodsGift" funcNodeId="4010"><span>查询</span></a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px;" id="resetGoods" ><span>重置</span></a>
				  </td>
  				</tr>
  			</table>
 		</form>
		<table class="easyui-datagrid" align="center" title="查询结果"  id="goodsGift_data" toolbar="#goodsToolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="fasle">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="schoolName" align="center" width="6%"><span>校区</span></th>
					<th field="name" align="center" width="6%"><span>学员姓名</span></th>
					<th field="byName" align="center" width="5%"><span>英文名</span></th>
					<th field="phone" align="center" width="11%"><span>联系电话</span></th>
					<th field="giftChannel" align="center" width="8%"><span>来源类型</span></th>
					<th field="giftChannelDesc" align="center" width="11%"><span>赠品来源</span></th>
					<th field="giftName" align="center" width="11%"><span>赠品名称</span></th>
					<th field="isGet" align="center" width="6%"><span>是否领取</span></th>
					<th field="isRtn" align="center" width="6%"><span>是否退回</span></th>
					<th field="createDate" align="center" width="9%"><span>赠送时间</span></th>
					<th field="getDate" align="center" width="9%"><span>领取时间</span></th>
					<th field="rtnDate" align="center" width="9%"><span>退回时间</span></th>
				</tr>
			</thead>
		</table>
		<div id="goodsToolbar" style="padding: 2px;height:auto;">
   			<a href="javascript:void(0)" id="toolbtn1" class="easyui-linkbutton" iconCls="icon-add" style="width:120px;" onclick="locateStu('goods')"><span>实物赠品赠送</span></a>
 			<a href="javascript:void(0)" id="toolbtn2" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="getGoodsGift()"><span>赠品领取</span></a>
 			<a href="javascript:void(0)" id="toolbtn3" class="easyui-linkbutton" iconCls="icon-remove" style="width:100px;" onclick="rtnGoodsGift()"><span>赠品退回</span></a>
 			<a href="javascript:void(0)" id="toolbtn4" class="easyui-linkbutton" iconCls="icon-redo" style="width:100px;" onclick="viewGoodsGift()"><span>浏览</span></a>
 		</div>
  	</div>
  	  	<div title="劵类赠品" style="padding:5px;display:block;">
 		 <form id="qryCouponFm">
  			<table class="search_tab">
  				<tr>
  					<td align="right" width="80px"><span>所属校区：</span></td>
  					<td align="left" width="110px">
  						<select id="couponSchoolId" editable="false" name="schoolId" class="easyui-combobox" style="width:100px;height:25px;" >
        				</select>
  					</td>
  					<td align="right" width="70px"><span>学员姓名：</span></td>
  					<td align="left" width="110px">
  						<input class="easyui-textbox" name="studentName" id="couponStudentName" style="width:100px;height:25px;" />
  					</td>
  					<td align="right" width="70px"><span>联系电话：</span></td>
  					<td align="left" width="110px">
  						<input class="easyui-textbox" name="phone" style="width:100px;height:25px;" />
  					</td>
  					<td align="right" width="70px"><span>班级：</span></td>
  					<td align="left" width="110px">
  						<input id="couponClassInstId" name="className" class="easyui-textbox" style="width:100px;height:25px;" />
  					</td>
  					<td align="right" width="70px"><span>赠券状态：</span></td>
  					<td align="left" width="150px">
  						<select id="couponState" class="easyui-combobox" name="giftState" style="width:100px;height:25px;"
  							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_GIFT_T&codeType=COUPON_STATE">
  						</select>
  					</td>
  					<td></td>
  				</tr>
  				<tr>
  					<td align="right"><span>来源类型：</span></td>
  					<td align="left">
  						<select class="easyui-combobox" id="couponGiftChannel"  name="giftChannel" style="width:100px;height:25px;" ></select>
  					</td>
  					<td align="left"><select class="easyui-combobox" id="couponStageId"  name="channelVal" style="width:100px;height:25px;" disabled="disabled"></select></td>
  					<td align="center" colspan="3"><span>赠券类型：</span>
  						<select class="easyui-combobox" id="couponGiftType"  name="giftType" style="width:100px;height:25px;" ></select>
  						&nbsp;<select class="easyui-combobox" id="couponGiftId"  name="giftId" style="width:100px;height:25px;" ></select>
  					</td>
  					<td align="right"><span>赠券编号：</span></td>
  					<td>
  						<input class="easyui-textbox"  name="giftCode" style="width:100px;height:25px;" />
	      			</td>
	      			<td align="right"><span>是否领取：</span></td>
	      			<td>
  						<input type="radio" value="Y" name="isGet"/><span>是</span>
	      				&nbsp;<input type="radio" value="N" name="isGet"/><span>否</span>
	      			</td>
	      			<td></td>
  				</tr>
  				<tr>
				  <td align="right"><span>赠送日期：</span></td>
				  <td align="left" colspan="2">
					<input class="easyui-datebox"  name="sendStartTime" style="width:95px;height:25px;" />
				  	<span>至&nbsp;</span><input class="easyui-datebox"  name="sendEndTime" style="width:95px;" /></td>
				  <td align="center" colspan="3"><span>领取日期：</span>
				 	<input class="easyui-datebox"  name="getStartTime" style="width:95px;height:25px;" />
				  	<span>至</span>
					<input class="easyui-datebox"  name="getEndTime" style="width:95px;height:25px;" />
				  </td>
				  <td align="right"><span>作废日期：</span></td>
				  <td align="left" colspan="4">
					<input class="easyui-datebox"  name="returnStartTime" style="width:95px;height:25px;" />
					<span>至</span>
					<input class="easyui-datebox"  name="returnEndTime" style="width:95px;height:25px;" />
					&nbsp;&nbsp;<span>几天内过期：</span>
					<input class="easyui-numberbox"  name="expedTime" style="width:50px;height:25px;" />
				  </td>
				</tr>
				<tr>
					<td colspan="10" align="center">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px;" id="qryCouponGift" funcNodeId="4015"><span>查询</span></a>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px;" id="resetCoupon" ><span>重置</span></a>
				  	</td>
				</tr>
  			</table>
 		</form>
		<table class="easyui-datagrid" align="center" title="查询结果"  id="couponGift_data" toolbar="#couponToolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="false">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="schoolName" align="center" width="6%"><span>校区</span></th>
					<th field="name" align="center" width="7%"><span>学员姓名</span></th>
					<th field="byName" align="center" width="6%"><span>英文名</span></th>
					<th field="phone" align="center" width="11%"><span>联系电话</span></th>
					<th field="giftChannel" align="center" width="8%"><span>来源类型</span></th>
					<th field="giftChannelDesc" align="center" width="11%"><span>赠品来源</span></th>
					<th field="giftTypeVal" align="center" width="8%"><span>赠券类型</span></th>
					<th field="totalAmount" align="center" width="6%"><span>面值</span></th>
					<th field="amount" align="center" width="6%"><span>可用金额</span></th>
					<th field="usableAmount" align="center" width="6%"><span>剩余金额</span></th>
					<th field="giftCode" align="center" width="9%"><span>赠券编号</span></th>
					<th field="giftState" align="center" width="8%"><span>赠券状态</span></th>
					<th field="isGet" align="center" width="6%"><span>是否领取</span></th>
					<th field="effDate" align="center" width="9%"><span>有效开始日期</span></th>
					<th field="expDate" align="center" width="9%"><span>有效结束日期</span></th>
					<th field="createDate" align="center" width="9%"><span>赠送时间</span></th>
					<th field="getDate" align="center" width="9%"><span>领取时间</span></th>
					<th field="rtnDate" align="center" width="9%"><span>作废时间</span></th>
				</tr>
			</thead>
		</table>
		<div id="couponToolbar" style="padding: 2px;height:auto;">
   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" style="width:120px;" onclick="locateStu('coupon')"><span>券类赠品赠送</span></a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="getCouponGift()"><span>券类领取</span></a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="couponExchange()"><span>券类兑换</span></a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" style="width:100px;" onclick="couponInvalidate()"><span>券类作废</span></a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="couponDelay()"><span>券类延期</span></a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-redo" style="width:100px;" onclick="viewCouponGiftInfo()"><span>浏览</span></a>
 		</div>
  	</div>
  	  	<div title="赠课" style="padding:5px;display:block;">
 		<form id="qryCourseFm">
  			<table class="search_tab">
  				<tr>
  					<td align="right" width="10%"><span>所属校区：</span></td>
  					<td align="left" width="5%">
  						<select id="courseSchoolId" editable="false" name="schoolId" class="easyui-combobox" style="width:100px;height:25px;">
        				</select>
  					</td>
  					<td align="right" width="11%"><span>学员姓名：</span></td>
  					<td align="left" width="5%">
  						<input class="easyui-textbox" name="studentName" id="couponStudentName" style="width:100px;height:25px;" />
  					</td>
  					<td align="right" width="10%"><span>联系电话：</span></td>
  					<td align="left" width="5%">
  						<input class="easyui-textbox" name="phone" style="width:100px;height:25px;" />
  					</td>
  					<td align="right" width="11%"><span>班级：</span></td>
  					<td align="left" width="16%">
  						<input id="courseClassInstId" name="className" class="easyui-textbox" style="width:100px;height:25px;" />
  					</td>
  					<td width="27%"></td>
  				</tr>
  				<tr>
  					<td align="right"><span>来源类型：</span></td>
  					<td align="left">
  						<select class="easyui-combobox" id="courseGiftChannel" name="giftChannel" style="width:100px;height:25px;" ></select>
  					</td>
  					<td align="left"><select class="easyui-combobox" id="courseStageId"  name="channelVal" style="width:100px;height:25px;" disabled="disabled"></select></td>
  					<td align="center" colspan="3"><span>赠课类型：</span>
  						<select class="easyui-combobox" id="courseGiftType"  name="giftType" style="width:100px;height:25px;" ></select>
  						&nbsp;<select class="easyui-combobox" id="courseGiftId" name="giftId" style="width:100px;height:25px;" ></select>
  					</td>
  					<td align="right"><span>赠课状态：</span></td>
  					<td>
  						<select id="couponState" class="easyui-combobox" name="giftState" style="width:100px;height:25px;"
  							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_GIFT_T&codeType=COURSE_STATE">
  						</select>
	      			</td>
	      			<td></td>
  				</tr>
  				<tr>
				  <td align="right"><span>赠送日期：</span></td>
				  <td align="left" colspan="2">
					<input class="easyui-datebox"  name="sendStartTime" style="width:95px;height:25px;" />
				 	 <span>至&nbsp;</span><input class="easyui-datebox"  name="sendEndTime" style="width:95px;height:25px;" /></td>
				  <td align="center" colspan="3"><span>终止日期：</span>
				 	<input class="easyui-datebox"  name="breakStartTime" style="width:95px;height:25px;" />
				  	<span>至</span>
					<input class="easyui-datebox"  name="breakEndTime" style="width:95px;height:25px;" />
				  </td>
				  <td align="right"><span>几天内过期：</span></td>
				  <td>
  					<input class="easyui-textbox"  name="expedTime" style="width:100px;height:25px;" />
	      		  </td>
				  <td align="left">
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px;" id="qryCourseGift" funcNodeId="4022"><span>查询</span></a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px;" id="resetCourse" ><span>重置</span></a>
				  </td>
  				</tr>
  			</table>
 		</form>
		<table class="easyui-datagrid" align="center" title="查询结果"   id="courseGift_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="schoolName" align="center" width="6%"><span>校区</span></th>
					<th field="name" align="center" width="6%"><span>学员姓名</span></th>
					<th field="byName" align="center" width="5%"><span>英文名</span></th>
					<th field="phone" align="center" width="10%"><span>联系电话</span></th>
					<th field="giftChannel" align="center" width="7%"><span>来源类型</span></th>
					<th field="giftChannelDesc" align="center" width="10%"><span>赠品来源</span></th>
					<th field="giftTypeVal" align="center" width="8%"><span>赠课类型</span></th>
					<th field="giftNum" align="center" width="6%"><span>赠送课时</span></th>
					<th field="giftState" align="center" width="6%"><span>赠课状态</span></th>
					<th field="classProgress" align="center" width="6%"><span>课程进度</span></th>
					<th field="effDate" align="center" width="7%"><span>有效开始日期</span></th>
					<th field="expDate" align="center" width="7%"><span>有效结束日期</span></th>
					<th field="createDate" align="center" width="7%"><span>赠送时间</span></th>
					<th field="rtnDate" align="center" width="7%"><span>终止时间</span></th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px;height:auto;">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" style="width:100px;" onclick="locateStu('course')"><span>赠送</span></a>
   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" style="width:100px;" onclick="courseFinish()"><span>终止</span></a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-redo" style="width:100px;" onclick="viewCourseGiftInfo()"><span>浏览</span></a>
 		</div>
	  	</div>
	  </div>
  	</body>
</html>
