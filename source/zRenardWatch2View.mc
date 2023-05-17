using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Lang;
using Toybox.Application;
using Toybox.Weather;

var weatherIcons = {};

class zRenardWatch2View extends WatchUi.WatchFace {
    hidden var ico_charge = WatchUi.loadResource(Rez.Drawables.id_charge);
	hidden var sleepMode;
	hidden var font_vlarge = WatchUi.loadResource( Rez.Fonts.id_font_vlarge );
	hidden var modeSeconds;
	hidden var delayedUpdate = 0; // First time we run, we get weather
	hidden var weatherCondition = -1;       
	
    function initialize() {
        WatchFace.initialize();
        sleepMode = false; 
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	var battery = System.getSystemStats().battery;
	    var bgC = Application.Properties.getValue("BackgroundColor");
        var modeSeconds = Application.Properties.getValue("ShowSeconds");
        var showWeather = Application.Properties.getValue("ShowWeather");
        // Update weather every X minutes
        var delayedUpdateMax = 5; //Application.Properties.getValue("WeatherRefreshRateMinutes")*60;
      	// Ensure that we reduce current delay
      	// On reverse, it's not necessary, we will update 1 time more quicker, not a big deal
      	if (delayedUpdate>delayedUpdateMax) { delayedUpdate=delayedUpdateMax; }
        var weatherConditionDay = Application.Properties.getValue("WeatherDay");
 		var nowText = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        
        if (showWeather) { // compute weather only if needed
        	if (delayedUpdate==0 || weatherCondition==-1) {
		        var weather = Weather.getDailyForecast();
		        if (weather!= null) {	
		        	if (weatherConditionDay==3) { // Smart way to get weather
		        	 if (nowText.hour.toNumber()<12) { // Before noon
		        	 	weatherCondition=weather[1].condition; // Today weather
		        	 } else {
		        	 	weatherCondition=weather[2].condition; // Tommorow weather
		        	 }
		        	} else { // Otherwise we rely on settings (Today or Tommorow)
		        		weatherCondition=weather[weatherConditionDay].condition;
		        	}
		        }
		        delayedUpdate=delayedUpdateMax;
	        } else { // Used to reduce the update rate of the weather
	         	delayedUpdate=delayedUpdate-1;
		    }  
		}
        
    	dc.setColor(bgC,bgC);
    	dc.clearClip();
		dc.clear();
        if (dc has :setAntiAlias ) { dc.setAntiAlias(true); }
    	if ( !sleepMode ||
    		 ( sleepMode && !Application.Properties.getValue("UltraSleepMode") ) ||
    		 ( sleepMode && (Application.Properties.getValue("UltraSleepMode") &&
    		   				 battery>Application.Properties.getValue("BatteryLevelCritical")
    		 				)
    		 )
    		) {
	    	var width = dc.getWidth();
	    	var height = dc.getHeight();
	    	var showMove = Application.Properties.getValue("ShowMove");
	    	var moveDisplayType = Application.Properties.getValue("MoveDisplayType");
	    	var moveColor = Application.Properties.getValue("MoveColor");
        	var moveLevel = ActivityMonitor.getInfo().moveBarLevel;
	    	var fgHC = Application.Properties.getValue("ForegroundColorHours");
	    	var fgMC = Application.Properties.getValue("ForegroundColorMinutes");
	    	var fgSC = Application.Properties.getValue("ForegroundColorSeconds");
	    	var hlC = Application.Properties.getValue("HighLightColor");
			var hours = nowText.hour.toNumber();
	        if (!System.getDeviceSettings().is24Hour) {
				if (hours > 12) {
					hours = hours - 12;
				}
			}			
			var myHours = Lang.format("$1$",[hours.format("%d")]);
			var myMinutes = Lang.format("$1$",[nowText.min.format("%d")]);
			var mySecondes = Lang.format("$1$",[nowText.sec.format("%d")]);
			var myDay = Lang.format("$1$",[nowText.day.format("%d")]);
			
		    if (Application.Properties.getValue("LeadingZero")) {
				myHours = Lang.format("$1$",[hours.format("%02d")]);
				myMinutes = Lang.format("$1$",[nowText.min.format("%02d")]);
				mySecondes = Lang.format("$1$",[nowText.sec.format("%02d")]);
				myDay = Lang.format("$1$",[nowText.day.format("%02d")]);
			}
			
			// Activity status
			if (showMove && moveLevel>0) {
				if (moveDisplayType==1) {
					dc.setPenWidth(Application.Properties.getValue("MoveWidth")*2);
					dc.setColor(moveColor, Graphics.COLOR_TRANSPARENT);
					dc.drawArc(width / 2, height / 2, (width / 2)-1,Graphics.ARC_CLOCKWISE,90,90-72*moveLevel);
					dc.setPenWidth(1);
				}
				if (moveDisplayType==2) {
					drawPoly(dc,(width/4)+20, (height/6), 13, -Math.PI / 2, moveColor, Application.Properties.getValue("MoveWidth"), 5, moveLevel);
				}
			}
			
			// Hours
			dc.setColor(fgHC,Graphics.COLOR_TRANSPARENT);  		
			dc.drawText( (width / 2)-45, (height/2)-Graphics.getFontHeight(font_vlarge)/2, font_vlarge,myHours, Graphics.TEXT_JUSTIFY_CENTER);
			// Minutes
			dc.setColor(fgMC,Graphics.COLOR_TRANSPARENT);  		
			dc.drawText( (width / 2)+40+20, (height/2)-20-Graphics.getFontHeight(Graphics.FONT_SYSTEM_NUMBER_HOT)/2, Graphics.FONT_NUMBER_HOT, myMinutes, Graphics.TEXT_JUSTIFY_CENTER);
			// Secondes
			if (modeSeconds&&!sleepMode) {
				dc.setColor(fgSC,Graphics.COLOR_TRANSPARENT);
				dc.drawText( (width / 2)+40+30, (height/2)+28-Graphics.getFontHeight(Graphics.FONT_NUMBER_MILD )/2, Graphics.FONT_NUMBER_MILD , mySecondes, Graphics.TEXT_JUSTIFY_CENTER);
			}
			
			// Separator between Hours and others data
			dc.setColor(Application.Properties.getValue("VerticalLineColor"),Graphics.COLOR_TRANSPARENT);
	    	dc.fillRectangle((width / 2)+17, 0, Application.Properties.getValue("VerticalLineWidth"), height);
	
			dc.setColor(hlC ,Graphics.COLOR_TRANSPARENT);
			if (!sleepMode || (sleepMode && !Application.Properties.getValue("UseSleepMode"))) {
				// Date if not in sleep mode (or sleep mode desactivated)
				//dc.drawText( (width / 2), (height /2)+60-20, Graphics.FONT_TINY, nowText.day_of_week+" "+myDay+" "+nowText.month+" "+nowText.year, Graphics.TEXT_JUSTIFY_CENTER);

				if (modeSeconds) {
					dc.drawText( (width / 4)+20, 5+height-(height /4), Graphics.FONT_XTINY, nowText.day_of_week+" "+myDay+" "+nowText.month, Graphics.TEXT_JUSTIFY_CENTER);
					dc.drawText( (width / 4)+20, 5+height-(height /4)+Graphics.getFontHeight(Graphics.FONT_XTINY), Graphics.FONT_XTINY, nowText.year.toString(), Graphics.TEXT_JUSTIFY_CENTER);
				} else {
					dc.drawText( width-(width / 4), (height /2)+10, Graphics.FONT_XTINY, nowText.day_of_week+" "+myDay+" "+nowText.month, Graphics.TEXT_JUSTIFY_CENTER);
					dc.drawText( width-(width / 4), (height /2)+10+Graphics.getFontHeight(Graphics.FONT_XTINY), Graphics.FONT_XTINY, nowText.year.toString(), Graphics.TEXT_JUSTIFY_CENTER);
				}

				var battery_level=0;
				if (battery>=0 && battery<=12.5) { battery_level=1;} // 1 line  - 0-12.5
				if (battery>12.5 && battery<=25) { battery_level=2;} // 2 lines - 12.5-25
				if (battery>25 && battery<=37.5) { battery_level=3;} // 3 lines - 25-37.5
	    		if (battery>37.5 && battery<=50) { battery_level=4;} // 4 lines - 37.5-50
				if (battery>50 && battery<=62.5) { battery_level=5;} // 5 lines - 50-62.5
				if (battery>62.5 && battery<=75) { battery_level=6;} // 6 lines - 62.5-75
				if (battery>75 && battery<=87.5) { battery_level=7;} // 7 lines - 75-87.5
				if (battery>87.5 && battery<=100) { battery_level=8;} // 8 lines - 87.5-100
	
		        var textBattery = (battery + 0.5).toNumber();
	        	if (battery <=Application.Properties.getValue("BatteryLevelCritical")) {
		        	dc.setColor(Application.Properties.getValue("BatteryColor"), Graphics.COLOR_TRANSPARENT);
		        	dc.drawText(width-(width / 4), (3*height/4)+4, Graphics.FONT_TINY, textBattery.toString(), Graphics.TEXT_JUSTIFY_CENTER);
	    	    }
		        if (battery <=Application.Properties.getValue("BatteryLevel") || System.getSystemStats().charging ) {
		        	drawPoly(dc,width-(width / 4),(3*height/4)+17,16,-((Math.PI*2)/8)*2.5,Application.Properties.getValue("BatteryIconColor"), Application.Properties.getValue("BatteryIconWidth"),8,battery_level);
		        }
		
		        if (System.getSystemStats().charging ) {
					dc.drawBitmap((width / 2)-20/2, height-20, ico_charge);
		        } else {
		         if (showWeather) {
		         	var defaultConditionIcon = 53; // default icon ? for unknow weather
		         	var conditionIcon = weatherCondition;
		         	if (Application.Properties.getValue("WeatherIconColor")==0) { //Black icon
		         		conditionIcon=conditionIcon+100;
		         		defaultConditionIcon=defaultConditionIcon+100;
		         	}
		         	var ico_weather = weatherIcons.get(conditionIcon);
		         	if (ico_weather==null) {
						ico_weather = weatherIcons.get(defaultConditionIcon);
					}
					dc.drawBitmap((width / 2)-20/2, height-20, ico_weather);		         
		         }
		        }
		        
		        if (Application.Properties.getValue("ShowNotification")) {
					var notification = System.getDeviceSettings().notificationCount;
					if (notification > 0) {
						drawPoly(dc,width-(width / 4),(height/6)+7,16,-((Math.PI*2)/8)*2.5,Application.Properties.getValue("NotificationIconColor"),Application.Properties.getValue("NotificationIconWidth"),8,notification);
						if (notification>=8) {
							dc.setColor(Application.Properties.getValue("NotificationColor"), Graphics.COLOR_TRANSPARENT);
							dc.drawText(width-(width / 4), 18+15, Graphics.FONT_TINY, notification.toString(), Graphics.TEXT_JUSTIFY_CENTER);
						}
					}
				}
			}
		}
    }

	function onPartialUpdate(dc) {	
	    var modeSeconds = Application.Properties.getValue("ShowSeconds");
		if (sleepMode && modeSeconds) {
		 	var nowText = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
			var mySecondes = Lang.format("$1$",[nowText.sec.format("%d")]);
			if (Application.Properties.getValue("LeadingZero")) {
				mySecondes = Lang.format("$1$",[nowText.sec.format("%02d")]);
			}	
			// Seconds
	    	var width = dc.getWidth();
			var height = dc.getHeight();
	    	var fgSC = Application.Properties.getValue("ForegroundColorSeconds");
			var bgC = Application.Properties.getValue("BackgroundColor");
		
			dc.setClip((width / 2)+45,(height/2)+15,45,Graphics.getFontHeight(Graphics.FONT_NUMBER_MILD )+5);
			dc.clear();
//			dc.setColor(Graphics.COLOR_PINK,bgC);
//			dc.drawRectangle((width / 2)+45,(height/2)+15,45,Graphics.getFontHeight(Graphics.FONT_NUMBER_MILD )+5);
			dc.setColor(fgSC,bgC);
			dc.drawText( (width / 2)+40+30, (height/2)+28-Graphics.getFontHeight(Graphics.FONT_NUMBER_MILD )/2, Graphics.FONT_NUMBER_MILD , mySecondes, Graphics.TEXT_JUSTIFY_CENTER);
		}
	}
	
	function drawPoly(dc,x,y,radius,rotation,color,width,numberOfSides,numberDisplayed) {
		// Activity status
		var angle = (Math.PI*2)/numberOfSides;
		var x1 = x +  radius*Math.cos(0+rotation);
		var y1 =  y +  radius*Math.sin(0+rotation);
		var x2 = 10;
		var y2 = 10;
		
		dc.setPenWidth(width);
		dc.setColor(color ,Graphics.COLOR_TRANSPARENT);
		for (var i = 1; i <= numberOfSides && i<=numberDisplayed; i += 1 ) {
			x2=Math.cos(i*angle+rotation) * radius + x;
			y2=Math.sin(i*angle+rotation) * radius + y;
			dc.drawLine(x1, y1, x2, y2);
			x1=x2;
			y1=y2;
		}	
    }
	
    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
		sleepMode = false;    
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
		sleepMode = true;
    }

}
