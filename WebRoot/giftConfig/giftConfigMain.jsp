<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/giftConfig/goodsGiftConfig.js"></script>
		<script type="text/javascript" src="<%=path %>/js/giftConfig/courseGiftConfig.js"></script>
		<script type="text/javascript" src="<%=path %>/js/giftConfig/couponGiftConfig.js"></script>
  	</head>
  	<body>
  	<div id="tt" class="easyui-tabs" style="min-width:1110px;width:100%;overflow:auto;height:auto;">
  		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<div title="实物赠品" style="padding:5px;display:block;">
			<table align="center" title="查询结果" id="goodsGift_data">
				
			</table>
			<div id="goodsToolbar">
	   			<a href="javascript:void(0)" class="easyui-linkbutton" style="width:100px" iconCls="icon-add" onclick="addGoods()"><span>添加</span></a>
	 		</div>
	 		<div id="goodsDlg" class="easyui-dialog" style="width:550px;height:300px;padding:0px 0px" modal="true" closed="true" buttons="#goods-buttons">
				<form id="goodsFm" method="post">
					<input name="giftId" type="hidden" />
					<table width="98%" style="margin:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
						<tr id="giftCodeTr">
							<td align="right"><span>编号：</span></td>
							<td align="left"><input name="giftCode" id="giftCode" style="width:265px" class="easyui-textbox" disabled="disabled"/></td>
						</tr>
						<tr>
							<td align="right"><span>品名：</span></td>
							<td align="left"><input name="giftName" id="giftName" style="width:265px" class="easyui-textbox" required="true" /></td>
						</tr>
						<tr>
							<td align="right"><span>价值金额（元）：</span></td>
							<td align="left"><input name="amount" id="amount" style="width:265px" class="easyui-numberbox" required="true" /></td>
						</tr>
						<tr>
							<td align="right"><span>使用方式说明：</span></td>
							<td align="left"><input name="useType" id="useType" style="width:265px" class="easyui-textbox" required="true" /></td>
						</tr>
						<tr>
							<td align="right"><span>领取时效说明：</span></td>
							<td align="left"><input name="getRemark" id="getRemark" style="width:265px" class="easyui-textbox" /></td>
						</tr>
						<tr>
							<td align="right"><span>有效期说明：</span></td>
							<td align="left"><input name="effRemark" id="effRemark" style="width:265px" class="easyui-textbox" /></td>
						</tr>
						<tr>
							<td align="right"><span>是否有效：</span></td>
							<td align="left"><input type="radio" style="vertical-align:middle;" value="Y" name="isEff" checked="checked"/><span>是</span>&nbsp;<input type="radio" style="vertical-align:middle;" value="N" name="isEff"/><span>否</span></td>
						</tr>
					</table>
				</form>
			</div>
			<div style="text-align:center" id="goods-buttons">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="saveGoodsSubmit()"><span>提交</span></a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" style="width:100px;" onclick="javascript:$('#goodsDlg').dialog('close')"><span>取消</span></a>
			</div>
  		</div>
  		<div title="课程赠品" style="padding:5px;display:block;">
			<table align="center" title="查询结果" id="courseGift_data" class="easyui-datagrid">
				
			</table>
			<div id="courseToolbar">
	   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" style="width:120px"  onclick="addCourseType()"><span>添加赠课类型</span></a>
	 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" style="width:120px"  onclick="viewCourseTypeInfo()"><span>维护赠课类型</span></a>
	 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" style="width:120px"  onclick="addCourseName()"><span>添加赠课名称</span></a>
	 		</div>
	 		<div id="courseTypeDlg" class="easyui-dialog" style="width:550px;height:230px;padding:0px 0px" modal="true" closed="true" buttons="#courseType-buttons">
				<form id="courseTypeFm" method="post">
					<input name="giftType" type="hidden" />
					<table width="98%" style="margin:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
						<tr>
							<td align="right"><span>赠课类型名称：</span></td>
							<td align="left"><input name="typeName" style="width:265px" class="easyui-textbox" required="true" /></td>
						</tr>
						<tr>
							<td align="right"><span>管理类型：</span></td>
							<td align="left"><input type="radio" style="vertical-align:middle;" value="BOOK" name="manageType" checked="checked"/><span>预约赠课</span>&nbsp;<input type="radio" style="vertical-align:middle;" value="SHORT" name="manageType"/><span>短期赠课</span></td>
						</tr>
						<tr>
							<td align="right"><span>有效期（年）：</span></td>
							<td align="left"><input name="effNum" style="width:265px" class="easyui-numberbox" required="true" /></td>
						</tr>
						<tr>
							<td align="right"><span>有效期说明：</span></td>
							<td align="left"><input name="effRemark" style="width:265px" class="easyui-textbox" /></td>
						</tr>
					</table>
				</form>
			</div>
			<div style="text-align:center" id="courseType-buttons">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="saveCourseType()"><span>提交</span></a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" style="width:100px;" onclick="javascript:$('#courseTypeDlg').dialog('close')"><span>取消</span></a>
			</div>
	 		<div id="courseNameDlg" class="easyui-dialog" style="width:550px;height:320px;padding:0px 0px" modal="true" closed="true" buttons="#courseName-buttons">
				<form id="courseNameFm" method="post" novalidate>
					<input name="giftId" type="hidden" />
					<input id="courseGiftCode" name="giftCode" type="hidden" />
					<table width="98%" style="margin-top:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
						<tr>
							<td align="right"><span>赠课类型：</span></td>
							<td align="left"><select id="giftCourseType" name="giftType" style="width:265px;" required="true"></select></td>
						</tr>
						<tr>
							<td align="right"><span>管理类型：</span></td>
							<td align="left"><input id="manageType" name="manageType" style="width:265px" class="easyui-textbox" disabled="disabled"/></td>
						</tr>
						<tr>
							<td align="right"><span>有效期（年）：</span></td>
							<td align="left"><input id="courseEffNum" name="courseEffNum" style="width:265px" class="easyui-numberbox" disabled="disabled"/></td>
						</tr>
						<tr>
							<td align="right"><span>有效期说明：</span></td>
							<td align="left"><input id="courseEffRemark" name="courseEffRemark" style="width:265px" class="easyui-textbox" disabled="disabled"/></td>
						</tr>
						<tr>
							<td align="right"><span>赠课名称：</span></td>
							<td align="left"><input name="giftName" id="giftName" style="width:265px" class="easyui-textbox" required="true" /></td>
						</tr>
						<tr>
							<td align="right"><span>价值金额：</span></td>
							<td align="left"><input name="amount" id="amount" style="width:265px" class="easyui-numberbox" required="true" /></td>
						</tr>
						<tr>
							<td align="right"><span>课时：</span></td>
							<td align="left"><input name="giftNum" id="giftNum" style="width:265px" class="easyui-numberbox" required="true" /></td>
						</tr>
						<tr>
							<td align="right"><span>是否有效：</td>
							<td align="left"><input type="radio" style="vertical-align:middle;" value="Y" name="isEff"/><span>是</span>&nbsp;<input type="radio" style="vertical-align:middle;" value="N" name="isEff"/><span>否</span></td>
						</tr>
					</table>
				</form>
			</div>
			<div style="text-align:center" id="courseName-buttons">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="saveCourseName()"><span>提交</span></a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" style="width:100px;" onclick="javascript:$('#courseNameDlg').dialog('close')"><span>取消</span></a>
			</div>
  		</div>
  		<div title="券类赠品" style="padding:5px;display:block;">
		<table align="center" title="查询结果" id="couponGift_data" class="easyui-datagrid">
			
		</table>
		<div id="couponToolbar">
   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" style="width:120px" onclick="addCouponType()"><span>增加赠券类型</span></a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" style="width:120px" onclick="viewCouponTypeInfo()"><span>维护赠券类型</span></a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" style="width:100px" onclick="addCouponName()"><span>增加券类</span></a>
 		</div>
		<div id="couponTypeDlg" class="easyui-dialog" style="width:550px;height:250px;padding:0px 0px" modal="true" closed="true" buttons="#couponType-buttons">
			<form id="couponTypeFm" method="post">
			<input name="giftType" type="hidden" />
			<table width="98%" style="margin:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
				<tr>
					<td align="right"><span>赠券类型名称：</span></td>
					<td align="left"><input name="typeName" style="width:265px" class="easyui-textbox" required="true" /></td>
				</tr>
				<tr>
					<td align="right"><span>使用方式：<span></td>
					<td align="left"><input name="useType" style="width:265px;" class="easyui-textbox" required="true"></select></td>
				</tr>
				<tr>
					<td align="right"><span>有效期（月）：</span></td>
					<td align="left"><input name="effNum" style="width:265px" class="easyui-numberbox" required="true" /></td>
				</tr>
				<tr>
					<td align="right"><span>有效期说明：</span></td>
					<td align="left"><input name="effRemark" style="width:265px" class="easyui-textbox" /></td>
				</tr>
				<tr>
					<td align="right"><span>是否抵扣学费：</span></td>
					<td align="left"><input type="radio" style="vertical-align:middle;" value="Y" name="isMinus" checked="checked"/><span>是</span>&nbsp;<input type="radio" style="vertical-align:middle;" value="N" name="isMinus"/><span>否</span></td>
				</tr>
			</table>
			</form>
		</div>
		<div style="text-align:center" id="couponType-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="saveCouponType()"><span>提交</span></a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" style="width:100px;" onclick="javascript:$('#couponTypeDlg').dialog('close')"><span>取消</span></a>
		</div>
 		<div id="couponNameDlg" class="easyui-dialog" style="width:550px;height:390px;padding:0px 0px" modal="true" closed="true" buttons="#couponName-buttons">
			<form id="couponNameFm" method="post">
			<input name="giftId" type="hidden" />
			<input id="couponGiftCode" name="giftCode" type="hidden" />
			<table width="98%" style="margin:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
				<tr>
					<td align="right"><span>赠券类型：</span></td>
					<td align="left"><select class="easyui-combobox" id="giftCouponType" name="giftType" style="width:265px;" required="true"></select></td>
				</tr>
				<tr>
					<td align="right"><span>使用方式：</span></td>
					<td align="left"><input id="couponUseType" name="couponUseType" style="width:265px" class="easyui-textbox" disabled="disabled"/></td>
				</tr>
				<tr>
					<td align="right"><span>有效期（月）：</span></td>
					<td align="left"><input id="couponEffNum" name="couponEffNum" style="width:265px" class="easyui-numberbox" disabled="disabled"/></td>
				</tr>
				<tr>
					<td align="right"><span>有效期说明：</span></td>
					<td align="left"><input id="couponEffRemark" name="couponEffRemark" style="width:265px" class="easyui-textbox" disabled="disabled"/></td>
				</tr>
				<tr>
					<td align="right"><span>是否抵扣学费：</span></td>
					<td align="left"><input id="couponMinus" name="couponMinus" style="width:265px" class="easyui-textbox" disabled="disabled"/></td>
				</tr>
				<tr id="minusCourses" style="display:none">
					<td align="right"><span>抵扣课程类型：</span></td>
					<td align="left"><input type="checkbox"   name="courseTypes" value="001"><span>常规课</span>&nbsp;&nbsp;<input type="checkbox"   name="courseTypes" value="002"><span>短期课</span></td>
				</tr>
				<tr>
						<td align="right"><span>领取时效说明：</span></td>
						<td align="left"><input name="getRemark" id="getRemark" style="width:265px" class="easyui-textbox" /></td>
				</tr>
				<tr>
					<td align="right"><span>赠券名称：</span></td>
					<td align="left"><input name="giftName" id="giftName" style="width:265px" class="easyui-textbox" required="true" /></td>
				</tr>
				<tr>
					<td align="right"><span>价值金额：</span></td>
					<td align="left"><input name="amount" id="amount" style="width:265px" class="easyui-textbox" required="true" /></td>
				</tr>
				<tr>
					<td align="right"><span>是否有效：</span></td>
					<td align="left"><input type="radio" style="vertical-align:middle;" value="Y" name="isEff"/><span>是</span>&nbsp;<input type="radio" style="vertical-align:middle;" value="N" name="isEff"/><span>否</span></td>
				</tr>
			</table>
			</form>
		</div>
		<div style="text-align:center" id="couponName-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="saveCouponName()"><span>提交</span></a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" style="width:100px;" onclick="javascript:$('#couponNameDlg').dialog('close')"><span>取消</span></a>
		</div> 		
	  	</div>
	  </div>
  	</body>
</html>
