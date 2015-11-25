<%@ page language="java" import="java.util.*,net.sf.json.*"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="com.rise.pub.util.*"%>
<%
	String path = request.getContextPath();
	String studentInfo =request.getParameter("studentInfo");
	String studentId =request.getParameter("studentId");
	String schoolId= request.getParameter("schoolId");
	String courses=request.getParameter("courses");
	
	JSONObject object=new JSONObject();
	if(courses!=null && !"".equals(courses))
    {
		object = JSONObject.fromObject(courses);
    }

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<%@ include file="../common/head.jsp"%>
		<%@ include file="../common/formvalidator.jsp"%>
		<script type="text/javascript" src="<%=path %>/pub/js/date.js"></script>
		<script type="text/javascript" src="<%=path %>/js/course/addCourse.js"></script>
		<script type="text/javascript" src="<%=path %>/js/course/short.js"></script>
		<style>
.praiseTab {
	border-collapse: collapse;
	border-spacing: 0;
	border: 0px solid #ccc;
}

.praiseTab td {
	border: none;
	margin: 0;
	padding: 0;
}

#modelSpan
{
	text-decoration:underline;
	color:blue;
	cursor:pointer;
	display:none;
	margin-right:5px;
}
 
</style>
	</head>

	<body>
	<form id="courseFm">
		<div class="easyui-panel" style="width: 1200px" title="学员基础信息">
			<input type="hidden" id="studentInfo" name="studentInfo" value="<%=studentInfo%>" />
			<input type="hidden" id="schoolId" name="schoolId" value="<%=schoolId%>" />	
			<table width="100%" cellpadding="5px" class="maintable"id="stuBaseInfo">
				<tr>
					<td width="13%" align="right">
						<span style="color: red;">*</span>
						<span>学员姓名：</span>
					</td>
					<td width="25%">
						<span></span>
					</td>
					<td width="13%" align="right">
						<span>出生日期：</span>
					</td>
					<td width="15%">
						<span></span>
					</td>
					<td align="right">
						<span>证件号码：</span>
					</td>
					<td>
						<span></span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<span>性别：</span>
					</td>
					<td>
						<span><span>
					</td>
					<td align="right">
						<span>课程类型：</span>
					</td>
					<td>
					
						<select name="courseType" editable='false' required="true" class="easyui-combobox" id="courseType" style="width: 150px; height: 28px;"
						 data-options="valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      				 required="true" >
	      				 <option value="002">短期课</option>
						</select>
					</td>
					<td align="right">
								<span>缴费时间：</span>
						</td>
							<td>
								<input name="payDate" id="payDate"  class="easyui-datebox" editable='false' required="true" value="<%=StringUtil.getJSONObjectKeyVal(object,"payDate")%>"  style="width: 150px; height: 28px;" />
							</td>
				</tr>
			</table>
		 
		</div>
			<div style="height: 10px;"></div>
			<input id="studentCourseId" name="studentCourseId" type="hidden" value="<%=StringUtil.getJSONObjectKeyVal(object,"studentCourseId")%>"/>
    	    <input id="oldClassType"  type="hidden" value="<%=StringUtil.getJSONObjectKeyVal(object,"classType")%>"/>
    	    <input id="oldStageId"   type="hidden" value="<%=StringUtil.getJSONObjectKeyVal(object,"stageId")%>"/>
    	     <input id="oldCourseType"  type="hidden" value="<%=StringUtil.getJSONObjectKeyVal(object,"courseType")%>"/>
    	    <input type="hidden" id="oldMinusAmount" name="oldMinusAmount" value="<%=StringUtil.getJSONObjectKeyVal(object,"minusAmount")%>" />	
			<input type="hidden" id="paySchoolId" name="paySchoolId" value="<%=schoolId%>" />	
			<input type="hidden" id="studentId" name="studentId" value="<%=studentId%>">
			<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}" />
			<input type="hidden" id="coursePriceId" name="coursePriceId" value="" />
		
			<div id="short">
				<div class="easyui-panel" style="width: 1200px; height: auto;"
					title="短期课课程">
					<table width="99%" cellpadding="5px" class="maintable">
						<tr>
							<td align="right">
								<span>短期课名称：</span>
							</td>
							<td align="left">
								<select class="easyui-combobox" id="shortClassId"  name="shortClassId" style="width: 150px; height: 28px;"
								 data-options="valueField: 'shortClassId', textField: 'className', panelHeight: 'auto',
								 onLoadSuccess:function(data){$('#shortClassId').combobox('setValue','<%=StringUtil.getJSONObjectKeyVal(object,"stageId")%>');}
								 "
	      				 		 url="/sys/pubData/qryData.do?param={queryCode:'Qrr_short_class'}"   >
								<select>
							</td>
							<td align="right">
								<span>班级类型：</span>
							</td>
							<td align="left">
								 <select class="easyui-combobox" id="shortClassType" name="shortClassType" style="width: 150px; height: 28px;"
								 data-options="valueField: 'classType', textField: 'classType', panelHeight: 'auto'">
								<select>
							</td>
							</tr>
							<tr>
							<td align="right">
							<span>业绩老师A：</span>
						</td>
						<td>
							<select name="adviserTeacherA" class="easyui-combobox" id="adviserTeacherA"
								style="width: 150px; height: 28px;"
								data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto',
								onLoadSuccess:function(data){$('#adviserTeacherA').combobox('setValue','<%=StringUtil.getJSONObjectKeyVal(object,"adviserTeacherA")%>');}"
	      						url="<%=path %>/pubData/qryTeacherList.do">
							</select>
						</td>
						<td align="right">
							<span>业绩老师B：</span>
						</td>
						<td>
							<select name="adviserTeacherB" class="easyui-combobox" id="adviserTeacherB"
								style="width: 150px; height: 28px;"
								data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto',
								onLoadSuccess:function(data){$('#adviserTeacherB').combobox('setValue','<%=StringUtil.getJSONObjectKeyVal(object,"adviserTeacherB")%>');}"
	      						url="<%=path %>/pubData/qryTeacherList.do">
							</select>
						</td>
						</tr>
						<tr>
							<td align="right">
								<span>备注：</span>
							</td>
							<td colspan="6">
								<input type="text" id="remark" name="remark" class="easyui-textbox validatebox" value='<%=StringUtil.getJSONObjectKeyVal(object,"remark")%>' style="width: 820px; height: 25px;">
							</td>
						</tr>
						<tr>
							<td align="right">
								<span>上传缴费单：</span>
							</td>
							<td colspan="6">
								<input style="width: 300px; height: 28px;"
									class="easyui-filebox" name="file2" data-options="prompt:''">
								<a href="javascript:void(0)" id="viewStudent"
									class="easyui-linkbutton" iconCls="icon-redo"
									style="width: 100px;">查看缴费单</a>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div style="height: 10px;"></div>
			<div class="easyui-panel" style="width: 1200px; height: auto;" title="缴费信息">
				<table width="100%" cellpadding="5px" class="maintable">
					<tr>
						<td align="center">
							<href ="javascript:void(0)" id="addArchives"
								class="easyui-linkbutton" iconCls="icon-add" plain="true"
								onclick="addArchives()">
							<span>使用现金抵扣券</span>
						</td>
						<td colspan="7" giftId="">
						<div style="float:left"><span><%=StringUtil.getJSONObjectKeyVal(object,"minusRemark")%>,</span>	</div><div style="float:left" id="useCoupon"></div>
						</td>
					</tr>
					<tr>
						<td align="center">
							<span>其他优惠</span>
						</td>
						<td colspan="7" >
							<div  id="favors"></div>
						</td>
					</tr>
					<tr>
						<td align="right">
							<span>总金额：</span>
						</td>
						<td align="left">
							<input id="totalAmount" name="totalAmount" type="text"    readonly="readonly"
								class="easyui-textbox validatebox"
								style="width: 200px; height: 25px;">
						</td>
						<td align="right">
							<span>赠券抵扣金额：</span>
						</td>
						 
						<td align="left">
							<input id="minusAmount" name="minusAmount" type="text" value="<%=StringUtil.getJSONObjectKeyVal(object,"minusAmount")%>"  readonly="readonly" class="easyui-textbox validatebox" style="width: 200px; height: 25px;">
						</td>
						<td align="left">
						 <span>优惠金额：</span> 
						 </td>
						 <td align="left">
				      	 <input id="favorAmount"   name="favorAmount" type="text" readonly="readonly"  value="<%=StringUtil.getJSONObjectKeyVal(object,"favorAmount")%>" class="easyui-textbox validatebox"  style="width: 200px; height: 25px;"/> 
				      	 </td>
						<td align="right">
							<span>实缴金额：</span>
						</td>
						<td align="left">
							<input id="amount" name="amount" type="text"   readonly="readonly" value="<%=StringUtil.getJSONObjectKeyVal(object,"amount")%>" class="easyui-textbox validatebox" style="width: 200px; height: 25px;">
						</td>
					</tr>
				</table>
			</div>
		</form>
		<div style="width: 1200px; text-align: center">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-ok" style="width: 150px" id="submitBtn"><span>提交</span>
			</a> &nbsp;&nbsp;&nbsp;&nbsp;
			<a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-back" style="width: 150px" id="backBtn"><span>返回</span>
			</a>
			<iframe id="dlg" class="easyui-dialog"
				style="width: 1000px; height: 450px; padding: 10px 20px"
				closed="true" modal="true">
			</iframe>
			<iframe id="giftDlg" class="easyui-dialog"
				style="width: 1200px; height: 450px; padding: 10px 20px"
				closed="true" modal="true">
			</iframe>
	</body>
</html>
<script type="text/javascript">
var studentCourse = {};//最后提交学生课程信息
var gifts = [];
var courses = [];
var coupons = [];//使用抵扣劵
var useCoupon = "";
var wom = {};//口碑信息

var minus = 0;//抵扣金额
var favorAmount = 0;//优惠金额
var totalAmount = 0;//课程金额
var amount = 0;//实缴金额

var oldMinusAmount='<%=StringUtil.getJSONObjectKeyVal(object,"minusAmount")%>';

var giftFlag=false;//赠品、赠课是否已消耗
initDate();
loadStuBaseInfo();
initOldCourse();
function initOldCourse()
{
	var studentCourseId=$("#studentCourseId").val();
	if(studentCourseId!='')
	{
		$("#payDate").attr("readOnly",true);
		 
		//$("#courseType").combobox({ disabled: true});
		 
	}
}

//提交
$("#submitBtn").click(function() 
{
	if($("#payDate").datebox("getValue")=="")
	{
		showMessage("提示","请选择缴费时间",null);
		return false;
	}
	addCourseInfo();
});

function addCourseInfo()
{
		
		//获取口碑信息-end
		var courseInfo =build();
		var paramValue=
		{
			"courseInfo":courseInfo
		};
		paramValue =JSON.stringify(paramValue);
		$.ajax({
					type : "POST",
					url: "/sys/course/addSingleCourse.do",
					data: "param="+paramValue,
					async: false,
					beforeSend: function()
			    	{
			    		showProgressLoader("正在修改课程,请稍等...",400);
			    	},
			    	success: function(data) 
			    	{
			    		hideProgressLoader() 
			    		if(data=="true")
			    		{
			    			showMessage('提示', "修改课程成功！",function(){window.location.href="qryCourseInfo.jsp";});
			    		}
			    		else
			    		{
			    			showMessage('提示', "修改课程失败！",null);
			    		}	
			    		
			    	},
			        error:function(){
			        	hideProgressLoader();
			        	showMessage('提示', "调用修改课程服务失败！",null);
			        }
				});
	}
$("#backBtn").click(function()
{
	window.location.href = "qryCourseInfo.jsp"
});

	//创建单报提交数据
	function build()
	{
	
		studentCourse={};                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
		var gifts=[];
		var obj = $("#courseFm").serializeObject();
		obj.payDate=$("#payDate").datebox("getValue");
		studentCourse.course=obj;
		studentCourse.gifts=gifts; 
		studentCourse.coupon=JSON.stringify(coupons);
		return studentCourse;
	}
		
	function closeDlg()
	{
		$('#dlg').dialog('close');
		$('#useCoupon').html(useCoupon);
		$("#minusAmount").textbox('setValue',Number(minus)+Number(oldMinusAmount));
		totalAmount=$("#totalAmount").textbox('getValue');
		favorAmount=$("#favorAmount").textbox('getValue');
		amount=totalAmount-minus-oldMinusAmount-favorAmount;
		$("#amount").textbox('setValue',amount);
	}
	
	function colDis(id)
	{
		var idT="#useCoupon"+id+"";
		$(idT).css('display','none');
		for(var i=coupons.length-1;i>=0;i--)
		{
			 var coupon=coupons[i];
			
			 if(coupon.studentGiftId==id)
			 {
				var usableAmountT=$("#minusAmount").textbox('getValue');
				usableAmountT=usableAmountT-coupon.usableAmount;
				$("#minusAmount").textbox('setValue',usableAmountT);
				coupons.remove(i);
			 }
		}
		 
		minus=$("#minusAmount").textbox('getValue');
		favorAmount=$("#favorAmount").textbox('getValue');
		totalAmount=$("#totalAmount").textbox('getValue');
		amount=totalAmount-minus-favorAmount;
		$("#amount").textbox('setValue',amount);
	}
	
	function addArchives()
	{
		$('#dlg').dialog({
			title:"使用抵扣券",
		});
		$('#dlg').attr("src","/sys/course/useCoupon.jsp?studentId="+$("#studentId").val());
		$('#dlg').dialog("open");
	}
	
	function getMinus()
	{
		return $("#minusAmount").textbox('getValue');
	}
	
	function getFavorAmount()
	{
		return $("#favorAmount").textbox('getValue');
	}
	
	function getTotalAmount()
	{
		return $("#totalAmount").textbox('getValue');
	}
	
	function getAmount()
	{
		return $("#amount").textbox('getValue');
	}
	
	
	
	function loadStuBaseInfo()
	{
		var studentInfo =$("#studentInfo").val();
		if(studentInfo.indexOf(";;")!=-1)
		{
			studentInfo =studentInfo.split(";;");
			var tr1 =$("#stuBaseInfo").find("tr:eq(0)");
		    tr1.find("td:eq(1)").find("span").html(studentInfo[0]);
		    tr1.find("td:eq(3)").find("span").html(studentInfo[2]);
		    tr1.find("td:eq(5)").find("span").html(studentInfo[3]);
		    $("#stuBaseInfo").find("tr:eq(1)").find("td:eq(1)").find("span").html(studentInfo[4]);
		}	
	}
	</script>
