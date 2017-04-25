	$(document).ready(function(){
		$("#backBtn").click(function(){
			window.history.back();
		});
		$("#submitBtn").click(function(){
			approve();
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
						tr1.find("td:eq(5)").html(obj.higherNum);//已升学人数
						tr1.find("td:eq(6)").html(obj.higherRate);//升学率
						tr1.find("td:eq(7)").html(obj.planHigherNum);//可升学人数
						tr1.find("td:eq(8)").html(obj.numGap);//升学缺口
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
				}
				if(data.approveInfo!=undefined&&data.approveInfo.length>0)
				{
					$.each(data.approveInfo,function(i,obj){
						var tr3=$("#modelTr3").clone();
						tr3.find("td:eq(0)").html(obj.tacheName);
						tr3.find("td:eq(1)").html(obj.createDate);
						tr3.find("td:eq(2)").html(obj.handlerName);
						tr3.find("td:eq(3)").html(obj.approveType);
						tr3.find("td:eq(4)").html(obj.remark);
						tr3.css("display","table-row")
						$("#tab3").append(tr3);
					});
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
					if($("#comboState").val()=="001")
					{
						$("#approveName").html("合并班审批：");
						$("#text1").html("同意合并班");
						$("#text2").html("不同意合并班");
						$("#applyRemark").panel({
							title:"合并说明"
						});
					}
					else
					{
						$("#approveName").html("取消合并班审批：");
						$("#text1").html("同意取消合并班");
						$("#text2").html("不同意取消合并班");
						$("#applyRemark").panel({
							title:"取消合并说明"
						});
					}
					$("#applyRemark").html(data.remark);
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
	

function approve()
{
	var approveType="";
	$("input[name='approveType']").each(function(){
		if($(this).is(":checked"))
		{
			approveType =$(this).val();
			return false;
		}	
	})
	if(approveType=="")
	{
		$.messager.alert('提示', "请选择是否同意该申请！");
	}
	else
	{
		var param = {};
		param.approveType = approveType;
		param.handlerId = $("#handlerId").val();
		param.comboState = $("#comboState").val();
		var remark = trim($("#remark").val());
		remark = string2Json(remark);
		remark = encodeURI(remark);
		param.remark = remark;
		param.applyId = $("#applyId").val();
		$.ajax( {
			type : "POST",
			url : "/sys/mergeClass/approveApply.do",
			data :"param="+JSON.stringify(param),
			async : false,
			beforeSend : function() {
				showProgressLoader("正在提交审批,请稍等...", 400);
			},
			success : function(data) {
				hideProgressLoader()
				if (data == "true") {
					showMessage('提示', "审批成功！", function() {
						window.location.href = "mergeList.jsp";
					});
				} else {
					showMessage('提示', "审批失败！", null);
				}
	
			},
			error : function() {
				hideProgressLoader();
				showMessage('提示', "调用审批服务失败！", null);
			}
		});
	}	
}