<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String shortClassInstId =request.getParameter("shortClassInstId");
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  	<body>
 		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
 		<input id="shortClassInstId" type="hidden" value="<%=shortClassInstId %>"/>
 		<input id="studentLinkId" type="hidden" value=""/>
 		<div  class="easyui-panel" title="学生反馈信息" style="width:1100px;">
 			<table id="infoTab" width="100%;" class="maintable">
 				<tr>
 					<td align="left" colspan="8">  			
 				 		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" style="width:150px" onclick="addInfo()" ><span>添加</span></a>	
					</td>
				</tr>
				<tr>
					<td align="center" width="100px;"><span>姓名</span></td><td align="center"><span>缴费情况</span></td><td align="center"><span>缴费日期</span></td><td align="center" width="110px;"><span>是否定金转全费</span></td>
					<td align="center" width="130px;"><span>定金转全费日期</span></td><td align="center" width="100px;"><span>是否补缴全费</span></td><td align="center" width="160px;"><span>补缴全费日期</span></td><td align="center" width="220px;"><span>操作</span></td>
				</tr>
				<tr id="modelTr" style="display:none">
					<td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td>
					<td align="center"></td><td align="center"></td><td align="center"></td>
					<td align="center">
						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px" onclick="updateInfo(this)" ><span>修改</span></a>
						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" style="width:100px" onclick="deleteInfo(this)"><span>删除</span></a>	
					</td>
				</tr>
 			</table>	
 		</div>
 		<div style="width:1100px;text-align:center;margin-top:25px;">
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:150px" id="backBtn" ><span>返回</span></a>	
  		</div>
  		<div id="dlg" class="easyui-dialog" style="width: 580px; height: 350px; padding: 10px 20px" closed="true" data-options="modal:true" buttons="#dlgBtn">
  			<table  class="tab" style="width:500px;margin:20px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0"">
  				<tr>
  					<td align="right">姓名:</td><td align="center" colspan="2"><input type="text" id="studentName" class="easyui-textbox" style="width:120px;height:25px;"></td>
  					<td align="right"></td><td align="center"></td>
  				</tr>
  				<tr>
  					<td align="right">缴费情况:</td>
  					<td align="center" style="border-right:none;">
  						<input type="radio" name="001" value="Y" title="双击取消选择"><lable>全费</lable>
  					</td>
  					<td>	
  						<input type="radio" name="001" value="N" title="双击取消选择"><lable>定金</lable>
  					</td>
  					<td align="right">缴费日期:</td>
  					<td align="center"><input style="width:120px;height:25px" id="001" type="text" class="easyui-datebox"></td>
  				</tr>
  				<tr>
  					<td align="right">是否定金转全费:</td>
  					<td align="center" style="padding-right:16px;border-right:none;">
  						<input type="radio" name="002" value="N" title="双击取消选择"><lable>否</lable>
  					</td>
  					<td>	
  						<input type="radio" name="002" value="Y" title="双击取消选择"><lable>是</lable>
  					</td>
  					<td align="right">定金转全费日期:</td>
  					<td align="center"><input style="width:120px;height:25px" id="002" type="text" class="easyui-datebox"></td>
  				</tr>
  				<tr>
  					<td align="right">是否补缴全费:</td>
  					<td align="center" style="padding-right:16px;border-right:none;">
  						<input type="radio" name="003" value="N" title="双击取消选择"><lable>否</lable>
  					</td>
  					<td>	
  						<input type="radio" name="003" value="Y" title="双击取消选择"><lable>是</lable>
  					</td>
  					<td align="right">补缴全费日期:</td>
  					<td align="center"><input style="width:120px;height:25px" id="003" type="text" class="easyui-datebox"></td>
  				</tr>
  			</table>
  		</div>
  		<div id="dlgBtn">
    		<a href="javascript:void(0)" id="submitBtn" class="easyui-linkbutton" iconCls="icon-ok">提交</a> 
    		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
  		</div>	
  	</body>
</html>
<script type="text/javascript">
	ajaxLoadEnd();
	$(document).ready(function(){
		$("#backBtn").click(function(){
			window.history.back();
		});
		initPage();
		$("input[type='radio']").dblclick(function(){
			$(this).attr("checked",false);
		})
		$("#submitBtn").click(function(){
			submitInfo();
		})
	});
	
	function initPage()
	{
		$.ajax( {
			type : "POST",
			url : "/sys/demoClass/qryStuFeedbackInfo.do",
			data :"shortClassInstId="+$("#shortClassInstId").val(),
			async : false,
			dataType:"json",
			beforeSend : function() {
				showProgressLoader("正在加载数据,请稍等...", 400);
			},
			success : function(data) {
				hideProgressLoader();
				if(data!=null&&data.length>0)
				{
					$.each(data,function(i,obj){
						var tr =$("#modelTr").clone();
						tr.find("td:eq(0)").html(obj.studentName);
						var fee1=fee2=fee3="";
						if(obj.fee1=="Y")
						{
							fee1="全费";
						}
						else if(obj.fee1=="N")
						{
							fee1="定金";
						}
						if(obj.fee2=="Y")
						{
							fee2="是";
						}
						else if(obj.fee2=="N")
						{
							fee2="否";
						}
						if(obj.fee3=="Y")
						{
							fee3="是";
						}
						else if(obj.fee3=="N")
						{
							fee3="否";
						}
						tr.find("td:eq(1)").html(fee1);
						tr.find("td:eq(2)").html(obj.date1);
						tr.find("td:eq(3)").html(fee2);
						tr.find("td:eq(4)").html(obj.date2);
						tr.find("td:eq(5)").html(fee3);
						tr.find("td:eq(6)").html(obj.date3);
						tr.attr("studentLinkId",obj.studentLinkId);
						tr.css("display","table-row");
						$("#infoTab").append(tr);
					});
				}	
			},
			error : function() {
				hideProgressLoader();
				showMessage('提示', "调用查询学生反馈服务失败！", null);
			}
		});
	}
	
	function addInfo()
	{	
		clearData("dlg");
		$("#studentLinkId").val("");
		$("#studentName").textbox({disabled:""});
		$("#dlg").dialog('open').dialog('setTitle', '新增反馈');
	}
	
	function submitInfo()
	{
		if($("#studentName").textbox("getValue")=="")
		{
			$.messager.alert("提示", "请填写学生姓名");
			return false;
		}
		var param =[];
		for(var i=1;i<4;i++)
		{
			var obj ={};
			obj.shortClassInstId =$("#shortClassInstId").val();
			obj.handlerId =$("#handlerId").val();
			obj.studentName=$("#studentName").textbox("getValue");
			var radioName ="00"+i;
			obj.feeType =radioName;
			if($("input[name='"+radioName+"']:checked").val()!=undefined)
			{
				obj.isChecked=$("input[name='"+radioName+"']:checked").val();
			}
			if($("#"+radioName).datebox("getValue")!="")
			{
				obj.feeDate =$("#"+radioName).datebox("getValue");
			}
			if($("#studentLinkId").val()!="")
			{
				obj.studentLinkId=$("#studentLinkId").val();
			}	
			param.push(obj)
		}
		$.ajax( {
			type : "POST",
			url : "/sys/demoClass/addStuFeedback.do",
			data :"param="+JSON.stringify(param),
			async : false,
			beforeSend : function() {
				showProgressLoader("正在录入反馈,请稍等...", 400);
			},
			success : function(data) {
				hideProgressLoader()
				if (data == "true") {
					showMessage('提示', "录入反馈成功！", function() {
						$('#dlg').dialog('close');
						$("#infoTab").find("tr:gt(2)").remove();
						hideMessage();
						initPage();
					});
				} else {
					showMessage('提示', "录入反馈失败！", null);
				}
	
			},
			error : function() {
				hideProgressLoader();
				showMessage('提示', "调用录入反馈服务失败！", null);
			}
		});
	}
	
	
	function deleteInfo(obj)
	{
		var studentLinkId =$(obj).parent().parent().attr("studentLinkId");
		$.messager.confirm('提示','您确定要删除该学生反馈？',function(r){
			if(r) 
			{
				$.post('/sys/demoClass/deleteStuFeedback.do', {studentLinkId : studentLinkId}, function(result) {
					if (result == "true") 
					{
						showMessage('提示', "删除反馈成功！", function() {
							$("#infoTab").find("tr:gt(2)").remove();
							hideMessage();
							initPage();
						});
					} 
					else 
					{
						showMessage('提示', "删除反馈失败！", null);
					}
					
				});
			}
		});
	}
	
	function updateInfo(obj)
	{
		var studentLinkId =$(obj).parent().parent().attr("studentLinkId");
		clearData("dlg");
		$("#studentName").textbox({disabled:"disabled"});
		$("#studentLinkId").val(studentLinkId);
		$.ajax( {
			type : "POST",
			url : "/sys/demoClass/getStuFeedback.do",
			data :"studentLinkId="+studentLinkId,
			async : false,
			dataType:"json",
			beforeSend : function() {
				showProgressLoader("正在加载数据,请稍等...", 400);
			},
			success : function(data) {
				hideProgressLoader();
				if(data.studentLinkId!=undefined)
				{
					$("#studentName").textbox("setValue",data.studentName);
					$("#001").datebox("setValue",data.date1);
					$("#002").datebox("setValue",data.date2);
					$("#003").datebox("setValue",data.date3);
					if($("input[name='001'][value='"+data.fee1+"']").length>0)
					{
						$("input[name='001'][value='"+data.fee1+"']").get(0).checked = true;
					}
					if($("input[name='002'][value='"+data.fee2+"']").length>0)
					{
						$("input[name='002'][value='"+data.fee2+"']").get(0).checked = true;
					}
					if($("input[name='003'][value='"+data.fee3+"']").length>0)
					{
						$("input[name='003'][value='"+data.fee3+"']").get(0).checked = true;
					}
				}	
			},
			error : function() {
				hideProgressLoader();
			}
		});
		
		$("#dlg").dialog('open').dialog('setTitle', '修改反馈');
	}
</script>