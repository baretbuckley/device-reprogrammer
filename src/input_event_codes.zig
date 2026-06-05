pub const Type = enum(u16) {
    Sync = 0x00,
    Key = 0x01,
    Relative = 0x02,
    Absolute = 0x03,
    Misc = 0x04,
    Switch = 0x05,
    Led = 0x11,
    Snd = 0x12,
    Rep = 0x14,
    ForceFeedback = 0x15,
    Power = 0x16,
    ForceFeedbackStatus = 0x17,
};
pub const type_max = 0x17;
pub const type_count = type_max + 1;

pub const SyncEvent = enum(u16) {
    Report = 0,
    Config = 1,
    mt_report = 2,
    dropped = 3,
};
pub const SyncEvent_max = 0xF;
pub const SyncEvent_count = SyncEvent_max + 1;

pub const KeyEvent = extern struct {
    code: u16,

    pub fn fromCode(code: u16) KeyEvent {
        return KeyEvent{ .code = code };
    }

    pub const KEY_RESERVED = fromCode(0);
    pub const KEY_ESC = fromCode(1);
    pub const KEY_1 = fromCode(2);
    pub const KEY_2 = fromCode(3);
    pub const KEY_3 = fromCode(4);
    pub const KEY_4 = fromCode(5);
    pub const KEY_5 = fromCode(6);
    pub const KEY_6 = fromCode(7);
    pub const KEY_7 = fromCode(8);
    pub const KEY_8 = fromCode(9);
    pub const KEY_9 = fromCode(10);
    pub const KEY_0 = fromCode(11);
    pub const KEY_MINUS = fromCode(12);
    pub const KEY_EQUAL = fromCode(13);
    pub const KEY_BACKSPACE = fromCode(14);
    pub const KEY_TAB = fromCode(15);
    pub const KEY_Q = fromCode(16);
    pub const KEY_W = fromCode(17);
    pub const KEY_E = fromCode(18);
    pub const KEY_R = fromCode(19);
    pub const KEY_T = fromCode(20);
    pub const KEY_Y = fromCode(21);
    pub const KEY_U = fromCode(22);
    pub const KEY_I = fromCode(23);
    pub const KEY_O = fromCode(24);
    pub const KEY_P = fromCode(25);
    pub const KEY_LEFTBRACE = fromCode(26);
    pub const KEY_RIGHTBRACE = fromCode(27);
    pub const KEY_ENTER = fromCode(28);
    pub const KEY_LEFTCTRL = fromCode(29);
    pub const KEY_A = fromCode(30);
    pub const KEY_S = fromCode(31);
    pub const KEY_D = fromCode(32);
    pub const KEY_F = fromCode(33);
    pub const KEY_G = fromCode(34);
    pub const KEY_H = fromCode(35);
    pub const KEY_J = fromCode(36);
    pub const KEY_K = fromCode(37);
    pub const KEY_L = fromCode(38);
    pub const KEY_SEMICOLON = fromCode(39);
    pub const KEY_APOSTROPHE = fromCode(40);
    pub const KEY_GRAVE = fromCode(41);
    pub const KEY_LEFTSHIFT = fromCode(42);
    pub const KEY_BACKSLASH = fromCode(43);
    pub const KEY_Z = fromCode(44);
    pub const KEY_X = fromCode(45);
    pub const KEY_C = fromCode(46);
    pub const KEY_V = fromCode(47);
    pub const KEY_B = fromCode(48);
    pub const KEY_N = fromCode(49);
    pub const KEY_M = fromCode(50);
    pub const KEY_COMMA = fromCode(51);
    pub const KEY_DOT = fromCode(52);
    pub const KEY_SLASH = fromCode(53);
    pub const KEY_RIGHTSHIFT = fromCode(54);
    pub const KEY_KPASTERISK = fromCode(55);
    pub const KEY_LEFTALT = fromCode(56);
    pub const KEY_SPACE = fromCode(57);
    pub const KEY_CAPSLOCK = fromCode(58);
    pub const KEY_F1 = fromCode(59);
    pub const KEY_F2 = fromCode(60);
    pub const KEY_F3 = fromCode(61);
    pub const KEY_F4 = fromCode(62);
    pub const KEY_F5 = fromCode(63);
    pub const KEY_F6 = fromCode(64);
    pub const KEY_F7 = fromCode(65);
    pub const KEY_F8 = fromCode(66);
    pub const KEY_F9 = fromCode(67);
    pub const KEY_F10 = fromCode(68);
    pub const KEY_NUMLOCK = fromCode(69);
    pub const KEY_SCROLLLOCK = fromCode(70);
    pub const KEY_KP7 = fromCode(71);
    pub const KEY_KP8 = fromCode(72);
    pub const KEY_KP9 = fromCode(73);
    pub const KEY_KPMINUS = fromCode(74);
    pub const KEY_KP4 = fromCode(75);
    pub const KEY_KP5 = fromCode(76);
    pub const KEY_KP6 = fromCode(77);
    pub const KEY_KPPLUS = fromCode(78);
    pub const KEY_KP1 = fromCode(79);
    pub const KEY_KP2 = fromCode(80);
    pub const KEY_KP3 = fromCode(81);
    pub const KEY_KP0 = fromCode(82);
    pub const KEY_KPDOT = fromCode(83);

    pub const KEY_ZENKAKUHANKAKU = fromCode(85);
    pub const KEY_102ND = fromCode(86);
    pub const KEY_F11 = fromCode(87);
    pub const KEY_F12 = fromCode(88);
    pub const KEY_RO = fromCode(89);
    pub const KEY_KATAKANA = fromCode(90);
    pub const KEY_HIRAGANA = fromCode(91);
    pub const KEY_HENKAN = fromCode(92);
    pub const KEY_KATAKANAHIRAGANA = fromCode(93);
    pub const KEY_MUHENKAN = fromCode(94);
    pub const KEY_KPJPCOMMA = fromCode(95);
    pub const KEY_KPENTER = fromCode(96);
    pub const KEY_RIGHTCTRL = fromCode(97);
    pub const KEY_KPSLASH = fromCode(98);
    pub const KEY_SYSRQ = fromCode(99);
    pub const KEY_RIGHTALT = fromCode(100);
    pub const KEY_LINEFEED = fromCode(101);
    pub const KEY_HOME = fromCode(102);
    pub const KEY_UP = fromCode(103);
    pub const KEY_PAGEUP = fromCode(104);
    pub const KEY_LEFT = fromCode(105);
    pub const KEY_RIGHT = fromCode(106);
    pub const KEY_END = fromCode(107);
    pub const KEY_DOWN = fromCode(108);
    pub const KEY_PAGEDOWN = fromCode(109);
    pub const KEY_INSERT = fromCode(110);
    pub const KEY_DELETE = fromCode(111);
    pub const KEY_MACRO = fromCode(112);
    pub const KEY_MUTE = fromCode(113);
    pub const KEY_VOLUMEDOWN = fromCode(114);
    pub const KEY_VOLUMEUP = fromCode(115);
    pub const KEY_POWER = fromCode(116);
    pub const KEY_KPEQUAL = fromCode(117);
    pub const KEY_KPPLUSMINUS = fromCode(118);
    pub const KEY_PAUSE = fromCode(119);
    pub const KEY_KPCOMMA = fromCode(121);
    pub const KEY_SCALE = fromCode(120);

    pub const KEY_HANGEUL = fromCode(122);
    pub const KEY_HANGUEL = KEY_HANGEUL;
    pub const KEY_HANJA = fromCode(123);
    pub const KEY_YEN = fromCode(124);
    pub const KEY_LEFTMETA = fromCode(125);
    pub const KEY_RIGHTMETA = fromCode(126);
    pub const KEY_COMPOSE = fromCode(127);

    pub const KEY_STOP = fromCode(128);
    pub const KEY_AGAIN = fromCode(129);
    pub const KEY_PROPS = fromCode(130);
    pub const KEY_UNDO = fromCode(131);
    pub const KEY_FRONT = fromCode(132);
    pub const KEY_COPY = fromCode(133);
    pub const KEY_OPEN = fromCode(134);
    pub const KEY_PASTE = fromCode(135);
    pub const KEY_FIND = fromCode(136);
    pub const KEY_CUT = fromCode(137);
    pub const KEY_HELP = fromCode(138);
    pub const KEY_MENU = fromCode(139);
    pub const KEY_CALC = fromCode(140);
    pub const KEY_SETUP = fromCode(141);
    pub const KEY_SLEEP = fromCode(142);
    pub const KEY_WAKEUP = fromCode(143);
    pub const KEY_FILE = fromCode(144);
    pub const KEY_SENDFILE = fromCode(145);
    pub const KEY_DELETEFILE = fromCode(146);
    pub const KEY_XFER = fromCode(147);
    pub const KEY_PROG1 = fromCode(148);
    pub const KEY_PROG2 = fromCode(149);
    pub const KEY_WWW = fromCode(150);
    pub const KEY_MSDOS = fromCode(151);
    pub const KEY_COFFEE = fromCode(152);
    pub const KEY_SCREENLOCK = KEY_COFFEE;
    pub const KEY_ROTATE_DISPLAY = fromCode(153);
    pub const KEY_DIRECTION = KEY_ROTATE_DISPLAY;
    pub const KEY_CYCLEWINDOWS = fromCode(154);
    pub const KEY_MAIL = fromCode(155);
    pub const KEY_BOOKMARKS = fromCode(156);
    pub const KEY_COMPUTER = fromCode(157);
    pub const KEY_BACK = fromCode(158);
    pub const KEY_FORWARD = fromCode(159);
    pub const KEY_CLOSECD = fromCode(160);
    pub const KEY_EJECTCD = fromCode(161);
    pub const KEY_EJECTCLOSECD = fromCode(162);
    pub const KEY_NEXTSONG = fromCode(163);
    pub const KEY_PLAYPAUSE = fromCode(164);
    pub const KEY_PREVIOUSSONG = fromCode(165);
    pub const KEY_STOPCD = fromCode(166);
    pub const KEY_RECORD = fromCode(167);
    pub const KEY_REWIND = fromCode(168);
    pub const KEY_PHONE = fromCode(169);
    pub const KEY_ISO = fromCode(170);
    pub const KEY_CONFIG = fromCode(171);
    pub const KEY_HOMEPAGE = fromCode(172);
    pub const KEY_REFRESH = fromCode(173);
    pub const KEY_EXIT = fromCode(174);
    pub const KEY_MOVE = fromCode(175);
    pub const KEY_EDIT = fromCode(176);
    pub const KEY_SCROLLUP = fromCode(177);
    pub const KEY_SCROLLDOWN = fromCode(178);
    pub const KEY_KPLEFTPAREN = fromCode(179);
    pub const KEY_KPRIGHTPAREN = fromCode(180);
    pub const KEY_NEW = fromCode(181);
    pub const KEY_REDO = fromCode(182);

    pub const KEY_F13 = fromCode(183);
    pub const KEY_F14 = fromCode(184);
    pub const KEY_F15 = fromCode(185);
    pub const KEY_F16 = fromCode(186);
    pub const KEY_F17 = fromCode(187);
    pub const KEY_F18 = fromCode(188);
    pub const KEY_F19 = fromCode(189);
    pub const KEY_F20 = fromCode(190);
    pub const KEY_F21 = fromCode(191);
    pub const KEY_F22 = fromCode(192);
    pub const KEY_F23 = fromCode(193);
    pub const KEY_F24 = fromCode(194);

    pub const KEY_PLAYCD = fromCode(200);
    pub const KEY_PAUSECD = fromCode(201);
    pub const KEY_PROG3 = fromCode(202);
    pub const KEY_PROG4 = fromCode(203);
    pub const KEY_ALL_APPLICATIONS = fromCode(204);
    pub const KEY_DASHBOARD = KEY_ALL_APPLICATIONS;
    pub const KEY_SUSPEND = fromCode(205);
    pub const KEY_CLOSE = fromCode(206);
    pub const KEY_PLAY = fromCode(207);
    pub const KEY_FASTFORWARD = fromCode(208);
    pub const KEY_BASSBOOST = fromCode(209);
    pub const KEY_PRINT = fromCode(210);
    pub const KEY_HP = fromCode(211);
    pub const KEY_CAMERA = fromCode(212);
    pub const KEY_SOUND = fromCode(213);
    pub const KEY_QUESTION = fromCode(214);
    pub const KEY_EMAIL = fromCode(215);
    pub const KEY_CHAT = fromCode(216);
    pub const KEY_SEARCH = fromCode(217);
    pub const KEY_CONNECT = fromCode(218);
    pub const KEY_FINANCE = fromCode(219);
    pub const KEY_SPORT = fromCode(220);
    pub const KEY_SHOP = fromCode(221);
    pub const KEY_ALTERASE = fromCode(222);
    pub const KEY_CANCEL = fromCode(223);
    pub const KEY_BRIGHTNESSDOWN = fromCode(224);
    pub const KEY_BRIGHTNESSUP = fromCode(225);
    pub const KEY_MEDIA = fromCode(226);

    pub const KEY_SWITCHVIDEOMODE = fromCode(227); // Cycle between available video outputs (Monitor/LCD/TV-out/etc)
    pub const KEY_KBDILLUMTOGGLE = fromCode(228);
    pub const KEY_KBDILLUMDOWN = fromCode(229);
    pub const KEY_KBDILLUMUP = fromCode(230);

    pub const KEY_SEND = fromCode(231); // AC Send
    pub const KEY_REPLY = fromCode(232); // AC Reply
    pub const KEY_FORWARDMAIL = fromCode(233); // AC Forward Msg
    pub const KEY_SAVE = fromCode(234); // AC Save
    pub const KEY_DOCUMENTS = fromCode(235);

    pub const KEY_BATTERY = fromCode(236);

    pub const KEY_BLUETOOTH = fromCode(237);
    pub const KEY_WLAN = fromCode(238);
    pub const KEY_UWB = fromCode(239);

    pub const KEY_UNKNOWN = fromCode(240);

    pub const KEY_VIDEO_NEXT = fromCode(241); // drive next video source
    pub const KEY_VIDEO_PREV = fromCode(242); // drive previous video source
    pub const KEY_BRIGHTNESS_CYCLE = fromCode(243); // brightness up, after max is min
    pub const KEY_BRIGHTNESS_AUTO = fromCode(244); // Set Auto Brightness: manual brightness control is off, rely on ambient
    pub const KEY_BRIGHTNESS_ZERO = KEY_BRIGHTNESS_AUTO; // brightness off, use ambient
    pub const KEY_DISPLAY_OFF = fromCode(245); // display device to off state

    pub const KEY_WWAN = fromCode(246); // Wireless WAN (LTE, UMTS, GSM, etc.)
    pub const KEY_WIMAX = KEY_WWAN;
    pub const KEY_RFKILL = fromCode(247); // Key that controls all radios

    pub const KEY_MICMUTE = fromCode(248); // Mute / unmute the microphone

    // Code 255 is reserved for special needs of AT keyboard driver

    pub const BTN_MISC = fromCode(0x100);
    pub const BTN_0 = fromCode(0x100);
    pub const BTN_1 = fromCode(0x101);
    pub const BTN_2 = fromCode(0x102);
    pub const BTN_3 = fromCode(0x103);
    pub const BTN_4 = fromCode(0x104);
    pub const BTN_5 = fromCode(0x105);
    pub const BTN_6 = fromCode(0x106);
    pub const BTN_7 = fromCode(0x107);
    pub const BTN_8 = fromCode(0x108);
    pub const BTN_9 = fromCode(0x109);

    pub const BTN_MOUSE = fromCode(0x110);
    pub const BTN_LEFT = fromCode(0x110);
    pub const BTN_RIGHT = fromCode(0x111);
    pub const BTN_MIDDLE = fromCode(0x112);
    pub const BTN_SIDE = fromCode(0x113);
    pub const BTN_EXTRA = fromCode(0x114);
    pub const BTN_FORWARD = fromCode(0x115);
    pub const BTN_BACK = fromCode(0x116);
    pub const BTN_TASK = fromCode(0x117);

    pub const BTN_JOYSTICK = fromCode(0x120);
    pub const BTN_TRIGGER = fromCode(0x120);
    pub const BTN_THUMB = fromCode(0x121);
    pub const BTN_THUMB2 = fromCode(0x122);
    pub const BTN_TOP = fromCode(0x123);
    pub const BTN_TOP2 = fromCode(0x124);
    pub const BTN_PINKIE = fromCode(0x125);
    pub const BTN_BASE = fromCode(0x126);
    pub const BTN_BASE2 = fromCode(0x127);
    pub const BTN_BASE3 = fromCode(0x128);
    pub const BTN_BASE4 = fromCode(0x129);
    pub const BTN_BASE5 = fromCode(0x12a);
    pub const BTN_BASE6 = fromCode(0x12b);
    pub const BTN_DEAD = fromCode(0x12f);

    pub const BTN_GAMEPAD = fromCode(0x130);
    pub const BTN_SOUTH = fromCode(0x130);
    pub const BTN_A = BTN_SOUTH;
    pub const BTN_EAST = fromCode(0x131);
    pub const BTN_B = BTN_EAST;
    pub const BTN_C = fromCode(0x132);
    pub const BTN_NORTH = fromCode(0x133);
    pub const BTN_X = BTN_NORTH;
    pub const BTN_WEST = fromCode(0x134);
    pub const BTN_Y = BTN_WEST;
    pub const BTN_Z = fromCode(0x135);
    pub const BTN_TL = fromCode(0x136);
    pub const BTN_TR = fromCode(0x137);
    pub const BTN_TL2 = fromCode(0x138);
    pub const BTN_TR2 = fromCode(0x139);
    pub const BTN_SELECT = fromCode(0x13a);
    pub const BTN_START = fromCode(0x13b);
    pub const BTN_MODE = fromCode(0x13c);
    pub const BTN_THUMBL = fromCode(0x13d);
    pub const BTN_THUMBR = fromCode(0x13e);

    pub const BTN_DIGI = fromCode(0x140);
    pub const BTN_TOOL_PEN = fromCode(0x140);
    pub const BTN_TOOL_RUBBER = fromCode(0x141);
    pub const BTN_TOOL_BRUSH = fromCode(0x142);
    pub const BTN_TOOL_PENCIL = fromCode(0x143);
    pub const BTN_TOOL_AIRBRUSH = fromCode(0x144);
    pub const BTN_TOOL_FINGER = fromCode(0x145);
    pub const BTN_TOOL_MOUSE = fromCode(0x146);
    pub const BTN_TOOL_LENS = fromCode(0x147);
    pub const BTN_TOOL_QUINTTAP = fromCode(0x148); // Five fingers on trackpad
    pub const BTN_STYLUS3 = fromCode(0x149);
    pub const BTN_TOUCH = fromCode(0x14a);
    pub const BTN_STYLUS = fromCode(0x14b);
    pub const BTN_STYLUS2 = fromCode(0x14c);
    pub const BTN_TOOL_DOUBLETAP = fromCode(0x14d);
    pub const BTN_TOOL_TRIPLETAP = fromCode(0x14e);
    pub const BTN_TOOL_QUADTAP = fromCode(0x14f); // Four fingers on trackpad

    pub const BTN_WHEEL = fromCode(0x150);
    pub const BTN_GEAR_DOWN = fromCode(0x150);
    pub const BTN_GEAR_UP = fromCode(0x151);

    pub const KEY_OK = fromCode(0x160);
    pub const KEY_SELECT = fromCode(0x161);
    pub const KEY_GOTO = fromCode(0x162);
    pub const KEY_CLEAR = fromCode(0x163);
    pub const KEY_POWER2 = fromCode(0x164);
    pub const KEY_OPTION = fromCode(0x165);
    pub const KEY_INFO = fromCode(0x166); // AL OEM Features/Tips/Tutorial
    pub const KEY_TIME = fromCode(0x167);
    pub const KEY_VENDOR = fromCode(0x168);
    pub const KEY_ARCHIVE = fromCode(0x169);
    pub const KEY_PROGRAM = fromCode(0x16a); // Media Select Program Guide
    pub const KEY_CHANNEL = fromCode(0x16b);
    pub const KEY_FAVORITES = fromCode(0x16c);
    pub const KEY_EPG = fromCode(0x16d);
    pub const KEY_PVR = fromCode(0x16e); // Media Select Home
    pub const KEY_MHP = fromCode(0x16f);
    pub const KEY_LANGUAGE = fromCode(0x170);
    pub const KEY_TITLE = fromCode(0x171);
    pub const KEY_SUBTITLE = fromCode(0x172);
    pub const KEY_ANGLE = fromCode(0x173);
    pub const KEY_FULL_SCREEN = fromCode(0x174); // AC View Toggle
    pub const KEY_ZOOM = KEY_FULL_SCREEN;
    pub const KEY_MODE = fromCode(0x175);
    pub const KEY_KEYBOARD = fromCode(0x176);
    pub const KEY_ASPECT_RATIO = fromCode(0x177); // HUTRR37: Aspect
    pub const KEY_SCREEN = KEY_ASPECT_RATIO;
    pub const KEY_PC = fromCode(0x178); // Media Select Computer
    pub const KEY_TV = fromCode(0x179); // Media Select TV
    pub const KEY_TV2 = fromCode(0x17a); // Media Select Cable
    pub const KEY_VCR = fromCode(0x17b); // Media Select VCR
    pub const KEY_VCR2 = fromCode(0x17c); // VCR Plus
    pub const KEY_SAT = fromCode(0x17d); // Media Select Satellite
    pub const KEY_SAT2 = fromCode(0x17e);
    pub const KEY_CD = fromCode(0x17f); // Media Select CD
    pub const KEY_TAPE = fromCode(0x180); // Media Select Tape
    pub const KEY_RADIO = fromCode(0x181);
    pub const KEY_TUNER = fromCode(0x182); // Media Select Tuner
    pub const KEY_PLAYER = fromCode(0x183);
    pub const KEY_TEXT = fromCode(0x184);
    pub const KEY_DVD = fromCode(0x185); // Media Select DVD
    pub const KEY_AUX = fromCode(0x186);
    pub const KEY_MP3 = fromCode(0x187);
    pub const KEY_AUDIO = fromCode(0x188); // AL Audio Browser
    pub const KEY_VIDEO = fromCode(0x189); // AL Movie Browser
    pub const KEY_DIRECTORY = fromCode(0x18a);
    pub const KEY_LIST = fromCode(0x18b);
    pub const KEY_MEMO = fromCode(0x18c); // Media Select Messages
    pub const KEY_CALENDAR = fromCode(0x18d);
    pub const KEY_RED = fromCode(0x18e);
    pub const KEY_GREEN = fromCode(0x18f);
    pub const KEY_YELLOW = fromCode(0x190);
    pub const KEY_BLUE = fromCode(0x191);
    pub const KEY_CHANNELUP = fromCode(0x192); // Channel Increment
    pub const KEY_CHANNELDOWN = fromCode(0x193); // Channel Decrement
    pub const KEY_FIRST = fromCode(0x194);
    pub const KEY_LAST = fromCode(0x195); // Recall Last
    pub const KEY_AB = fromCode(0x196);
    pub const KEY_NEXT = fromCode(0x197);
    pub const KEY_RESTART = fromCode(0x198);
    pub const KEY_SLOW = fromCode(0x199);
    pub const KEY_SHUFFLE = fromCode(0x19a);
    pub const KEY_BREAK = fromCode(0x19b);
    pub const KEY_PREVIOUS = fromCode(0x19c);
    pub const KEY_DIGITS = fromCode(0x19d);
    pub const KEY_TEEN = fromCode(0x19e);
    pub const KEY_TWEN = fromCode(0x19f);
    pub const KEY_VIDEOPHONE = fromCode(0x1a0); // Media Select Video Phone
    pub const KEY_GAMES = fromCode(0x1a1); // Media Select Games
    pub const KEY_ZOOMIN = fromCode(0x1a2); // AC Zoom In
    pub const KEY_ZOOMOUT = fromCode(0x1a3); // AC Zoom Out
    pub const KEY_ZOOMRESET = fromCode(0x1a4); // AC Zoom
    pub const KEY_WORDPROCESSOR = fromCode(0x1a5); // AL Word Processor
    pub const KEY_EDITOR = fromCode(0x1a6); // AL Text Editor
    pub const KEY_SPREADSHEET = fromCode(0x1a7); // AL Spreadsheet
    pub const KEY_GRAPHICSEDITOR = fromCode(0x1a8); // AL Graphics Editor
    pub const KEY_PRESENTATION = fromCode(0x1a9); // AL Presentation App
    pub const KEY_DATABASE = fromCode(0x1aa); // AL Database App
    pub const KEY_NEWS = fromCode(0x1ab); // AL Newsreader
    pub const KEY_VOICEMAIL = fromCode(0x1ac); // AL Voicemail
    pub const KEY_ADDRESSBOOK = fromCode(0x1ad); // AL Contacts/Address Book
    pub const KEY_MESSENGER = fromCode(0x1ae); // AL Instant Messaging
    pub const KEY_DISPLAYTOGGLE = fromCode(0x1af); // Turn display (LCD) on and off
    pub const KEY_BRIGHTNESS_TOGGLE = KEY_DISPLAYTOGGLE;
    pub const KEY_SPELLCHECK = fromCode(0x1b0); // AL Spell Check
    pub const KEY_LOGOFF = fromCode(0x1b1); // AL Logoff

    pub const KEY_DOLLAR = fromCode(0x1b2);
    pub const KEY_EURO = fromCode(0x1b3);

    pub const KEY_FRAMEBACK = fromCode(0x1b4); // Consumer - transport controls
    pub const KEY_FRAMEFORWARD = fromCode(0x1b5);
    pub const KEY_CONTEXT_MENU = fromCode(0x1b6); // GenDesc - system context menu
    pub const KEY_MEDIA_REPEAT = fromCode(0x1b7); // Consumer - transport control
    pub const KEY_10CHANNELSUP = fromCode(0x1b8); // 10 channels up (10+)
    pub const KEY_10CHANNELSDOWN = fromCode(0x1b9); // 10 channels down (10-)
    pub const KEY_IMAGES = fromCode(0x1ba); // AL Image Browser
    pub const KEY_NOTIFICATION_CENTER = fromCode(0x1bc); // Show/hide the notification center
    pub const KEY_PICKUP_PHONE = fromCode(0x1bd); // Answer incoming call
    pub const KEY_HANGUP_PHONE = fromCode(0x1be); // Decline incoming call
    pub const KEY_LINK_PHONE = fromCode(0x1bf); // AL Phone Syncing

    pub const KEY_DEL_EOL = fromCode(0x1c0);
    pub const KEY_DEL_EOS = fromCode(0x1c1);
    pub const KEY_INS_LINE = fromCode(0x1c2);
    pub const KEY_DEL_LINE = fromCode(0x1c3);

    pub const KEY_FN = fromCode(0x1d0);
    pub const KEY_FN_ESC = fromCode(0x1d1);
    pub const KEY_FN_F1 = fromCode(0x1d2);
    pub const KEY_FN_F2 = fromCode(0x1d3);
    pub const KEY_FN_F3 = fromCode(0x1d4);
    pub const KEY_FN_F4 = fromCode(0x1d5);
    pub const KEY_FN_F5 = fromCode(0x1d6);
    pub const KEY_FN_F6 = fromCode(0x1d7);
    pub const KEY_FN_F7 = fromCode(0x1d8);
    pub const KEY_FN_F8 = fromCode(0x1d9);
    pub const KEY_FN_F9 = fromCode(0x1da);
    pub const KEY_FN_F10 = fromCode(0x1db);
    pub const KEY_FN_F11 = fromCode(0x1dc);
    pub const KEY_FN_F12 = fromCode(0x1dd);
    pub const KEY_FN_1 = fromCode(0x1de);
    pub const KEY_FN_2 = fromCode(0x1df);
    pub const KEY_FN_D = fromCode(0x1e0);
    pub const KEY_FN_E = fromCode(0x1e1);
    pub const KEY_FN_F = fromCode(0x1e2);
    pub const KEY_FN_S = fromCode(0x1e3);
    pub const KEY_FN_B = fromCode(0x1e4);
    pub const KEY_FN_RIGHT_SHIFT = fromCode(0x1e5);

    pub const KEY_BRL_DOT1 = fromCode(0x1f1);
    pub const KEY_BRL_DOT2 = fromCode(0x1f2);
    pub const KEY_BRL_DOT3 = fromCode(0x1f3);
    pub const KEY_BRL_DOT4 = fromCode(0x1f4);
    pub const KEY_BRL_DOT5 = fromCode(0x1f5);
    pub const KEY_BRL_DOT6 = fromCode(0x1f6);
    pub const KEY_BRL_DOT7 = fromCode(0x1f7);
    pub const KEY_BRL_DOT8 = fromCode(0x1f8);
    pub const KEY_BRL_DOT9 = fromCode(0x1f9);
    pub const KEY_BRL_DOT10 = fromCode(0x1fa);

    pub const KEY_NUMERIC_0 = fromCode(0x200); // used by phones, remote controls,
    pub const KEY_NUMERIC_1 = fromCode(0x201); // and other keypads
    pub const KEY_NUMERIC_2 = fromCode(0x202);
    pub const KEY_NUMERIC_3 = fromCode(0x203);
    pub const KEY_NUMERIC_4 = fromCode(0x204);
    pub const KEY_NUMERIC_5 = fromCode(0x205);
    pub const KEY_NUMERIC_6 = fromCode(0x206);
    pub const KEY_NUMERIC_7 = fromCode(0x207);
    pub const KEY_NUMERIC_8 = fromCode(0x208);
    pub const KEY_NUMERIC_9 = fromCode(0x209);
    pub const KEY_NUMERIC_STAR = fromCode(0x20a);
    pub const KEY_NUMERIC_POUND = fromCode(0x20b);
    pub const KEY_NUMERIC_A = fromCode(0x20c); // Phone key A - HUT Telephony 0xb9
    pub const KEY_NUMERIC_B = fromCode(0x20d);
    pub const KEY_NUMERIC_C = fromCode(0x20e);
    pub const KEY_NUMERIC_D = fromCode(0x20f);

    pub const KEY_CAMERA_FOCUS = fromCode(0x210);
    pub const KEY_WPS_BUTTON = fromCode(0x211); // WiFi Protected Setup key

    pub const KEY_TOUCHPAD_TOGGLE = fromCode(0x212); // Request switch touchpad on or off
    pub const KEY_TOUCHPAD_ON = fromCode(0x213);
    pub const KEY_TOUCHPAD_OFF = fromCode(0x214);

    pub const KEY_CAMERA_ZOOMIN = fromCode(0x215);
    pub const KEY_CAMERA_ZOOMOUT = fromCode(0x216);
    pub const KEY_CAMERA_UP = fromCode(0x217);
    pub const KEY_CAMERA_DOWN = fromCode(0x218);
    pub const KEY_CAMERA_LEFT = fromCode(0x219);
    pub const KEY_CAMERA_RIGHT = fromCode(0x21a);

    pub const KEY_ATTENDANT_ON = fromCode(0x21b);
    pub const KEY_ATTENDANT_OFF = fromCode(0x21c);
    pub const KEY_ATTENDANT_TOGGLE = fromCode(0x21d); // Attendant call on or off
    pub const KEY_LIGHTS_TOGGLE = fromCode(0x21e); // Reading light on or off

    pub const BTN_DPAD_UP = fromCode(0x220);
    pub const BTN_DPAD_DOWN = fromCode(0x221);
    pub const BTN_DPAD_LEFT = fromCode(0x222);
    pub const BTN_DPAD_RIGHT = fromCode(0x223);

    pub const BTN_GRIPL = fromCode(0x224);
    pub const BTN_GRIPR = fromCode(0x225);
    pub const BTN_GRIPL2 = fromCode(0x226);
    pub const BTN_GRIPR2 = fromCode(0x227);

    pub const KEY_ALS_TOGGLE = fromCode(0x230); // Ambient light sensor
    pub const KEY_ROTATE_LOCK_TOGGLE = fromCode(0x231); // Display rotation lock
    pub const KEY_REFRESH_RATE_TOGGLE = fromCode(0x232); // Display refresh rate toggle

    pub const KEY_BUTTONCONFIG = fromCode(0x240); // AL Button Configuration
    pub const KEY_TASKMANAGER = fromCode(0x241); // AL Task/Project Manager
    pub const KEY_JOURNAL = fromCode(0x242); // AL Log/Journal/Timecard
    pub const KEY_CONTROLPANEL = fromCode(0x243); // AL Control Panel
    pub const KEY_APPSELECT = fromCode(0x244); // AL Select Task/Application
    pub const KEY_SCREENSAVER = fromCode(0x245); // AL Screen Saver
    pub const KEY_VOICECOMMAND = fromCode(0x246); // Listening Voice Command
    pub const KEY_ASSISTANT = fromCode(0x247); // AL Context-aware desktop assistant
    pub const KEY_KBD_LAYOUT_NEXT = fromCode(0x248); // AC Next Keyboard Layout Select
    pub const KEY_EMOJI_PICKER = fromCode(0x249); // Show/hide emoji picker (HUTRR101)
    pub const KEY_DICTATE = fromCode(0x24a); // Start or Stop Voice Dictation Session (HUTRR99)
    pub const KEY_CAMERA_ACCESS_ENABLE = fromCode(0x24b); // Enables programmatic access to camera devices. (HUTRR72)
    pub const KEY_CAMERA_ACCESS_DISABLE = fromCode(0x24c); // Disables programmatic access to camera devices. (HUTRR72)
    pub const KEY_CAMERA_ACCESS_TOGGLE = fromCode(0x24d); // Toggles the current state of the camera access control. (HUTRR72)
    pub const KEY_ACCESSIBILITY = fromCode(0x24e); // Toggles the system bound accessibility UI/command (HUTRR116)
    pub const KEY_DO_NOT_DISTURB = fromCode(0x24f); // Toggles the system-wide "Do Not Disturb" control (HUTRR94

    pub const KEY_BRIGHTNESS_MIN = fromCode(0x250); // Set Brightness to Minimum
    pub const KEY_BRIGHTNESS_MAX = fromCode(0x251); // Set Brightness to Maximum

    // Keycodes for hotkeys toggling the electronic privacy screen found on some
    // laptops on/off. Note when the embedded-controller turns on/off the eprivacy
    // screen itself then the state should be reported through drm connecter props:
    // https://www.kernel.org/doc/html/latest/gpu/drm-kms.html#standard-connector-properties
    // Except when implementing the drm connecter properties API is not possible
    // because e.g. the firmware does not allow querying the presence and/or status
    // of the eprivacy screen at boot.

    pub const KEY_EPRIVACY_SCREEN_ON = fromCode(0x252);
    pub const KEY_EPRIVACY_SCREEN_OFF = fromCode(0x253);

    pub const KEY_ACTION_ON_SELECTION = fromCode(0x254); // AL Action on Selection (HUTRR119)
    pub const KEY_CONTEXTUAL_INSERT = fromCode(0x255); // AL Contextual Insertion (HUTRR119)
    pub const KEY_CONTEXTUAL_QUERY = fromCode(0x256); // AL Contextual Query (HUTRR119)

    pub const KEY_KBDINPUTASSIST_PREV = fromCode(0x260);
    pub const KEY_KBDINPUTASSIST_NEXT = fromCode(0x261);
    pub const KEY_KBDINPUTASSIST_PREVGROUP = fromCode(0x262);
    pub const KEY_KBDINPUTASSIST_NEXTGROUP = fromCode(0x263);
    pub const KEY_KBDINPUTASSIST_ACCEPT = fromCode(0x264);
    pub const KEY_KBDINPUTASSIST_CANCEL = fromCode(0x265);

    // Diagonal movement keys
    pub const KEY_RIGHT_UP = fromCode(0x266);
    pub const KEY_RIGHT_DOWN = fromCode(0x267);
    pub const KEY_LEFT_UP = fromCode(0x268);
    pub const KEY_LEFT_DOWN = fromCode(0x269);

    pub const KEY_ROOT_MENU = fromCode(0x26a); // Show Device's Root Menu
    // Show Top Menu of the Media (e.g. DVD)
    pub const KEY_MEDIA_TOP_MENU = fromCode(0x26b);
    pub const KEY_NUMERIC_11 = fromCode(0x26c);
    pub const KEY_NUMERIC_12 = fromCode(0x26d);

    // Toggle Audio Description: refers to an audio service that helps blind and
    // visually impaired consumers understand the action in a program. Note: in
    // some countries this is referred to as "Video Description".

    pub const KEY_AUDIO_DESC = fromCode(0x26e);
    pub const KEY_3D_MODE = fromCode(0x26f);
    pub const KEY_NEXT_FAVORITE = fromCode(0x270);
    pub const KEY_STOP_RECORD = fromCode(0x271);
    pub const KEY_PAUSE_RECORD = fromCode(0x272);
    pub const KEY_VOD = fromCode(0x273); // Video on Demand
    pub const KEY_UNMUTE = fromCode(0x274);
    pub const KEY_FASTREVERSE = fromCode(0x275);
    pub const KEY_SLOWREVERSE = fromCode(0x276);

    // Control a data application associated with the currently viewed channel,
    // e.g. teletext or data broadcast application (MHEG, MHP, HbbTV, etc.)

    pub const KEY_DATA = fromCode(0x277);
    pub const KEY_ONSCREEN_KEYBOARD = fromCode(0x278);
    // Electronic privacy screen control
    pub const KEY_PRIVACY_SCREEN_TOGGLE = fromCode(0x279);

    // Select an area of screen to be copied
    pub const KEY_SELECTIVE_SCREENSHOT = fromCode(0x27a);

    // Move the focus to the next or previous user controllable element within a UI container
    pub const KEY_NEXT_ELEMENT = fromCode(0x27b);
    pub const KEY_PREVIOUS_ELEMENT = fromCode(0x27c);

    // Toggle Autopilot engagement
    pub const KEY_AUTOPILOT_ENGAGE_TOGGLE = fromCode(0x27d);

    // Shortcut Keys
    pub const KEY_MARK_WAYPOINT = fromCode(0x27e);
    pub const KEY_SOS = fromCode(0x27f);
    pub const KEY_NAV_CHART = fromCode(0x280);
    pub const KEY_FISHING_CHART = fromCode(0x281);
    pub const KEY_SINGLE_RANGE_RADAR = fromCode(0x282);
    pub const KEY_DUAL_RANGE_RADAR = fromCode(0x283);
    pub const KEY_RADAR_OVERLAY = fromCode(0x284);
    pub const KEY_TRADITIONAL_SONAR = fromCode(0x285);
    pub const KEY_CLEARVU_SONAR = fromCode(0x286);
    pub const KEY_SIDEVU_SONAR = fromCode(0x287);
    pub const KEY_NAV_INFO = fromCode(0x288);
    pub const KEY_BRIGHTNESS_MENU = fromCode(0x289);

    // Some keyboards have keys which do not have a defined meaning, these keys
    // are intended to be programmed / bound to macros by the user. For most
    // keyboards with these macro-keys the key-sequence to inject, or action to
    // take, is all handled by software on the host side. So from the kernel's
    // point of view these are just normal keys.
    //
    // The KEY_MACRO# codes below are intended for such keys, which may be labeled
    // e.g. G1-G18, or S1 - S30. The KEY_MACRO# codes MUST NOT be used for keys
    // where the marking on the key does indicate a defined meaning / purpose.
    //
    // The KEY_MACRO# codes MUST also NOT be used as fallback for when no existing
    // KEY_FOO define matches the marking / purpose. In this case a new KEY_FOO
    // define MUST be added.
    pub const KEY_MACRO1 = fromCode(0x290);
    pub const KEY_MACRO2 = fromCode(0x291);
    pub const KEY_MACRO3 = fromCode(0x292);
    pub const KEY_MACRO4 = fromCode(0x293);
    pub const KEY_MACRO5 = fromCode(0x294);
    pub const KEY_MACRO6 = fromCode(0x295);
    pub const KEY_MACRO7 = fromCode(0x296);
    pub const KEY_MACRO8 = fromCode(0x297);
    pub const KEY_MACRO9 = fromCode(0x298);
    pub const KEY_MACRO10 = fromCode(0x299);
    pub const KEY_MACRO11 = fromCode(0x29a);
    pub const KEY_MACRO12 = fromCode(0x29b);
    pub const KEY_MACRO13 = fromCode(0x29c);
    pub const KEY_MACRO14 = fromCode(0x29d);
    pub const KEY_MACRO15 = fromCode(0x29e);
    pub const KEY_MACRO16 = fromCode(0x29f);
    pub const KEY_MACRO17 = fromCode(0x2a0);
    pub const KEY_MACRO18 = fromCode(0x2a1);
    pub const KEY_MACRO19 = fromCode(0x2a2);
    pub const KEY_MACRO20 = fromCode(0x2a3);
    pub const KEY_MACRO21 = fromCode(0x2a4);
    pub const KEY_MACRO22 = fromCode(0x2a5);
    pub const KEY_MACRO23 = fromCode(0x2a6);
    pub const KEY_MACRO24 = fromCode(0x2a7);
    pub const KEY_MACRO25 = fromCode(0x2a8);
    pub const KEY_MACRO26 = fromCode(0x2a9);
    pub const KEY_MACRO27 = fromCode(0x2aa);
    pub const KEY_MACRO28 = fromCode(0x2ab);
    pub const KEY_MACRO29 = fromCode(0x2ac);
    pub const KEY_MACRO30 = fromCode(0x2ad);

    // Some keyboards with the macro-keys described above have some extra keys
    // for controlling the host-side software responsible for the macro handling:
    // -A macro recording start/stop key. Note that not all keyboards which emit
    //  KEY_MACRO_RECORD_START will also emit KEY_MACRO_RECORD_STOP if
    //  KEY_MACRO_RECORD_STOP is not;advertised, then KEY_MACRO_RECORD_START
    //  should be interpreted as a recording start/stop toggle;
    // -Keys for switching between different macro (pre)sets, either a key for
    //  cycling through the configured presets or keys to directly select a preset.

    pub const KEY_MACRO_RECORD_START = fromCode(0x2b0);
    pub const KEY_MACRO_RECORD_STOP = fromCode(0x2b1);
    pub const KEY_MACRO_PRESET_CYCLE = fromCode(0x2b2);
    pub const KEY_MACRO_PRESET1 = fromCode(0x2b3);
    pub const KEY_MACRO_PRESET2 = fromCode(0x2b4);
    pub const KEY_MACRO_PRESET3 = fromCode(0x2b5);

    // Some keyboards have a buildin LCD panel where the contents are controlled
    // by the host. Often these have a number of keys directly below the LCD
    // intended for controlling a menu shown on the LCD. These keys often don't
    // have any labeling so we just name them KEY_KBD_LCD_MENU#
    pub const KEY_KBD_LCD_MENU1 = fromCode(0x2b8);
    pub const KEY_KBD_LCD_MENU2 = fromCode(0x2b9);
    pub const KEY_KBD_LCD_MENU3 = fromCode(0x2ba);
    pub const KEY_KBD_LCD_MENU4 = fromCode(0x2bb);
    pub const KEY_KBD_LCD_MENU5 = fromCode(0x2bc);

    // Performance Boost key (Alienware)/G-Mode key (Dell)
    pub const KEY_PERFORMANCE = fromCode(0x2bd);

    pub const BTN_TRIGGER_HAPPY = fromCode(0x2c0);
    pub const BTN_TRIGGER_HAPPY1 = fromCode(0x2c0);
    pub const BTN_TRIGGER_HAPPY2 = fromCode(0x2c1);
    pub const BTN_TRIGGER_HAPPY3 = fromCode(0x2c2);
    pub const BTN_TRIGGER_HAPPY4 = fromCode(0x2c3);
    pub const BTN_TRIGGER_HAPPY5 = fromCode(0x2c4);
    pub const BTN_TRIGGER_HAPPY6 = fromCode(0x2c5);
    pub const BTN_TRIGGER_HAPPY7 = fromCode(0x2c6);
    pub const BTN_TRIGGER_HAPPY8 = fromCode(0x2c7);
    pub const BTN_TRIGGER_HAPPY9 = fromCode(0x2c8);
    pub const BTN_TRIGGER_HAPPY10 = fromCode(0x2c9);
    pub const BTN_TRIGGER_HAPPY11 = fromCode(0x2ca);
    pub const BTN_TRIGGER_HAPPY12 = fromCode(0x2cb);
    pub const BTN_TRIGGER_HAPPY13 = fromCode(0x2cc);
    pub const BTN_TRIGGER_HAPPY14 = fromCode(0x2cd);
    pub const BTN_TRIGGER_HAPPY15 = fromCode(0x2ce);
    pub const BTN_TRIGGER_HAPPY16 = fromCode(0x2cf);
    pub const BTN_TRIGGER_HAPPY17 = fromCode(0x2d0);
    pub const BTN_TRIGGER_HAPPY18 = fromCode(0x2d1);
    pub const BTN_TRIGGER_HAPPY19 = fromCode(0x2d2);
    pub const BTN_TRIGGER_HAPPY20 = fromCode(0x2d3);
    pub const BTN_TRIGGER_HAPPY21 = fromCode(0x2d4);
    pub const BTN_TRIGGER_HAPPY22 = fromCode(0x2d5);
    pub const BTN_TRIGGER_HAPPY23 = fromCode(0x2d6);
    pub const BTN_TRIGGER_HAPPY24 = fromCode(0x2d7);
    pub const BTN_TRIGGER_HAPPY25 = fromCode(0x2d8);
    pub const BTN_TRIGGER_HAPPY26 = fromCode(0x2d9);
    pub const BTN_TRIGGER_HAPPY27 = fromCode(0x2da);
    pub const BTN_TRIGGER_HAPPY28 = fromCode(0x2db);
    pub const BTN_TRIGGER_HAPPY29 = fromCode(0x2dc);
    pub const BTN_TRIGGER_HAPPY30 = fromCode(0x2dd);
    pub const BTN_TRIGGER_HAPPY31 = fromCode(0x2de);
    pub const BTN_TRIGGER_HAPPY32 = fromCode(0x2df);
    pub const BTN_TRIGGER_HAPPY33 = fromCode(0x2e0);
    pub const BTN_TRIGGER_HAPPY34 = fromCode(0x2e1);
    pub const BTN_TRIGGER_HAPPY35 = fromCode(0x2e2);
    pub const BTN_TRIGGER_HAPPY36 = fromCode(0x2e3);
    pub const BTN_TRIGGER_HAPPY37 = fromCode(0x2e4);
    pub const BTN_TRIGGER_HAPPY38 = fromCode(0x2e5);
    pub const BTN_TRIGGER_HAPPY39 = fromCode(0x2e6);
    pub const BTN_TRIGGER_HAPPY40 = fromCode(0x2e7);
};

// We avoid low common keys in module aliases so they don't get huge.
// pub const type_max = 0x17;
pub const key_min_interesting: comptime_int = @intFromEnum(KeyEvent.KEY_MUTE);
pub const key_max = 0x2ff;
pub const key_cnt = key_max + 1;
