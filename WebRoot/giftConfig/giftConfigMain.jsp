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
		<script type="text/javascript" src="<%=path %>/js/giftConfig/goodsGiftConfig.js"></script>
		<script type="text/javascript" src="<%=path %>/js/giftConfig/courseGiftConfig.js"></script>
		<script type="text/javascript" src="<%=path %>/js/giftConfig/couponGiftConfig.js"></script>
  	</head>
  	<body>
  	<div id="tt" class="easyui-tabs" style="min-width:1110px;width:98%;height:auto;">
  		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<div title="实物赠品" style="padding:5px;display:block;">
			<table align="center" title="查询结果" data-options="height:600" id="goodsGift_data">
				
			</table>
			<div id="goodsToolbar">
	   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="addGoods()">添加</a>
	 		</div>
	 		<div id="goodsDlg" class="easyui-dialog" style="width:550px;height:300px;padding:0px 0px" modal="true" closed="true" buttons="#goods-buttons">
				<form id="goodsFm" method="post">
					<input name="giftId" type="hidden" />
					<table width="98%" style="margin:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
						<tr id="giftCodeTr">
							<td align="right">编号：</td>
							<td align="left"><input name="giftCode" id="giftCode" style="width:265px" class="easyui-textbox" disabled="disabled"/></td>
						</tr>
						<tr>
							<td align="right">品名：</td>
							<td align="left"><input name="giftName" id="giftName" style="width:265px" class="easyui-textbox" required="true" /></td>
						</tr>
						<tr>
							<td align="right">价值金额（元）：</td>
							<td align="left"><input name="amount" id="amount" style="width:265px" class="easyui-numberbox" required="true" /></td>
						</tr>
						<tr>
							<td align="right">使用方式说明：</td>
							<td align="left"><input name="useType" id="useType" style="width:265px" class="easyui-textbox" required="true" /></td>
						</tr>
						<tr>
							<td align="right">领取时效说明：</td>
							<td align="left"><input name="getRemark" id="getRemark" style="width:265px" class="easyui-textbox" /></td>
						</tr>
						<tr>
							<td align="right">有效期说明：</td>
							<td align="left"><input name="effRemark" id="effRemark" style="width:265px" class="easyui-textbox" /></td>
						</tr>
						<tr>
							<td align="right">是否有效：</td>
							<td align="left"><input type="radio" style="vertical-align:middle;" value="Y" name="isEff" checked="checked"/><span>是</span>&nbsp;<input type="radio" style="vertical-align:middle;" value="N" name="isEff"/><span>否</span></td>
						</tr>
					</table>
				</form>
			</div>
			<div id="goods-buttons">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveGoodsSubmit()">提交</a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#goodsDlg').dialog('close')">取消</a>
			</div>
  		</div>
  		<div title="课程赠品" style="padding:5px;display:block;">
			<table align="center" title="查询结果" data-options="height:600" id="courseGift_data">
				
			</table>
			<div id="courseToolbar">
	   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="addCourseType()">添加赠课类型</a>
	 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" onclick="viewCourseTypeInfo()">维护赠课类型</a>
	 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="addCourseName()">添加赠课名称</a>
	 		</div>
	 		<div id="courseTypeDlg" class="easyui-dialog" style="width:550px;height:250px;padding:0px 0px" modal="true" closed="true" buttons="#courseType-buttons">
				<form id="courseTypeFm" method="post">
					<input name="giftType" type="hidden" />
					<table width="98%" style="margin:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
						<tr>
							<td align="right">编号：</td>
							<td align="left"><input name="giftCode" style="width:265px" class="easyui-textbox" /></td>
						</tr>
						<tr>
							<td align="right">赠课类型名称：</td>
							<td align="left"><input name="typeName" style="width:265px" class="easyui-textbox" required="true" /></td>
						</tr>
						<tr>
							<td align="right">管理类型：</td>
							<td align="left"><input type="radio" style="vertical-align:middle;" value="BOOK" name="manageType" checked="checked"/><span>预约赠课</span>&nbsp;<input type="radio" style="vertical-align:middle;" value="SHORT" name="manageType"/><span>短期赠课</span></td>
						</tr>
						<tr>
							<td align="right">有效期（年）：</td>
							<td align="left"><input name="effNum" style="width:265px" class="easyui-numberbox" required="true" /></td>
						</tr>
						<tr>
							<td align="right">有效期说明：</td>
							<td align="left"><input name="effRemark" style="width:265px" class="easyui-textbox" /></td>
						</tr>
					</table>
				</form>
			</div>
			<div id="courseType-buttons">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveCourseType()">提交</a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#courseTypeDlg').dialog('close')">取消</a>
			</div>
	 		<div id="courseNameDlg" class="easyui-dialog" style="width:550px;height:320px;padding:0px 0px" modal="true" closed="true" buttons="#courseName-buttons">
				<form id="courseNameFm" method="post" novalidate>
					<input name="giftId" type="hidden" />
					<input id="courseGiftCode" name="giftCode" type="hidden" />
					<table width="98%" style="margin-top:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
						<tr>
							<td align="right">赠课类型：</td>
							<td align="left"><select id="giftCourseType" name="giftType" style="width:265px;" required="true"></select></td>
						</tr>
						<tr>
							<td align="right">管理类型：</td>
							<td align="left"><input id="manageType" name="manageType" style="width:265px" class="easyui-textbox" disabled="disabled"/></td>
						</tr>
						<tr>
							<td align="right">有效期（年）：</td>
							<td align="left"><input id="courseEffNum" name="courseEffNum" style="width:265px" class="easyui-numberbox" disabled="disabled"/></td>
						</tr>
						<tr>
							<td align="right">有效期说明：</td>
							<td align="left"><input id="courseEffRemark" name="courseEffRemark" style="width:265px" class="easyui-textbox" disabled="disabled"/></td>
						</tr>
						<tr>
							<td align="right">赠课名称：</td>
							<td align="left"><input name="giftName" id="giftName" style="width:265px" class="easyui-textbox" required="true" /></td>
						</tr>
						<tr>
							<td align="right">价值金额：</td>
							<td align="left"><input name="amount" id="amount" style="width:265px" class="easyui-numberbox" required="true" /></td>
						</tr>
						<tr>
							<td align="right">课时：</td>
							<td align="left"><input name="giftNum" id="giftNum" style="width:265px" class="easyui-numberbox" required="true" /></td>
						</tr>
						<tr>
							<td align="right">是否有效：</td>
							<td align="left"><input type="radio" style="vertical-align:middle;" value="Y" name="isEff"/><span>是</span>&nbsp;<input type="radio" style="vertical-align:middle;" value="N" name="isEff"/><span>否</span></td>
						</tr>
					</table>
				</form>
			</div>
			<div id="courseName-buttons">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveCourseName()">提交</a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#courseNameDlg').dialog('close')">取消</a>
			</div>
  		</div>
  		<div title="券类赠品" style="padding:5px;display:block;">
		<table align="center" title="查询结果" data-options="height:600" id="couponGift_data">
			
		</table>
		<div id="couponToolbar">
   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="addCouponType()">增加赠券类型</a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" onclick="viewCouponTypeInfo()">维护赠券类型</a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="addCouponName()">增加券类</a>
 		</div>
		<div id="couponTypeDlg" class="easyui-dialog" style="width:550px;height:270px;padding:0px 0px" modal="true" closed="true" buttons="#couponType-buttons">
			<form id="couponTypeFm" method="post">
			<input name="giftType" type="hidden" />
			<table width="98%" style="margin:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
				<tr>
					<td align="right">编号：</td>
					<td align="left"><input name="giftCode" style="width:265px" class="easyui-textbox" required="true" /></td>
				</tr>
				<tr>
					<td align="right">赠券类型名称：</td>
					<td align="left"><input name="typeName" style="width:265px" class="easyui-textbox" required="true" /></td>
				</tr>
				<tr>
					<td align="right">使用方式：</td>
					<td align="left"><input name="useType" style="width:265px;" class="easyui-textbox" required="true"></select></td>
				</tr>
				<tr>
					<td align="right">有效期（月）：</td>
					<td align="left"><input name="effNum" style="width:265px" class="easyui-numberbox" required="true" /></td>
				</tr>
				<tr>
					<td align="right">有效期说明：</td>
					<td align="left"><input name="effRemark" style="width:265px" class="easyui-textbox" /></td>
				</tr>
				<tr>
					<td align="right">是否抵扣学费：</td>
					<td align="left"><input type="radio" style="vertical-align:middle;" value="Y" name="isMinus" checked="checked"/><span>是</span>&nbsp;<input type="radio" style="vertical-align:middle;" value="N" name="isMinus"/><span>否</span></td>
				</tr>
			</table>
			</form>
		</div>
		<div id="couponType-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveCouponType()">提交</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#couponTypeDlg').dialog('close')">取消</a>
		</div>
 		<div id="couponNameDlg" class="easyui-dialog" style="width:550px;height:340px;padding:0px 0px" modal="true" closed="true" buttons="#couponName-buttons">
			<form id="couponNameFm" method="post">
			<input name="giftId" type="hidden" />
			<input id="couponGiftCode" name="giftCode" type="hidden" />
			<table width="98%" style="margin:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
				<tr>
					<td align="right">赠券类型：</td>
					<td align="left"><select class="easyui-combobox" id="giftCouponType" name="giftType" style="width:265px;" required="true"></select></td>
				</tr>
				<tr>
					<td align="right">使用方式：</td>
					<td align="left"><input id="couponUseType" name="couponUseType" style="width:265px" class="easyui-textbox" disabled="disabled"/></td>
				</tr>
				<tr>
					<td align="right">有效期（月）：</td>
					<td align="left"><input id="couponEffNum" name="couponEffNum" style="width:265px" class="easyui-numberbox" disabled="disabled"/></td>
				</tr>
				<tr>
					<td align="right">有效期说明：</td>
					<td align="left"><input id="couponEffRemark" name="couponEffRemark" style="width:265px" class="easyui-textbox" disabled="disabled"/></td>
				</tr>
				<tr>
					<td align="right">是否抵扣学费：</td>
					<td align="left"><input id="couponMinus" name="couponMinus" style="width:265px" class="easyui-textbox" disabled="disabled"/></td>
				</tr>
				<tr>
					<td align="right">赠券名称：</td>
					<td align="left"><input name="giftName" id="giftName" style="width:265px" class="easyui-textbox" required="true" /></td>
				</tr>
				<tr>
					<td align="right">价值金额：</td>
					<td align="left"><input name="amount" id="amount" style="width:265px" class="easyui-textbox" required="true" /></td>
				</tr>
				<tr>
					<td align="right">是否有效：</td>
					<td align="left"><input type="radio" style="vertical-align:middle;" value="Y" name="isEff"/><span>是</span>&nbsp;<input type="radio" style="vertical-align:middle;" value="N" name="isEff"/><span>否</span></td>
				</tr>
			</table>
			</form>
		</div>
		<div id="couponName-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveCouponName()">提交</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#couponNameDlg').dialog('close')">取消</a>
		</div> 		
	  	</div>
	  </div>
  	</body>
</html>
