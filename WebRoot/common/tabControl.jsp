<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<input type="hidden" id="tabsInfo" value="${sessionScope.StaffT.tabsAuthInfo}">
<script type="text/javascript">
	$(document).ready(function(){
		if($("ul.tabs").length&&$("ul.tabs").length>0&&document.URL.indexOf("admin.jsp")==-1)
		{
			var strArr=$("#tabsInfo").val().split(",");
			$("ul.tabs").find("li").each(function()
			{
				if(!isContain(strArr,$(this).find("span.tabs-title").html()))
				{
					$(this).css("display","none");
				}	
			});
			if($("ul.tabs").find("li:visible").length>0)
			{
				$("ul.tabs").find("li:visible:first").trigger("click");
			}
			else
			{
				$(".tabs-panels").find(".panel").css("display","none");
			}	
			
		}		
	});
	
	function isContain(arr,val)
	{
		var flag =false;
		if(arr.length>0)
		{
			for(var i=0;i<arr.length;i++)
			{
				if(val==arr[i])
				{
					flag =true;
					break;
				}	
			}	
		}	
		return flag;
	}
</script>