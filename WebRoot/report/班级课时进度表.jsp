<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
  	</head>
  	<body>
  		<input id="staffId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<input type="hidden" id="resourceId" value="748">
  		<div style="margin-right:5px;">
  			<form id="qryFm">
	  			<table class="search_tab">
	  				<tr>
	  					<td align="right" width="50px"><span>校区：</span></td>
	  					<td align="left"  width="100px">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        	</select>
	  					</td>
	  					<td align="right" width="50px"><span>班级：</span></td>
	  					<td align="left"  width="100px">
	  						<input id="className" name="className" class="easyui-textbox" style="width: 100px; height: 25px;">
	  					</td>
	  					<td align="right" width="50px"><span>教师：</span></td>
	  					<td align="left"  width="100px">
	  						<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'"
				        	</select>
	  					</td>
	  					<td align="right" width="50px"><span>阶段：</span></td>
	  					<td align="left"  width="100px">
	  						<select id="stageId" name="stageId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'"
					      		url="<%=path %>/pubData/qryStage.do?">
				        	</select>
	  					</td>
	  					<td width="50px" align="right" ><span>日期：</span></td>
						<td width="100px">
	  						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTime" name="startTime" data-options="formatter:myYearMonthformatter, parser:myparser,onShowPanel:settingYearMonthPanel" editable="false"/>
						</td>
						<td align="left">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px; height: 25px;" id="qryBtn" funcNodeId="5007">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:80px; height: 25px;" id="reset">重置</a>
						</td>
	  				</tr>	
	  			</table>
  			</form>
  		<div style="min-width:1100px;width:100%;margin:2px auto;"><a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;margin: 2px ">导出全部</a>
  		<a href="javascript:void(0)" id="diffBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 120px;margin: 2px ">提交差异说明</a></div>	
		<div class="easyui-panel" title="排课信息" style="width:1505px;overflow:auto;min-height:400px">
		<table class="maintable" id="hoursPlanTab" style="width:1500px;margin-right: 10px;" cellspacing="0" cellpadding="0">
		  <tr align="center">
		     <td align="center" width="78px;" rowspan="2"><span>学校</span></td>
		    <td align="center" width="78px;" rowspan="2"><span>班级</span></td>
		    <td align="center" width="96px;" rowspan="2"><span>带班老师</span></td>
		    <td align="center" width="240px;"rowspan="2"><span>上课时段</span></td>
		    <td align="center" width="86px;" rowspan="2"><span>开课日期</span></td>
		    <td align="center" width="86px;" rowspan="2"><span>结课日期</span></td>
		    <td align="center" width="42px;" rowspan="2"><span>上月已上课时</span></td>
		    <td align="center" width="42px;" rowspan="2"><span>上月剩余课时数</span></td>
		    <td align="center" width="42px;" rowspan="2"><span>上月课时差异</span></td>
		    <td align="center" width="62px;" colspan="3"><span>第一周</span></td>
		    <td align="center" width="62px;" colspan="3"><span>第二周</span></td>
		    <td align="center" width="62px;" colspan="3"><span>第三周</span></td>
		    <td align="center" width="62px;" colspan="3"><span>第四周</span></td>
		    <td align="center" width="62px;" colspan="3"><span>第五周</span></td>
		    <td align="center" width="48px;" rowspan="2"><span>本月计划课时</span></td>
		    <td align="center" width="48px;" rowspan="2"><span>本月实际课时</span></td>
		    <td align="center" width="48px;" rowspan="2"><span>课时差异</span></td>
		    <td align="center" width="48px;" rowspan="2"><span>差异说明</span></td>
		  </tr>
		  <tr align="center">
		    <td align="center" width="40px;"><span>剩余课时</span></td>
		    <td align="center" width="40px;"><span>计划课时</span></td>
		    <td align="center" width="40px;"><span>实际课时</span></td>
		    <td align="center" width="40px;"><span>剩余课时</span></td>
		    <td align="center" width="40px;"><span>计划课时</span></td>
		    <td align="center" width="40px;"><span>实际课时</span></td>
		    <td align="center" width="40px;"><span>剩余课时</span></td>
		    <td align="center" width="40px;"><span>计划课时</span></td>
		    <td align="center" width="40px;"><span>实际课时</span></td>
		    <td align="center" width="40px;"><span>剩余课时</span></td>
		    <td align="center" width="40px;"><span>计划课时</span></td>
		    <td align="center" width="40px;"><span>实际课时</span></td>
		    <td align="center" width="40px;"><span>剩余课时</span></td>
		    <td align="center" width="40px;"><span>计划课时</span></td>
		    <td align="center" width="40px;"><span>实际课时</span></td>
		  </tr>
		</table>
		</div>
		</div>
		<form id="excelForm" action="<%=path%>/export/exportExpClassDetail.do" enctype="multipart/form-data"  method="post">
			<input type="hidden" id="param" name="param">
		</form>
  	</body>
</html>
<script type="text/javascript">
	$(document).ready(function(){
		var clearFlag = true;
		$('#startTime').datebox("setValue",new Date().getFullYear()+"-"+(new Date().getMonth()+1));
		$("#schoolId").combobox({
			loader:function(param,success,error){  
			    $.ajax({  
					url: "/sys/pub/pageCategory.do?staffId="+$("#staffId").val()+"&resourceId="+$("#resourceId").val()+"&fieldId=schoolId",  
					dataType: 'json',  
					success: function(data) {
				    	if(data.length == schoolData.length) {
				    		data.unshift({schoolName:'全部校区', schoolId:""});  
				    	}
						success(data);  
					}
				});  
	   		},
    		onChange : function(n, o) {
    			$("#teacherId").combobox({
		    		url:"/sys/pubData/qryTeacherList.do?schoolId="+n
		    	});
    		},
    		onLoadSuccess : function(data) {
				ajaxLoadEnd();
				if(data.length > 0) {
					$("#schoolId").combobox("setValue", data[0].schoolId);
					clearFlag = false;
				}	
			}
    		
    	});	
		
		$("#qryBtn").click(function() {
			var object = $("#qryFm").serializeObject();
	    	var obj = JSON.stringify(object);
	    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
	    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
	    	$.ajax(
					{
						type : "POST",
						url : "/sys/report/getHours.do?param="+obj,
						async: true,
						dataType:"json",
						beforeSend: function()
				    	{
				    		showProgressLoader("正在查询,请稍后...",400);
				    	},
				    	success: function(data) 
				    	{
				    		hideProgressLoader();
				    		var html="<tr>"+$("#hoursPlanTab").find("tr:eq(0)").html()+"</tr><tr>"+$("#hoursPlanTab").find("tr:eq(1)").html()+"</tr>";
				    		for(var i=0;i<data.length;i++)
				    		{
				    			var obj=data[i];
				    			html+="<tr class='infoTr' classInstId =\""+obj.classInstId+"\" month=\""+obj.month+"\">";
				    			html+="<td align='center'><span>"+obj.schoolName+"</span></td>";
				    			html+="<td align='center'><span>"+obj.className+"</span></td>";
				    			html+="<td align='center'><span>"+obj.byname+"</span></td>";
				    			html+="<td align='center'><span>"+obj.dateRange+"</span></td>";
				    			html+="<td align='center'><span>"+obj.startDate+"</span></td>";
				    			html+="<td align='center'><span>"+obj.finishDate+"</span></td>";
				    			html+="<td align='center'><span>"+obj.realHour+"</span></td>";
				    			html+="<td align='center'><span>"+obj.diffNum+"</span></td>";
				    			html+="<td align='center'><span>"+obj.monthDiffNum+"</span></td>";
				    			html+="<td align='center'><span>"+obj.weekDiff1+"</span></td>";
				    			html+="<td align='center'><span>"+obj.weekPlan1+"</span></td>";
				    			html+="<td align='center'><span>"+obj.weekHand1+"</span></td>";
				    			html+="<td align='center'><span>"+obj.weekDiff2+"</span></td>";
				    			html+="<td align='center'><span>"+obj.weekPlan2+"</span></td>";
				    			html+="<td align='center'><span>"+obj.weekHand2+"</span></td>";
				    			html+="<td align='center'><span>"+obj.weekDiff3+"</span></td>";
				    			html+="<td align='center'><span>"+obj.weekPlan3+"</span></td>";
				    			html+="<td align='center'><span>"+obj.weekHand3+"</span></td>";
				    			html+="<td align='center'><span>"+obj.weekDiff4+"</span></td>";
				    			html+="<td align='center'><span>"+obj.weekPlan4+"</span></td>";
				    			html+="<td align='center'><span>"+obj.weekHand4+"</span></td>";
				    			html+="<td align='center'><span>"+obj.weekDiff5+"</span></td>";
				    			html+="<td align='center'><span>"+obj.weekPlan5+"</span></td>";
				    			html+="<td align='center'><span>"+obj.weekHand5+"</span></td>";
				    			html+="<td align='center'><span>"+obj.monthPlanHours+"</span></td>";
				    			html+="<td align='center'><span>"+obj.monthRealNum+"</span></td>";
				    			html+="<td align='center'><span>"+obj.mDiffNum+"</span></td>";
				    			if(obj.remark=='' || obj.remark==undefined)
				    			{
				    				
				    				html+="<td align='center' width='40px;'><input class='easyui-textbox' style='width:150px; height: 25px;'/></td>";
				    			}else
				    			{
				    				html+="<td align='center'><span>"+obj.remark+"</span></td>";
				    			}
				    			
				    			html+="</tr>";
				    		}
							
							$("#hoursPlanTab").html(html);
							$.parser.parse(	$("#hoursPlanTab"))
				    	},
				    	error:function()
				        {
				    		hideProgressLoader();
				        	$.messager.progress('close');
				        }
				   });
	    });
		
	$("#reset").click(function() {
		$("#qryFm").form('clear');//清空窗体数据 
		if(!clearFlag) {
    		$("#schoolId").combobox('select',$("#schoolId").combobox("getData")[0].schoolId);
    	} else {
    		$("#schoolId").combobox('setValue',"");
    	}
		$('#startTime').datebox("setValue",new Date().getFullYear()+"-"+(new Date().getMonth()+1));
	});
		
		
		
		$("#diffBtn").click(function(){
			var arr =[];
			$(".infoTr").each(function(){
				var val =$(this).find("td:last").find(".textbox-value").val();
				if(val!=null&&val!="")
				{
					var obj ={
						classInstId:$(this).attr("classInstId"),
						month:$(this).attr("month"),
						val:val
					}
					arr.push(obj);
				}	
			});
			if(arr.length>0)
			{
				$.ajax({
				url:"/sys/report/recordDiffInfo.do",
				data:"param="+JSON.stringify(arr),
				type:"post",
				beforeSend:function(){
					showProgressLoader("正在提交数据,请稍后",400);
				},
				success:function(data)
				{
					hideProgressLoader();
					if(data=="true")
					{
						showMessage("提示","提交差异说明成功",null);
					}
					else
					{
						showMessage("提示","提交差异说明失败",null);
					}	
				},
				error:function(data)
				{
					hideProgressLoader();
				}
				});
			}
			else
			{
				showMessage("提示","没有差异说明数据可以提交",null);
				return false;
			}	
		});
	});

	$("#export").click(function(){
		var arr =[];
		$(".infoTr").each(function(){
			var obj={};
			obj.schoolName =$(this).find("td:eq(0)").find("span").html();
			obj.className =$(this).find("td:eq(1)").find("span").html();
			obj.byname =$(this).find("td:eq(2)").find("span").html();
			obj.dateRange =$(this).find("td:eq(3)").find("span").html();
			obj.startDate =$(this).find("td:eq(4)").find("span").html();
			obj.finishDate =$(this).find("td:eq(5)").find("span").html();
			obj.realHour =$(this).find("td:eq(6)").find("span").html();
			obj.diffNum =$(this).find("td:eq(7)").find("span").html();
			obj.monthDiffNum =$(this).find("td:eq(8)").find("span").html();
			obj.weekDiff1 =$(this).find("td:eq(9)").find("span").html();
			obj.weekPlan1 =$(this).find("td:eq(10)").find("span").html();
			obj.weekHand1 =$(this).find("td:eq(11)").find("span").html();
			obj.weekDiff2 =$(this).find("td:eq(12)").find("span").html();
			obj.weekPlan2 =$(this).find("td:eq(13)").find("span").html();
			obj.weekHand2 =$(this).find("td:eq(14)").find("span").html();
			obj.weekDiff3 =$(this).find("td:eq(15)").find("span").html();
			obj.weekPlan3 =$(this).find("td:eq(16)").find("span").html();
			obj.weekHand3 =$(this).find("td:eq(17)").find("span").html();
			obj.weekDiff4 =$(this).find("td:eq(18)").find("span").html();
			obj.weekPlan4 =$(this).find("td:eq(19)").find("span").html();
			obj.weekHand4 =$(this).find("td:eq(20)").find("span").html();
			obj.weekDiff5 =$(this).find("td:eq(21)").find("span").html();
			obj.weekPlan5 =$(this).find("td:eq(22)").find("span").html();
			obj.weekHand5 =$(this).find("td:eq(23)").find("span").html();
			obj.monthPlanHours =$(this).find("td:eq(24)").find("span").html();
			obj.monthRealNum =$(this).find("td:eq(25)").find("span").html();
			obj.mDiffNum =$(this).find("td:eq(26)").find("span").html();
			if($(this).find("td:eq(27)").find(".textbox-value").length>0)
			{
				obj.remark ="";
			}
			else
			{
				obj.remark =$(this).find("td:eq(27)").find("span").html();
			}
			arr.push(obj);
		});
		if(arr.length<1)
		{
			showMessage("提示","没有数据可以导出",null);
			return false;
		}
		else
		{
			var param={
				info:arr,
				fileName:parent.$("li.tabs-selected").find("span.tabs-title").html()
			}
			$("#param").val(JSON.stringify(param));
			$("#excelForm").submit();
		}	
	});
</script>
