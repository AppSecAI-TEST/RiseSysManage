<%@ page language="java" import="java.util.*,net.sf.json.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.rise.pub.util.*"%>
<%
	String path = request.getContextPath();
	String schoolId= request.getParameter("schoolId");
	String studentId =request.getParameter("studentId");
	String order=request.getParameter("order");
	String courses=request.getParameter("courses");
	String name=request.getParameter("name");
	String viewFlag = request.getParameter("viewFlag");
	JSONObject object=new JSONObject();
	if(courses!=null && !"".equals(courses))
    {
		object = JSONObject.fromObject(courses);
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/course/addCourse.js"></script>
		
		<script type="text/javascript">
			$(document).ready(function()
			{
				var height = $(document).height();
				$('#frame<%=name%>',parent.document).css("height",height+20);
			});
			
			
		</script>
		
  	</head>
  
  	<body >
  	<div  class="easyui-panel" title="连报课程<%=order%>" style="width:99%;padding:10px;border-color:#95B1E7">
  	<input id="frameName" name="frameName" type="hidden" value="<%=name%>"/>
  	<form id="courseFm">
	      <div style="height: 5px;"></div>
	      <div class="easyui-panel" style="width:100%;height:auto;" title="常规课课程">
      	      <table width="100%" cellpadding="5px" class="maintable" >
	      	      <tr>
						<input id="studentCourseId" name="studentCourseId" type="hidden" value="<%=StringUtil.getJSONObjectKeyVal(object, "studentCourseId")%>" />
						<input id="oldClassType" type="hidden" value="<%=StringUtil.getJSONObjectKeyVal(object, "classType")%>" />
						<input id="oldStageId" name="oldStageId"  type="hidden" value="<%=StringUtil.getJSONObjectKeyVal(object, "stageId")%>" />
						<input id="oldFeeType" name="oldFeeType"  type="hidden" value="<%=StringUtil.getJSONObjectKeyVal(object, "feeType")%>" />
						<input id="studentId" name="studentId" type="hidden" value="<%=studentId%>" />
						<input id="courseType" name="courseType" type="hidden" value="001" />
						<input id="advisterType" name="adviserType" type="hidden" value="teacher" />
						<input id="courseState" name="courseState" type="hidden" value="001" />
						<input id="feeType" name="feeType" type="hidden" value="002" />
						<input id="feeState" name="feeState" type="hidden" value="00A" />
						<input id="stageOrder" name="stageOrder" type="hidden" value="" />
						<input id="schoolId" name="schoolId" type="hidden" value="<%=schoolId%>" />
						<input type="hidden" id="paySchoolId" name="paySchoolId" value="<%=schoolId%>" />
						<input type="hidden" id="coursePriceId" name="coursePriceId" value="" />
						<td align="right"><span>缴费时间：</span></td>
						<td>
							<input name="payDate" id="payDate" editable='false' type="text" class="easyui-datebox" required="true" style="width: 120px; height: 25px;" value="<%=StringUtil.getJSONObjectKeyVal(object, "payDate")%>" />
						</td>
						<td align="right"><span>阶段：</span>
						<td>
							<select name="stageId" id="stageId" editable='false'  style="width: 100px; height: 25px;"
								data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto',
	      						onLoadSuccess:function(data){$('#stageId').combobox('setValue','<%=StringUtil.getJSONObjectKeyVal(object, "stageId")%>');}"
								url="<%=path%>/pubData/qryStage.do" required="true">
							</select>
						</td>
						<td align="right"><span>班级类型：</span>
						<td>
							<select name="classType" id="classType" editable='false' class="easyui-combobox" style="width: 100px; height: 25px;" drequired="true">
								
							</select>
						</td>
					</tr>
	      	     	<tr>
	      	        	<td align="right"><span>业绩类型：</span></td>
	      	       	 	<td><span>升学</span></td>
	      	        	<td align="right">
							<span>业绩老师A：</span>
						</td>
						<td>
							<select   editable='false' id="adviserTeacherA_school" style="width: 100px; height: 25px;"
								data-options="formatter:formatSchool,valueField: 'schoolId', textField: 'schoolName', panelHeight: '150px'"
								  ></select>
								  
							<select name="adviserTeacherA"  id="adviserTeacherA" editable='false'  
								style="width: 100px; height: 25px;"
								data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: '150px'">
							</select>
						</td>
						<td align="right">
							<span>业绩老师B：</span>
						</td>
						<td>
						<select   editable='false' id="adviserTeacherB_school" style="width: 100px; height: 25px;" data-options="formatter:formatSchool,valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
						</select>
							<select name="adviserTeacherB" id="adviserTeacherB"
								style="width: 100px; height: 25px;"
								data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: '150px'">
							</select>
						</td>
      	        	</tr>
      	      </table>
		</div>
      	<div style="height: 10px;"></div>
      	<div class="easyui-panel" style="width:100%;height:auto;" title="赠品信息">
      	
      	      <table width="100%" cellpadding="5px" class="maintable" id="giftTab">
	      	      <tr id="giftModelTR">
	      	        <td width="8%" align="right"><span>赠品类型：</span></td>
	      	        <td width="8%">
	      	        <select   id="parentType" style="width: 100px; height: 25px;"
	      				     data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: '150px'"
	      					 url="<%=path %>/pubData/qryCodeNameList.do?tableName=GIFT_TYPE_T&codeType=PARENT_TYPE"  >
      	            </select>
      	            </td>
	      	        <td width="7%" align="right"><span>赠品名称：</span></td>
	      	        <td width="39%">
	      	      	<table  border="0">
	   	                <tr>
			      	         <td id='td0' ><select  class="easyui-combobox" editable='false' id="giftType" style="width: 100px; height: 25px;"></select></td>
			      	         <td id="td1" style="display:none"><select  editable='false' class="easyui-combobox" id="giftId" style="width: 100px; height: 25px;"></select></td>
			      	         <td id="td2" style="display:none"><input   id="giftCode" type="text" class="easyui-textbox validatebox" required="true" style="width:100px; height: 25px;"/></td>
		                     <td id="td3" style="display:none"><input   id="giftEffDate" type="text" class="easyui-datebox"  style="width: 100px; height: 25px;"/></td>
	      	             </tr>
      	            </table>
      	            </td>
	      	        <td width="7%" align="right"><span>是否领用：</span></td>
	      	        <td width="5%" align="left">
	      	          <input type="radio" name="isGetY"   value="Y">
	      	          <label for="radio"><span>已领用</span></label>
	      	          <input type="radio" name="isGetY"   value="N">
	      	          <label for="radio"> <span>未领用</span></label>
      	           </td>
	      	        <td width="6%" align="right"><span>发放人：</span></td>
	      	        <td width="8%"><input   id="granter" type="text" disabled="disabled" class="easyui-textbox validatebox"  style="width: 100px; height: 25px;"/></td>
	      	       
	      	        <td width="6%"><a href="javascript:void(0)" id="addGiftBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px; height: 25px;">添加</a></td>
      	        </tr>
      	      <tr style="display:none;" name="addGift" id="addGift" >
      	        <td align="right"><span>赠品类型：</span></td>
      	        <td align="left" parentType="">&nbsp;</td>
      	        <td align="right"><span>赠品名称：</span></td>
      	        <td align="left" giftType="" giftId="">&nbsp;</td>
      	        <td align="right"><span>是否领用：</span></td>
      	        <td align="left" isGet="">&nbsp;</td>
      	        <td align="right"><span>发放人：</span></td>
      	        <td align="left" granter="">&nbsp;</td>
      	        
      	        <td><a href='javascript:void(0)' class='linkmore' onclick='delRow(this)' ><span>删除</span></a></td>
     	       </tr>
      	      </table>
      		</div>
      		<div style="height: 5px;"></div>
      		<div class="easyui-panel" style="width:100%;height:auto;" title="赠课信息">
      	      <table width="100%" cellpadding="5px" class="maintable" >
	      	      <tr  id="giftCourseTr">
	      	        <td colspan="2" align="right"><span>赠课类型</span></td>
	      	        <td width="22%" align="right">
		      	        <div align="left">
		      	          <select   id="giftCourseType" style="width: 100px; height: 25px;"
		      	           data-options="formatter:formatTypeName,  valueField: 'giftType', textField: 'typeName', panelHeight: '150px'"
		      	          url="/sys/pubData/qryData.do?param={queryCode:'Qry_Gift_Type',parentType:'COURSE'}" ></select>
      	            </div></td>
	      	        <td width="10%" align="right"><span>赠课名称：</span></td>
	      	        <td width="11%"><select class="easyui-combobox" editable='false' id="giftCourseId" style="width: 100px; height: 25px;" >
	      	          </select></td>
	      	       
	      	        <td width="12%" align="right"><span>课时量:</span></td>
	      	        <td width="22%" id="courseHours"></td>
      	            <td width="7%"><a href="javascript:void(0)" id="addCourse" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px; height: 25px;">添加</a></td>
      	        </tr>
      	      </table>
      	       <table width="100%" cellpadding="5px" class="maintable" id="giftCourse">
	      	      <tr align="center">
	      	        <td style="display:none;" width="6%" ><span>序号</span>&nbsp;</td>
	      	        <td width="9%"><span>赠课类型</span></td>
	      	        <td width="9%"><span>赠课名称</span></td>
	      	        <td width="11%"><span>赠送课时量</span></td>
	      	        <td width="9%"><span>赠送时间</span></td>
	      	        <td width="10%"><span>课程状态</span></td>
	      	        <td width="11%"><span>有效期开始时间</span></td>
	      	        <td width="11%"><span>有效期结束时间</span></td>
	      	        <td width="8%"><span>课程进度</span></td>
	      	        <td width="7%"><span>操作</span></td>
      	        </tr>
	      	      <tr style="display:none;" id="add" align="right">
	      	        <td style="display:none;"  val="">&nbsp;</td>
	      	        <td  align="center" giftCourseType="">&nbsp;</td>
	      	        <td  align="center"  giftId="">&nbsp;</td>
	      	        <td  align="center">&nbsp;</td>
	      	        <td  align="center">&nbsp;</td>
	      	        <td  align="center">&nbsp;</td>
	      	        <td  align="center">&nbsp;</td>
	      	        <td  align="center">&nbsp;</td>
	      	        <td  align="center">&nbsp;</td>
	      	        <td  align="center"> <a href='javascript:void(0)' class='linkmore' onclick='delRow(this)'><span>删除</span></a></td>
      	        </tr>
      	      </table>
			</div>
			<div style="height: 5px;"></div>
			<div class="easyui-panel" style="width:100%;height:auto;" title="课程费用">
			     	      <table width="100%" cellpadding="5px" class="maintable" >
			  	            <tr>
			     	            <td  align="right" ><span>现金抵扣劵：</span></td>
			     	            <td align="center"  ><href="javascript:void(0)" id="addArchives" class="easyui-linkbutton" iconCls="icon-add" onclick="addArchives()">使用现金抵扣券</</td>
			      	            <td colspan="8"  giftId=""><div id="useCoupon"/></td>
			   	            </tr>
			   	            <tr>
				      	        <td width="10%"  align="right" ><span>课程金额：</span></td>
				      	        <td width="14%"  align="left" ><input id="totalAmount" readonly="readonly"  name="totalAmount" type="text" value="<%=StringUtil.getJSONObjectKeyVal(object,"totalAmount")%>" class="easyui-textbox validatebox"  style="width: 100px; height: 25px;"> </td>
				      	        <td width="12%"  align="right" ><span >现金抵扣券金额：</span></td>
				      	        <td colspan="3"  align="left" ><input id="minusAmount"   readonly="readonly"  name="minusAmount" type="text" value="<%=StringUtil.getJSONObjectKeyVal(object,"minusAmount")%>" class="easyui-textbox validatebox"  style="width: 100px; height: 25px;">  </td>
				      	        <td width="11%"  align="right"><span>连报优惠金额：</span></td>
				      	        <td width="17%"  align="left" ><input id="favorAmount"   name="favorAmount" type="text" value="<%=StringUtil.getJSONObjectKeyVal(object,"favorAmount")%>" class="easyui-textbox validatebox"  style="width: 100px; height: 25px;"/></td>
				      	        <td width="12%"  align="right"><span>实缴课程金额：</span></td>
				      	        <td width="17%"  align="left" ><input id="amount"   readonly="readonly"   name="amount" type="text"  value="<%=StringUtil.getJSONObjectKeyVal(object,"amount")%>" class="easyui-textbox validatebox"  style="width: 100px; height: 25px;"> </td>
			      	         </tr>
			      	      </table>
				</div>
						
				<iframe id="dlg" class="easyui-dialog" style="width:1000px; height: 450px; padding: 10px 20px" closed="true" modal="true">
				</iframe>
	      	  </form>
  		</div>
  	</body>
</html>
<script type="text/javascript">
initPayDate();
	var studentCourse={};//最后提交学生课程信息
    var gifts  =[];  
	var courses=[];
	var coupons=[];//使用抵扣劵
	var useCoupon="";
	
	var minus=0;//抵扣金额
	var favorAmount=0;//优惠金额
	var totalAmount=0;//课程金额
	var amount=0;//实缴金额

	var setPriceId="<%=StringUtil.getJSONObjectKeyVal(object,"coursePriceId")%>";
	var adviserTeacherAid="<%=StringUtil.getJSONObjectKeyVal(object,"adviserTeacherA")%>";
	var adviserTeacherBid="<%=StringUtil.getJSONObjectKeyVal(object,"adviserTeacherB")%>";
	
	var schools=getSchools();
	var teachers=getTeachers();
	$("#adviserTeacherA_school").combobox({data:schools});
	$("#adviserTeacherB_school").combobox({data:schools});
	$("#adviserTeacherA").combobox({data:teachers});
	$("#adviserTeacherB").combobox({data:teachers});
	$("#adviserTeacherA_school").combobox({
		onChange:function(){
			var sId =$("#adviserTeacherA_school").combobox("getValue");
			var urls ="<%=path %>/pubData/qryTeacherList.do?schoolId="+sId;
			$("#adviserTeacherA").combobox({
				url:urls
			});
		}
	})
	
	$("#adviserTeacherB_school").combobox({
		onChange:function(){
			var sId =$("#adviserTeacherB_school").combobox("getValue");
			var urls ="<%=path%>/pubData/qryTeacherList.do?schoolId="+sId;
			$("#adviserTeacherB").combobox({
				url:urls
			});
		}
	})
	initOldCourse();
	var viewFlag ="<%=viewFlag %>";
	if(viewFlag=="true")
	{
		disableForm("courseFm",true)
	}	
	function initOldCourse()
	{
		if(setPriceId!='')
		{
			$("#payDate").datebox({ disabled: true});
		}
		for ( var i = 0; i < teachers.length; i++)
		{
			if (adviserTeacherAid == teachers[i].teacherId) 
			{
				$("#adviserTeacherA_school").combobox('setValue',teachers[i].schoolId);
				$("#adviserTeacherA").combobox('setValue',teachers[i].teacherId); 
			}
			if (adviserTeacherBid == teachers[i].teacherId) 
			{
				$("#adviserTeacherB_school").combobox('setValue',teachers[i].schoolId);
				$("#adviserTeacherB").combobox('setValue',teachers[i].teacherId); 
			}
		}
		
	}

	$(":radio[name='isGetY']").click(function()
{
	var isGet=$(this).val();
	var type=$('#parentType').combobox('getValue');
 	if('Y'==isGet)
 	{
 		if(type=='COUPON')
 		{
 			 $("#td2").css('display','block');
        	 $("#td3").css('display','block');
 		}
        $("#granter").textbox({disabled:false});
 	}else
 	{
 		  $("#td2").css('display','none');
          $("#td3").css('display','none');
          $("#granter").textbox({disabled:true});
 	}
});
	
	$('#parentType').combobox({
	 onChange:function(n,o)
		{
		     $("#td0").css('display','none');
		 	 $("#td1").css('display','none');
             $("#td2").css('display','none');
             $("#td3").css('display','none');
             $("#granter").textbox({disabled:true});
             var isGet = $("input[name='isGetY']:checked").val();
       		if(n=='COUPON')//券类
       		{
			    var urls="/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift_Type\",parentType:\""+n+"\"}";
	       		$("#giftType").combobox(
	       		{
	        		url : urls,//返回json数据的url
	        		valueField : "giftType",
	        		textField :  "typeName",
	        		panelHeight : "150px",
	        		onLoadSuccess : function ()
	        		{ //数据加载完毕事件
	                    var data = $('#giftType').combobox('getData');
	                    if (data.length > 0)
	                    {
	                      //  $("#giftId").combobox('select', data[0].param2);
	                    }
	                    $("#td0").css('display','block');
	                    $("#td1").css('display','block');
	                  
	                    if(isGet=='Y')
	                    {
	                    	 $("#td2").css('display','block');
	                   		 $("#td3").css('display','block');
	                    }
	                }
	        	});
       		}else if(n=='GOODS')//实物类
       		{
       			$("#td1").css('display','block');
			    var urls="/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift\",giftType:\""+n+"\"}";
	       		$("#giftId").combobox(
	       		{
	        		url : urls,//返回json数据的url
	        		valueField : "giftId",
	        		textField :  "giftName",
	        		panelHeight : "150px",
	        		onLoadSuccess : function ()
	        		{ //数据加载完毕事件
	                    var data = $('#giftId').combobox('getData');
	                    if (data.length > 0)
	                    {
	                      //  $("#giftId").combobox('select', data[0].param2);
	                    }
	                }
	        	});
       		}else if(n=='TEXTBOOK')//实物类
       		{
       			$("#td1").css('display','block');
			    var urls="/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift\",giftType:\""+n+"\"}";
	       		$("#giftId").combobox(
	       		{
	        		url : urls,//返回json数据的url
	        		valueField : "giftId",
	        		textField :  "giftName",
	        		panelHeight : "150px",
	        		onLoadSuccess : function ()
	        		{ //数据加载完毕事件
	                    var data = $('#giftId').combobox('getData');
	                    if (data.length > 0)
	                    {
	                      //  $("#giftId").combobox('select', data[0].param2);
	                    }
	                }
	        	});
       		}
       		 if(isGet=='Y')
              {
             	  $("#granter").textbox({disabled:false});
              }
		},
		url:"<%=path%>/pubData/qryCodeNameList.do?tableName=GIFT_TYPE_T&codeType=PARENT_TYPE"
	});
	
	$('#giftCourseType').combobox(
{
	onChange : function(n, o)
	{
		var urls = "/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift\",giftType:\""+ n + "\"}";
		$("#giftCourseId").combobox(
		{
			url : urls,//返回json数据的url
			valueField : "giftId",
			textField : "giftName",
			panelHeight : "150px"
		});
	}
});
$('#giftType').combobox(
{
	onChange : function(n, o) 
	{
		var urls = "/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift\",giftType:\""+ n + "\"}";
		$("#giftId").combobox(
		{
			url : urls,//返回json数据的url
			valueField : "giftId",
			textField : "giftName",
			panelHeight : "150px",
			onLoadSuccess : function() 
			{ //数据加载完毕事件
				var data = $('#giftId').combobox('getData');
				if (data.length > 0) 
				{
					//  $("#giftId").combobox('select', data[0].param2);
				}
			}	
		});
	}
});
$('#giftCourseId').combobox(
{
	onChange : function(n, o) 
	{
		var data = $('#giftCourseId').combobox('getData');
		if (data.length > 0) 
		{
			for ( var i = 0; i < data.length; i++)
			{
				var giftNum = data[0].giftNum;
				var giftId = data[0].giftId;
				if (n == giftId) 
				{
					$("#courseHours").html(giftNum);
				}
			}
		}
	}
});
	//选择阶段价加载班级
$('#stageId').combobox({
	onChange : function(n, o)
	{
	var data = $("#stageId").combobox('getData');
	var amount;
	if(n=='')
	 {
		 return;
	 }
	for ( var i = 0; i < data.length; i++)
	{
		if (n == data[i].stageId) 
		{
			$("#stageOrder").val(data[i].seqOrder);
		}
	}
	
	var stageType = $("#stageId").combobox('getText');
	var payDate=$("#payDate").datebox('getText');
	if(payDate=='')
	{
		$("#stageId").combobox('setValue',"");
		$("#classType").combobox('setValue',"");
		$("#totalAmount").textbox('setValue', '');
		parent.window.showMsg("请选择缴费时间");	
		return;
	}
	
	var studentCourseId=$("#studentCourseId").val();
	var classType="<%=StringUtil.getJSONObjectKeyVal(object,"classType")%>";//初始化已有值
	 
	var url="";
	if(studentCourseId=='')//新报
	{
		url = "/sys/pubData/qryData.do?param={queryCode:\"Qry_Stage_Class\",time:\""+ payDate + "\",stageId:\""+ stageType + "\",schoolId:\""+ <%=schoolId%> + "\"}";
	}else//已有
	{
		url= "/sys/pubData/qryData.do?param={queryCode:\"Qry_Old_Stage_Class\",setPriceId:\""+ setPriceId + "\",stageId:\""+ stageType + "\"}";
	}
	$("#classType").combobox(
	{
		url : url,//返回json数据的url
		valueField : "classType",
		textField : "classType",
		panelHeight : "150px",
		onLoadSuccess : function() //数据加载完毕事件
		{ 
			var data = $('#classType').combobox('getData');
			
			if(data==null || data.length==0)
			{
				$("#stageId").combobox('setText',"");
				$("#classType").combobox('setText',"");
				$.messager.alert('提示', "没有适用的常规格价格体系,请重新选择缴费日期");	
				return;
			} 
			for(var i=0;i<data.length;i++)
			{
				if(classType==data[i].classType || data.length==1)
				{
					$("#classType").combobox('select',data[i].classType);
					$("#totalAmount").textbox('setValue', data[i].amount);
					minus = $("#minusAmount").textbox('getValue');
					favorAmount = $("#favorAmount").textbox('getValue');
					totalAmount = $("#totalAmount").textbox('getValue');
					amount = totalAmount - minus - favorAmount;
					$("#amount").textbox('setValue', amount);
					$("#coursePriceId").val(data[i].setPriceId); 
				}
			}
		}
	});
   }
});
	
$("#classType").combobox(
{
	onChange:function(n,o)
	{
		var data = $('#classType').combobox('getData');
		for(var i=0;i<data.length;i++)
		{
			if(n==data[i].classType)
			{
				$("#classType").combobox('select',data[i].classType);
			
				$("#totalAmount").textbox('setValue', data[i].amount);
				 
				minus = $("#minusAmount").textbox('getValue');
				favorAmount = $("#favorAmount").textbox('getValue');
				totalAmount = $("#totalAmount").textbox('getValue');
				amount = totalAmount - minus - favorAmount;
				$("#amount").textbox('setValue', amount);
				$("#coursePriceId").val(data[i].setPriceId); 
				parent.window.countAmount();
			}
			
		}
	}

});

$("#favorAmount").textbox(
{
	onChange:function()
	{
		minus = $("#minusAmount").textbox('getValue');
		favorAmount = $("#favorAmount").textbox('getValue');
		var reg= /^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$/;
		if(!reg.test(favorAmount))
		{
			$("#favorAmount").textbox('setValue','');
			return false;
		}	
		totalAmount = $("#totalAmount").textbox('getValue');
		amount = totalAmount - minus - favorAmount;
		$("#amount").textbox('setValue', amount);
		parent.window.countAmount();
		parent.window.checkFavorAmount();
	}
	
});
	//增加赠品
$("#addGiftBtn").click(function ()
{
		var giftModelTR=$("#giftModelTR").clone();
		var flag=true;
		var giftTR=$("#addGift").clone();
		giftTR.css("display",'table-row');
		giftTR.attr("val","gift");
		giftTR.find("td").each(function(n,node)
		{
			var getFlag = $("input[name='isGetY']:checked").val(); //是否领取
			var parentType=$("#parentType").combobox('getValue');
			var giftEffDate=$("#giftEffDate").textbox('getValue');
			if('N'==getFlag)
			{
				$("#giftEffDate").textbox('setValue','');
				$("#giftCode").textbox('setValue','');
				$("#granter").textbox("setValue",'');
			}
			if(n==1)//赠品类型;	
			{
				var name=$("#parentType").combobox('getText');
				if(name=='')
				{
					parent.window.showMsg("请选择赠品类型");
					flag=false;
					return false;
				}
				$(node).html("<span>"+name+"</span>");	
				$(node).attr("parentType",parentType);
			}else if(n==3)//赠品名称;劵类ID
			{
				var giftId=$("#giftId").combobox('getValue');
				var giftName=$("#giftId").combobox('getText');
			 
				var giftType=$("#giftType").combobox("getText");
				var giftTypeVal=$("#giftType").combobox('getValue');
				
				var code=$("#giftCode").textbox('getValue');
				
				//判断是否是券类
				if(giftId=='')
				{
					parent.window.showMsg("请选择赠品名称");
					flag=false;
					return false;
				}
				
				//判断是否是券类
				if(parentType=='COUPON' && code=='' && 'Y'==getFlag)
				{
					parent.window.showMsg("请输入券类编码");
					flag=false;
					return false;
				}
			
				if(''!=giftName && code!='')
				{
					$(node).html("<span>"+giftType+"  "+giftName+"   "+ code +"   "+giftEffDate+"</span>");	
				}else if(''!=giftName && code=='')
				{
					$(node).html("<span>"+giftType+"  "+giftName+"</span>");	
				}else
				{
					$(node).html("<span>"+giftName+"</span>");	
				}
				
				var datas = $('#giftType').combobox('getData');
				 
				for(var m=0;m<datas.length;m++)
				{
					if(giftTypeVal==datas[m].giftType)
					{
						 $(node).attr("effNum",datas[m].effNum);
						 $(node).attr("unit",datas[m].unit);
					}
				}
				
				var amount=""; 
				var data = $('#giftId').combobox('getData');
                if (data.length > 0)
                {
                    for(var i=0;i<data.length;i++)
                    {
                    	var giftIdT=data[i].giftId;
                    	if(giftIdT==giftId)
                    	{
                    		giftTypeVal=data[i].giftType;
                    		amount=data[i].amount;
                    	}
                    }
                }
				 
				$(node).attr("giftName",giftName);
				$(node).attr("amount",amount);
				$(node).attr("giftId",giftId);
				$(node).attr("giftType",giftTypeVal);
				$(node).attr("giftCode",code);
				$(node).attr("effDate",giftEffDate);
				
			}else if(n==5)
			{
				$(node).attr("isGet","N");
				if('Y'==getFlag)
				{
					if(giftEffDate=='' &&　parentType=='COUPON')
					{
						flag=false;
						parent.window.showMsg("请填写有效期");
						return false;
					}
					$(node).html("<span>已领取</span>");	
					$(node).attr("isGet","Y");
				}else if('N'==getFlag)
				{
					$(node).html("<span>未领取</span>");	
					$(node).attr("isGet","N");
				}
				else
				{
					  parent.window.showMsg("请选择已领或者未领");
					  flag=false;
					  return false;
				}
			}else if(n==7)
			{
				var granter=$("#granter").textbox("getValue");
				if(''==granter && 'Y'==getFlag)
				{
					  parent.window.showMsg("发放人为空");
					  flag=false;
					  return false;
				}
				$(node).html("<span>"+granter+"</span>");	
				$(node).attr("granter",granter);
			} 
			
		});
	
		if(flag)
		{
			$("#giftFm").form('clear');
			$("#addGift").after(giftTR);
			clearData("giftModelTR");
			$("input[name='isGetY'][value='Y']").attr("checked", "checked");
			var height = $(document).height();
				$('#frame<%=name%>',parent.document).css("height",height+20);
	    }
		
	
	
	});

//增加课程
$("#addCourse").click(function()
{
	var objectTr = $("#add").clone();//克隆模板
		objectTr.css("display", 'table-row');
		objectTr.attr("val", "course");
		var flag=true;
		objectTr.find("td").each(function(i, node) {
			var effDate = "";
			if (i == 0) {
				$(node).html("<span>" + (i ++) + "</span>");
				
			} else if (i == 1) {
				var name = $("#giftCourseType").combobox('getText');
				var val = $("#giftCourseType").combobox('getValue');

				var datas = $('#giftCourseType').combobox('getData');

				for ( var m = 0; m < datas.length; m++) 
				{
					if (val == datas[m].giftType) {
						$(node).attr("effNum", datas[m].effNum);
						$(node).attr("unit", datas[m].unit);
					}
				}
				if(name=='')
				{
					parent.window.showMsg("请选择赠课类型");
					flag=false;
					return false;
				}
				$(node).html("<span>" + name + "</span>");
				$(node).attr("giftCourseType", val);//赠课类型	
			} else if (i == 2) {
				var name = $("#giftCourseId").combobox('getText');
				var val = $("#giftCourseId").combobox('getValue');
				$(node).html("<span>" + name + "</span>");
				$(node).attr("giftId", val);//赠课细类	
				if(name=='')
				{
					parent.window.showMsg("请选择赠课名称");
					flag=false;
					return false;
				}
				
			} else if (i == 3) {
				var hours = $("#courseHours").html();
				$(node).html("<span>" + hours + "</span>");
				$(node).attr("hours", hours);//课时
			} else if (i == 4) {
				$(node).html("<span>" + sysDate() + "</span>");
			} else if (i == 5) {
				$(node).html("<span>未使用</span>");
			} else if (i == 6) {
				$(node).html("<span>" + afterDate(1) + "</span>");
			} else if (i == 7) {
				$(node).html("<span>" + afterYear(1) + "</span>");
			}
		});
		if(flag==true)
		{
			$("#add").after(objectTr);
			clearData("giftCourseTr");
			$("#courseHours").html("");
			var height = $(document).height();
				$('#frame<%=name%>',parent.document).css("height",height+20);
		}
			
		
	});
	//创建连报提交数据
	function build()
	{
		//if(!$("#courseFm").form('validate'))return;
		gifts=[];
		studentCourse={};                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
		$("#giftTab").find('tr').each(function(i,node)
		{
			var trName=$(this).attr("val");
			var studentGiftId=$(this).attr("studentGiftId");
 
			if('gift'==trName)
			{
				 var  tds=$(this).children('td');
			 
				 var giftName=tds.eq(3).attr("giftName");
				 var  amount=tds.eq(3).attr('amount');
				 var  effNum=tds.eq(3).attr('effNum');
				 var  unit=tds.eq(3).attr('unit');
				 var  giftId=tds.eq(3).attr('giftId');
				 var  giftType=tds.eq(3).attr('giftType');
				 var  giftCode=tds.eq(3).attr('giftCode');
				 var  isGet=tds.eq(5).attr('isGet');
				 var  granter=tds.eq(7).attr('granter');
				 var  effDate=tds.eq(3).attr('effDate');
				 var  gift = {};
				 
				 gift.studentId=$("#studentId").val();
				
				 gift.giftName=giftName;
				 gift.usableAmount=amount;
				 gift.amount=amount;
				 gift.studentGiftId=studentGiftId;
				 gift.unit = unit; 
				 gift.effNum = effNum; 
				 gift.giftType = giftType;
				 gift.giftId=giftId;
				 gift.giftCode=giftCode;
				 gift.effDate=effDate;
				 gift.isGet=isGet;
				 gift.granter=granter;
				 
				 gifts.push(gift);  
			 }
		});
			  
			 
		$("#giftCourse").find('tr').each(function(i,node)
		{
			var trName=$(this).attr("val");
			var studentGiftId=$(this).attr("studentGiftId");
			if('course'==trName)
			{
				 var  tds=$(this).children('td');
				 var  giftType=tds.eq(1).attr('giftCourseType');
				 var  effNum=tds.eq(1).attr('effNum');
				 var  unit=tds.eq(1).attr('unit');
				 var  giftId=tds.eq(2).attr('giftId');
				 var  hours=tds.eq(3).attr('hours');
				
				 var  gift = {};
				 gift.studentId=$("#studentId").val();
				 gift.giftType = giftType;
				 gift.giftId=giftId;
				 gift.giftNum=hours;
				 gift.studentGiftId=studentGiftId;
				 gift.unit = unit; 
				 gift.effNum = effNum; 
				 
				 var datas = $('#giftType').combobox('getData');
				 
				for(var m=0;m<datas.length;m++)
				{
					if(giftType==datas[m].giftType)
					{
						gift.unit=datas[m].unit;
						gift.effNum=datas[m].effNum;
					}
				}
				
				 gifts.push(gift);  
			 }
		});
		
		studentCourse.gifts=gifts;
		studentCourse.giftCourses= courses;
		
		var obj = $("#courseFm").serializeObject();
		obj.payDate=$("#payDate").datebox("getValue");
		studentCourse.course=obj;
		studentCourse.course=obj;
		studentCourse.coupon=JSON.stringify(coupons); 
		//alert(JSON.stringify(studentCourse));
		return studentCourse;
	}
		
	function closeDlg()
	{
		$('#dlg').dialog('close');
		$('#useCoupon').html(useCoupon);
		$("#minusAmount").textbox('setValue',minus);
	}
	
	function colDis(id)
	{
		var idT="#useCoupon"+id+"";
		$(idT).css('display','none');
		for(var i=0;i<coupons.length;i++)
		{
			 var coupon=coupons[i];
			 if(coupon.studentGiftId==id)
			 {
				var usableAmountT=$("#minusAmount").textbox('getValue');
				usableAmountT=usableAmountT-coupon.usableAmount;
				$("#minusAmount").textbox('setValue',usableAmountT);
				
			 }
		}
	}
	
	function addArchives()
	{
		$('#dlg').dialog({
			title:"使用抵扣券",
		});
		var courseType=$("#courseType").val();
		$('#dlg').attr("src","/sys/course/useCoupon.jsp?studentId="+$("#studentId").val()+"&courseType="+courseType);
		$('#dlg').dialog("open");
	}

	initCousreGift();
	
		var arr=["连报课程一的","连报课程二的","连报课程三的","连报课程四的","连报课程五的","连报课程六的"];
		function checkParam(n)
		{
			if($("#payDate").datebox("getValue")=="")
			{
				parent.showMessage("提示","请选择"+arr[n]+"缴费时间",function(){
					parent.hideMessage();
					parent.scrolltoFrame(n,$("#payDate").parent().offset().top);
				});
				return false;
			}
			if($("#stageId").combobox("getValue")=="")
			{
				parent.showMessage("提示","请选择"+arr[n]+"阶段",function(){
					parent.hideMessage();
					parent.scrolltoFrame(n,$("#stageId").parent().offset().top);
				});
				return false;
			}
			if($("#classType").combobox("getValue")=="")
			{
				parent.showMessage("提示","请选择"+arr[n]+"班级类型",function(){
					parent.hideMessage();
					parent.scrolltoFrame(n,$("#classType").parent().offset().top);
					
				});
				return false;
			}
			
			if($("#adviserTeacherA").combobox("getValue")!='' && ($("#adviserTeacherB").combobox("getValue")==$("#adviserTeacherA").combobox("getValue")))
			{
				parent.showMessage("提示",arr[n]+"业绩老师A不能和业绩老师B相同",function(){
					parent.hideMessage();
					parent.scrolltoFrame(n,$("#adviserTeacherB").parent().offset().top);
				});
				return false;
			}
			return true;
		}
	</script>
