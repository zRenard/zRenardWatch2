using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Lang;
using Toybox.Application;

class zRenardWatch2View extends WatchUi.WatchFace {
//    hidden var ico_msg;
    hidden var ico_bat1; // 1 line  - 0-12.5
    hidden var ico_bat2; // 2 lines - 12.5-25
    hidden var ico_bat3; // 3 lines - 25-37.5
    hidden var ico_bat4; // 4 lines - 37.5-50
    hidden var ico_bat5; // 5 lines - 50-62.5
    hidden var ico_bat6; // 6 lines - 62.5-75
    hidden var ico_bat7; // 7 lines - 75-87.5
    hidden var ico_bat8; // 8 lines - 87.5-100
    hidden var ico_charge;
	hidden var sleepMode;
	hidden var font_vlarge;
	hidden var modeSeconds;

    function initialize() {
        WatchFace.initialize();
//        ico_msg = WatchUi.loadResource(Rez.Drawables.id_msg);
        ico_charge = WatchUi.loadResource(Rez.Drawables.id_charge);
        ico_bat1 = WatchUi.loadResource(Rez.Drawables.id_bat1);
        ico_bat2 = WatchUi.loadResource(Rez.Drawables.id_bat2);
        ico_bat3 = WatchUi.loadResource(Rez.Drawables.id_bat3);
        ico_bat4 = WatchUi.loadResource(Rez.Drawables.id_bat4);
        ico_bat5 = WatchUi.loadResource(Rez.Drawables.id_bat5);
        ico_bat6 = WatchUi.loadResource(Rez.Drawables.id_bat6);
        ico_bat7 = WatchUi.loadResource(Rez.Drawables.id_bat7);
        ico_bat8 = WatchUi.loadResource(Rez.Drawables.id_bat8);
        font_vlarge = WatchUi.loadResource( Rez.Fonts.id_font_vlarge );
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
	    var bgC = Application.getApp().getProperty("BackgroundColor");
        var modeSeconds = Application.getApp().getProperty("ShowSeconds");
        
    	dc.setColor(bgC,bgC);
    	dc.clearClip();
		dc.clear();
        dc.setAntiAlias(true);  
    	if ( !sleepMode ||
    		 ( sleepMode && !Application.getApp().getProperty("UltraSleepMode") ) ||
    		 ( sleepMode && (Application.getApp().getProperty("UltraSleepMode") &&
    		   				 battery>Application.getApp().getProperty("BatteryLevelCritical")
    		 				)
    		 )
    		) {
	    	var width = dc.getWidth();
	    	var height = dc.getHeight();
	    	var showMove = Application.getApp().getProperty("ShowMove");
	    	var moveDisplayType = Application.getApp().getProperty("MoveDisplayType");
	    	var moveColor = Application.getApp().getProperty("MoveColor");
        	var moveLevel = ActivityMonitor.getInfo().moveBarLevel;
	    	var fgC = Application.getApp().getProperty("ForegroundColor");
	    	var fgHC = Application.getApp().getProperty("ForegroundColorHours");
	    	var fgMC = Application.getApp().getProperty("ForegroundColorMinutes");
	    	var fgSC = Application.getApp().getProperty("ForegroundColorSeconds");
	    	var hlC = Application.getApp().getProperty("HighLightColor");
	 		var now = new Time.Moment(Time.today().value());
	 		var nowText = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
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
			
		    if (Application.getApp().getProperty("LeadingZero")) {
				myHours = Lang.format("$1$",[hours.format("%02d")]);
				myMinutes = Lang.format("$1$",[nowText.min.format("%02d")]);
				mySecondes = Lang.format("$1$",[nowText.sec.format("%02d")]);
				myDay = Lang.format("$1$",[nowText.day.format("%02d")]);
			}
			
			// Activity status
			if (showMove && moveLevel>0) {
				if (moveDisplayType==1) {
					dc.setPenWidth(2);
					dc.setColor(moveColor, Graphics.COLOR_TRANSPARENT);
					dc.drawArc(width / 2, height / 2, (width / 2)-2,Graphics.ARC_CLOCKWISE,90,90-72*moveLevel);
					dc.setPenWidth(1);
				}
				if (moveDisplayType==2) {
					drawPoly(dc,(width/4)+20, (height/6), 13, -Math.PI / 2, moveColor, 2, 6, moveLevel);
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
			dc.setColor(Graphics.COLOR_WHITE ,Graphics.COLOR_TRANSPARENT);
	    	dc.fillRectangle((width / 2)+17, 0, 2, height);
	
			dc.setColor(hlC ,Graphics.COLOR_TRANSPARENT);
			if (!sleepMode || (sleepMode && !Application.getApp().getProperty("UseSleepMode"))) {
				// Date if not in sleep mode (or sleep mode desactivated)
				//dc.drawText( (width / 2), (height /2)+60-20, Graphics.FONT_TINY, nowText.day_of_week+" "+myDay+" "+nowText.month+" "+nowText.year, Graphics.TEXT_JUSTIFY_CENTER);

				if (modeSeconds) {
					dc.drawText( (width / 4)+20, 5+height-(height /4), Graphics.FONT_XTINY, nowText.day_of_week+" "+myDay+" "+nowText.month, Graphics.TEXT_JUSTIFY_CENTER);
					dc.drawText( (width / 4)+20, 5+height-(height /4)+Graphics.getFontHeight(Graphics.FONT_XTINY), Graphics.FONT_XTINY, nowText.year, Graphics.TEXT_JUSTIFY_CENTER);
				} else {
					dc.drawText( width-(width / 4), (height /2)+10, Graphics.FONT_XTINY, nowText.day_of_week+" "+myDay+" "+nowText.month, Graphics.TEXT_JUSTIFY_CENTER);
					dc.drawText( width-(width / 4), (height /2)+10+Graphics.getFontHeight(Graphics.FONT_XTINY), Graphics.FONT_XTINY, nowText.year, Graphics.TEXT_JUSTIFY_CENTER);
				}

				// @TODO : Draw it instead of images. it will help handling colors.
				var ico_bat = ico_bat8;
				if (battery>=0 && battery<=12.5) { ico_bat = ico_bat1; } // 1 line  - 0-12.5
				if (battery>12.5 && battery<=25) { ico_bat = ico_bat2; } // 2 lines - 12.5-25
				if (battery>25 && battery<=37.5) { ico_bat = ico_bat3; } // 3 lines - 25-37.5
	    		if (battery>37.5 && battery<=50) { ico_bat = ico_bat4; } // 4 lines - 37.5-50
				if (battery>50 && battery<=62.5) { ico_bat = ico_bat5; } // 5 lines - 50-62.5
				if (battery>62.5 && battery<=75) { ico_bat = ico_bat6; } // 6 lines - 62.5-75
				if (battery>75 && battery<=87.5) { ico_bat = ico_bat7; } // 7 lines - 75-87.5
				if (battery>87.5 && battery<=100) { ico_bat = ico_bat8; } // 8 lines - 87.5-100
	
		        var textBattery = (battery + 0.5).toNumber();
	        	if (battery <=Application.getApp().getProperty("BatteryLevelCritical")) {
		        	dc.setColor(fgC, Graphics.COLOR_TRANSPARENT);
		        	dc.drawText(width-(width / 4), (3*height/4)+4, Graphics.FONT_TINY, textBattery.toString(), Graphics.TEXT_JUSTIFY_CENTER);
	    	    }
		        if (battery <=Application.getApp().getProperty("BatteryLevel") || System.getSystemStats().charging ) {
		        	dc.setColor(fgC, Graphics.COLOR_TRANSPARENT);
		        	// Octogone = 100/8=12.5 step for bat level
		        	dc.drawBitmap(width-(width / 4)-(34/2), 3*height/4, ico_bat);
		        }
		
		        if (System.getSystemStats().charging ) {
					dc.drawBitmap((width / 2)-20/2, height-20, ico_charge);
		        }
		        
		        if (Application.getApp().getProperty("ShowNotification")) {
					var notification = System.getDeviceSettings().notificationCount;
					if (notification > 0) {
						var ico_msg = ico_bat8;
						if (notification==1) { ico_msg = ico_bat1; }
						if (notification==2) { ico_msg = ico_bat2; }
						if (notification==3) { ico_msg = ico_bat3; }
			    		if (notification==4) { ico_msg = ico_bat4; }
						if (notification==5) { ico_msg = ico_bat5; }
						if (notification==6) { ico_msg = ico_bat6; }
						if (notification==7) { ico_msg = ico_bat7; }
						if (notification==8) { ico_msg = ico_bat8; }
						dc.drawBitmap(width-(width / 4)-(34/2), 15+15, ico_msg);
						if (notification>=8) {
							dc.setColor(fgC, Graphics.COLOR_TRANSPARENT);
							dc.drawText(width-(width / 4), 18+15, Graphics.FONT_TINY, notification, Graphics.TEXT_JUSTIFY_CENTER);
						}
					}
				}
			}
		}
    }

	function onPartialUpdate(dc) {
	    var modeSeconds = Application.getApp().getProperty("ShowSeconds");
		if (sleepMode && modeSeconds) {
			var now = new Time.Moment(Time.today().value());
		 	var nowText = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
			var mySecondes = Lang.format("$1$",[nowText.sec.format("%d")]);
			if (Application.getApp().getProperty("LeadingZero")) {
				mySecondes = Lang.format("$1$",[nowText.sec.format("%02d")]);
			}	
			// Secondes
	    	var width = dc.getWidth();
			var height = dc.getHeight();
	    	var fgSC = Application.getApp().getProperty("ForegroundColorSeconds");
			var bgC = Application.getApp().getProperty("BackgroundColor");
		
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
