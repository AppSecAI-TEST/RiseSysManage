$.extend($.fn.validatebox.defaults.rules,
{ 
	//学生姓名校验
	stuName:
	{ 
		validator:function(value,param)
		{
			if(! /^[\u4E00-\u9FA5]+$/.test(value))
			{
				$.fn.validatebox.defaults.rules.stuName.message="输入的姓名只能为中文";
				return false;
			}
			else if(value.length>12)
			{
				$.fn.validatebox.defaults.rules.stuName.message="输入的姓名不能超过十二个字";
				return false;
			}	
    		return true;	
    	}
	},
	//英文名校验
	byname:
	{
		validator:function(value,param)
		{
			if(!/^[A-Za-z]+$/.test(value))
			{
				$.fn.validatebox.defaults.rules.byname.message="英文名只能输入英文";
				return false;
			}
			else if(value.length>24)
			{
				$.fn.validatebox.defaults.rules.byname.message="英文名长度不能超过24";
				return false;
			}
			return true;
		}
	},
	//证件类型为身份证时身份证信息校验
	certNo:
	{
		validator:function(value,param)
		{
			if($("#"+param[0]).length>0)
			{
				if($("#"+param[0]).combobox("getText")=="身份证")
				{
					if(!validateIdCard(value))
					{
						$.fn.validatebox.defaults.rules.certNo.message="请输入有效的身份证号码";
						return false;
					}	
				}
			}	
			return true;
		}
	},
	//日期格式校验
	date:
	{
		validator:function(value,param)
		{
			if(!/^(\d{4})-(\d{2})-(\d{2})$/.test(value))
			{
				$.fn.validatebox.defaults.rules.certNo.message="请输入正确的日期格式";
				return false;	
			}
			return true;
		}
	}
}); 