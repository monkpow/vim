try{
	window.onload=initShippingCalendar
}catch(e){
	put(e)
}

initshippingcalendar = function(){
	shippingcalendar.initialize(); //having trouble assigning this directly to onload.  
}

initshippingcalendar = function(){
	shippingcalendar.initialize(); //having trouble assigning this directly to onload.  
}

field={
	initialize:function(){
		this.form=document.forms['CheckoutForm'];
		this.shipDate=this.form['customFieldDS.customfield_ROW0_value'];
		this.shipOpts=this.form['shippingOptionsDS.shipping_options_ROW0_shipping_method_id'];
		this.state=this.form['shipping-state'];
		this.applyBtn=this.form.elements['eventName.updateShippingMethodEvent'];
		this.shipMethods=$('merchant-selected-shipping-methods');
		this.deliverDate=$('vwcf-yhst-93672551109875-shipping-calendar');
	}
}

ShippingCalendar={
	initialize:function(){
		ShippingDate.initialize();  
		field.initialize();
		field.shipMethods.style.display="none"; //hide the native yahoo fields, as well be using the field.deliverDate instead
		field.applyBtn.style.display="none";
		$('labelmerchant-selected-shipping-methods').style.display="none";
		$('labelmerchant-selected-shipping-methods').parentNode.style.display="none";
		field.deliverDate.onclick=this.launch;
		field.deliverDate.onfocus=field.deliverDate.blur;
		field.state.onchange=this.launch;
		field.shipDate.style.display="none"; 
		if (field.shipDate.value!=""){
			var shipMethod=field.shipMethods.value;
			var shipOffset= (shipMethod.match(/2DAY/i)) ? 2 : 1 ;// relies on the 2 day shipping options having values which match "2DAY", and all others options being 1 day 
			var usersDate=new Date(field.shipDate.value);
			usersDate.setDate(usersDate.getDate()+shipOffset);
			updateDeliveryDateDisplay(usersDate);
		}
		this.launch(); 
	},
	launch:function(){
		if(!$('cal')){
			r=document.createElement('div');
			r.setAttribute("id","cal");
			r.style.display="none"
			field.deliverDate.parentNode.parentNode.appendChild(r);
		}
		CalendarDisplay.writeCalendar();
	}
}

CalendarDisplay={
	element:('cal'),
	initialize:function(){
		initShippingCalendar();
	},
	show:function(){
		$('cal').style.display="block"; 
	},
	hide:function(){
		$('cal').style.display="none"; 
	},
	changeMonth:function(num,e) {
		killEvent(e);
		ShippingDate.pointer.setDate(1); // move pointer to beginning of month before changing months to avoid EOM and February problems
		var newMonth=ShippingDate.pointer.getMonth()+num;
		ShippingDate.pointer.setMonth(newMonth);
		CalendarDisplay.writeCalendar();
	},
	generateCalendarHeader:function(){
		var calendarHeader="";
		calendarHeader += "<br /><table cellpadding='5' cellspacing='0' border='0' width='252' align='center'>";
		calendarHeader += "<tr bgcolor='#003366'>";
		calendarHeader += "<td>";
		calendarHeader += "<span style='color:white'>"
		if (ShippingDate.pointer > ShippingDate.earliest){
			calendarHeader += "<a href='javascript:stub();' onClick='javascript:CalendarDisplay.changeMonth(-1,event);return false;'   style='color:white;text-decoration:none;font-weight:bold;'>&lt;&lt;</a>"	;
		}
		calendarHeader += "</span></td>";
		calendarHeader += "<td align='center' colspan='5'>";
		calendarHeader += "<span style='color:white'>" + ShippingDate.pointer.monthName() + " " + ShippingDate.pointer.getFullYear() + "</span></td>";
		calendarHeader += "<td align='right'>";
		calendarHeader += "<span style='color:white'>" 
		calendarHeader += "<a href='javascript:stub();' onClick='javascript:CalendarDisplay.changeMonth(1,event);return false;'   style='color:white;text-decoration:none;font-weight:bold;'>&gt;&gt;</a>"	
		calendarHeader += "</span></td>"
		calendarHeader += "</tr>";
		//calendarHeader += "</table>";
		return calendarHeader;
	},
	generateCalendarGrid:function(){
		var blankColumn = "<td>&nbsp;</td>";
		var daysArray=["S","M","T","W","T","F","S"];
		
		var result = "<tr bgcolor='#EFEFEF'>"; 
		for (var i=0;daysArray[i];i++){
			result+="<td align='center'>"+daysArray[i]+"</td>";
		}
		result +="</tr><tr>";
		var thisMonth=Calendar.getMonthAsSparseArray(ShippingDate.pointer);
		var days = ShippingDate.pointer.monthLength();
		for(i=0;i< thisMonth.length;i++){
			var dayOfWeek=i % 7; // makes assumption that week starts on Sunday
			if(thisMonth[i]==undefined) // first members of sparse array are undefined
			result += blankColumn;
			continue;
		}
		ShippingDate.pointer.setDate(thisMonth[i]);
		var shippingType= ShippingDate.pointer.getShippingType();						
		if (shippingType != -1) { // could be better.  getShippingType returns -1 if this is a nonshippable day
			var passableDate=ShippingDate.pointer.getFullYear()+"/"+(ShippingDate.pointer.getMonth()+1)+"/"+ShippingDate.pointer.getDate(); // due to escaping issues below
			result+= "<td align='center' style='border:1px solid #FFFFFF; background-color:"+Color[shippingType]+";'>";
			result+="<a  href='javascript:returnDate(\"" + passableDate + "\",\""+shippingType+"\")'>";
			result+= ShippingDate.pointer.getDate() + " </a>";
			result+= "</td>";
		} else {
			result += "<td align='center'>" + ShippingDate.pointer.getDate() + "</td>"
		}
		if((i%7)==6){
			result +="</tr><tr>";
		}
	}
	result += "</tr></table>";
	return result;
};

isNonContinentalState = function(){
	var inputState=field.state.value.toLowerCase(); 
	if (
		inputState == "hawaii" 
		|| inputState == "puerto rico" 
		|| inputState == "alaska" 
		|| inputState == "ak" 
		|| inputState== "hi" 
		|| inputState =="pr"
	) {
		return true;
	}else{
		return false;
	}
}

ShippingDate={
	initialize:function(){
		this.earliest=this.getEarliest(new Date());
		this.latest=this.getLatest(new Date());
		this.pointer=new Date(this.earliest);
		this.now=new Date();
	} ,
	getEarliest:function(date){
		if(date.getDay()==5){ //Friday 
			if(date.afterShippingCutoff()){
				date.setDate(date.getDate()+4); // make it Tuesday
			} else {
				date.setDate(date.getDate()+3); // make it Monday
			}
			return date;
		} else if (date.getDay()==6 || date.getDay()==0) { // Saturday or Sunday
			while(date.getDay()!=2){
				date.setDate(date.getDate()+1);
			}
			return date;
			
		} else { // any old day
			if(date.afterShippingCutoff()){ // if its later than 10:30am, date++
				date.setDate(date.getDate()+1)
			}
			date.setDate(date.getDate()+1);// 1 day handling minimum
			if(date.getDay()==6){date.setDate(date.getDate()+2);} // if calculated shipping date is saturday, make monday
			if(date.getDay()==0){date.setDate(date.getDate()+1);} // if calculated shipping date is sunday, make monday
		}
		return date; 
	},
	
	getLatest:function(date){
		return new Date(date.setDate(date.getDate()+330));
	} 
}

Date.prototype.display=function(type){
	var month=this.getMonth()+1;
	month=(month<10) ? "0"+ month : month;
	var date=this.getDate();
	date=(date<10) ? "0"+ date : date;
	if (type=="short"){
		return this.MonthName()+"d";
	}else{
		return (month+'/'+date+'/'+this.getFullYear());
	}
}

Date.prototype.isHoliday=function(offset){
	var compare = (arguments.length ==1) 
	? new Date(this.getFullYear(), this.getMonth(),this.getDate()+offset) 
	: new Date(this);
	
	for (var i=0; i<Calendar.holidays.length; i++) {
		var _holiday=new Date(Calendar.holidays[i]);
		if (compare.equals(_holiday)){				
			return true;
		}
	}
	return false;
}

Date.prototype.monthLength=function(){
// if you create a new date with an out of range 'day of month' 
// value, JS will adjust the month to a real date. 
// E.g. new Date("Feb 30,2007") returns "Mar 02 2007"
	
	for (var i=31;i>0;i--){
		var tester=new Date(this.getFullYear(),this.getMonth(), i);
		if(tester.getMonth()==this.getMonth()){
			return i;
		}
	}
}

Date.prototype.monthName=function(){
	_months=['January', 'February', 'March', 'April', 'May', 'June','July', 'August', 'September', 'October', 'November', 'December'];
	return _months[this.getMonth()];
}

Date.prototype.dayName=function(){
	_days=['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri','Sat'];
	return _days[this.getDay()];
}

Date.prototype.afterShippingCutoff=function(){
// if after 10:30am return true;
// using UTC time to avoid timezone issues
	var UTCOffset=[this.getUTCDate()-this.getDate()] /*equals 0 or 1*/ *24; // equals 0 or 24
	var hours=this.getUTCHours()+UTCOffset
	if (hours>=17 || (hours==10 && this.getMinutes()>30)){
		return true;
	} else {
		return false;
	}
}

Calendar={
	holidays:["05/28/2007","07/04/2007","09/03/2007","11/22/2007", "12/25/2007","01/01/2008"],
	getMonthAsSparseArray:function(date){
		var result=[];
		var days = ShippingDate.pointer.monthLength();
		var firstOfMonth = new Date ((date.getFullYear()), date.getMonth(), 1); //
		var offset  = firstOfMonth.getDay();
		result=new Array(offset);
		for(var i=1;i<=days;i++){
			result[result.length]=i
		}
		return result;
	}
}

killEvent = function(e) {
	if (!e) var e = window.event;
	e.cancelBubble = true;
	if (e.stopPropagation) e.stopPropagation();
}

returnDate = function(date,shippingType) {
	try{ 
		deliveryDate=new Date(date); // convert due to escaping issues in caller
		var factor=(shippingType.search(/1day/)>0) ? -1 : -2;
		var shipDate=new Date(deliveryDate);
		shipDate=new Date(shipDate.setDate(shipDate.getDate()+factor));
		field.shipDate.value = shipDate.display();
		updateDeliveryDateDisplay(deliveryDate); 
		switch(deliveryDate.getShippingType()) {
			case "fedex1day":field.shipOpts.selectedIndex=0;break;
			case "fedex2day":field.shipOpts.selectedIndex=1;break;
			case "fedex1daySat":field.shipOpts.selectedIndex=2;break;
			case "fedex2daySat":field.shipOpts.selectedIndex=3;break;
			case "fedex1dayNonContinental":field.shipOpts.selectedIndex=4;break;
			case "fedex1daySatNonContinental":field.shipOpts.selectedIndex=5;break;
		}
		field.applyBtn.click(); // this submits the form with the hidden values
	}catch(e){
		put(e)
	}
}

Color={
	fedex2day:"#9CF", // blue
	fedex1day:"#F9C", // red
	fedex2daySat:"#CFC", // green
	fedex1daySat:"#FC9", // red
	fedex1daySatNonContinental:"brown", 												
	fedex1dayNonContinental:"orange"
}

getCalendarKey = function(cal){
	var result="";
	if(isNonContinentalState()){
		result += "<p style='border-left:15px solid "+Color.fedex1dayNonContinental+";line-height:14px;padding-left:15px;'>Fedex Overnight / Alaska, Hawaii, Puerto Rico<span class='price'></span></p>";
		result += "<p style='border-left:15px solid "+Color.fedex1daySatNonContinental+";line-height:15px;padding-left:15px;'>FedEx Overnight / Saturday / Alaska, Hawaii, Puerto Rico<span class='price'></span></p>";
	}else{
		result += "<p style='border-left:15px solid "+Color.fedex2day+";line-height:15px;padding-left:15px;'>FedEx 2Day Shipping<span class='price'></span></p>";
		result += "<p style='border-left:15px solid "+Color.fedex1day+";line-height:15px;padding-left:15px;'>FedEx Overnight Service<span class='price'></span></p>";
		result += "<p style='border-left:15px solid "+Color.fedex2daySat+";line-height:15px;padding-left:15px;'>FedEx 2Day with Saturday Delivery<span class='price'></span></p>";
		result += "<p style='border-left:15px solid "+Color.fedex1daySat+";line-height:15px;padding-left:15px;'>FedEx Overnight / Saturday <span class='price'></span></p>";
	} return result;
}

Date.prototype.getShippingType=function() {
	if(
		this <= ShippingDate.earliest 
		|| this >= ShippingDate.latest 
		|| this.isHoliday() 
		|| this.getDay() <= 1  
		|| this.getDay() == 2 && this.isHoliday(-1)
		// the following are all special exceptions for the Christmas holiday
		|| this.equals(new Date("2007/12/26"))
		|| (this.equals(new Date("2007/12/27")) && ShippingDate.now.equals(new Date("2007/12/24")) && ShippingDate.now.afterShippingCutoff())
	) { return -1 }
	
	var shipCompany="fedex";
	var continental=(isNonContinentalState()) ? "NonContinental" :"";
	var saturday=(this.getDay()==6) ? "Sat" : "";
	var shipSpeed=(
		this.equals(ShippingDate.earliest)
		|| this.getDay() == 2
		|| this.getDay() == 3 && (this.isHoliday(-2) || this.isHoliday(-1))
		|| this.getDay() == 4 && (this.isHoliday(-2) || this.isHoliday(-1))
		|| this.getDay() == 5 && (this.isHoliday(-2) || this.isHoliday(-1))
		|| this.getDay() == 6 && (this.isHoliday(-2) || this.isHoliday(-1))
		|| isNonContinentalState()
		// the following are all special exceptions for the Christmas holiday
		|| (this.equals(new Date("2007/12/28")) && (ShippingDate.now.equals(new Date("2007/12/24")) && ShippingDate.now.afterShippingCutoff()))
		|/Users/nkrimm/.vim/scripts/jsTidy.rb:27:in `gets': No such file or directory - ^M (Errno::ENOENT)
		from /Users/nkrimm/.vim/scripts/jsTidy.rb:27
		/Users/nkrimm/.vim/scripts/jsTidy.rb:27:in `gets': No such file or directory - ^M (Errno::ENOENT)
		from /Users/nkrimm/.vim/scripts/jsTidy.rb:27
		| (this.equals(new Date("2007/12/28")) && (ShippingDate.now.equals(new Date("2007/12/25"))))
		|| (this.equals(new Date("2007/12/28")) && (ShippingDate.now.equals(new Date("2007/12/26"))))
	) ? "1day" : "2day";
	
	var result=shipCompany+shipSpeed+saturday+continental;
	return result;
}	

Date.prototype.equals=function(date){
	return ( 
		date.getMonth()==this.getMonth() 
		&& date.getFullYear()==this.getFullYear() 
		&& date.getDate()==this.getDate()
	);
}

CalendarDisplay.writeCalendar=writeCalendar;

writeCalendar = function() {	  
	try{
		var tableOutput=CalendarDisplay.generateCalendarGrid();
		calendarHeader=CalendarDisplay.generateCalendarHeader();
		calendarKey=getCalendarKey();
		tableOutput = (calendarHeader + tableOutput) + calendarKey;
		document.getElementById('cal').innerHTML=tableOutput;	
		CalendarDisplay.show();
	}catch(e){ 
		put(e) 
	}
}

updateDeliveryDateDisplay=function(date){
	inputDateFieldLabel=$('labelvwcf-yhst-93672551109875-shipping-calendar'); 
	var t=$('deliveryDateDisplay');
	t=inputDateFieldLabel.getElementsByTagName("strong")[0];
	if (t==undefined){
		t=document.createElement("span");
		t.setAttribute("style","background:#EEE;font-weight:bold;");
		t.setAttribute("id","deliveryDateDisplay");
		inputDateFieldLabel.appendChild(t);
	}
	t.innerHTML="You've chosen <b>"+date.display() +"</b> as your delivery date.  You can choose a new date by clicking on the calendar.";
}

/*
utilities 
*/

//put=function(msg){console.log(msg)}; // for logging in firebug/firefox
put=function(msg){}// swallow messages
//put=function(msg){alert(msg);} // for logging in ie

$=function(id){ return document.getElementById(id);} // thanks prototype.js
stub = function(){}// for stubbing javascript urls in href.  like, href="javascript:stub()"

/* end utilities */
