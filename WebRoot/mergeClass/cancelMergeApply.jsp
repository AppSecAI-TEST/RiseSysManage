<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String applyId =request.getParameter("applyId");
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  	<body>
  		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<input id="applyId" type="hidden" value="<%=applyId%>"/>
  		<div class="easyui-panel" title="班级信息" style="width:1293px;">
  			<table id="tab1" width="100%;" class="maintable">
	  			<tr>
	  				<td align="center" width="6%">校区</td>
	  				<td align="center" width="7%">班级名称</td>
	  				<td align="center" width="15%">结课日期</td>
	  				<td align="center"  width="29%">上课时间段</td>
	  				<td align="center" width="7%">在读人数</td>
	  				<td align="center" width="7%">已升学人数</td>
	  				<td align="center" width="7%">升学率</td>
	  				<td align="center" width="14%">可升学人数</td>
	  				<td align="center" width="7%">升学缺口</td>
	  			</tr>
	  			<tr id="modelTr1" style="display:none">
	  				<td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td>
	  				<td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td>
	  			</tr>
  			</table>
  		</div>
  		<div class="easyui-panel" title="合并班计划" style="width:1293px;">
  			<table id="tab2" width="100%;" class="maintable">
  				<tr>
  					<td align="center" width="4%">校区</td>
  					<td align="center" width="5%">班级名称</td>
  					<td align="center" width="9%">开始日期</td>
  					<td align="center" width="4%">开始课时</td>
  					<td align="center" width="4%">合并时长(周)</td>
  					<td align="center" width="8%">合并形式</td>
  					<td align="center" width="8%">合并后结课日期</td>
  					<td align="center" width="5%">合并后班级</td>
  					<td align="center" width="4%">定班人数</td>
  					<td align="center" width="4%">定班率</td>
  					<td align="center" width="18%">合并后上课时段</td>
  					<td align="center" width="14%">带班老师</td>
  					<td align="center" width="9%">开课日期</td>
  				</tr>
  				<tr id="modelTr2" style="display:none">
  					<td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td>
  					<td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td>
  				</tr>
  				<tr id="modelTr21" style="display:none">
  					<td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td><td align="center"></td>
  				</tr>
  			</table>
  		</div>
  		<div id="courseChangePlan"  class="easyui-panel" title="课程调整计划" style="width:1293px;">  			
  		</div>
  		<div class="easyui-panel" id="applyRemark" title="合并说明" style="width:1293px;padding:20px">
  		</div>
  		<div class="easyui-panel" title="取消合并班说明" style="width:1293px;">
  			<input name="remark" id="remark" type="text" style="width:80%;height:120px" class="easyui-textbox" data-options="multiline:true" /> 						
  		</div>
  		<div style="width:1293px;text-align:right;margin:50px 0;">
  			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px" id="submitBtn"><span>提交</span></a>
  				&nbsp;&nbsp;&nbsp;&nbsp;
  			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px" id="backBtn" ><span>返回</span></a>		
  		</div>		
  	</body>
</html>
<script type="text/javascript">
	$(document).ready(function(){
		$("#submitBtn").click(function(){
			cancel();
		});
		$("#backBtn").click(function(){
			window.history.back();
		});
		initPage();
	});
	function initPage()
	{
		$.ajax({
			type : "POST",
			url : "/sys/mergeClass/getMergeInfo.do",
			data :"applyId="+$("#applyId").val()+"&approveFlag=N",
			async : false,
			dataType:"json",
			beforeSend : function() 
			{
				showProgressLoader("正在加载数据,请稍等...", 400);
			},
			success : function(data) 
			{
				if(data.classInfo!=undefined&&data.classInfo.length>0)
				{
					$.each(data.classInfo,function(i,obj){
						var tr1=$("#modelTr1").clone();
						tr1.find("td:eq(0)").html(obj.schoolName);
						tr1.find("td:eq(1)").html(obj.className);
						tr1.find("td:eq(2)").html(obj.finishDate);
						tr1.find("td:eq(3)").html(obj.classTime);
						tr1.find("td:eq(4)").html(obj.readNum);
						tr1.find("td:eq(5)").html();//已升学人数
						tr1.find("td:eq(6)").html();//升学率
						tr1.find("td:eq(7)").html();//可升学人数
						tr1.find("td:eq(8)").html();//升学缺口
						tr1.css("display","table-row")
						$("#tab1").append(tr1);
					});
				}
				if(data.detailInfo!=undefined&&data.detailInfo.length>0)
				{
					$.each(data.detailInfo,function(i,obj){
						if(i==0)
						{
							var tr2=$("#modelTr2").clone();
							tr2.find("td:eq(0)").html(obj.schoolName);
							tr2.find("td:eq(1)").html(obj.classesName);
							tr2.find("td:eq(2)").html(obj.startDate).attr("rowspan",data.detailInfo.length);
							tr2.find("td:eq(3)").html(obj.startHours);
							tr2.find("td:eq(4)").html(obj.weeks).attr("rowspan",data.detailInfo.length);
							tr2.find("td:eq(5)").html(obj.comboType);
							tr2.find("td:eq(6)").html(obj.comboFinishDate);
							tr2.find("td:eq(7)").html(obj.className).attr("rowspan",data.detailInfo.length);
							tr2.find("td:eq(8)").html(obj.orderNum);
							tr2.find("td:eq(9)").html(obj.orderPer).attr("rowspan",data.detailInfo.length);
							tr2.find("td:eq(10)").html(obj.times).attr("rowspan",data.detailInfo.length);
							tr2.find("td:eq(11)").html(obj.teachers).attr("rowspan",data.detailInfo.length);
							tr2.find("td:eq(12)").html(obj.openClassDate).attr("rowspan",data.detailInfo.length);
						}
						else
						{
							var tr2=$("#modelTr21").clone();
							tr2.find("td:eq(0)").html(obj.schoolName);
							tr2.find("td:eq(1)").html(obj.classesName);
							tr2.find("td:eq(2)").html(obj.startHours);
							tr2.find("td:eq(3)").html(obj.comboType);
							tr2.find("td:eq(4)").html(obj.comboFinishDate);
							tr2.find("td:eq(5)").html(obj.orderNum);
						}	
						tr2.css("display","table-row")
						tr2.attr("applyDetailId",obj.applyDetailId);
						tr2.attr("schoolName",obj.schoolName);
						tr2.attr("className",obj.classesName);
						$("#tab2").append(tr2);
					});
					$("#applyRemark").html(data.remark);
				}
				if(data.hoursInfo!=undefined&&data.hoursInfo.length>0)
				{
					var num =data.hoursInfo.length/data.classNum;
					var maxrow =20;	
					var maxWeek =18;
					var tabNum =num/maxWeek;
					var lastNum=num%maxWeek;
					if(lastNum==0)
					{
						lastNum=18;
					}	
					if(tabNum<=1)
					{
						tabNum =1;
					}
					else if(tabNum<=2)
					{
						tabNum =2;
					}
					else
					{
						tabNum =3;
					}
					var count=1;
					var rowNum =data.classNum+1;
					var initStr="";
					for(var i=1;i<=tabNum;i++)
					{
						initStr +="<table class='maintable'>";
						for(var j=0;j<rowNum;j++)
						{
							var jobj =$("#tab2").find("tr:eq("+(j+2)+")");
							initStr+="<tr>";
							var cellNum=null;
							if(i<tabNum)
							{
								cellNum =maxrow;
							}
							else
							{
								cellNum =lastNum+2;
							}
							for(var k=0;k<cellNum;k++)
							{
								if(j==0&&k==0)
								{
									initStr+="<td width='62.2px' align='center'>校区</td>";
								}
								else if(j==0&&k==1)
								{
									initStr+="<td width='62.2px' align='center'>班级名称</td>";
								}
								else if(j==0)
								{
									initStr+="<td width='62.2px' align='center'>第"+(count++)+"周</td>";
								}
								else if(k==0)
								{
									initStr+="<td width='62.2px' align='center'>"+jobj.attr("schoolName")+"</td>";
								}
								else if(k==1)
								{
									initStr+="<td width='62.2px' align='center'>"+jobj.attr("className")+"</td>";
								}
								else
								{
									initStr+="<td width='62.2px' align='center'>"+getCellHours((i*18+k-19),jobj.attr("applyDetailId"),data.hoursInfo)+"</td>";
								}	
							}	
							initStr+="</tr>";
						}	
						initStr +="</table>";
					}
					$("#courseChangePlan").html(initStr)
				}	
				hideProgressLoader();
			},
			error : function() 
			{
				hideProgressLoader();
			}
		});
	}
	
	
	function getCellHours(val1,val2,objs)
	{
		var str ="";
		$.each(objs,function(i,obj){
			if(val1==obj.weekOrder&&val2==obj.applyDetailId)
			{
				str = obj.hours;
				return false;
			}
		})	
		return str;
	}
	
	function cancel()
	{
		$(function () {
        $.messager.confirm("提示", "您确定要取消该合并申请？", function (data) {
            if (data) 
            {
            	var param={};
            	param.applyId =$("#applyId").val();
            	param.handlerId =$("#handlerId").val();
            	param.remark =$("#remark").textbox("getValue");
                $.ajax( {
					type : "POST",
					url : "/sys/mergeClass/cancelApply.do",
					data :"param="+JSON.stringify(param),
					async : false,
					beforeSend : function() {
						showProgressLoader("正在提交申请,请稍等...", 400);
					},
					success : function(data) {
						hideProgressLoader()
						if (data == "true") {
							showMessage('提示', "申请成功！", function() {
								window.location.href = "mergeList.jsp";
							});
						} else {
							showMessage('提示', "申请失败！", null);
						}
			
					},
					error : function() {
						hideProgressLoader();
						showMessage('提示', "调用取消合并申请服务失败！", null);
					}
				});
            }
        });
    });
		
	}
</script>