// 对Date的扩展，将 Date 转化为指定格式的String 
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
// 例子： 
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function(fmt) 
{ //author: meizz 
  var o = { 
    "M+" : this.getMonth()+1,                 //月份 
    "d+" : this.getDate(),                    //日 
    "h+" : this.getHours(),                   //小时 
    "m+" : this.getMinutes(),                 //分 
    "s+" : this.getSeconds(),                 //秒 
    "q+" : Math.floor((this.getMonth()+3)/3), //季度 
    "S"  : this.getMilliseconds()             //毫秒 
  }; 
  if(/(y+)/.test(fmt)) 
    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
  for(var k in o) 
    if(new RegExp("("+ k +")").test(fmt)) 
  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length))); 
  return fmt; 
}

 var now = new Date();                                                //当前日期
 var nowDayOfWeek = (now.getDay() == 0) ? 7 : now.getDay() - 1;       //今天是本周的第几天。周一=0，周日=6
 var nowDay = now.getDate();                                          //当前日
 var nowMonth = now.getMonth();                                       //当前月值（1月=0，12月=11）
 var nowMonReal = now.getMonth() + 1;                                 //当前月实际数字
 var nowYear = now.getFullYear();                                     //当前年
 
 //日期+天
 function AddDays(d, n) {
     var t = new Date(d);//复制并操作新对象，避免改动原对象
     t.setDate(t.getDate() + n);
     return t.format("yyyy-MM-dd");
 }
 
 //日期+月。日对日，若目标月份不存在该日期，则置为最后一日
 function AddMonths(d, n) {
     var t = new Date(d);
     t.setMonth(t.getMonth() + n);
     if (t.getDate() != d.getDate()) { t.setDate(0); }
     return t;
 }
 
 //日期+年。月对月日对日，若目标年月不存在该日期，则置为最后一日
 function AddYears(d, n) {
     var t = new Date(d);
     t.setFullYear(t.getFullYear() + n);
     if (t.getDate() != d.getDate()) { t.setDate(0); }
     return t;
 }
 
 //当前日期
 function sysDate()
 {
	 return now.format("yyyy-MM-dd");
 }
 
 //当前日期+天
 function afterDate(n)
 {
	var d=AddDays(now,n);
	return d;
 }
 //当前日期+月
 function afterMonth(n)
 {
	var d=AddMonths(now,n);
	return d.format("yyyy-MM-dd");
 }
 
  function afterYear(n)
 {
	var d=AddYears(now,n);
	return d.format("yyyy-MM-dd");
 }
  
 //获得本季度的开始月份
 function getQuarterStartMonth() {
     if (nowMonth <= 2) { return 0; }
     else if (nowMonth <= 5) { return 3; }
     else if (nowMonth <= 8) { return 6; }
     else { return 9; }
 }
 
 //周一
 function getWeekStartDate() {
     return AddDays(now, -nowDayOfWeek);
 }
 
 //周日。本周一+6天
 function getWeekEndDate() {
     return AddDays(getWeekStartDate(), 6);
 }
 
 //月初
 function getMonthStartDate() {
     return new Date(nowYear, nowMonth, 1);
 }
 
 //月末。下月初-1天
 function getMonthEndDate() {
     return AddDays(AddMonths(getMonthStartDate(), 1), -1);
 }
 
 //季度初
 function getQuarterStartDate() {
     return new Date(nowYear, getQuarterStartMonth(), 1);
 }
 
 //季度末。下季初-1天
 function getQuarterEndDate() {
     return AddDays(AddMonths(getQuarterStartDate(), 3), -1);
 }
 
