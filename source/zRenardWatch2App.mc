using Toybox.Application;
using Toybox.WatchUi;

class zRenardWatch2App extends Application.AppBase {

    function initialize() {
        AppBase.initialize();        
        // White icons : Some are duplicated
        weatherIcons.put(0,WatchUi.loadResource(Rez.Drawables.id_w0));
        weatherIcons.put(1,WatchUi.loadResource(Rez.Drawables.id_w1));
        weatherIcons.put(2,WatchUi.loadResource(Rez.Drawables.id_w2));
        weatherIcons.put(3,WatchUi.loadResource(Rez.Drawables.id_w3));
        weatherIcons.put(4,WatchUi.loadResource(Rez.Drawables.id_w4));
        weatherIcons.put(5,WatchUi.loadResource(Rez.Drawables.id_w5));
        weatherIcons.put(6,WatchUi.loadResource(Rez.Drawables.id_w6));
        weatherIcons.put(7,WatchUi.loadResource(Rez.Drawables.id_w50));
        weatherIcons.put(8,WatchUi.loadResource(Rez.Drawables.id_w8));
        weatherIcons.put(9,WatchUi.loadResource(Rez.Drawables.id_w8));
        weatherIcons.put(10,WatchUi.loadResource(Rez.Drawables.id_w10));
        weatherIcons.put(11,WatchUi.loadResource(Rez.Drawables.id_w11));
        weatherIcons.put(12,WatchUi.loadResource(Rez.Drawables.id_w12));
        weatherIcons.put(13,WatchUi.loadResource(Rez.Drawables.id_w13));
        weatherIcons.put(14,WatchUi.loadResource(Rez.Drawables.id_w14));
        weatherIcons.put(15,WatchUi.loadResource(Rez.Drawables.id_w15));
        weatherIcons.put(16,WatchUi.loadResource(Rez.Drawables.id_w16));
        weatherIcons.put(17,WatchUi.loadResource(Rez.Drawables.id_w17));
        weatherIcons.put(18,WatchUi.loadResource(Rez.Drawables.id_w14));
        weatherIcons.put(19,WatchUi.loadResource(Rez.Drawables.id_w15));
        weatherIcons.put(20,WatchUi.loadResource(Rez.Drawables.id_w1));
        weatherIcons.put(21,WatchUi.loadResource(Rez.Drawables.id_w50));
        weatherIcons.put(22,WatchUi.loadResource(Rez.Drawables.id_w1));
        weatherIcons.put(23,WatchUi.loadResource(Rez.Drawables.id_w23));
        weatherIcons.put(24,WatchUi.loadResource(Rez.Drawables.id_w14));
        weatherIcons.put(25,WatchUi.loadResource(Rez.Drawables.id_w3));
        weatherIcons.put(26,WatchUi.loadResource(Rez.Drawables.id_w15));
        weatherIcons.put(27,WatchUi.loadResource(Rez.Drawables.id_w3));
        weatherIcons.put(28,WatchUi.loadResource(Rez.Drawables.id_w6));
        weatherIcons.put(29,WatchUi.loadResource(Rez.Drawables.id_w8));
        weatherIcons.put(30,WatchUi.loadResource(Rez.Drawables.id_w8));
        weatherIcons.put(31,WatchUi.loadResource(Rez.Drawables.id_w14));
        weatherIcons.put(32,WatchUi.loadResource(Rez.Drawables.id_w32));
        weatherIcons.put(33,WatchUi.loadResource(Rez.Drawables.id_w33));
        weatherIcons.put(34,WatchUi.loadResource(Rez.Drawables.id_w34));
        weatherIcons.put(35,WatchUi.loadResource(Rez.Drawables.id_w37));
        weatherIcons.put(36,WatchUi.loadResource(Rez.Drawables.id_w5));
        weatherIcons.put(37,WatchUi.loadResource(Rez.Drawables.id_w37));
        weatherIcons.put(38,WatchUi.loadResource(Rez.Drawables.id_w33));
        weatherIcons.put(39,WatchUi.loadResource(Rez.Drawables.id_w8));
        weatherIcons.put(40,WatchUi.loadResource(Rez.Drawables.id_w1));
        weatherIcons.put(41,WatchUi.loadResource(Rez.Drawables.id_w41));
        weatherIcons.put(42,WatchUi.loadResource(Rez.Drawables.id_w42));
        weatherIcons.put(43,WatchUi.loadResource(Rez.Drawables.id_w4));
        weatherIcons.put(44,WatchUi.loadResource(Rez.Drawables.id_w50));
        weatherIcons.put(45,WatchUi.loadResource(Rez.Drawables.id_w14));
        weatherIcons.put(46,WatchUi.loadResource(Rez.Drawables.id_w4));
        weatherIcons.put(47,WatchUi.loadResource(Rez.Drawables.id_w50));
        weatherIcons.put(48,WatchUi.loadResource(Rez.Drawables.id_w14));
        weatherIcons.put(49,WatchUi.loadResource(Rez.Drawables.id_w50));
        weatherIcons.put(50,WatchUi.loadResource(Rez.Drawables.id_w50));
        weatherIcons.put(51,WatchUi.loadResource(Rez.Drawables.id_w34));
        weatherIcons.put(52,WatchUi.loadResource(Rez.Drawables.id_w52));
        weatherIcons.put(53,WatchUi.loadResource(Rez.Drawables.id_w53));
        // Black icons
 		weatherIcons.put(100,WatchUi.loadResource(Rez.Drawables.id_b0));
        weatherIcons.put(101,WatchUi.loadResource(Rez.Drawables.id_b1));
        weatherIcons.put(102,WatchUi.loadResource(Rez.Drawables.id_b2));
        weatherIcons.put(103,WatchUi.loadResource(Rez.Drawables.id_b3));
        weatherIcons.put(104,WatchUi.loadResource(Rez.Drawables.id_b4));
        weatherIcons.put(105,WatchUi.loadResource(Rez.Drawables.id_b5));
        weatherIcons.put(106,WatchUi.loadResource(Rez.Drawables.id_b6));
        weatherIcons.put(107,WatchUi.loadResource(Rez.Drawables.id_b50));
        weatherIcons.put(108,WatchUi.loadResource(Rez.Drawables.id_b8));
        weatherIcons.put(109,WatchUi.loadResource(Rez.Drawables.id_b8));
        weatherIcons.put(110,WatchUi.loadResource(Rez.Drawables.id_b10));
        weatherIcons.put(111,WatchUi.loadResource(Rez.Drawables.id_b11));
        weatherIcons.put(112,WatchUi.loadResource(Rez.Drawables.id_b12));
        weatherIcons.put(113,WatchUi.loadResource(Rez.Drawables.id_b13));
        weatherIcons.put(114,WatchUi.loadResource(Rez.Drawables.id_b14));
        weatherIcons.put(115,WatchUi.loadResource(Rez.Drawables.id_b15));
        weatherIcons.put(116,WatchUi.loadResource(Rez.Drawables.id_b16));
        weatherIcons.put(117,WatchUi.loadResource(Rez.Drawables.id_b17));
        weatherIcons.put(118,WatchUi.loadResource(Rez.Drawables.id_b14));
        weatherIcons.put(119,WatchUi.loadResource(Rez.Drawables.id_b15));
        weatherIcons.put(120,WatchUi.loadResource(Rez.Drawables.id_b1));
        weatherIcons.put(121,WatchUi.loadResource(Rez.Drawables.id_b50));
        weatherIcons.put(122,WatchUi.loadResource(Rez.Drawables.id_b1));
        weatherIcons.put(123,WatchUi.loadResource(Rez.Drawables.id_b23));
        weatherIcons.put(124,WatchUi.loadResource(Rez.Drawables.id_b14));
        weatherIcons.put(125,WatchUi.loadResource(Rez.Drawables.id_b3));
        weatherIcons.put(126,WatchUi.loadResource(Rez.Drawables.id_b15));
        weatherIcons.put(127,WatchUi.loadResource(Rez.Drawables.id_b3));
        weatherIcons.put(128,WatchUi.loadResource(Rez.Drawables.id_b6));
        weatherIcons.put(129,WatchUi.loadResource(Rez.Drawables.id_b8));
        weatherIcons.put(130,WatchUi.loadResource(Rez.Drawables.id_b8));
        weatherIcons.put(131,WatchUi.loadResource(Rez.Drawables.id_b14));
        weatherIcons.put(132,WatchUi.loadResource(Rez.Drawables.id_b32));
        weatherIcons.put(133,WatchUi.loadResource(Rez.Drawables.id_b33));
        weatherIcons.put(134,WatchUi.loadResource(Rez.Drawables.id_b34));
        weatherIcons.put(135,WatchUi.loadResource(Rez.Drawables.id_b37));
        weatherIcons.put(136,WatchUi.loadResource(Rez.Drawables.id_b5));
        weatherIcons.put(137,WatchUi.loadResource(Rez.Drawables.id_b37));
        weatherIcons.put(138,WatchUi.loadResource(Rez.Drawables.id_b33));
        weatherIcons.put(139,WatchUi.loadResource(Rez.Drawables.id_b8));
        weatherIcons.put(140,WatchUi.loadResource(Rez.Drawables.id_b1));
        weatherIcons.put(141,WatchUi.loadResource(Rez.Drawables.id_b41));
        weatherIcons.put(142,WatchUi.loadResource(Rez.Drawables.id_b42));
        weatherIcons.put(143,WatchUi.loadResource(Rez.Drawables.id_b4));
        weatherIcons.put(144,WatchUi.loadResource(Rez.Drawables.id_b50));
        weatherIcons.put(145,WatchUi.loadResource(Rez.Drawables.id_b14));
        weatherIcons.put(146,WatchUi.loadResource(Rez.Drawables.id_b4));
        weatherIcons.put(147,WatchUi.loadResource(Rez.Drawables.id_b50));
        weatherIcons.put(148,WatchUi.loadResource(Rez.Drawables.id_b14));
        weatherIcons.put(149,WatchUi.loadResource(Rez.Drawables.id_b50));
        weatherIcons.put(150,WatchUi.loadResource(Rez.Drawables.id_b50));
        weatherIcons.put(151,WatchUi.loadResource(Rez.Drawables.id_b34));
        weatherIcons.put(152,WatchUi.loadResource(Rez.Drawables.id_b52));
        weatherIcons.put(153,WatchUi.loadResource(Rez.Drawables.id_b53));
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new zRenardWatch2View() ];
    }

    // New app settings have been received so trigger a UI update
    function onSettingsChanged() {
        WatchUi.requestUpdate();
    }

}