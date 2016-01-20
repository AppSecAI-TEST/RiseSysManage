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

function getAdvister()
{
	var url="/sys/pubData/qryStaffList.do?post=16,17";
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

