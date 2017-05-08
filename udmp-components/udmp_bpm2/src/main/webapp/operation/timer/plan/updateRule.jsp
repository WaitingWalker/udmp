<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'updateRule.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/um-page.css">
	<link rel="stylesheet" href="<%=basePath %>/css/default.css" type="text/css" />

  </head>
  
  <body>
  
  <div class="um-span-updateRuleLeft" style="font-size:10px">  	
  		字段 允许值 允许的特殊字符   <br>
		秒 0-59 , - * /    <br>
		分 0-59 , - * /    <br>
		小时 0-23 , - * /    <br>
		日期 1-31 , - * ? / L W C    <br>
		月份 1-12 或者 JAN-DEC , - * /    <br>
		星期 1-7 或者 SUN-SAT , - * ? / L C #  <br>  
		年（可选） 留空, 1970-2099 , - * /    <br>
		表达式意义    <br>
		"0 0 12 * * ?" 每天中午12点触发    <br>
		"0 15 10 ? * *" 每天上午10:15触发    <br>
		"0 15 10 * * ?" 每天上午10:15触发    <br>
		"0 15 10 * * ? *" 每天上午10:15触发   <br> 
		"0 15 10 * * ? 2005" 2005年的每天上午10:15触发    <br>
		"0 * 14 * * ?" 在每天下午2点到下午2:59期间的每1分钟触发  <br>  
		"0 0/5 14 * * ?" 在每天下午2点到下午2:55期间的每5分钟触发    <br>
		"0 0/5 14,18 * * ?" 在每天下午2点到2:55期间和下午6点到6:55期间的每5分钟触发    <br>
		"0 0-5 14 * * ?" 在每天下午2点到下午2:05期间的每1分钟触发    <br>
		"0 10,44 14 ? 3 WED" 每年三月的星期三的下午2:10和2:44触发    <br>
		"0 15 10 ? * MON-FRI" 周一至周五的上午10:15触发    <br>
		"0 15 10 15 * ?" 每月15日上午10:15触发    <br>
		"0 15 10 L * ?" 每月最后一日的上午10:15触发    <br>
		"0 15 10 ? * 6L" 每月的最后一个星期五上午10:15触发    <br>
		"0 15 10 ? * 6L 2002-2005" 2002年至2005年的每月的最后一个星期五上午10:15触发    <br>
		"0 15 10 ? * 6#3" 每月的第三个星期五上午10:15触发    <br>
		每天早上6点    <br>
		0 6 * * *    <br>
		每两个小时    <br>
		0 */2 * * *    <br>
		晚上11点到早上8点之间每两个小时，早上八点    <br>
		0 23-7/2，8 * * *    <br>
		</div>
		<div class="um-s-updateRuleRight" style="font-size:10px">
		每个月的4号和每个礼拜的礼拜一到礼拜三的早上11点    <br>
		0 11 4 * 1-3    <br>
		1月1日早上4点    <br>
		0 4 1 1 *    <br>
		
		
		有些子表达式能包含一些范围或列表   <br>
		例如：子表达式（天（星期））可以为 “MON-FRI”，“MON，WED，FRI”，“MON-WED,SAT”   <br>
		“*”：字符代表所有可能的值   <br>
		因此，“*”在子表达式（月）里表示每个月的含义，“*”在子表达式（天（星期））表示星期的每一天   <br>
		“/”：字符用来指定数值的增量   <br>
		例如：在子表达式（分钟）里的“0/15”表示从第0分钟开始，每15分钟 ;  <br>
		在子表达式（分钟）里的“3/20”表示从第3分钟开始，每20分钟（它和“3，23，43”）的含义一样   <br>
		“？”：字符仅被用于天（月）和天（星期）两个子表达式，表示不指定值   <br>
		当2个子表达式其中之一被指定了值以后，为了避免冲突，需要将另一个子表达式的值设为“？”   <br>
		“L”： 字符仅被用于天（月）和天（星期）两个子表达式，它是单词“last”的缩写   <br>
		但是它在两个子表达式里的含义是不同的。   <br>
		在天（月）子表达式中，“L”表示一个月的最后一天 ,  <br>
		在天（星期）自表达式中，“L”表示一个星期的最后一天，也就是SAT   <br>
		如果在“L”前有具体的内容，它就具有其他的含义了   <br>
		例如：“6L”表示这个月的倒数第６天，“ＦＲＩＬ”表示这个月的最后一个星期五   <br>
		注意：在使用“L”参数时，不要指定列表或范围，因为这会导致问题  <br>
		</div>
	</div>
  </body>
</html>
