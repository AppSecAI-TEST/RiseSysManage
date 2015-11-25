$(document).ready(function()
{
	
	 
});

function getSchools()
{
	var url="/sys/pubData/qrySchoolList.do";
	return loadData(url);
}

function getTeachers()
{
	var url="/sys/pubData/qryTeacherList.do";
	return loadData(url);
}

function loadData(urls)
{
	var loadData;
	 $.ajax(
	 {
		type : "POST",
		url: urls,
		async: false,
		dataType:"json",
		beforeSend: function()
    	{
    		 
    	},
    	success: function(data) 
    	{
    		 loadData=data;
    	},
        error:function()
        {
        	 
        }
	});
	 return loadData;
}

