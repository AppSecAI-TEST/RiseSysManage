$(document).ready(function(){
	initPage();
	$("#backBtn").click(function() {
		window.location.href ="resourceList.jsp";
	});
	$("#submitBtn").click(function() {
		classTimeConfig();
	});
});

function initPage()
{
	$.ajax( {
		type : "POST",
		url : "/sys/timeResource/getClassTimeConfigInfo.do",
		async : false,
		dataType:"json",
		beforeSend : function() 
		{
			showProgressLoader("正在加载数据,请稍等...", 400);
		},
		success : function(data) 
		{
			hideProgressLoader()
			if(data.rowspan!=undefined)
			{
				var rowspan =parseInt(data.rowspan);
				$.each(data.configInfo,function(i,obj){
					var tr =null;
					var tdCount =0;
					if(i%rowspan==0)
					{
						tr =$("#modelTr1").clone();
						tr.find("td:eq("+tdCount+")").attr("rowspan",rowspan);
						tr.find("td:eq("+tdCount+")").html("<span>"+obj.weekTimeVal+"</span>");
						tdCount++;
					}
					else
					{
						tr =$("#modelTr2").clone();
					}
					tr.find("td:eq("+tdCount+++")").html("<span>"+obj.hourRangeVal+"</span>");
					tr.find("td:eq("+tdCount+++")").html("<span>"+obj.lessionHours+"</span>")
					if(obj.timeState!="")
					{
						tr.find("td:eq("+tdCount+++")").find("input[type='radio']").each(function(index){
							$(this).attr("name",i);
							if(index==0)
							{
								$(this).attr("checked","checked");
							}	
						});
						
					}
					else
					{
						tr.find("td:eq("+tdCount+++")").find("input[type='radio']").each(function(index){
							$(this).attr("name",i);
							if(index>0)
							{
								$(this).attr("checked","checked");
							}	
						});
						
					}
					tr.find("td:eq("+tdCount+++")").html("<span>"+obj.apmVal+"</span>");
					tr.attr("weekTime",obj.weekTime);
					tr.attr("timeName",obj.hourRangeVal);
					tr.attr("hourRange",obj.hourRange);
					tr.attr("apm",obj.apm);
					tr.attr("lessionHours",obj.lessionHours);
					tr.addClass("addTr");
					tr.css("display","table-row");
					$("#classInfo").append(tr);
				});
			}	
		},
		error : function() 
		{
			hideProgressLoader();
			showMessage('提示', "加载数据失败！", null);
		}
	});
}

function classTimeConfig()
{
	var addInfo =[];
	var flag =false;
	$(".addTr").each(function(){
		var tr =$(this);
		tr.find("input[type='radio']").each(function(index){
			if(index==0)
			{
				if(this.checked)
				{
					var config ={};
					config.handlerId =$("#handlerId").val();
					config.weekTime =tr.attr("weekTime");
					config.timeName =tr.attr("timeName");
					config.hourRange =tr.attr("hourRange");
					config.apm =tr.attr("apm");
					config.lessionHours =tr.attr("lessionHours");
					config.timeState ="001";
					addInfo.push(config);
				}	
			}	
		});
	});
	if(addInfo.length>1)
	{
		$.ajax( {
			type : "POST",
			url : "/sys/timeResource/addClassTimeConfig.do",
			data :"param="+JSON.stringify(addInfo),
			async : false,
			beforeSend : function() {
				showProgressLoader("正在添加上课时段配置,请稍等...", 400);
			},
			success : function(data) {
				hideProgressLoader()
				if (data == "true") {
					showMessage('提示', "添加上课时段配置成功！", function() {
						window.location.href = "resourceList.jsp";
					});
				} else {
					showMessage('提示', "添加上课时段配置失败！", null);
				}
	
			},
			error : function() {
				hideProgressLoader();
				showMessage('提示', "调用添加上课时段配置服务失败！", null);
			}
		});
	}
	else
	{
		showMessage('提示', "请至少开放一条上课时段！", null);
		return false;
	}	
}