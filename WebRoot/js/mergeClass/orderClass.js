var max =19;
var applyId =null;
var arr=[];
$(document).ready(function(){
	applyId=$("#applyId").val();
	$("#backBtn").click(function(){
		window.history.back();
	});
	$("#submitBtn").click(function(){
		orderClass();
	});
	initPage();
});


function initPage()
{
	$.ajax( {
		type : "POST",
		url : "/sys/mergeClass/qryMergeClassStudent.do",
		data :"applyId="+applyId,
		async : false,
		dataType:"json",
		beforeSend : function()
		{
			showProgressLoader("正在加载数据,请稍等...", 400);
		},
		success : function(data) 
		{
			if(data.length>0)
			{
				$.each(data,function(i,obj){
					var classObj=
					{
						classInstId:obj.classInstId,
						operateArr:[]
					}
					arr.push(classObj);
					$("#detail").append(createClassDiv(obj,i));
				});
				$.parser.parse("#detail");
			}
			hideProgressLoader();
		},
		error : function() 
		{
			hideProgressLoader();
			showMessage('提示', "加载数据失败！", null);
		}
	});
}


function createClassDiv(obj,num)
{
	var str ="";
	if(obj.studentList!=undefined&&obj.studentList.length>0)
	{
		str +="<div style='width:1292px;margin-bottom:40px'>";
		str +="<div class='easyui-panel' title='班级："+obj.className+"("+obj.schoolName+")' style='width:1292px;min-height:60px;'>";
		str +=createStudentTable(obj.studentList,num);	
		str +="</div>";
		str +="<div class='easyui-panel' title='定班历史情况' style='width:1292px;min-height:60px;'>";
		if(obj.changeList!=undefined&&obj.changeList.length>0)
		{
			str +="<table class='maintable' width='100%'><tr><td align='center' width='90px'>操作人</td><td align='center' width='90px'>操作日期</td><td align='center'>动作</td></tr>";
			$.each(obj.changeList,function(i,node){
				str+="<tr><td align='center'>"+node.handlerName+"</td>";
				str+="<td align='center'>"+node.createTime+"</td><td align='center'>"+node.content+"</td></tr>";
			});
			str +="</table>";
		}	
		str +="</div>";
	}
	return str;
}

function createStudentTable(obj,num)
{
	var str="";
	var tabNum =Math.ceil(obj.length/max);
	var lastNum=obj.length%max;
	for(var i=1;i<=tabNum;i++)
	{
		var tr1="<tr>";
		var tr2="<tr>";
		str+="<table class='maintable'>";
		var cellNum =0;
		if(i<tabNum)
		{
			cellNum =max+1;
		}
		else
		{
			cellNum =lastNum+1;
		}
		for(var j=0;j<cellNum;j++)
		{
			if(j==0)
			{
				tr1+="<td width='62.2px' align='center'>学员姓名:</td>";
				tr2+="<td width='62.2px' align='center'>是否定班:</td>";
			}
			else
			{
				var value =obj[(tabNum-1)*max+j-1];
				tr1+="<td width='62.2px' align='center'>"+value.studentName+"</td>";
				if(value.orderFlag=="Y")
				{
					tr2+="<td width='62.2px' align='center'><input type='checkbox' studentName=\""+value.studentName+"\" arrNbr='"+num+"' checked=true  studentId='"+value.studentId+"' classInstId='"+value.classInstId+"' onclick='selectThis(this)'></td>";
				}
				else
				{
					tr2+="<td width='62.2px' align='center'><input type='checkbox' studentName=\""+value.studentName+"\"  arrNbr='"+num+"'  studentId='"+value.studentId+"' classInstId='"+value.classInstId+"' onclick='selectThis(this)'></td>";
				}	
			}	
		}
		tr1+="</tr>";
		tr2+="</tr>";
		str+=tr1+tr2;
		str +="</table>"
	}
	return str;
}



function selectThis(obj)
{
	if($(obj).is(":checked"))
	{
		checkOperate(parseInt($(obj).attr("arrNbr")),true,$(obj).attr("classInstId"),$(obj).attr("studentId"),$(obj).attr("studentName"))
	}
	else
	{
		checkOperate(parseInt($(obj).attr("arrNbr")),false,$(obj).attr("classInstId"),$(obj).attr("studentId"),$(obj).attr("studentName"))
	}	
}

//检测之前是否选择或取消过并添加相应操作
function checkOperate(index,operate,classInstId,studentId,studentName)
{
	var obj=
	{
		classInstId:classInstId,
		studentId:studentId,
		studentName:studentName,
		operate:operate,
		applyId:applyId
	}
	if(arr[index].operateArr.length<1)
	{
		arr[index].operateArr.push(obj)
	}
	else
	{
		var flag =true;
		$.each(arr[index].operateArr,function(i,node){
		//如果存在记录则删除
			if(node.classInstId==classInstId&&node.studentId==studentId)
			{
				arr[index].operateArr.splice(i,1);
				flag =false;
				return false;
			}	
		});
		if(flag)
		{
			arr[index].operateArr.push(obj)
		}	
	}	
}


function orderClass()
{
	var operate=[];
	var changeText=[];
	var numArr=[];
	$.each(arr,function(i,obj){
		var addStr="";
		var delStr="";
		var numObj ={
			classInstId:obj.classInstId,
			applyId:applyId,
			orderNum:0
		}
		numArr.push(numObj);
		if(obj.operateArr.length<1)
		{
			return true;
		}	
		else
		{
			var addStr="";
			var delStr="";
			$.each(obj.operateArr,function(i,node){
				if(node.operate)
				{
					addStr+=node.studentName+"、";
				}
				else
				{
					delStr+=node.studentName+"、";
				}
				operate.push(node);
			});
			if(addStr!="")
			{
				addStr="增加定班："+addStr;
				addStr =addStr.substring(0,addStr.length-1);
			}
			if(delStr!="")
			{
				delStr="取消定班："+delStr;
				delStr= delStr.substring(0,delStr.length-1);
			}
			if(addStr!=""||delStr!="")
			{
				var content="";
				if(addStr!=""&&delStr!="")
				{
					content =addStr+"；"+delStr;
				}
				else
				{
					content =addStr+delStr;
				}	
				
				var change={
					objId:applyId,
					objType:obj.classInstId,
					content:content,
					handlerId:$("#handlerId").val()
				}
				changeText.push(change);
			}	
		}	
	})
	if(operate.length<1)
	{
		$.messager.alert('提示', "您没有进行任何定班或取消定班操作！");
		return false;
	}
	else
	{
		$("input:checkbox:checked").each(function(){
			var classInstId =$(this).attr("classInstId");
			for(var i=0;i<numArr.length;i++)
			{
				if(numArr[i].classInstId==classInstId)
				{
					numArr[i].orderNum +=1;
					return true;
				}	
			}	
		});
		var param={
			operate:operate,
			change:changeText,
			orderInfo:numArr
		}
		$.ajax( {
			type : "POST",
			url : "/sys/mergeClass/orderClass.do",
			data :"param="+JSON.stringify(param),
			async : false,
			beforeSend : function() {
				showProgressLoader("正在提交定班信息,请稍等...", 400);
			},
			success : function(data) {
				hideProgressLoader()
				if (data == "true") {
					showMessage('提示', "提交成功！", function() {
						window.location.reload();
					});
				} else {
					showMessage('提示', "提交失败！", null);
				}
	
			},
			error : function() {
				hideProgressLoader();
				showMessage('提示', "调用定班服务失败！", null);
			}
		});
		
	}	
}