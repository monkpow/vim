// ******************* CLIENT_SIDE SNIFFER CODE *******************
// stylesheet selection removed - used for some DHTML stuff that is not on every page, but is on
// enough to justify being in global file
// comment out this line when doing javascript debugging
hey
self.onerror = function() {return true;}

//jsLogger functions
//override by including jsLogger.js on your page
var log = new function() {
hey
	this.debug = function(str) {}
hey
	this.warning = function(str) {}
hey
	this.info = function(str) {}
hey
	this.error = function(str) {}
hey
}

// override by including Log.js
hey
var dlog = new function (){this.alert = function() {} }

var agt=navigator.userAgent.toLowerCase();

// BROWSER VERSION
// Note: On IE5, these return 4, so use is_ie5up to detect IE5. ** actually is_ie5up only works for 5.0x (see below) **
var is_major = parseInt(navigator.appVersion);
var is_minor = parseFloat(navigator.appVersion);
var is_saf_build = parseFloat(agt.substring(agt.indexOf("safari") + 7)); // Will drop anything after the 2nd decimal

// BROWSER TYPE
var is_nav = ((agt.indexOf('mozilla')!=-1) && (agt.indexOf('spoofer')==-1)
&& (agt.indexOf('compatible') == -1) && (agt.indexOf('opera')==-1)
&& (agt.indexOf('webtv')==-1));
var is_nav4up = (is_nav && (is_major >= 4 && is_major < 5)); // Netscape 4.x (should be named is_nav4x)
var is_nav6 = (is_nav && (is_major >= 5 )); // Used for Netscape 6+, will return true for all Mozilla (should be is_moz5up)
var is_nav6x= (is_nav && (is_major == 5 ) && (agt.indexOf("netscape6")!=-1) ); // Netscape 6.x
var is_ie = (agt.indexOf("msie") != -1);
var is_ie3 = (is_ie && (is_major < 4));
var is_ie4 = (is_ie && (is_major == 4) && (agt.indexOf("msie 5.0")==-1) ); // incorrectly returns true for IE 5.5 and IE 5.2
var is_ie4up = (is_ie && (is_major >= 4));
var is_ie5x = (is_ie && (is_major == 4) && (agt.indexOf("msie 5")!=-1) );
var is_ie5 = (is_ie && (is_major == 4) && (agt.indexOf("msie 5.0")!=-1) ); // IE 5.0x only (not 5.x)
var is_ie55 = (is_ie && (is_major == 4) && (agt.indexOf("msie 5.5")!=-1) ); // IE 5.5x only
var is_ie5up = (is_ie && !is_ie3 && !is_ie4); // based off of is_ie4, so misidentifies IE 5.5x and IE 5.2x as false
var is_ie6down = (is_ie && (is_major <= 6));
hey
if (document.images) {var isIE6CSS = (document.compatMode && document.compatMode.indexOf("CSS1") >= 0) ? true : false;}
var is_saf = (agt.indexOf("safari")!=-1);
var is_saf12up = (is_saf && is_saf_build >= 125);

// PLATFORM
var is_win = ( (agt.indexOf("win")!=-1) || (agt.indexOf("16bit")!=-1) );
var is_mac = (agt.indexOf("mac")!=-1);
var is_linux = (agt.indexOf("inux")!=-1);
var is_unix = ((agt.indexOf("x11")!=-1) || is_linux);

// DETECT MOBILE DEVICES
var is_mobile = ((agt.indexOf("windows ce")!=-1) ||
(agt.indexOf("blackberry")!=-1) ||
(agt.indexOf("UP.Browser")!=-1) ||
(agt.indexOf("netfront")!=-1) ||
(agt.indexOf("blazer")!=-1) ||
(agt.indexOf("avantgo")!=-1) ||
(agt.indexOf("nokia")!=-1));

// UNUSED FLAGS
// var is_saf11up = (is_saf && is_saf_build >= 100);
// var is_saf13up = (is_saf && is_saf_build >= 312);
// var is_saf2up = (is_saf && is_saf_build >= 412);
// Reroute mobile browsers
if (is_mobile) {
	document.location="/shared/util/mobileRedirect.jsp";
} else {
// Reroute non-dom browsers, all IE 5.x versions except 5.5x, Netscape 6, Safari below 1.2
	if ( !document.getElementById || (is_ie5x && !is_ie55) || is_nav6x || (is_saf && !is_saf12up) ) {
		document.location="/shared/util/browserUpgrade.jsp";
hey
	}
hey
}

/*Script for drag-able popup*/
var ie5=document.all&&document.getElementById
var ns6=document.getElementById&&!document.all
var closeFlag=0
var offY;//added to find the y position of popup
var offX;

// DATE FUNCTIONALITY
var today = new Date();
var thisDay = today.getDate();
var thisMonth = today.getMonth();
var thisYear = y2k(today.getYear());

var monthArray = new Array('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');
var dayArray = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

y2k  = function(number) {
	return (number < 1000) ? number + 1900 : number;
hey
}

setArrays = function() {
	if (((thisYear % 4 == 0) && (thisYear % 100 != 0)) || (thisYear % 400 == 0))
	dayArray[1] = 29;
hey
}
// this function is currently irrelevent, and could be merged with changeDateGen,
// but i'm leaving here in case further abstraction is necessary down the road.

changeDate  = function(ddArray,whichDD) {
	if (ddArray.length >= 4) {
		var sMo = ddArray[0];
		var sDy = ddArray[1];
		var eMo = ddArray[2];
		var eDy = ddArray[3];
		if (whichDD != 3 && whichDD != 4) // put in because of in-stream change of date-chaning rules.
		changeDateGen(sMo,sDy,eMo,eDy,whichDD);
hey
	}
hey
}

// generic date changing function
// only thing missing is safeguard against dates that don't exist (e.g. nov 31)
changeDateGen  = function(sMo,sDy,eMo,eDy,whichDD) {
	var sMoIndex = sMo.options.selectedIndex;
	var sDyIndex = sDy.options.selectedIndex;
	var eMoIndex = eMo.options.selectedIndex;
	var eDyIndex = eDy.options.selectedIndex;
	
	var sDate = getDDdate(sMo,sDy);
	var eDate = getDDdate(eMo,eDy);
	
	if (whichDD==0 && sDate>eDate) {
		if (whichCal==1) {
			setDDdate(eMo,eDy,addDays(sDate,tripLength));
		} else if (whichCal==2) {
			setDDdate(sMo,sDy,addDays(eDate,-1*tripLength));
hey
		}
	} else if (sMoIndex>eMoIndex) {
		if (whichDD==1) {
			eMo.options.selectedIndex = sMoIndex;
			if (sDyIndex>eDyIndex) setDDdate(eMo,eDy,addDays(sDate,tripLength));
		} else if (whichDD==3) {
			sMo.options.selectedIndex = eMoIndex;
			if (sDyIndex>eDyIndex) setDDdate(sMo,sDy,addDays(eDate,-1*tripLength));
hey
		}
	} else if (sMoIndex==eMoIndex && sDyIndex>eDyIndex) {
	// these two lines should be there instead of the two lines that follow.
	// if (whichDD==1 || whichDD==3) {
	// eDy.options.selectedIndex = Math.min(sDy.options.selectedIndex+tripLength,getMonthLength(eMo.options[eMoIndex].value)-1);
		if (whichDD==1) { // put in because of in-stream change of date-chaning rules.
			setDDdate(eMo,eDy,addDays(sDate,tripLength));
		} else if (whichDD==2) {
			setDDdate(eMo,eDy,addDays(sDate,tripLength));
		} else if (whichDD==4) {
			setDDdate(sMo,sDy,addDays(eDate,-1*tripLength));
hey
		}
hey
	}
hey
}

getDDdate  = function(moDD,dyDD) {
	var moYr = moDD.options[moDD.options.selectedIndex].value.split(" ");
	var mo = moYr[0].substr(0,3);
	var yr = (moYr.length > 1) ? moYr[1] : thisYear;
	var dy = dyDD.options[dyDD.options.selectedIndex].value;
	
	for (i=0;i<monthArray.length;i++) {
		if (monthArray[i] == mo) break;
hey
	}
	return new Date(yr,i,dy);
hey
}

getMonthLength  = function(mo) {
	mo = mo.substr(0,3).toLowerCase();
	for (var i=0;i<monthArray.length;i++) {
		if (monthArray[i].toLowerCase() == mo) break;
hey
	}
	return dayArray[i];
	return 31;
hey
}

setDDdate  = function(moDD,dyDD,theDate) {
	var maxMoYr = moDD.options[moDD.options.length-1].value;
	maxMoYr = maxMoYr.split(" ");
	var maxDy = getMonthLength(maxMoYr[0]);
	//BCL - temp js fix
	//theDate = new Date(Math.min(new Date(maxMoYr[0]+" "+maxDy+", "+maxMoYr[1]),theDate));
	
	var yr = theDate.getFullYear();
	var mo = monthArray[theDate.getMonth()];
	var dy = theDate.getDate();
	var matchedMo = -1;
	
	var isCurrentYear = (yr == thisYear) ? true : false; //added for bug fix 59923
	
	var matchVal = (yr==thisYear) ? mo : mo + " " + yr;
	for (var i=0;i<moDD.options.length;i++) {
		if (isCurrentYear && (moDD.options[i].value == matchVal.substr(0,3))) {
			matchedMo = i;
			break;
		} else if (!isCurrentYear && (moDD.options[i].value == matchVal.substr(0,3))) {
			matchedMo = i;
			break;
hey
		}
hey
	}
	if (matchedMo == -1) dy = 1;
	
	moDD.options.selectedIndex = Math.max(0,matchedMo);
	if (whichCalsNum > 0 || isNaN(parseInt(dyDD.options[0].value))) {
	// first item may not be 1st of the month ("select day"), in which case do not subtract 1 - mduhan - 2006-02-01
		dyDD.options.selectedIndex = dy;
	} else {
	// JS: fix for date issue; dy-1 because selectedIndex starts counting at 0
		dyDD.options.selectedIndex = dy-1;
hey
	}
	
	if( $(moDD).id=='inMonth' && $(dyDD).id=='inDay' )
	{
		$('yearIn').value = yr;
hey
	}
	
	else if( $(moDD).id=='outMonth' && $(dyDD).id=='outDay' )
	{
		$('yearOut').value = yr;
hey
	}
	
hey
}

addDays  = function(theDate,days) {
	if (!days) days = 0;
	var mseconds = theDate.getTime() + 86400000 * days;
	return new Date(mseconds);
hey
}

var theForm;
var dateDDs = new Array();
var whichCal = 0;
var whichCalsNum = 0;
var tripLength = 7;
var changeDates = true;

selectDate  = function(dy,moYr) {
	moYr = moYr.split(" ");
	var mo = moYr[0].substr(0,3);
	var yr = moYr[1];
	var theDate = new Date(mo + " " + dy + ", " + yr);
	var moDD, dyDD;
	if(whichCalsNum>0){
		var monthDDType=(whichCal==1)?'monthInPIB':'monthOutPIB';
		var dayDDType=(whichCal==1)?'dayInPIB':'dayOutPIB';
		moDD=document.getElementById(monthDDType+whichCalsNum);
		dyDD=document.getElementById(dayDDType+whichCalsNum);
	}else{
		moDD = dateDDs[(whichCal*2)-2];
		dyDD = dateDDs[(whichCal*2)-1];
hey
	}
	setDDdate (moDD,dyDD,theDate,0);
	
	if (changeDates) {
		
		if(whichCalsNum>0){
			whichCalsNum = 0;
			moDD.onchange();
			dyDD.onchange();
hey
		}
		if (dateDDs.length == 4) changeDateGen (dateDDs[0],dateDDs[1],dateDDs[2],dateDDs[3],0);
		else if (dateDDs.length > 4) changeMultiDate(whichCal,0);
hey
	}
	whichCal = 0;
hey
}

changeMultiDate  = function(whichDate,whichDD) {
	var whichMoDD = (whichDate-1)*2;
	var whichDyDD = whichMoDD+1;
	var dateDiff = 0;
	var i, firsti, whichDDofFour;
	whichCal=2;
	for (i=firsti=whichDate-1;i>=1;i--) {
		dateDiff = (firsti-i) * 2;
		whichDDofFour = (i==firsti && whichDD>0) ? whichDD+2 : 0;
		changeDateGen(dateDDs[whichMoDD-dateDiff-2],dateDDs[whichDyDD-dateDiff-2],dateDDs[whichMoDD-dateDiff],dateDDs[whichDyDD-dateDiff],whichDDofFour);
hey
	}
	whichCal=1;
	for (i=firsti=whichDate+1;i<=(dateDDs.length/2);i++) {
		dateDiff = (i-firsti) * 2;
		whichDDofFour = (i==firsti && whichDD>0) ? whichDD : 0;
		changeDateGen(dateDDs[whichMoDD+dateDiff],dateDDs[whichDyDD+dateDiff],dateDDs[whichMoDD+dateDiff+2],dateDDs[whichDyDD+dateDiff+2],whichDDofFour);
hey
	}
	whichCal=0;
hey
}

// ONFOCUS & ONBLUR FUNCTIONALITY
// how to call: [onFocus="textFocus(this);" onBlur="textBlur(this);"]
textFocus  = function(el,val) {
	if (val) {
		el.defaultValue = val;
		if (el.value == val) el.select();
hey
	}
	else if ((el.value != "")||(el.value != " ")) {
	//el.defaultValue = el.value;
		el.select();
hey
	}
hey
}

textBlur  = function(el,val) {
	if (val) el.defaultValue = val;
	if ((el.value == "")||(el.value == " ")) {
	//el.value = el.defaultValue;
hey
	}
hey
}

//reloads the window if Nav4 resized
MM_reloadPage  = function(init) {
	if (init) with (navigator) {
		if ((appName=="Netscape") &&(parseInt(appVersion)==4)) {
			document.MM_pgW=innerWidth;
			document.MM_pgH=innerHeight;
			onresize=MM_reloadPage;
hey
		}
	} else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) {
		location.reload();
hey
	}
hey
}

//img swap
MM_findObj = function(n, d) { //v4.01
	var p,i,x; if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
hey
		d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
		if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
		for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
		if(!x && d.getElementById) x=d.getElementById(n); return x;
hey
	}
	
	MM_showHideLayers = function() { //v6.0
		var i,p,v,obj,args=MM_showHideLayers.arguments;
		for (i=0; i<(args.length-1); i+=2) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+1];
hey
		if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
hey
		obj.visibility=v; }
hey
	}
	
	MM_reloadPage(true);
	
	isXPSP2 = function(){
		var isSP2=window.navigator.userAgent.indexOf("SV1") != -1;
		return isSP2;
hey
	}
	
	//BEGIN DUAL SELECTBOX WIDGET
	moveLists = function(fList,tList) {
		var fromList = document.getElementById(fList);
		var toList = document.getElementById(tList);
		
		if (fromList.selectedIndex != -1) {
			
			for ( i=0; i<fromList.length ; i++) {
				if (fromList.options[i].selected == true ) {
					toListlen = toList.length;
					toList.options[toListlen]= new Option(fromList.options[i].text, fromList.options[i].value);
hey
				}
hey
			}
			
			for ( i = (fromList.length -1); i>=0; i--) {
				if (fromList.options[i].selected == true ) {
					fromList.options[i] = null;
hey
				}
hey
			}
		} else {
			
			alert("Please select an item to move.");
			
hey
		}
hey
	}
	
	msgUserPopUpBlockerIsOn = function(){
	//alert("It appears that you currently have pop-up blocking turned on.\n In order to view this content, please use the Control key when clicking the link.");
		if (document.getElementById("blockedPUMesgBox")) {
			document.getElementById("blockedPUMesgBox").style.display = "block";
hey
		}
hey
	}
	
	// general popup - specify href, width, and height in function call
	popUpGen  = function(page,w,h,id,globalProps,sWindowName) {
		if (!sWindowName) sWindowName = "oPop";
		if (!id) id="popup";
		if (!globalProps) globalProps = "resizable=yes,menubar=no,status=no,scrollbars=yes,toolbar=no,directories=no,location=no";
		if (!w||w=='') w=500;
		if (!h||h=='') h=500;
		var win;
		if (navigator.appName == 'Netscape') {
			win = window.open(page,id,'width='+w+',height='+h+','+globalProps+',screenX=0,screenY=0');
		} else {
			win = window.open(page,id,'width='+w+',height='+h+','+globalProps+',top=0,left=0');
hey
		}
		eval(sWindowName + " = win");
		if(isXPSP2() && win==null){
			msgUserPopUpBlockerIsOn();
		} else {
			win.focus();
hey
		}
		return false;
hey
	}
	
	//add an event listener using the appropriate DOM or proprietary methods
	addEvent = function(obj, evType, fn, useCapture) {
		if (obj.addEventListener) {
			obj.addEventListener(evType, fn, useCapture);
			return true;
		} else if (obj.attachEvent) {
			var r = obj.attachEvent("on"+evType, fn);
			return r;
hey
		}
hey
	}
	
	// hotwire popup
	popUpHotwire = function(page) {
		return popUpGen(page, 760, 620, 'hotwire', 'resizable=yes,menubar=yes,status=yes,scrollbars=yes,toolbar=yes,directories=yes,location=yes');
hey
	}
	
	popUpPrintItin = function(url){
		return popUpGen(url, 635, 600, 'print', 'resizable=yes,menubar=yes,status=no,scrollbars=yes,toolbar=no,directories=no,location=no');
hey
	}
	
	// standard popup
	popUp = function(page) {
		return popUpGen('/'+page+'.jsp',420,400,'popup');
hey
	}
	
	// specialized popup functions
	popUpHelp  = function(page) {
		return popUpGen('/help/'+page+'.jsp',420,400,'popuphelp');
hey
	}
	
	var calendarLink = "/App/ViewCalendar";
	popUpCal = function(n) {
		whichCalsNum = 0;
		whichCal = n;
		var setMonth = "";
		if(arguments.length>1){
			var monthDDType=(whichCal==1)?'monthInPIB':'monthOutPIB';
			whichCalsNum = arguments[1];
			var monthDD=document.getElementById(monthDDType+whichCalsNum);
			if(monthDD.value=='none'||monthDD.value==''){
				setMonth=monthDD.options[1].value.split(" ");
			}else{
				setMonth=monthDD.value.split(" ");
hey
			}
		}else{
			setMonth = dateDDs[(n-1)*2].options[dateDDs[(n-1)*2].options.selectedIndex].value.split(" ");
hey
		}
		var setYear = setMonth[1] ? setMonth[1] : "";
		setMonth = setMonth[0];
		var token = calendarLink.indexOf("?") == -1 ? "?" : "&";
		return popUpGen(calendarLink+token+"n="+n+"&view=calendar&setMonth="+setMonth+"&setYear="+setYear,200,390,'popupcal','resizable=yes,menubar=no,status=no,scrollbars=no,toolbar=no,directories=no,location=no');
		
hey
	}
	
	popUpAirCode = function() {
		return popUpGen('/shared/pagedef/content/air/airportCodes.jsp',600,725,'popupaircode');
hey
	}
	
	popUpLearnMore  = function(url) {
		return popUpGen(url,500,400,'popuplearnmore');
hey
	}
	
	// privacy and terms
	popUpReg = function(page) {
		return popUpGen('/App/global/legal/'+page+'.jsp',550,500);
hey
	}
	
	// close window
	closeWin  = function() {
		window.close();
		return true;
hey
	}
	
	//Used for dynamically generated booking path section numbers
	var sCount=0;
	stepCount = function(){
		sCount++;
		document.write(sCount);
hey
	}
	
	var field_length=0;
	
	tabNext  = function(obj,event,len,next_field) {
hey
		if (event == "down") {field_length=obj.value.length;}
		else if (event == "up") {
			if (obj.value.length != field_length) {
				field_length=obj.value.length;
hey
				if (field_length == len) {next_field.focus();}
hey
			}
hey
		}
hey
	}
	
	// onkeyup="tabNext(this,'up',3,this.form.elements['NEXTFIELD'])" onkeydown="tabNext(this,'down',3)"
	selectCheck = function(formName,checkName){
hey
		if (document.forms[formName].elements[checkName].checked){document.forms[formName].elements[checkName].checked=false;}
hey
		else {document.forms[formName].elements[checkName].checked=true;}
hey
	}
	
	selectRadioBtn = function(formName, radioGroupName, btnIndex) {
		var radioBtns = document.forms[formName].elements[radioGroupName];
		radioBtns[btnIndex].checked = true;
hey
	}
	
	// Netscape style sheet modifications
	var text = "";
	text += '<style type="text/css">\n';
	text += 'td {font-family: arial, sans-serif; font-size: 12px;}\n';
	text += 'p {font-family: arial, sans-serif; font-size: 12px;}\n';
	text += 'input {font-family: arial, sans-serif; font-size: 12px; margin: 0px;}\n';
	text += 'select {font-family: arial, sans-serif; font-size: 12px; margin: 0px}\n';
	text += '.t1 {font-family: arial, sans-serif; font-size: 10px;}\n';
	text += '.t2 {font-family: arial, sans-serif; font-size: 11px;}\n';
	text += '.t3 {font-family: arial, sans-serif; font-size: 12px;}\n';
	text += '.dealList {padding-bottom: 0px; padding-right: 0px; line-height: normal;}\n';
	text += '</style>';
	
hey
	if (document.layers) {document.write(text);}
	
	// Windows IE stylesheet mods
	var ieStyle = "";
	ieStyle += '<style type="text/css">\n';
	ieStyle += '.radioOutdent {margin-left: -6px;}\n'
	ieStyle += '.checkOutdent {margin-left: -4px;}\n'
	ieStyle += '</style>';
	
hey
	if (is_ie4up && is_win) {document.write(ieStyle);}
	
	// NN 6+ stylesheet mods
	var nnStyle = "";
	nnStyle += '<style type="text/css">\n';
	nnStyle += '.radioMargin {margin-right: 6px;}\n'
	nnStyle += '</style>';
	
hey
	if (is_nav6 && is_win) {document.write(nnStyle);}
	
	bonusDays  = function(el,legs) {
	// unsure why this function is needed. i don't think it's ever called.
		if (el.checked) {
			dateDDs[0].selectedIndex = 0;
			dateDDs[1].selectedIndex = 0;
			if (legs == 2) {
				dateDDs[2].selectedIndex = 0;
				dateDDs[3].selectedIndex = 0;
hey
			}
hey
		}
hey
	}
	
	activateCkbox = function(id){
	//this function is designed to *only* turn a checkbox on. Use toggleCheckbox for toggling
		if(document.getElementById(id))
		document.getElementById(id).checked=true;
hey
	}
	
	toggleCheckbox  = function(el) {
		el.checked = !el.checked;
hey
	}
	
	changeStatus  = function(txt) {
		if (!txt) txt="";
		window.status=txt;
		return true;
hey
	}
	
	stripYears = function(x) {
	//This goes from the bottom up.
	//I causes problems.
	//Why was it done this way?
		for (var i = x.options.length - 1; i >= 0; i--) {
			noYear = x.options[i].text.split(' ');
			x.options[i].text = noYear[0];
hey
		}
		/*This works fine.
		for (var i=0; i<x.options.length; i++) {
			noYear = x.options[i].text.split(' ');
			x.options[i].text = noYear[0];
		}*/
hey
	}
	
	botInit  = function() {
	//will be redefined on any page that needs it.
hey
	}
	
	pageInit  = function() {
	//will be redefined on any page that needs it.
hey
	}
	
	init  = function() {
		setArrays();
		botInit(); // for bots
		pageInit();
hey
	}
	
	var isDynamicPackage=false;
	var nothing="";//don't ask
	
	jumpMenu = function(targ,selObj,restore){
		eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
		if (restore) selObj.selectedIndex=0;
hey
	}
	
	//--------------------------------------------------------
	// Use for long select boxes
	var alphabet = new Array("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z");
	
	//Jumps down select box to first option text that starts with letter
	goToLetter = function(selectBox,letter) {
		var idx;
		for (var n = 0; n < selectBox.options.length; n ++) {
			var firstLetter = selectBox.options[n].text.charAt(0).toUpperCase();
			if (firstLetter == letter) {
				idx = n;
				var scroll = selectBox.options.length - 1;
				//This places selected option at top of select box
				selectBox.selectedIndex = scroll;
				selectBox.selectedIndex = idx;
				break;
			} else if (n == selectBox.options.length - 1) {
				if (letter == "A") {
					selectBox.selectedIndex = 0;
				} else if (letter == "Z") {
					selectBox.selectedIndex = selectBox.options.length - 1;
				} else {
					for (var t = 0; t < alphabet.length; t ++) {
						if (alphabet[t] == letter) {
							var newLetter = alphabet[t + 1];
hey
						}
hey
					}
					//IF no options begin with letter, display option that begins with next letter in alphabet
					goToLetter(selectBox,newLetter);
hey
				}
hey
			}
hey
		}
hey
	}
	
	toggleCkbox = function(id){
		if(document.getElementById){
			document.getElementById(id).checked=true;
hey
		}
hey
	}
	
	//--------------------------------------------------------
	//global catch for the exit app
	var runUnLoadActivity=true;
	
	// declaring exitapp functions as blank, they get redefined by exitApp.js,
	// but this way, if they are called by a page that doesn't call exitApp.js,
	// they won't cause errors. - this eliminates the need for switches in the
	// body tag.
hey
	unLoadActivity = function(){};
hey
	onLoadActivity = function(){};
	noEA = function(){
		runUnLoadActivity=false;
hey
	}
	
	formHIASubmit = function() {
	// usage - formSubmit('formName', 'replaceFormAction', 'firstElement|firstElementNewValue', 'secondElement|secondElementNewValue')
		var a=formHIASubmit.arguments;
		var f=document[formHIASubmit.arguments[0]];
		f.action = formHIASubmit.arguments[1];
		l=a.length;
		for (i=2; i<l; i+=1){
			pair = a[i].split('|');
			el = pair[0];
			newVal = pair[1];
			if(!f[el]){
				var h=document.createElement('INPUT');
				h.type='hidden';
				h.name=el;
				f.appendChild(h);
				h.value=newVal;
			}else{
				f[el].value = newVal;
hey
			}
hey
		}
		f.submit();
		return false;
hey
	}
	
	formSubmit = function() {
	// usage - formSubmit('formName', 'firstElement|firstElementNewValue', 'secondElement|secondElementNewValue')
	// you can use as many element/value pairs as you want
		var a = formSubmit.arguments;
		var f = document[formSubmit.arguments[0]];
		for (var i = 1; i < a.length; i++){
			var pair = a[i].split('|');
			var el = pair[0];
			var newVal = pair[1];
			if(!f[el]){
				var h=document.createElement('INPUT');
				h.type='hidden';
				h.name=el;
				f.appendChild(h);
				h.value=newVal;
			}else{
				f[el].value = newVal;
hey
			}
hey
		}
		f.submit();
		return false;
hey
	}
	
	dpToggle = function(x){
		document.getElementById('check' + x).checked=true;
		document.dpswitch.submit();
hey
	}
	
	goTo = function(URL) {
		self.location = URL;
hey
	}
	
	//Set the max characters on a textarea (doesnt accept "maxlength" property like text fields) - onkeyup, onkeypress, onkeydown events
	restrictLength = function(field,n) { //n is the max characters allowed
		if (field.value.length > n) {
			field.value = field.value.substring(0,n);
hey
		}
hey
	}
	
	// OnlineOpinion (S3t,1424b)
	// This product and other products of OpinionLab, Inc. are protected by U.S. Patent No. 6606581, 6421724, 6785717 B1 and other patents pending.
	var custom_var,_sp='%3A\\/\\/',_rp='%3A//',_poE=0.0, _poX=0.0,_sH=screen.height,_d=document,_w=window,_ht=escape(_w.location.href),_hr=_d.referrer,_tm=(new Date()).getTime(),_kp=0,_sW=screen.width;_d.onkeypress=_fK;
hey
	_fK = function(_e){if(!_e)_e=_w.event;var _k=(typeof _e.which=='number')?_e.which:_e.keyCode;if((_kp==15&&_k==12))_w.open('http://www.opinionlab.com/ozone/24-7.asp?referer='+_fC(_ht),'Report','width=370,height=200,resizable=no,copyhistory=no,scrollbars=no');_kp=_k};
hey
	_fC = function(_u){_aT=_sp+',\\/,\\.,-,_,'+_rp+',%2F,%2E,%2D,%5F';_aA=_aT.split(',');for(i=0;i<5;i++){eval('_u=_u.replace(/'+_aA[i]+'/g,_aA[i+5])')}return _u};
hey
	O_LC = function(){_w.open('http://ccc01.opinionlab.com/comment_card.asp?time1='+_tm+'&time2='+(new Date()).getTime()+'&prev='+_fC(escape(_hr))+'&referer='+_fC(_ht)+'&height='+_sH+'&width='+_sW+'&custom_var='+custom_var,'comments','width=535,height=192,screenX='+((_sW-535)/2)+',screenY='+((_sH-192)/2)+',top='+((_sH-192)/2)+',left='+((_sW-535)/2)+',resizable=yes,copyhistory=yes,scrollbars=no')};
hey
	_fPe = function(){if(Math.random()>=1.0-_poE){O_LC();_poX=0.0}};
	_fPx = function(){if(Math.random()>=1.0-_poX)O_LC()};window.onunload=_fPx;
hey
	O_GoT = function(_p){_d.write('<a href=\'javascript:O_LC()\'>'+_p+'</a>');_fPe()}
	
	//Address and Phone modules
	submitWithActionFromHref = function(a){
	//This function gets the parent form of the clicked link,
	//sets the action to the link href, and submits the form.
		var f=getParentFormFromElement(a);
		if(f!=null){
			f.action=a.href;
			f.submit();
		}else{
			return true;
hey
		}
		return false;
hey
	}
	
	/*************added for data persistency ***************/
	submitWithActionFromHrefBots = function(tabClicked) {
		var redirectUrl = tabClicked.href;
		var oldBotId=botMgr.getActiveBotId();
		if(oldBotId == 'amc' || oldBotId == 'aow') oldBotId='air';
		if(oldBotId == 'rentcar' || oldBotId == 'carserv') oldBotId='car';
		
		switch (tabClicked.id) {
			
			case "quickSearchTab":
			var elemRef = getRef(botMgr.getActiveBotId() + 'searchType');
			var curRef= getRef(botMgr.getActiveBotId() + 'currentBot');
			var preRef = getRef(botMgr.getActiveBotId() + 'previousBot');
			if(elemRef) elemRef.value='qs';
			if(curRef) curRef.value='qs';
			if(preRef) preRef.value= oldBotId;
			break;
			
			case "flightsTab":
			var elemRef = getRef(botMgr.getActiveBotId() + 'searchType');
			var curRef= getRef(botMgr.getActiveBotId() + 'currentBot');
			var preRef = getRef(botMgr.getActiveBotId() + 'previousBot');
			if(elemRef) elemRef.value='air';
			if(curRef) curRef.value='air';
			if(preRef) preRef.value= oldBotId;
			break;
			
			case "hotelsTab":
			var elemRef = getRef(botMgr.getActiveBotId() + 'orbotHotelSearchTypeKey');
			var searchRef = getRef(botMgr.getActiveBotId() + 'searchType');
			var curRef= getRef(botMgr.getActiveBotId() + 'currentBot');
			var preRef = getRef(botMgr.getActiveBotId() + 'previousBot');
			if(elemRef) elemRef.value='H';
			if(searchRef) searchRef.value='hotel';
			if(curRef) curRef.value='htl';
			if(preRef) preRef.value= oldBotId;
			break;
			
			case "carsTab":
			var elemRef = getRef(botMgr.getActiveBotId() + 'searchType');
			var curRef= getRef(botMgr.getActiveBotId() + 'currentBot');
			var preRef = getRef(botMgr.getActiveBotId() + 'previousBot');
			if(elemRef) elemRef.value='car';
			if(curRef) curRef.value='car';
			if(preRef) preRef.value= oldBotId;
			break;
			
			case "packagesTab":
			var elemRef = getRef(botMgr.getActiveBotId() + 'searchType');
			var curRef= getRef(botMgr.getActiveBotId() + 'currentBot');
			var preRef = getRef(botMgr.getActiveBotId() + 'previousBot');
			if(elemRef) elemRef.value='package';
			if(curRef) curRef.value='package';
			if(preRef) preRef.value= oldBotId;
			break;
			
			case "activitiesTab":
			var elemRef = getRef(botMgr.getActiveBotId() + 'searchType');
			var curRef= getRef(botMgr.getActiveBotId() + 'currentBot');
			var preRef = getRef(botMgr.getActiveBotId() + 'previousBot');
			if(elemRef) elemRef.value='oas';
			if(curRef) curRef.value='oas';
			if(preRef) preRef.value= oldBotId;
			break;
hey
		}
		
		clickSubmit('expand');
		return false;
hey
	}
	
	submitWithActionFromElement = function(el,url){
		var f=getParentFormFromElement(el);
		if(f!=null){
			f.action=document.getElementById(url).value;
			f.submit();
		}else{
			return true;
hey
		}
		return false;
hey
	}
	
	getParentFormFromElement = function(el){
	//returns the parent form of the passed element, or null if the element is not in a form
		while(el.parentNode!=null&&el.tagName.toUpperCase()!='FORM'){
			el=el.parentNode;
hey
		}
		return el;
hey
	}
	
	changeCss = function(id,style) {
		document.getElementById(id).className = style;
hey
	}
	
	expandPromoCode = function() {
		document.getElementById('promoDirections').className+=" visible";
		document.getElementById('expand').className+=" expanded";
hey
	}
	
	collapsePromoCode = function() {
		document.getElementById('promoDirections').className=document.getElementById('promoDirections').className.replace(new RegExp(" visible\\b"), "");
		document.getElementById('expand').className=document.getElementById('expand').className.replace(new RegExp(" expanded\\b"), "");
hey
	}
	
	//Returns true if 'currentClass' is in 'element'
	//returns false otherwise.
	hasClass = function(element, currentClass) {
		var found = false;
		if (element && element.className) { //check to see if the element even has a classname attribute
			var classes = element.className.split(" ");
			
			//find the class in the className
			for (var i=0; i < classes.length; i++) {
				if (classes[i] == currentClass) {
					found = true;
					break;
hey
				}
hey
			}
hey
		}
		return found;
hey
	}
	
	//Returns an array of elements containing the supplied classname
	//Uses hasClass so it wiil find elements with multiple class names
	//takes an array so pass it document.elements or form.elements
	getElementsByClass = function(elements, currentClass)
	{
		var classElements = new Array();
		for (var i=0; i < elements.length; i++)
		{
			if (hasClass(elements[i], currentClass))
			{
				classElements.push(elements[i]);
hey
			}
hey
		}
		return classElements;
hey
	}
	
	/*************************************************************************
	* Given the select box, set all its contents to null,
	* thus removing all of the options.
	*
	* @param selectBox - the select box object we are emptying
	*************************************************************************/
	emptyOptions = function(selectBox){
		var length = selectBox.options.length;
		while( length > 0 ){
			selectBox.options[0] = null;
			length = selectBox.options.length;
hey
		}
		return true;
hey
	}
	
	/*************************************************************************
	* Given the select box, fill it from the given array
	*
	* @param selectBox - the select box we are filling
	* @param objArray - array of objects we are putting in the select box
	* The objects in this array should be it's own array with a Name - Value pair
	* Example would be passing Hertz, ZE to show an option with the HTML equivilant as:
	* <option value="ZE">Hertz</option>
	*************************************************************************/
	populateOptions = function(selectBox, objArray, selectValue){
		var length = selectBox.options.length;
		if( length > 0 ){
			emptyOptions(selectBox);
hey
		}
		for( i=0; i < objArray.length; i++ ){
			selectBox.options[i] = new Option(objArray[i][0],objArray[i][1]);
			
			if(objArray[i][1] == selectValue){
				selectBox.options[i].selected = true;
hey
			}
hey
		}
		return true;
hey
	}
	/*************************************************************************
	* Hide the loaded div
	* @param status - 1 or 0
	* Fix for Bug 58614
	*************************************************************************/
	var closeFlag=0
	closeit = function(status){
		if(status==0 && closeFlag==0){
			var objDiv = document.getElementById("dwindow");
			var objDiv1 = document.getElementById("discountWindow");
			var objDiv2 = document.getElementById("learnMoreWindow");
			if(objDiv !=null)
			document.getElementById("dwindow").style.display="none";
			if(objDiv1 !=null)
			objDiv1.style.display="none";
			if(objDiv2 !=null)
			objDiv2.style.display="none";
			
hey
		}
		else if(status==1){
			closeFlag=1
hey
		}
		else{
			closeFlag=0
hey
		}
hey
	}
	
	/*************************************************************************
	* Check or clear a group of checkboxes
	*
	* @param containerId - The id of a parent object of all the checkboxes
	* @param groupName - The value of the name attribute of the checkboxes
	* @param checkedStatus - Boolean value to be assigned to the checked property
	*
	*************************************************************************/
	
	setAllCheckboxes = function(containerId, groupName, checkedStatus) {
		var inputs = document.getElementById(containerId).getElementsByTagName("input");
		for (var i=0; i<inputs.length; i++) {
			if (inputs[i].type == "checkbox" && (!inputs[i].disabled) ) {
				inputs[i].checked = checkedStatus;
hey
			}
hey
		}
hey
	}
	
	/*************added for group selection support throughout the TP site ***************/
	//<%-- enable/disble assign groups controls. Same code is used on addEditEditExceptionCodes.jsp possibly could be refactor into one include --%>
	toggleListSelects = function(interactiveState)
	{
		if (interactiveState == "off")
		{
			disableLinks();
			document.getElementById('assignedGroupsList').disabled = true;
			document.getElementById('unassignedGroupsList').disabled = true;
			document.getElementById('addLink').style.color = "#aaa";
			document.getElementById('removeLink').style.color = "#aaa";
			document.getElementById('addLink').style.color = "#aaa";
			document.getElementById('assignedGroupsListLabel').style.color = "#aaa";
			document.getElementById('unassignedGroupsListLabel').style.color = "#aaa";
hey
		}
		if (interactiveState == "on")
		{
			enableLinks();
			document.getElementById('assignedGroupsList').disabled = false;
			document.getElementById('unassignedGroupsList').disabled = false;
			document.getElementById('addLink').style.color = "";
			document.getElementById('removeLink').style.color = "";
			document.getElementById('assignedGroupsListLabel').style.color = "#000";
			document.getElementById('unassignedGroupsListLabel').style.color = "#000";
hey
		}
hey
	}
	//<%-- attach move functions --%>
	enableLinks = function()
	{
		if(document.getElementById('addLink')) {
			document.getElementById('addLink').onclick = enableAddLink;
			document.getElementById('removeLink').onclick = enableRemoveLink;
hey
		}
hey
	}
	//<%-- remove move functions --%>
	disableLinks = function()
	{
		if(document.getElementById('addLink')) {
			document.getElementById('addLink').onclick = noClick;
			document.getElementById('removeLink').onclick = noClick;
hey
		}
hey
	}
	noClick = function() {} // <%-- empty function to disable links --%>
	enableAddLink = function() //<%-- add function --%>
	{
		moveLists('unassignedGroupsList','assignedGroupsList');
hey
	}
	enableRemoveLink = function() //<%-- remove function --%>
	{
		moveLists('assignedGroupsList','unassignedGroupsList');
hey
	}
	enableMoveLists = function()
	{
		submitActions('assignedGroupsList','assignedGroups');
hey
	}
	
	toggleAnswersList = function(interactiveState){
		
		var signs = document.getElementsByClassName('handle');
		var questionActive = document.getElementsByClassName('questionActive');
		var counter = document.getElementsByClassName('counter');
		
		if (interactiveState == 'off') {
			
			$('hideRevealLinks').style.visibility = "hidden";
			
			var changeList = document.getElementsByClassName("hrReveal",$('questionsList'));
			for (var i=0; i<changeList.length;i++) {
				changeList[i].removeClassName("hrReveal");
				changeList[i].addClassName("hrHide");
hey
			}
			
			for (var i = 0; i < signs.length; i++) {
				signs[i].hide();
hey
			}
			
			for (var i = 0; i < questionActive.length; i++) {
				questionActive[i].hide();
hey
			}
			
			for (var i = 0; i < counter.length; i++) {
				counter[i].hide();
hey
			}
hey
		}
		else {
			
			$('hideRevealLinks').style.visibility = "visible";
			
			for (var i = 0; i < signs.length; i++) {
				signs[i].show();
hey
			}
			
			for (var i = 0; i < questionActive.length; i++) {
				questionActive[i].show();
hey
			}
			
			for (var i = 0; i < counter.length; i++) {
				counter[i].show();
hey
			}
			
hey
		}
hey
	}
	
	submitActions = function(selectId,listId) {
		var e = document.getElementById(selectId);
		var list = "";
		for (var i = 0; i < e.options.length; i++) {
			list+= e.options[i].value + ",";
hey
		}
		document.getElementById(listId).value = list;
hey
	}
	
	// Return the available content width space in browser window
	getInsideWindowWidth = function() {
		if (window.innerWidth) {
			return window.innerWidth;
		} else if (isIE6CSS) {
		// measure the html element's clientWidth
			return document.body.parentElement.clientWidth
		} else if (document.body && document.body.clientWidth) {
			return document.body.clientWidth;
hey
		}
		return 0;
hey
	}
	
	// Return the available content height space in browser window
	getInsideWindowHeight = function() {
		if (window.innerHeight) {
			return window.innerHeight;
		} else if (isIE6CSS) {
		// measure the html element's clientHeight
			return document.body.parentElement.clientHeight
		} else if (document.body && document.body.clientHeight) {
			return document.body.clientHeight;
hey
		}
		return 0;
hey
	}
	
	popupPosition = function(event){
		
		var browserWidth = 0;
		browserHeight = 0;
		
		if( typeof( window.innerWidth ) == 'number' ) {
		//Non-IE
			browserWidth = window.innerWidth;
			browserHeight = window.innerHeight;
		} else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
		//IE 6+ in 'standards compliant mode'
			browserWidth = document.documentElement.clientWidth;
			browserHeight = document.documentElement.clientHeight;
		} else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
		//IE 4 compatible
			browserWidth = document.body.clientWidth;
			browserHeight = document.body.clientHeight;
hey
		}
		
		// Determine scrollbar position
		var scrollX = 0, scrollY = 0;
		if( typeof( window.pageYOffset ) == 'number' ) {
		//Netscape compliant
			scrollY = window.pageYOffset;
			scrollX = window.pageXOffset;
		} else if( document.body && ( document.body.scrollLeft || document.body.scrollTop ) ) {
		//DOM compliant
			scrollY = document.body.scrollTop;
			scrollX = document.body.scrollLeft;
		} else if( document.documentElement && ( document.documentElement.scrollLeft || document.documentElement.scrollTop ) ) {
		//IE6 standards compliant mode
			scrollY = document.documentElement.scrollTop;
			scrollX = document.documentElement.scrollLeft;
hey
		}
		
		//Determine window position based on browser and scrollbar calculations
		windowLeft=scrollX;
		windowTop=scrollY;
		windowRight=browserWidth+scrollX;
		windowBottom=browserHeight+scrollY;
		
		// Determine x and y position of mouseclick
		clickX = event.clientX;
		clickY = event.clientY;
		
		// Default popup position relative to link
		popupDefaultOffsetX=50;
		popupDefaultOffsetY=-50;
		
		// Popup dimensions
		popupWidth = 295;
		popupHeight = 350;
		
		// Determine default position of popup based on link and relative position
		popupX=clickX+popupDefaultOffsetX+scrollX;
		popupY=clickY+popupDefaultOffsetY+scrollY;
		
		// Exception cases: Modify position of popup based on window constraints
		if(popupX + popupWidth > windowRight) {
			popupX=clickX-(popupDefaultOffsetX + popupWidth);
hey
		}
		if(popupX < windowLeft) {
			popupX=windowLeft+50;
hey
		}
		if((popupY+popupHeight) > windowBottom) {
			popupY=windowBottom-(popupHeight+25);
hey
		}
		if(popupY < windowTop) {
			popupY=scrollY;
hey
		}
		
		offX=popupX;
		offY=popupY;
		
hey
	}
	
	loadwindowBMSM = function(url,offset,link){
		if (!ie5&&!ns6)
		window.open(url,"","scrollbars=1")
		else{
			document.getElementById(link).style.display=''
			document.getElementById(link).style.width=295+"px"
			document.getElementById(link).style.height=400+"px"
			document.getElementById(link).style.left=offX+"px"
			document.getElementById(link).style.top=offY-offset+"px"
			if(link == 'discountWindow'){
				document.getElementById("contentFrame").src=url;
hey
			}
			else {
				document.getElementById("learnMoreContentFrame").src=url
				document.getElementById(link).style.width=355+"px"
				document.getElementById(link).style.height=332+"px"
				
hey
			}
hey
		}
hey
	}
	
	// this simple function is used to switch tabbed content areas
	changeTab = function(tabName, controlId) {
		$(controlId).className="";
		$(controlId).addClassName(tabName);
hey
	}
