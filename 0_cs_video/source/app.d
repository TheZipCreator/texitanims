import texit;
import std.string, std.regex, std.file;

mixin Texit!("../qbicfeet_10x10.png", 10, 2, 1+64*4, 36*2, 64, 36, "VPN Video");

float beat0(float n) {
  return (60f/90f)*n;
}

string repeat(string s, int n) {
  string res;
  for(int i = 0; i < n; i++)
    res ~= s;
  return res;
}

string genIPv4() {
  import std.random, std.conv;
  string ret = "";
  for(int i = 0; i < 4; i++) {
    if(i != 0)
      ret ~= ".";
    ret ~= uniform(0, 255).to!string;
  }
  return ret;
}

string genLocalIPv4() {
  import std.random, std.conv;
  string ret = "192.168.";
  for(int i = 0; i < 2; i++) {
    if(i != 0)
      ret ~= ".";
    ret ~= uniform(0, 255).to!string;
  }
  return ret;
}

string genIPv6() {
  import std.random;
  enum string chars = "0123456789ABCDEF";
  string ret = "";
  for(int i = 0; i < 8; i++) {
    if(i != 0)
      ret ~= ":";
    for(int j = 0; j < 4; j++)
      ret ~= chars[uniform(0, $-1)]; // for some reason I can't use choice() here
  }
  return ret;
}

void setup() {
  // keep window in same place
  window.move(100, 100);
  // offset = 5*60+5;
  audio("assets/vpns.ogg");
  enum HWW = 1+64*2;
  enum HWH = 36*2;
  zoom = 4;
  translation = Vector(HWW/2, HWH/2);
  // intro
  queue(new TextEvent(4.beat0, float.infinity, Point(1, 0), [0, 0, 0], [1, 0, 0], "-".repeat(HWW-3)));
  queue(new TextEvent(4.beat0, float.infinity, Point(1, HWH-1), [0, 0, 0], [255, 0, 0], "-".repeat(HWW-3)));
  queue(new TextEvent(12.beat0, float.infinity, Point(0, 1), [0, 0, 0], [1, 0, 0], "|\n".repeat(HWH-2)));
  queue(new TextEvent(12.beat0, float.infinity, Point(HWW-2, 1), [0, 0, 0], [255, 0, 0], "|\n".repeat(HWH-2)));

  queue(new TextEvent(20.beat0, float.infinity, Point(0, 0), [0, 0, 0], [.5, 0, 0], "+"));
  queue(new TextEvent(20.beat0, float.infinity, Point(HWW-2, 0), [0, 0, 0], [.5, 0, 0], "+"));
  queue(new TextEvent(20.beat0, float.infinity, Point(HWW-2, HWH-1), [0, 0, 0], [.5, 0, 0], "+"));
  queue(new TextEvent(20.beat0, float.infinity, Point(0, HWH-1), [0, 0, 0], [.5, 0, 0], "+"));
  
  queue(new ZoomEvent(28.beat0, 24, 4, 1, easing!"easeInCubic"));
  queue(new TranslationEvent(28.beat0, 24, Vector(HWW/2, HWH/2), Vector(WIDTH/4, HEIGHT/4), easing!"easeOutBack"));
  
  enum end = float.infinity;
  // introduction
  queue(new TextEvent(26.5, end, Point(3, 3), "V\nP\nN"));
  queue(new TextEvent(27, end, Point(4, 3), "irtual"));
  queue(new TextEvent(27.5, end, Point(4, 4), "rivate"));
  queue(new TextEvent(27.75, end, Point(4, 5), "etwork"));
  queue(new TextEvent(28, end, Point(1, 8), [0, 1, 0], "Supposed use cases:"));
  queue(new TextEvent(29, end, Point(3, 10), [0, .5, 0], "* Staying private online"));
  queue(new TextEvent(30.5, end, Point(3, 11), [0, .5, 0], "* Encrypting your web traffic")); 
  queue(new TextEvent(31.5, end, Point(3, 12), [0, .5, 0], "* Prevent hackers")); 
  queue(new TextEvent(32.75, end, Point(1, 14), "But what actually *is* a VPN?"));
  // network
  queue(new TranslationEvent(36, 37.5, Vector(WIDTH/4, HEIGHT/4), Vector(WIDTH, HEIGHT/2), easing!"easeOutQuad"));
  queue(new ZoomEvent(36, 37.5, 1, 2, easing!"easeOutBack"));
  queue(new TextEvent(36, end, Point(WIDTH-4, 1), "Network"));
  string network  = readText("assets/network.txt");
  string networkC = network.replaceAll(`[^A^B^C^D^E^\n^ ]`.regex, " ");
  string networkI = network.replaceAll(`[ABCDE]`.regex, " ");
  string network2  = readText("assets/network2.txt");
  string network2C = network2.replaceAll(`[^A^B^C^D^E^\n^ ]`.regex, " ");
  string network2I = network2.replaceAll(`[ABCDE]`.regex, " ");
  queue(new TextEvent(41, end, Point(WIDTH-12, 10), [1, 0, 1], [0, 0, 0], networkC, false));
  queue(new TextEvent(41.5, end, Point(WIDTH-12, 10), networkI, false));
  queue(new TextEvent(43, end, Point(2+WIDTH/2, HEIGHT-10), "Usually some sort of internet connection, such as a"));
  queue(new TextEvent(45.5, end, Point(3+WIDTH/2, HEIGHT-9), [.6, .6, .8], "* Private Network"));
  queue(new TextEvent(46.25, end, Point(3+WIDTH/2, HEIGHT-8), [.6, .6, .8], "* Public Network"));
  queue(new TextEvent(47.5, end, Point(WIDTH+20, 8), [1, 0, 1], "A\nB\nC\nD\nE"));
  for(int i = 0; i < 5; i++)
    queue(new TextEvent(49, end, Point(WIDTH+2, 8+i), genIPv4));
  queue(new TextEvent(54.5, end, Point(WIDTH+2, 7), [.5, 1, 0], "IPv4"));
  queue(new TextEvent(58.5, end, Point(WIDTH-3, 15), [.5, 1, 0], "IPv6"));
  for(int i = 0; i < 5; i++)
    queue(new TextEvent(59.75, end, Point(WIDTH-3, 16+i), genIPv6));
  queue(new TranslationEvent(64, 66, Vector(WIDTH, HEIGHT/2), Vector(WIDTH/4, HEIGHT), easing!"easeOutSine"));
  queue(new ZoomEvent(64, 66, 2, 1.5, easing!"easeInOutBack"));
  queue(new TextEvent(61, end, Point(2, 30), [1, 1,  0], "Communications done with"));
  queue(new TextEvent(66.5, end, Point(2, 31), [.6, .6, 0], "* Radiowaves (bluetooth, WiFi)"));
  queue(new TextEvent(68, end, Point(2, 32), [.6, .6, 0], "* Fiber-Optic cables"));
  queue(new TextEvent(70, end, Point(2, 33), [.6, .6, 0], "* And other cables too, probably!"));
  // private network
  queue(new TranslationEvent(60+11, 60+14, Vector(WIDTH/4, HEIGHT), Vector(WIDTH, HEIGHT*1.5), easing!"easeOutQuad"));
  queue(new ZoomEvent(60+11, 60+14, 1.5, 2, easing!"easeInOutQuint"));
  queue(new TextEvent(60+11, end, Point(WIDTH-6, HWH-2), "Private Network"));
  queue(new TextEvent(60+11, end, Point(WIDTH-20, HWH-20), [1, 0, 1], networkC, false));
  queue(new TextEvent(60+11, end, Point(WIDTH-20, HWH-20), networkI, false));
  queue(new BoxEvent(60+15, end, Point(WIDTH-22, HWH-22), Point(WIDTH-10, HWH-10), [0, 1, 1]));
  queue(new TextEvent(60+15.5, end, Point(WIDTH-18, HWH-22), [0, .5, .5], "Local"));
  for(int i = 0; i < 5; i++) {
    queue(new TextEvent(60+16.5, end, Point(WIDTH-22, HWH-28+i), [0, .5, .5], genLocalIPv4));
    queue(new TextEvent(60+16.5, end, Point(WIDTH-5, HWH-28+i), [1, 0, 1], ""~cast(char)('A'+i)));
  }
  queue(new TextEvent(60+19, end, Point(WIDTH-22, HWH-29), "Local IPs (only exist on the private network):"));
  queue(new TextEvent(60+27, end, Point(WIDTH-22, HWH-16), [0, 1, 0], "R"));
  queue(new TextEvent(60+27, end, Point(WIDTH-21, HWH-16), "-+"));
  queue(new TextEvent(60+29, end, Point(WIDTH-22, HWH-30), [0, .5, 0], genIPv4));
  queue(new TextEvent(60+29, end, Point(WIDTH-5, HWH-30), [0, 1, 0], "Router"));
  queue(new TextEvent(60+33, end, Point(WIDTH-8, HWH-21), [.5, .5, 1], "Anyone who has internet access probably\n has a private network."));
  queue(new TextEvent(60+38, end, Point(WIDTH-8, HWH-18), [.5, .5, 1], "Private networks are commonly used to\n connect to peripherals, like printers."));
  queue(new TextEvent(60+44, end, Point(WIDTH-8, HWH-15), [.5, .5, 1], "Local area network (LAN) in video games\n also uses the private network"));
  // virtual private network
  queue(new TranslationEvent(60+49, 60+52, Vector(WIDTH, HEIGHT*1.5), Vector(WIDTH/2, HEIGHT*1.5), easing!"easeOutCubic"));
  queue(new TextEvent(60+49, end, Point(1, HWH-2), "Virtual Private Network"));
  queue(new TextEvent(60+55, end, Point(8, HWH-20), [1, 0, 1], network2C, false));
  queue(new TextEvent(60+55, end, Point(8, HWH-20), network2I, false));
  queue(new BoxEvent(60+55, end, Point(6, HWH-22), Point(18, HWH-10), [0, 1, 1]));
  queue(new TextEvent(60+55.1, end, Point(18, HWH-16), [1, 1, 0], "R"));
  queue(new TextEvent(60+56, end, Point(19, HWH-16), [0, .5, 0], "-".repeat(23)));
  queue(new TranslationEvent(2*60+1.5, 2*60+4, Vector(WIDTH/2, HEIGHT*1.5), Vector(WIDTH-22, HWH-16), easing!"easeOutCubic"));
  queue(new ZoomEvent(2*60+1.5, 2*60+4, 2, 0.5, easing!"easeOutSine"));
  queue(new TranslationEvent(2*60+4, 2*60+6, Vector(WIDTH-22, HWH-16), Vector(18, HWH-16)));
  queue(new TranslationEvent(2*60+8, 2*60+11, Vector(18, HWH-16), Vector(WIDTH/2, HEIGHT*1.5)));
  queue(new ZoomEvent(2*60+8, 2*60+11, .5, 2, easing!"easeOutBack"));
  queue(new TextEvent(2*60+8, end, Point(6, HWH-29), [.5, .5, 0], genIPv4));
  queue(new TextEvent(2*60+8, end, Point(26, HWH-29), [1, 1, 0], "R"));
  for(int i = 0; i < 3; i++) {
    queue(new TextEvent(2*60+8, end, Point(6, HWH-28+i), [.5, 0, .5], genLocalIPv4));
    queue(new TextEvent(2*60+8.5, end, Point(26, HWH-28+i), [1, 0, 1], ""~cast(char)('A'+i)));
  }
  queue(new TextEvent(2*60+14, end, Point(20, HWH-8), [1, .5, .5], "When using a VPN, it replaces your\n address with the VPN's address"));
  queue(new TextEvent(2*60+18, end, Point(20, HWH-4), [1, .5, .5], "VPNs let you access peripherals not\n directly connected to your private network"));

  queue(new TranslationEvent(2*60+32.5, 2*60+37, Vector(WIDTH/2, HEIGHT*1.5), Vector(HWW-WIDTH/4, HWH/2), easing!"easeOutCubic"));
  queue(new ZoomEvent(2*60+32.5, 2*60+34.75, 2, 3, easing!"easeOutCubic"));
  queue(new ZoomEvent(2*60+34.75, 2*60+37, 3, 1.5, easing!"easeInCubic"));

  queue(new TextEvent(2*60+32, end, Point(HWW-39, 24), [1, 0, 0], "This is usually *NOT*\n the use case people are\n referring to."));
  queue(new TextEvent(2*60+39, end, Point(HWW-39, 28), [.2, 1, .2], "What VPN companies advertise\n is a secure connection\n to the internet."));
  queue(new TextEvent(2*60+43, end, Point(HWW-39, 32), [.2, 1, .2], "These VPNs work basically the same,\n but act as proxies instead of\n allowing access to resources."));
  queue(new TextEvent(2*60+51.5, end, Point(HWW-39, 40), [.5, 0, 1], "R"));
  queue(new TextEvent(2*60+51.5, end, Point(HWW-9, 40), [1, 0, .5], "R"));
  queue(new TextEvent(2*60+51.5, end, Point(HWW-38, 40), "-".repeat(29)));
  queue(new TextEvent(2*60+53, end, Point(HWW-36, 42), [.5, 0, 1], genIPv4));
  queue(new TextEvent(2*60+53, end, Point(HWW-39, 43), "=>"));
  queue(new TextEvent(2*60+53, end, Point(HWW-36, 43), [1, 0, .5], genIPv4));
  // claims made by VPN companies
  // VPNs add security
  queue(new BoxEvent(2*60+58, end, Point(HWW, 0), Point(WW-2, WH-1), [0, 0, 0], [0, 1, 1]));
  queue(new TextEvent(2*60+58.5, end, Point(HWW, 0), [0, 0, 0], [0, .5, .5], "+"));
  queue(new TextEvent(2*60+58.5, end, Point(WW-2, 0), [0, 0, 0], [0, .5, .5], "+"));
  queue(new TextEvent(2*60+58.5, end, Point(HWW, WH-1), [0, 0, 0], [0, .5, .5], "+"));
  queue(new TextEvent(2*60+58.5, end, Point(WW-2, WH-1), [0, 0, 0], [0, .5, .5], "+"));
  queue(new TranslationEvent(2*60+58, 3*60, Vector(HWW-WIDTH/4, HWH/2), Vector(HWW+WIDTH/4, HEIGHT/4), easing!"easeOutQuad"));
  queue(new ZoomEvent(2*60+58, 3*60, 1.5, 1, easing!"easeOutQuad"));
  queue(new TextEvent(2*60+58, end, Point(HWW+2, 2), "Some of these companies also\nclaim to encypt your data, too"));
  queue(new TextEvent(3*60+1, end, Point(HWW+2, 5), [0, .5, .5], "\"an encrypted tunnel\nfor your data\""));
  queue(new TranslationEvent(3*60+4, 3*60+5, Vector(HWW+WIDTH/4, HEIGHT/4), Vector(HWW+WIDTH/2, HEIGHT/2), easing!"easeOutCubic"));
  queue(new ZoomEvent(3*60+4, 3*60+5, 1, 2, easing!"easeOutCubic"));
  queue(new TextEvent(3*60+4, end, Point(HWW+2, 10), "They claim that this increases security, but your data is \n/already/ encrypted,so this doesn't matter that much."));
  queue(new TextEvent(3*60+5, 3*60+5.5, Point(HWW+2, 8), [1, 0, 0], "security*"));
  queue(new TextEvent(3*60+9.5, end, Point(HWW+2, 15), [0, 1, .5], "H\nT\nT\nP\nS"));
  queue(new TextEvent(3*60+10.25, end, Point(HWW+3, 15), "yper"));
  queue(new TextEvent(3*60+10.5, end, Point(HWW+3, 16), "ext"));
  queue(new TextEvent(3*60+10.75, end, Point(HWW+3, 17), "ransfer"));
  queue(new TextEvent(3*60+11, end, Point(HWW+3, 18), "rotocol"));
  queue(new TextEvent(3*60+11.5, end, Point(HWW+3, 19), "ecure"));
  queue(new TextEvent(3*60+11.5, 3*60+12, Point(HWW+13, 19), [1, 0, 0], "(I forgot to put it in the script lol)"));
  queue(new TextEvent(3*60+13, end, Point(HWW+3, 21), [1, .5, 1], "* Dominant protocol used in over 93% of web traffic"));
  queue(new TextEvent(3*60+15, end, Point(HWW+3, 22), [1, .5, 1], "* Extremely secure"));
  queue(new TextEvent(3*60+16, end, Point(HWW+3, 23), [1, .5, 1], "* It's becoming increasingly difficult *not* to use"));
  queue(new TextEvent(3*60+21.5, end, Point(HWW+5, 26), [1, .5, .5], "These companies claim that VPNs make it harder\nfor hackers to access your data"));
  queue(new TranslationEvent(3*60+21.5, 3*60+24, Vector(HWW+WIDTH/2, HEIGHT/2), Vector(HWW+WIDTH/2, HEIGHT+6), easing!"easeOutCubic"));
  queue(new TextEvent(3*60+27, end, Point(HWW+3, 28), [.5, 1, .5], "This isn't really true either."));
  queue(new TextEvent(3*60+29, end, Point(HWW+3, 29), "91% are phishing."));
  queue(new TextEvent(3*60+30, end, Point(HWW+3, 30), [1, 0, 1], "Phishing is sending a fake email (or other message)\npretending to be someone you trust, such as a:"));
  queue(new TextEvent(3*60+33, end, Point(HWW+4, 32), [1, 1, 0], "-> Bank"));
  queue(new TextEvent(3*60+33.25, end, Point(HWW+4, 33), [1, 1, 0], "-> Government institution"));
  queue(new TextEvent(3*60+34.25, end, Point(HWW+4, 34), [1, 1, 0], "-> Website you have an account for"));
  queue(new TextEvent(3*60+36, end, Point(HWW+3, 36), [1, 0, 1], "This message contains a link to a fake login, and when\n you enter your login info, the hacker steals it."));
  enum HWW2 = HWW+WIDTH;
  queue(new TranslationEvent(3*60+43, 3*60+45, Vector(HWW+WIDTH/2, HEIGHT+6), Vector(HWW2+WIDTH/2, HEIGHT/3), easing!"easeOutSine"));
  queue(new ZoomEvent(3*60+43, 3*60+45, 2, 1.5, easing!"easeOutBack"));
  queue(new TextEvent(3*60+43, end, Point(HWW2+12, 2), [1, 0, 0], "VPNs can't prevent this sort of attack."));
  queue(new TextEvent(3*60+46, end, Point(HWW2+10, 3), [1, .4, .4], "* You can still access malicious sites with\n or without a VPN"));
  queue(new TextEvent(3*60+51, end, Point(HWW2+10, 6), [0, 1, 0], "What about other attacks though?"));
  queue(new TextEvent(3*60+52, end, Point(HWW2+10, 7), "* HTTPS is like, really secure"));
  queue(new TextEvent(3*60+56, end, Point(HWW2+10, 8), "* It would take longer than the suspected\n lifetime of the universe to break"));
  queue(new TextEvent(4*60, end, Point(HWW2+9, 14), [.5, .5, .5], "Exact numbers (in years) for the curious:
Lifetime of the universe:
  14 000 000 000
Amount of time to break HTTPS:
  1 750 823 527 851 487 515 838 344 967 599 448 
    364 396 526 882 843 832 205 774 359 265
  "));
  // VPNs add privacy
  queue(new TranslationEvent(60*4+3, 60*4+6, Vector(HWW2+WIDTH/2, HEIGHT/3), Vector(WW-WIDTH/2, WH-HEIGHT/2), easing!"easeOutCubic"));
  queue(new ZoomEvent(60*4+3, 60*4+6, 1.5, 2, easing!"easeOutCubic"));
  queue(new TextEvent(60*4+3, end, Point(WW-WIDTH+2, WH-HEIGHT+2), [0, .4, 1], "VPN providers also claim that using\nVPNs are more private than not."));
  queue(new TextEvent(4*60+8, end, Point(WW-WIDTH+2, WH-HEIGHT+4), [0, .5, 0], "Turns out this isn't true either."));
  queue(new TextEvent(4*60+11.5, end, Point(WW-WIDTH+2, WH-HEIGHT+14), "- NordVPN"));
  queue(new TextEvent(4*60+15, end, Point(WW-WIDTH+2, WH-HEIGHT+5), [0, .6, .6], "
\"Government agencies, marketers, internet service providers 
would all love to track and collect your browsing history, 
messages, and other private data. Best way to hide it? Using
a VPN to encrypt your traffic, hide your IP, and cover your 
tracks online. Use it at home, at work, and on the go to 
enjoy non-stop protection.\""));
  queue(new TextEvent(4*60+30, end, Point(WW-WIDTH+2, WH-HEIGHT+16), [1, 0, 0], "Turns out, this isn't true either!"));
  queue(new TextEvent(4*60+34.5, end, Point(WW-WIDTH+2, WH-HEIGHT+18), [1, 0, .5], "Pretty much *all* a VPN does is change your IP."));
  queue(new TextEvent(4*60+37, end, Point(WW-WIDTH+2, WH-HEIGHT+19), [1, 0, .5], "It might encrypt your data a bit but\n it's /already/ encrypted via HTTPS."));
  queue(new TextEvent(4*60+44, end, Point(WW-WIDTH+2, WH-HEIGHT+21), [.5, 0, 1], "VPNs don't prevent companies from using\n tracking cookies, the main way\n companies track you."));
  string browser = readText("assets/browser.txt");
  queue(new TranslationEvent(4*60+47, 4*60+49, Vector(WW-WIDTH*1.5, WH-HEIGHT/2), easing!"easeOutCubic"));
  queue(new TextEvent(4*60+47, end, Point(HWW+2, WH-20), [1, 0, 0], browser));
  queue(new TextEvent(4*60+47.5, end, Point(HWW+3, WH-20+1), "https://www.google.com"));
  queue(new BoxEvent(4*60+47.5, end, Point(HWW+2+(27/2)-6, WH-20+5), Point(HWW+2+(27/2)+6, WH-20+7), [1, 1, 1]));
  queue(new TextEvent(4*60+50, end, Point(HWW+5, WH-10), `
|
|
|
+--> [data]
  `));
  queue(new TextEvent(4*60+53, end, Point(HWW+30, WH-12), [.5, 1, 1], "These are neccesary for the modern \ninternet."));
  queue(new TextEvent(4*60+55.5, end, Point(HWW+30, WH-10), [.5, 1, 1], "They're how websites remember that \nyou're logged in."));
  queue(new TextEvent(5*60+1.5, end, Point(HWW+7, WH-8), [.5, 1, 1], "Typically, websites can only ask for cookies\n that were set on that website."));
  queue(new TextEvent(5*60+4.8, end, Point(HWW+20, WH-30), [0, 1, 0], browser));
  queue(new TextEvent(5*60+5, end, Point(HWW+21, WH-29), "https://www.example.com"));
  queue(new TextEvent(5*60+7, end, Point(HWW+18, WH-26), `
+------>
|
|
|
|
|
|
|
|
`));
  queue(new BoxEvent(5*60+7, end, Point(HWW+26, WH-26), Point(HWW+30, WH-23), [1, 0, 0]));
  queue(new TextEvent(5*60+12, end, Point(HWW+2, WH-31), [1, .5, 1], `
An advertising 
service could
place cookies, 
and then it
could record 
every website
you visited 
that uses that
service. 
`));
  
}
