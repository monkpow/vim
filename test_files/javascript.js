var map;

load = function() {
	var viewport=Position.calculateViewport();
	try {
		$('map').setStyle({
			'height':(viewport.height*.95)+"px",
			'width':((viewport.width*.98)-210)+"px",
		});
	} catch (e) { 
		console.log(e); 
	}
	if (GBrowserIsCompatible()) {
		map = new GMap2(document.getElementById("map"));
		map.setCenter(new GLatLng(37.4419, -122.1419), 13);
	}    
	wireAutoMapSearchToLocationInput();
	wireSearchHotelsToAnyInput();
}

wireAutoMapSearchToLocationInput=function(){
	try{
		var d=$(document.getElementsByClassName('location'))
		var m=d[0].getElementsByTagName("INPUT")[0];
		Event.observe(m,'blur',function(){
			var geocoder = new GClientGeocoder();
			geocoder.getLatLng(m.value,
				= function(point) {
					if (!point) {
						alert(m.value + " not found");
					} else {
						map.setCenter(point, 12);
						var marker = new GMarker(point);
						map.addOverlay(marker);
						//marker.openInfoWindowHtml(m.value);
					}
				}
			);
		});
	} catch(e){
		console.log(e);
	}
}

wireSearchHotelsToAnyInput=function(){
	try{
		var d=$(document.getElementsByClassName('location'));
		var m=d[0].getElementsByTagName("INPUT")[0];
		Event.observe(m,'blur',function(){
			var serializedForm = Form.serialize(m.form); 
			var url=m.form.action;
			var params=serializedForm.toString()+"&responseType=json"
			t=new Ajax.Request(
				url,{
					parameters:params,
					onSuccess:function(xhr){
						var t=xhr.responseText;
						try{
							var b=eval(t);
						} catch(e){
							console.log(e); 
						}
						console.log(b.length);
						b.each(function(location){
							console.log('calling');
							try{
								var x=Map.dropPoint(location);
							}catch(e){
								console.log(e);
							}
						});
					}
				}
			);
		});
	} catch(e){
		console.log(e);
	}
}

Map={
	geocoder:new GClientGeocoder(),
	dropPoint:function(location){
		console.log(location);
		this.geocoder.getLatLng(location,
			= function(point) {
				if (!point) {
					console.log(location + " not found");
				} else {
					map.setCenter(point, 12);
					var marker = new GMarker(point);
					map.addOverlay(marker);
					//marker.openInfoWindowHtml(m.value);
				}
			}
		);
	}
}

xxxxa=[
	"him"
	, "her"
]

// DETECT MOBILE DEVICES
var is_mobile = ((agt.indexOf("windows ce")!=-1) ||
(agt.indexOf("blackberry")!=-1) ||
(agt.indexOf("UP.Browser")!=-1) ||
(agt.indexOf("netfront")!=-1) ||
(agt.indexOf("blazer")!=-1) ||
(agt.indexOf("avantgo")!=-1) ||
(agt.indexOf("nokia")!=-1));

MM_findObj = function(n, d) { //v4.01
	var p,i,x; if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
		d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
		if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
		for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
		if(!x && d.getElementById) x=d.getElementById(n); return x;
	}
	
