<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/giftConfig/textbookConfig.js"></script>
  	</head>
  	<body>
  		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<div class="easyui-panel" style="min-width:1100px; width:100%;height:auto;padding:5px;display:block;" title="教材配置">
			<table align="center" title="查询结果"  id="textbook_data">
				
			</table>
			<div id="textbookToolbar">
	   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="addTextbook()"><span>添加教材</span></a>
	 		</div>
	 		<div id="textbookDlg" class="easyui-dialog" style="width:550px;height:245px;padding:0px 0px" modal="true" closed="true" buttons="#textbook-buttons">
				<form id="textbookFm" method="post">
					<input name="giftId" type="hidden" />
					<table width="98%" style="margin:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
						<tr id="giftCodeTr">
							<td align="right"><span>编号：</span></td>
							<td align="left"><input name="giftCode" id="giftCode" style="width:265px" class="easyui-textbox" disabled="disabled"/></td>
						</tr>
						<tr>
							<td align="right"><span>教材名称：</span></td>
							<td align="left"><input name="giftName" id="giftName" style="width:265px" class="easyui-textbox" required="true" /></td>
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
							<td align="right"><span>是否有效：</span></td>
							<td align="left"><input type="radio" style="vertical-align:middle;" value="Y" name="isEff" checked="checked"/><span>是</span>&nbsp;<input type="radio" style="vertical-align:middle;" value="N" name="isEff"/><span>否</span></td>
						</tr>
					</table>
				</form>
			</div>
			<div style="text-align:center" id="textbook-buttons">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="saveTextbookSubmit()"><span>提交</span></a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" style="width:100px;" onclick="javascript:$('#textbookDlg').dialog('close')"><span>取消</span></a>
			</div>
  		</div>
  	</body>
</html>
