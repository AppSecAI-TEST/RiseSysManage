<%@ page language="java" import="java.util.*,net.sf.json.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.rise.pub.util.*"%>
<%
	String path = request.getContextPath();
	String schoolId= request.getParameter("schoolId");
	String studentId =request.getParameter("studentId");
	String order=request.getParameter("order");
	String courses=request.getParameter("courses");
	String name=request.getParameter("name");
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
		<script type="text/javascript" src="<%=path %>/js/course.js"></script>
		<script type="text/javascript" src="<%=path %>/js/course/addCourse.js"></script>
  	</head>
  
  	<body >
  	<div  class="easyui-panel" title="连报课程<%=order%>" style="width:99%;padding:10px;border-color:#95B1E7">
  	<input id="frameName" name="frameName" type="hidden" value="<%=name%>"/>
  	<form id="courseFm">
	      <div style="height: 10px;"></div>
	      <div class="easyui-panel" style="width:100%;height:auto;" title="常规课课程">
	      
      	      <table width="100%" cellpadding="5px" class="maintable" >
	      	      <tr>
	      	        <input id="studentCourseId" name="studentCourseId" type="hidden" value="<%=StringUtil.getJSONObjectKeyVal(object,"studentCourseId")%>"/>
	      	        <input id="oldClassType"  type="hidden" value="<%=StringUtil.getJSONObjectKeyVal(object,"classType")%>"/>
	      	        <input id="oldStageId"   type="hidden" value="<%=StringUtil.getJSONObjectKeyVal(object,"stageId")%>"/>
	      	      	<input id="studentId"    name="studentId"     type="hidden" value="<%=studentId%>"/>
	      	    	<input id="courseType"   name="courseType"    type="hidden" value="001"/>
	      	    	<input id="advisterType" name="adviserType" type="hidden" value="teacher"/>
	      	    	<input id="courseState" name="courseState"  type="hidden" value="001"/>
	      	    	<input id="feeType"    name="feeType"  type="hidden" value="002"/>
	      	    	<input id="feeState"   name="feeState" type="hidden" value="00A"/>
	      	    	<input id="stageOrder" name="stageOrder" type="hidden" value=""/>
	      	    	<input id="schoolId"   name="schoolId" type="hidden" value="<%=schoolId%>"/>
	      	    	<input type="hidden" id="paySchoolId" name="paySchoolId" value="<%=schoolId%>" />	
	      	    	<input type="hidden" id="coursePriceId" name="coursePriceId" value="" />
	      	    	 <td align="right"><span>缴费时间：</span></td>
	      	        <td><input name="payDate" id="payDate" type="text" class="easyui-datebox" required="true" style="width: 150px; height: 28px;" value="<%=StringUtil.getJSONObjectKeyVal(object,"payDate")%>" /></td>
	      	        <td align="right"> <span>阶段：</span></td>
	      	        <td>
					 <select name="stageId"  id="stageId"   style="width: 150px; height: 28px;"
	      						data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#stageId').combobox('setValue','<%=StringUtil.getJSONObjectKeyVal(object,"stageId")%>');}"
	      						url="<%=path %>/pubData/qryStage.do" required="true" >
      	            </select>
					</td>
	      	        <td align="right"><span>班级类型：</span></td>
	      	        <td> 
	      	         <select name="classType" id="classType" class="easyui-combobox"  style="width: 150px; height: 28px;" drequired="true" >
	      						<option value="<%=StringUtil.getJSONObjectKeyVal(object,"classType")%>"><%=StringUtil.getJSONObjectKeyVal(object,"classType")%></option>
      	           	 </select>
	      	        </td>
	      	       
      	        </tr>
	      	      <tr>
	      	        <td  align="right"><span>业绩类型：</span></td>
	      	        <td><span>升学</span></td>
	      	        <td align="right"><span>业绩老师A：</span></td>
	      	        <td> <select name="adviserA"  class="easyui-combobox" style="width: 150px; height: 28px;"
		     				data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto',
		      				onLoadSuccess:function(data){$('#teacherId').combobox('setValue',data[0].teacherId);}" 
		      				url="<%=path %>/pubData/qryTeacherList.do?schoolId=${sessionScope.StaffT.schoolId}"></td>
	      	        <td align="right"><span>业绩老师B：</span></td>
	      	        <td> <select name="adviserB"  class="easyui-combobox" style="width: 150px; height: 28px;"
		     				data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto',
		      				onLoadSuccess:function(data){$('#teacherId').combobox('setValue',data[0].teacherId);}" 
		      				url="<%=path %>/pubData/qryTeacherList.do?schoolId=${sessionScope.StaffT.schoolId}"></td>
	      	      
      	        </tr>
      	      </table>
      	      
</div>
      	<div style="height: 10px;"></div>
      	<div class="easyui-panel" style="width:100%;height:auto;" title="赠品信息">
      	
      	      <table width="100%" cellpadding="5px" class="maintable" id="giftTab">
	      	      <tr id="giftModelTR">
	      	        <td width="8%" align="right"><span>赠品类型：</span></td>
	      	        <td width="8%">
	      	        <select   id="parentType" style="width: 100px; height: 28px;"
	      				     data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      					 url="<%=path %>/pubData/qryCodeNameList.do?tableName=GIFT_TYPE_T&codeType=PARENT_TYPE" required="true" >
      	            </select>
      	            </td>
	      	        <td width="7%" align="right"><span>赠品名称：</span></td>
	      	        <td width="39%">
	      	      	<table  border="0">
	   	                <tr>
			      	         <td id='td0' ><select  class="easyui-combobox" id="giftType" style="width: 120px; height: 28px;"></select></td>
			      	         <td id="td1" style="display:none"><select  class="easyui-combobox" id="giftId" style="width: 120px; height: 28px;"></select></td>
			      	         <td id="td2" style="display:none"><input   id="giftCode" type="text" class="easyui-textbox validatebox" required="true" style="width:150px; height: 28px;"/></td>
		                     <td id="td3" style="display:none"><input   id="giftEffDate" type="text" class="easyui-datebox" required="true" style="width: 100px; height: 28px;"/></td>
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
	      	        <td width="8%"><input   id="granter" type="text" class="easyui-textbox validatebox" required="true" style="width: 100px; height: 28px;"/></td>
	      	        <td width="4%"><span>是否退回</span></td>
	      	        <td width="6%"><a href="javascript:void(0)" id="addGiftBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px; height: 28px;">添加</a></td>
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
      	        <td>&nbsp;</td>
      	        <td><a href='javascript:void(0)' class='linkmore' onclick='delRow(this)' ><span>删除</span></a></td>
     	       </tr>
      	      </table>
      		</div>
      		<div style="height: 10px;"></div>
      		<div class="easyui-panel" style="width:100%;height:auto;" title="赠课信息">
      	      <table width="100%" cellpadding="5px" class="maintable" >
	      	      <tr>
	      	        <td colspan="2" align="right"><span>赠课类型</span></td>
	      	        <td width="22%" align="right">
		      	        <div align="left">
		      	          <select   id="giftCourseType" style="width: 150px; height: 28px;"
		      	           data-options="formatter:formatTypeName,  valueField: 'giftType', textField: 'typeName', panelHeight: 'auto'"
		      	          url="/sys/pubData/qryData.do?param={queryCode:'Qry_Gift_Type',parentType:'COURSE'}" ></select>
      	            </div></td>
	      	        <td width="10%" align="right"><span>赠课名称：</span></td>
	      	        <td width="11%"><select class="easyui-combobox" id="giftCourseId" style="width: 120px; height: 28px;" required="true">
	      	          </select></td>
	      	       
	      	        <td width="12%" align="right"><span>课时量:</span></td>
	      	        <td width="22%" id="courseHours"></td>
      	            <td width="7%"><a href="javascript:void(0)" id="addCourse" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px; height: 28px;">添加</a></td>
      	        </tr>
      	      </table>
      	       <table width="100%" cellpadding="5px" class="maintable" id="giftCourse">
	      	      <tr align="center">
	      	        <td width="6%" ><span>序号</span>&nbsp;</td>
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
	      	        <td  val="">&nbsp;</td>
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
			<div style="height: 10px;"></div>
			<div class="easyui-panel" style="width:100%;height:auto;" title="课程费用">
			     	      <table width="100%" cellpadding="5px" class="maintable" >
			  	            <tr>
			     	            <td  align="right" ><span>现金抵扣劵：</span></td>
			     	            <td align="center"  ><href="javascript:void(0)" id="addArchives" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addArchives()">使用现金抵扣券</</td>
			      	            <td colspan="8"  giftId=""><div id="useCoupon"/></td>
			   	            </tr>
			   	            <tr>
				      	        <td width="10%"  align="right" ><span>课程金额：</span></td>
				      	        <td width="14%"  align="left" ><input id="totalAmount" readonly="readonly"  name="totalAmount" type="text" value="<%=StringUtil.getJSONObjectKeyVal(object,"totalAmount")%>" class="easyui-textbox validatebox"  style="width: 200px; height: 25px;"> </td>
				      	        <td width="12%"  align="right" ><span >现金抵扣券金额：</span></td>
				      	        <td colspan="3"  align="left" ><input id="minusAmount"   readonly="readonly"  name="minusAmount" type="text" value="<%=StringUtil.getJSONObjectKeyVal(object,"minusAmount")%>" class="easyui-textbox validatebox"  style="width: 200px; height: 25px;">  </td>
				      	        <td width="11%"  align="right"><span>连报优惠金额：</span></td>
				      	        <td width="17%"  align="left" ><input id="favorAmount"   name="favorAmount" type="text" value="<%=StringUtil.getJSONObjectKeyVal(object,"favorAmount")%>" class="easyui-textbox validatebox"  style="width: 200px; height: 25px;"/></td>
				      	        <td width="12%"  align="right"><span>实缴课程金额：</span></td>
				      	        <td width="17%"  align="left" ><input id="amount"   readonly="readonly"   name="amount" type="text"  value="<%=StringUtil.getJSONObjectKeyVal(object,"amount")%>" class="easyui-textbox validatebox"  style="width: 200px; height: 25px;"> </td>
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

	var studentCourse={};//最后提交学生课程信息
    var gifts  =[];  
	var courses=[];
	var coupons=[];//使用抵扣劵
	var useCoupon="";
	
	var minus=0;//抵扣金额
	var favorAmount=0;//优惠金额
	var totalAmount=0;//课程金额
	var amount=0;//实缴金额

	//创建连报提交数据
	function build()
	{
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
		//alert($("#studentId").val())
		$('#dlg').attr("src","/sys/course/useCoupon.jsp?studentId="+$("#studentId").val());
		$('#dlg').dialog("open");
	}

	initCousreGift();
	
	</script>
