var classArr=null;
var maxrow =20;	
var maxWeek =18;
var totalNum =0;
var orderNum =0;
$(document).ready(function(){
	$("#backBtn").click(function(){
		window.history.back();
	})
	$.ajax({
		type : "POST",
		url : "/sys/mergeClass/qryClassInstList.do",
		data :"classInstIds="+$("#classInstIds").val(),
		async : false,
		dataType:"json",
		beforeSend : function() 
		{
			showProgressLoader("正在加载数据,请稍等...", 400);
		},
		success : function(data) 
		{
			hideProgressLoader()
			if(data!=null&&data.length>1)
			{
				classArr =data;
				initApplyClassTable(classArr);
			}	
		},
		error : function() 
		{
			hideProgressLoader();
		}
	});
});

function initApplyClassTable(classes)
{
	//生成初步控件
	var arr=[2,4,7,9,10,11,12];
	$.each(classes,function(i,obj){
		var tr1 =$("#modelTr1").clone();
		tr1.addClass("mergeTr");
		tr1.find("td:eq(0)").html(obj.schoolName)
		tr1.find("td:eq(1)").html(obj.className)
		if(i==0)
		{
			tr1.find("td:eq(2)").find("input").attr("id","startDate");
			tr1.find("td:eq(4)").find("input").attr("id","mergeWeek");
			tr1.find("td:eq(7)").find("input").attr("id","className");
			tr1.find("td:eq(9)").attr("id","orderRate").append("0%");
			tr1.find("td:eq(10)").find("select").each(function(index){
				if(index==0)
				{
					$(this).attr("id","weekTime1")
				}
				else if(index==1)
				{
					$(this).attr("id","hourRange1")
				}
				else if(index==2)
				{
					$(this).attr("id","weekTime2")
				}
				else if(index==3)
				{
					$(this).attr("id","hourRange2")
				}
			});
			tr1.find("td:eq(11)").find("select").each(function(index){
				if(index==0)
				{
					$(this).attr("id","school1")
				}
				else if(index==1)
				{
					$(this).attr("id","teacher1")
				}
				else if(index==2)
				{
					$(this).attr("id","school2")
				}
				else if(index==3)
				{
					$(this).attr("id","teacher2")
				}
			});
			tr1.find("td:eq(12)").find("input").attr("id","openClassDate");
		}
		tr1.find("td:eq(8)").find("input").attr("data-options","min:0,max:"+obj.readNum+",precision:0,required:true");
		tr1.css("display","table-row");
		$("#mergeTab").append(tr1);
		if(obj.higherNum!="")
		{
			totalNum +=parseInt(obj.higherNum);
		}	
		//班级信息
		var tr2 =$("#modelTr2").clone();
		tr2.find("td:eq(0)").html(obj.schoolName);
		tr2.find("td:eq(1)").html(obj.className);
		tr2.find("td:eq(2)").html(obj.finishDate);
		tr2.find("td:eq(3)").html(obj.classTime);
		tr2.find("td:eq(4)").html(obj.readNum);
		tr2.find("td:eq(5)").html(obj.higherNum);//已升学人数
		tr2.find("td:eq(6)").html(obj.higherRate);//升学率
		var min =0;
		if(tr2.find("td:eq(5)").html()!="")
		{
			min =parseInt(tr2.find("td:eq(5)").html());
		}	
		tr2.find("td:eq(7)").find("input").addClass("easyui-numberbox").attr("data-options","min:"+min+",max:"+obj.readNum+",precision:0,required:true");
		tr2.find("td:eq(8)").html();//升学缺口
		tr2.addClass("classTr");
		tr2.attr("classInstId",obj.classInstId);
		tr2.css("display","table-row");
		$("#classTab").append(tr2);
	});
	//合并单元格
	for(var i=0;i<7;i++)
	{
		var first =null;
		$(".mergeTr").each(function(index){
			if(index==0)
			{
				first=$(this);
			}
			else
			{   
				first.find("td:eq("+arr[i]+")").attr("rowspan",parseInt(first.find("td:eq("+arr[i]+")").attr("rowspan"))+1);
				$(this).find("td:eq("+(arr[i]-i)+")").remove();
			}	
		});

	}	
	//渲染成easyui控件
	$(".mergeTr").each(function(index){
		if(index==0)
		{
			$(this).find("td:eq(2)").find("input").addClass("easyui-datebox");
			$(this).find("td:eq(3)").find("input").addClass("easyui-numberbox");
			$(this).find("td:eq(4)").find("input").addClass("easyui-numberbox");
			$(this).find("td:eq(5)").find("select").addClass("easyui-combobox");
			$(this).find("td:eq(6)").find("input").addClass("easyui-datebox");
			$(this).find("td:eq(7)").find("input").addClass("easyui-textbox");
			$(this).find("td:eq(8)").find("input").addClass("easyui-numberbox");
			$(this).find("td:eq(9)").find("select").addClass("easyui-combobox");
			$(this).find("td:eq(10)").find("select").addClass("easyui-combobox");
			$(this).find("td:eq(11)").find("select").addClass("easyui-combobox");
			$(this).find("td:eq(12)").find("input").addClass("easyui-datebox");
		}
		else
		{   
			$(this).find("td:eq(2)").find("input").addClass("easyui-numberbox");
			$(this).find("td:eq(3)").find("select").addClass("easyui-combobox");
			$(this).find("td:eq(4)").find("input").addClass("easyui-datebox");
			$(this).find("td:eq(5)").find("input").addClass("easyui-numberbox");
		}	
	});
	$.parser.parse();
	$('input,select').validatebox();
	//加载数据
	$.ajax({
		type : "POST",
		url : "/sys/pubData/qryCodeNameList.do",
		data :"tableName=COMBO_CLASS_DETAIL_T&codeType=COMBO_TYPE",
		dataType:"json",
		success : function(data) 
		{
			hideProgressLoader()
			if(data!=null&&data.length>0)
			{
				$(".mergeTr").each(function(index){
					if(index==0)
					{
						$(this).find("td:eq(5)").find("select").combobox("loadData",data);
					}
					else
					{
						$(this).find("td:eq(3)").find("select").combobox("loadData",data);
					}	
				});
			}	
		}
	});
	$.ajax({
		type : "POST",
		url : "/sys/pubData/qryCodeNameList.do",
		data :"tableName=SCHOOLTIME_T&codeType=WEEK_TIME",
		dataType:"json",
		success : function(data) 
		{
			hideProgressLoader()
			if(data!=null&&data.length>0)
			{
				$("#weekTime1").combobox({
					onChange:function(){
						$("#hourRange1").combobox({
							url:"../pubData/qryHourRangeList.do?weekTime="+$("#weekTime1").combobox('getValue'),
							valueField : "timeId",
							textField : "timeName",
						});
					},
					data:data	
				})
				$("#weekTime2").combobox({
					onChange:function(){
						$("#hourRange2").combobox({
							url:"../pubData/qryHourRangeList.do?weekTime="+$("#weekTime2").combobox('getValue'),
							valueField : "timeId",
							textField : "timeName",
						});
					},
					data:data	
				})
			}	
		}
	});
	$.ajax({
		type : "POST",
		url : "/sys/pubData/qrySchoolList.do",
		dataType:"json",
		success : function(data) 
		{
			hideProgressLoader()
			if(data!=null&&data.length>0)
			{
				$("#school1").combobox({
					onChange:function(){
						$("#teacher1").combobox({
							url:"../pubData/qryTeacherList.do?schoolId="+$("#school1").combobox('getValue'),
						});
					},
					data:data	
				})
				$("#school2").combobox({
					onChange:function(){
						$("#teacher2").combobox({
							url:"../pubData/qryTeacherList.do?schoolId="+$("#school2").combobox('getValue'),
						});
					},
					data:data	
				})
			}	
		}
	});
	
	//绑定可升学人数变化事件
	$(".classTr").each(function(){
		var index=$(this);
		$(this).find("td:eq(7)").find(".easyui-numberbox").numberbox({
			onChange:function(nval)
			{
				if(nval=="")
				{
					index.find("td:eq(8)").html("");
				}
				else
				{
					var val1 =parseInt(nval);
					var val2=0;
					if(index.find("td:eq(5)").html()!="")
					{
						val2 =parseInt(index.find("td:eq(5)").html())
					}
					index.find("td:eq(8)").html(val1-val2);
				}	
			}
		});
	});
	//绑定合并时长改变事件
	$("#mergeWeek").numberbox({
		onChange:function(n,o)
		{
			initCourseApply(n)
		}
	});
	//绑定定班人数改变事件
	$(".mergeTr").each(function(index){
		if(index==0)
		{
			$(this).find("td:eq(8)").find(".easyui-numberbox").numberbox({
				onChange:function(n,o)
				{
					getOrderRate(n,o)
				}
			});
		}
		else
		{
			$(this).find("td:eq(5)").find(".easyui-numberbox").numberbox({
				onChange:function(n,o)
				{
					getOrderRate(n,o)
				}
			});
		}	
	});
	//绑定提交事件
	$("#submitBtn").click(function(){
		submitMergeInfo();
	})
}


function initCourseApply(num)
{
	showProgressLoader("正在加载数据,请稍等...", 400);
	if(num=="")
	{
		$("#courseChangePlan").html("");
		return;
	}	
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
	var rowNum =classArr.length+1;
	var initStr="";
	for(var i=1;i<=tabNum;i++)
	{
		initStr +="<table class='maintable'>";
		for(var j=0;j<rowNum;j++)
		{
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
					initStr+="<td width='62.2px' align='center'>"+classArr[j-1].schoolName+"</td>";
				}
				else if(k==1)
				{
					initStr+="<td width='62.2px' align='center'>"+classArr[j-1].className+"</td>";
				}
				else
				{
					initStr+="<td class='hourTd' weekOrder="+(i*18+k-19)+" classInstId="+classArr[j-1].classInstId+" width='62.2px' align='center'><input style='width:55px'  data-options='required:true,min:0,max:50,precision:0'></td>";
				}	
			}	
			initStr+="</tr>";
		}	
		initStr +="</table>";
	}
	$("#courseChangePlan").html(initStr)
	$("#courseChangePlan").find(".hourTd").find("input").addClass("easyui-numberbox");
	$.parser.parse("#courseChangePlan");
	hideProgressLoader();
}
 

function getOrderRate(newValue,oldValue)
{
	if(totalNum==0)
	{
		$("#orderRate").html("0%");
	}
	else
	{
		if(newValue==""||newValue==undefined)
		{
			newValue=0
		}
		else
		{
			newValue=parseInt(newValue)
		}
		if(oldValue==""||oldValue==undefined)
		{
			oldValue=0
		}
		else
		{
			oldValue=parseInt(oldValue)
		}
		orderNum =orderNum-oldValue+newValue;
		var rateValue =(orderNum/totalNum*100).toFixed(2)+"%";
		$("#orderRate").html(rateValue);
	}	
	
	
}


function submitMergeInfo()
{
	var flag = true;
	$("input[type='hidden']").each(function(){
		if($(this).val()=="")
		{
			flag =false;
			return false;
		}	
	})
	if(!flag)
	{
		showMessage('提示', "请将合并信息填写完整!",null);
		return false;
	}
	else
	{
		var combo={};
		//获取合并计划
		var comboClass={};
		comboClass.className=$("#className").textbox("getValue");
		comboClass.startComboDate =$("#startDate").datebox("getValue");
		comboClass.openClassDate=$("#openClassDate").datebox("getValue");
		comboClass.weeks =$("#mergeWeek").numberbox("getValue");
		comboClass.orderPer =$("#orderRate").html();
		comboClass.isHead=$("#isHead").val();
		comboClass.times=$("#weekTime1").combobox("getText")+" "+$("#hourRange1").combobox("getText")+"<br/>"+$("#weekTime2").combobox("getText")+" "+$("#hourRange2").combobox("getText");
		comboClass.teachers =$("#school1").combobox("getText")+" "+$("#teacher1").combobox("getText")+"<br/>"+$("#school2").combobox("getText")+" "+$("#teacher2").combobox("getText");
		comboClass.comboState="001";
		comboClass.remark=trim($("#remark").val());
		comboClass.handlerId =$("#handlerId").val();
		comboClass.state="00A";
		combo.info =comboClass;
		//获取详细计划
		var detailArr=[];
		$(".classTr").each(function(index){
			var detail={};
			var mergeTr =$(".mergeTr:eq("+index+")");
			detail.classInstId=$(this).attr("classInstId");
			if(index==0)
			{
				detail.startHours =mergeTr.find("td:eq(3)").find("input[type='hidden']").val();
				detail.comboType =mergeTr.find("td:eq(5)").find("input[type='hidden']").val();
				detail.comboFinishDate =mergeTr.find("td:eq(6)").find("input[type='hidden']").val();
				detail.orderNum =mergeTr.find("td:eq(9)").find("input[type='hidden']").val();
				detail.orderNum =mergeTr.find("td:eq(9)").find("input[type='hidden']").val();
			}
			else
			{
				detail.startHours =mergeTr.find("td:eq(2)").find("input[type='hidden']").val();
				detail.comboType =mergeTr.find("td:eq(3)").find("input[type='hidden']").val();
				detail.comboFinishDate =mergeTr.find("td:eq(4)").find("input[type='hidden']").val();
				detail.orderNum =mergeTr.find("td:eq(5)").find("input[type='hidden']").val();

			}	
			detail.finishDate =$(this).find("td:eq(2)").html();
			detail.times =$(this).find("td:eq(3)").html();
			detail.studyingNum =$(this).find("td:eq(4)").html();
			detail.higherNum =$(this).find("td:eq(5)").html();
			detail.higherPer =$(this).find("td:eq(6)").html();
			detail.planHigherNum =$(this).find("td:eq(7)").find("input[type='hidden']").val();
			detailArr.push(detail);
		})
		combo.detail =detailArr;
		//获取课时信息
		var hoursArr =[];
		$(".hourTd").each(function(){
			var hourObj ={}
			hourObj.classInstId =$(this).attr("classInstId");
			hourObj.weekOrder =$(this).attr("weekOrder");
			hourObj.hours =$(this).find("input[type='hidden']").val();
			hoursArr.push(hourObj);
		})
		combo.hours =hoursArr;
		$.ajax( {
			type : "POST",
			url : "/sys/mergeClass/mergeClassApply.do",
			data :"param="+JSON.stringify(combo),
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
				showMessage('提示', "调用申请合并班服务失败！", null);
			}
		});
	}	
}