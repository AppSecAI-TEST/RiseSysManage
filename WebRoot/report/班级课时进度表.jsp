<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/newRecruit.js"></script>
  	</head>
  	<body>
  		<input id="staffId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<div style="padding:5px 0;">
  			<form id="qryFm" style="margin:0 auto;">
	  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:80px;" cellspacing="2">
	  				<tr>
	  					<td align="right" width="80px"><span>校区：</span></td>
	  					<td align="left"  width="110px">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        	</select>
	  					</td>
	  					<td align="right" width="50px"><span>班级：</span></td>
	  					<td align="left"  width="110px">
	  						<input id="className" name="className" class="easyui-textbox" style="width: 100px; height: 25px;">
	  					</td>
	  					<td align="right" width="50px"><span>教师：</span></td>
	  					<td align="left"  width="110px">
	  						<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'"
				        	</select>
	  					</td>
	  					<td align="right" width="50px"><span>阶段：</span></td>
	  					<td align="left"  width="110px">
	  						<select id="stageId" name="stageId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'"
					      		url="<%=path %>/pubData/qryStage.do?">
				        	</select>
	  					</td>
	  					<td width="50px" align="right" ><span>日期：</span></td>
						<td width="114px">
	  						<input class="easyui-datebox" type="text" style="width:150px; height: 25px;" id="startTime" name="startTime" data-options="formatter:myYearMonthformatter, parser:myparser,onShowPanel:settingYearMonthPanel" editable="false"/>
						</td>
						<td align="center">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="5007">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
	  				</tr>	
	  			</table>
  			</form>
  		<div style="min-width:1100px;width:99%;margin:0 auto;"><a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;margin: 2px ">导出全部</a>
  		<a href="javascript:void(0)" id="diffBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 120px;margin: 2px ">提交差异说明</a></div>	
  		<div style="min-width:1100px;width:99%;margin:0 auto;">
		<div class="easyui-panel" title="排课信息" style="width:100%;overflow:auto;min-height:400px">
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
  		</div>	
  	</body>
</html>
<script type="text/javascript">
	$(document).ready(function(){
		$('#startTime').datebox("setValue",new Date().getFullYear()+"-"+(new Date().getMonth()+1));
		$("#schoolId").combobox({
			url : "/sys/pub/pageCategory.do?staffId="+$("#staffId").val()+"&resourceId=714&fieldId=schoolId&headFlag=N",
    		onLoadSuccess : function() {
    			if($("#schoolId").combobox("getData").length>0)
    			{
    				$("#schoolId").combobox("setValue",$("#schoolId").combobox("getData")[0].schoolId);
    			}	
    		},
    		onChange : function(n, o) {
    			$("#teacherId").combobox({
		    		url:"/sys/pubData/qryTeacherList.do?schoolId="+n
		    	});
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

	
</script>
