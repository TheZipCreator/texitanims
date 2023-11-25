import texit;
import std.string, std.regex, std.file, std.random, std.conv;

mixin Texit!("../qbicfeet_10x10.png", 10, 2, 1+64*4, 36*4, 64, 36, "VPN Video");

float beat0(float n) {
  return (60f/90f)*n;
}

float beat1(float n)  {
  enum START = 7*60+25.8;
  return START+((60f/120f)*n);
}

string repeat(string s, int n) {
  string res;
  for(int i = 0; i < n; i++)
    res ~= s;
  return res;
}

string genIPv4() {
  string ret = "";
  for(int i = 0; i < 4; i++) {
    if(i != 0)
      ret ~= ".";
    ret ~= uniform(0, 255).to!string;
  }
  return ret;
}

string genLocalIPv4() {
  string ret = "192.168.";
  for(int i = 0; i < 2; i++) {
    if(i != 0)
      ret ~= ".";
    ret ~= uniform(0, 255).to!string;
  }
  return ret;
}

string genIPv6() {
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

float end = 0.beat1;

int endBeat = 0;
int evtCount = 0;

void queuec(Event e) {
  if(evtCount%7 == 0) {
    endBeat++;
    if(endBeat > 32)
      endBeat = 32;
    end = endBeat.beat1;
  }
  queue(e);
  evtCount++;
}

void setup() {
  // keep window in same place
  offset = off;
  audio("assets/vpns.ogg");
  enum HWW = 1+64*2;
  enum HWH = 36*2;
  zoom = 4;
  translation = Vector(HWW/2, HWH/2);
  // intro
  queuec(new TextEvent(4.beat0, end, Point(1, 0), [0, 0, 0], [1, 0, 0], "-".repeat(HWW-3)));
  queuec(new TextEvent(4.beat0, end, Point(1, HWH-1), [0, 0, 0], [255, 0, 0], "-".repeat(HWW-3)));
  queuec(new TextEvent(12.beat0, end, Point(0, 1), [0, 0, 0], [1, 0, 0], "|\n".repeat(HWH-2)));
  queuec(new TextEvent(12.beat0, end, Point(HWW-2, 1), [0, 0, 0], [255, 0, 0], "|\n".repeat(HWH-2)));

  queuec(new TextEvent(20.beat0, end, Point(0, 0), [0, 0, 0], [.5, 0, 0], "+"));
  queuec(new TextEvent(20.beat0, end, Point(HWW-2, 0), [0, 0, 0], [.5, 0, 0], "+"));
  queuec(new TextEvent(20.beat0, end, Point(HWW-2, HWH-1), [0, 0, 0], [.5, 0, 0], "+"));
  queuec(new TextEvent(20.beat0, end, Point(0, HWH-1), [0, 0, 0], [.5, 0, 0], "+"));
  
  queuec(new ZoomEvent(28.beat0, 24, 4, 1, easing!"easeInCubic"));
  queuec(new TranslationEvent(28.beat0, 24, Vector(HWW/2, HWH/2), Vector(WIDTH/4, HEIGHT/4), easing!"easeOutBack"));
  

  
  // introduction
  queuec(new TextEvent(26.5, end, Point(3, 3), "V\nP\nN"));
  queuec(new TextEvent(27, end, Point(4, 3), "irtual"));
  queuec(new TextEvent(27.5, end, Point(4, 4), "rivate"));
  queuec(new TextEvent(27.75, end, Point(4, 5), "etwork"));
  queuec(new TextEvent(28, end, Point(1, 8), [0, 1, 0], "Supposed use cases:"));
  queuec(new TextEvent(29, end, Point(3, 10), [0, .5, 0], "* Staying private online"));
  queuec(new TextEvent(30.5, end, Point(3, 11), [0, .5, 0], "* Encrypting your web traffic")); 
  queuec(new TextEvent(31.5, end, Point(3, 12), [0, .5, 0], "* Prevent hackers")); 
  queuec(new TextEvent(32.75, end, Point(1, 14), "But what actually *is* a VPN?"));
  // network
  queuec(new TranslationEvent(36, 37.5, Vector(WIDTH/4, HEIGHT/4), Vector(WIDTH, HEIGHT/2), easing!"easeOutQuad"));
  queuec(new ZoomEvent(36, 37.5, 1, 2, easing!"easeOutBack"));
  queuec(new TextEvent(36, end, Point(WIDTH-4, 1), "Network"));
  string network  = readText("assets/network.txt");
  string networkC = network.replaceAll(`[^A^B^C^D^E^\n^ ]`.regex, " ");
  string networkI = network.replaceAll(`[ABCDE]`.regex, " ");
  string network2  = readText("assets/network2.txt");
  string network2C = network2.replaceAll(`[^A^B^C^D^E^\n^ ]`.regex, " ");
  string network2I = network2.replaceAll(`[ABCDE]`.regex, " ");
  queuec(new TextEvent(41, end, Point(WIDTH-12, 10), [1, 0, 1], [0, 0, 0], networkC, false));
  queuec(new TextEvent(41.5, end, Point(WIDTH-12, 10), networkI, false));
  queuec(new TextEvent(43, end, Point(2+WIDTH/2, HEIGHT-10), "Usually some sort of internet connection, such as a"));
  queuec(new TextEvent(45.5, end, Point(3+WIDTH/2, HEIGHT-9), [.6, .6, .8], "* Private Network"));
  queuec(new TextEvent(46.25, end, Point(3+WIDTH/2, HEIGHT-8), [.6, .6, .8], "* Public Network"));
  queuec(new TextEvent(47.5, end, Point(WIDTH+20, 8), [1, 0, 1], "A\nB\nC\nD\nE"));
  for(int i = 0; i < 5; i++)
    queuec(new TextEvent(49, end, Point(WIDTH+2, 8+i), genIPv4));
  queuec(new TextEvent(54.5, end, Point(WIDTH+2, 7), [.5, 1, 0], "IPv4"));
  queuec(new TextEvent(58.5, end, Point(WIDTH-3, 15), [.5, 1, 0], "IPv6"));
  for(int i = 0; i < 5; i++)
    queuec(new TextEvent(59.75, end, Point(WIDTH-3, 16+i), genIPv6));
  queuec(new TranslationEvent(64, 66, Vector(WIDTH, HEIGHT/2), Vector(WIDTH/4, HEIGHT), easing!"easeOutSine"));
  queuec(new ZoomEvent(64, 66, 2, 1.5, easing!"easeInOutBack"));
  queuec(new TextEvent(61, end, Point(2, 30), [1, 1,  0], "Communications done with"));
  queuec(new TextEvent(66.5, end, Point(2, 31), [.6, .6, 0], "* Radiowaves (bluetooth, WiFi)"));
  queuec(new TextEvent(68, end, Point(2, 32), [.6, .6, 0], "* Fiber-Optic cables"));
  queuec(new TextEvent(70, end, Point(2, 33), [.6, .6, 0], "* And other cables too, probably!"));
  // private network
  queuec(new TranslationEvent(60+11, 60+14, Vector(WIDTH/4, HEIGHT), Vector(WIDTH, HEIGHT*1.5), easing!"easeOutQuad"));
  queuec(new ZoomEvent(60+11, 60+14, 1.5, 2, easing!"easeInOutQuint"));
  queuec(new TextEvent(60+11, end, Point(WIDTH-6, HWH-2), "Private Network"));
  queuec(new TextEvent(60+11, end, Point(WIDTH-20, HWH-20), [1, 0, 1], networkC, false));
  queuec(new TextEvent(60+11, end, Point(WIDTH-20, HWH-20), networkI, false));
  queuec(new BoxEvent(60+15, end, Point(WIDTH-22, HWH-22), Point(WIDTH-10, HWH-10), [0, 1, 1]));
  queuec(new TextEvent(60+15.5, end, Point(WIDTH-18, HWH-22), [0, .5, .5], "Local"));
  for(int i = 0; i < 5; i++) {
    queuec(new TextEvent(60+16.5, end, Point(WIDTH-22, HWH-28+i), [0, .5, .5], genLocalIPv4));
    queuec(new TextEvent(60+16.5, end, Point(WIDTH-5, HWH-28+i), [1, 0, 1], ""~cast(char)('A'+i)));
  }
  queuec(new TextEvent(60+19, end, Point(WIDTH-22, HWH-29), "Local IPs (only exist on the private network):"));
  queuec(new TextEvent(60+27, end, Point(WIDTH-22, HWH-16), [0, 1, 0], "R"));
  queuec(new TextEvent(60+27, end, Point(WIDTH-21, HWH-16), "-+"));
  queuec(new TextEvent(60+29, end, Point(WIDTH-22, HWH-30), [0, .5, 0], genIPv4));
  queuec(new TextEvent(60+29, end, Point(WIDTH-5, HWH-30), [0, 1, 0], "Router"));
  queuec(new TextEvent(60+33, end, Point(WIDTH-8, HWH-21), [.5, .5, 1], "Anyone who has internet access probably\n has a private network."));
  queuec(new TextEvent(60+38, end, Point(WIDTH-8, HWH-18), [.5, .5, 1], "Private networks are commonly used to\n connect to peripherals, like printers."));
  queuec(new TextEvent(60+44, end, Point(WIDTH-8, HWH-15), [.5, .5, 1], "Local area network (LAN) in video games\n also uses the private network"));
  // virtual private network
  queuec(new TranslationEvent(60+49, 60+52, Vector(WIDTH, HEIGHT*1.5), Vector(WIDTH/2, HEIGHT*1.5), easing!"easeOutCubic"));
  queuec(new TextEvent(60+49, end, Point(1, HWH-2), "Virtual Private Network"));
  queuec(new TextEvent(60+55, end, Point(8, HWH-20), [1, 0, 1], network2C, false));
  queuec(new TextEvent(60+55, end, Point(8, HWH-20), network2I, false));
  queuec(new BoxEvent(60+55, end, Point(6, HWH-22), Point(18, HWH-10), [0, 1, 1]));
  queuec(new TextEvent(60+55.1, end, Point(18, HWH-16), [1, 1, 0], "R"));
  queuec(new TextEvent(60+56, end, Point(19, HWH-16), [0, .5, 0], "-".repeat(23)));
  queuec(new TranslationEvent(2*60+1.5, 2*60+4, Vector(WIDTH/2, HEIGHT*1.5), Vector(WIDTH-22, HWH-16), easing!"easeOutCubic"));
  queuec(new ZoomEvent(2*60+1.5, 2*60+4, 2, 0.5, easing!"easeOutSine"));
  queuec(new TranslationEvent(2*60+4, 2*60+6, Vector(WIDTH-22, HWH-16), Vector(18, HWH-16)));
  queuec(new TranslationEvent(2*60+8, 2*60+11, Vector(18, HWH-16), Vector(WIDTH/2, HEIGHT*1.5)));
  queuec(new ZoomEvent(2*60+8, 2*60+11, .5, 2, easing!"easeOutBack"));
  queuec(new TextEvent(2*60+8, end, Point(6, HWH-29), [.5, .5, 0], genIPv4));
  queuec(new TextEvent(2*60+8, end, Point(26, HWH-29), [1, 1, 0], "R"));
  for(int i = 0; i < 3; i++) {
    queuec(new TextEvent(2*60+8, end, Point(6, HWH-28+i), [.5, 0, .5], genLocalIPv4));
    queuec(new TextEvent(2*60+8.5, end, Point(26, HWH-28+i), [1, 0, 1], ""~cast(char)('A'+i)));
  }
  queuec(new TextEvent(2*60+14, end, Point(20, HWH-8), [1, .5, .5], "When using a VPN, it replaces your\n address with the VPN's address"));
  queuec(new TextEvent(2*60+18, end, Point(20, HWH-4), [1, .5, .5], "VPNs let you access peripherals not\n directly connected to your private network"));
  queuec(new TranslationEvent(2*60+32.5, 2*60+37, Vector(WIDTH/2, HEIGHT*1.5), Vector(HWW-WIDTH/4, HWH/2), easing!"easeOutCubic"));
  queuec(new ZoomEvent(2*60+32.5, 2*60+34.75, 2, 3, easing!"easeOutCubic"));
  queuec(new ZoomEvent(2*60+34.75, 2*60+37, 3, 1.5, easing!"easeInCubic"));

  queuec(new TextEvent(2*60+32, end, Point(HWW-39, 24), [1, 0, 0], "This is usually *NOT*\n the use case people are\n referring to."));
  queuec(new TextEvent(2*60+39, end, Point(HWW-39, 28), [.2, 1, .2], "What VPN companies advertise\n is a secure connection\n to the internet."));
  queuec(new TextEvent(2*60+43, end, Point(HWW-39, 32), [.2, 1, .2], "These VPNs work basically the same,\n but act as proxies instead of\n allowing access to resources."));
  queuec(new TextEvent(2*60+51.5, end, Point(HWW-39, 40), [.5, 0, 1], "R"));
  queuec(new TextEvent(2*60+51.5, end, Point(HWW-9, 40), [1, 0, .5], "R"));
  queuec(new TextEvent(2*60+51.5, end, Point(HWW-38, 40), "-".repeat(29)));
  queuec(new TextEvent(2*60+53, end, Point(HWW-36, 42), [.5, 0, 1], genIPv4));
  queuec(new TextEvent(2*60+53, end, Point(HWW-39, 43), "=>"));
  queuec(new TextEvent(2*60+53, end, Point(HWW-36, 43), [1, 0, .5], genIPv4));
  // claims made by VPN companies
  // VPNs add security
  queuec(new BoxEvent(2*60+58, end, Point(HWW, 0), Point(WW-2, HWH-1), [0, 0, 0], [0, 1, 1]));
  queuec(new TextEvent(2*60+58.5, end, Point(HWW, 0), [0, 0, 0], [0, .5, .5], "+"));
  queuec(new TextEvent(2*60+58.5, end, Point(WW-2, 0), [0, 0, 0], [0, .5, .5], "+"));
  queuec(new TextEvent(2*60+58.5, end, Point(HWW, HWH-1), [0, 0, 0], [0, .5, .5], "+"));
  queuec(new TextEvent(2*60+58.5, end, Point(WW-2, HWH-1), [0, 0, 0], [0, .5, .5], "+"));
  queuec(new TranslationEvent(2*60+58, 3*60, Vector(HWW-WIDTH/4, HWH/2), Vector(HWW+WIDTH/4, HEIGHT/4), easing!"easeOutQuad"));
  queuec(new ZoomEvent(2*60+58, 3*60, 1.5, 1, easing!"easeOutQuad"));
  queuec(new TextEvent(2*60+58, end, Point(HWW+2, 2), "Some of these companies also\nclaim to encypt your data, too"));
  queuec(new TextEvent(3*60+1, end, Point(HWW+2, 5), [0, .5, .5], "\"an encrypted tunnel\nfor your data\""));
  queuec(new TranslationEvent(3*60+4, 3*60+5, Vector(HWW+WIDTH/4, HEIGHT/4), Vector(HWW+WIDTH/2, HEIGHT/2), easing!"easeOutCubic"));
  queuec(new ZoomEvent(3*60+4, 3*60+5, 1, 2, easing!"easeOutCubic"));
  queuec(new TextEvent(3*60+4, end, Point(HWW+2, 10), "They claim that this increases security, but your data is \n/already/ encrypted,so this doesn't matter that much."));
  queuec(new TextEvent(3*60+5, 3*60+5.5, Point(HWW+2, 8), [1, 0, 0], "security*"));
  queuec(new TextEvent(3*60+9.5, end, Point(HWW+2, 15), [0, 1, .5], "H\nT\nT\nP\nS"));
  queuec(new TextEvent(3*60+10.25, end, Point(HWW+3, 15), "yper"));
  queuec(new TextEvent(3*60+10.5, end, Point(HWW+3, 16), "ext"));
  queuec(new TextEvent(3*60+10.75, end, Point(HWW+3, 17), "ransfer"));
  queuec(new TextEvent(3*60+11, end, Point(HWW+3, 18), "rotocol"));
  queuec(new TextEvent(3*60+11.5, end, Point(HWW+3, 19), "ecure"));
  queuec(new TextEvent(3*60+11.5, 3*60+12, Point(HWW+13, 19), [1, 0, 0], "(I forgot to put it in the script lol)"));
  queuec(new TextEvent(3*60+13, end, Point(HWW+3, 21), [1, .5, 1], "* Dominant protocol used in over 93% of web traffic"));
  queuec(new TextEvent(3*60+15, end, Point(HWW+3, 22), [1, .5, 1], "* Extremely secure"));
  queuec(new TextEvent(3*60+16, end, Point(HWW+3, 23), [1, .5, 1], "* It's becoming increasingly difficult *not* to use"));
  queuec(new TextEvent(3*60+21.5, end, Point(HWW+5, 26), [1, .5, .5], "These companies claim that VPNs make it harder\nfor hackers to access your data"));
  queuec(new TranslationEvent(3*60+21.5, 3*60+24, Vector(HWW+WIDTH/2, HEIGHT/2), Vector(HWW+WIDTH/2, HEIGHT+6), easing!"easeOutCubic"));
  queuec(new TextEvent(3*60+27, end, Point(HWW+3, 28), [.5, 1, .5], "This isn't really true either."));
  queuec(new TextEvent(3*60+29, end, Point(HWW+3, 29), "91% are phishing."));
  queuec(new TextEvent(3*60+30, end, Point(HWW+3, 30), [1, 0, 1], "Phishing is sending a fake email (or other message)\npretending to be someone you trust, such as a:"));
  queuec(new TextEvent(3*60+33, end, Point(HWW+4, 32), [1, 1, 0], "-> Bank"));
  queuec(new TextEvent(3*60+33.25, end, Point(HWW+4, 33), [1, 1, 0], "-> Government institution"));
  queuec(new TextEvent(3*60+34.25, end, Point(HWW+4, 34), [1, 1, 0], "-> Website you have an account for"));
  queuec(new TextEvent(3*60+36, end, Point(HWW+3, 36), [1, 0, 1], "This message contains a link to a fake login, and when\n you enter your login info, the hacker steals it."));
  enum HWW2 = HWW+WIDTH;
  queuec(new TranslationEvent(3*60+43, 3*60+45, Vector(HWW+WIDTH/2, HEIGHT+6), Vector(HWW2+WIDTH/2, HEIGHT/3), easing!"easeOutSine"));
  queuec(new ZoomEvent(3*60+43, 3*60+45, 2, 1.5, easing!"easeOutBack"));
  queuec(new TextEvent(3*60+43, end, Point(HWW2+12, 2), [1, 0, 0], "VPNs can't prevent this sort of attack."));
  queuec(new TextEvent(3*60+46, end, Point(HWW2+10, 3), [1, .4, .4], "* You can still access malicious sites with\n or without a VPN"));
  queuec(new TextEvent(3*60+51, end, Point(HWW2+10, 6), [0, 1, 0], "What about other attacks though?"));
  queuec(new TextEvent(3*60+52, end, Point(HWW2+10, 7), "* HTTPS is like, really secure"));
  queuec(new TextEvent(3*60+56, end, Point(HWW2+10, 8), "* It would take longer than the suspected\n lifetime of the universe to break"));
  queuec(new TextEvent(4*60, end, Point(HWW2+9, 14), [.5, .5, .5], "Exact numbers (in years) for the curious:
Lifetime of the universe:
  14 000 000 000
Amount of time to break HTTPS:
  1 750 823 527 851 487 515 838 344 967 599 448 
    364 396 526 882 843 832 205 774 359 265
  "));
  // VPNs add privacy
  queuec(new TranslationEvent(60*4+3, 60*4+6, Vector(HWW2+WIDTH/2, HEIGHT/3), Vector(WW-WIDTH/2, HWH-HEIGHT/2), easing!"easeOutCubic"));
  queuec(new ZoomEvent(60*4+3, 60*4+6, 1.5, 2, easing!"easeOutCubic"));
  queuec(new TextEvent(60*4+3, end, Point(WW-WIDTH+2, HWH-HEIGHT+2), [0, .4, 1], "VPN providers also claim that using\nVPNs are more private than not."));
  queuec(new TextEvent(4*60+8, end, Point(WW-WIDTH+2, HWH-HEIGHT+4), [0, .5, 0], "Turns out this isn't true either."));
  queuec(new TextEvent(4*60+11.5, end, Point(WW-WIDTH+2, HWH-HEIGHT+14), "- NordVPN"));
  queuec(new TextEvent(4*60+15, end, Point(WW-WIDTH+2, HWH-HEIGHT+5), [0, .6, .6], "
\"Government agencies, marketers, internet service providers 
would all love to track and collect your browsing history, 
messages, and other private data. Best way to hide it? Using
a VPN to encrypt your traffic, hide your IP, and cover your 
tracks online. Use it at home, at work, and on the go to 
enjoy non-stop protection.\""));
  queuec(new TextEvent(4*60+30, end, Point(WW-WIDTH+2, HWH-HEIGHT+16), [1, 0, 0], "Turns out, this isn't true either!"));
  queuec(new TextEvent(4*60+34.5, end, Point(WW-WIDTH+2, HWH-HEIGHT+18), [1, 0, .5], "Pretty much *all* a VPN does is change your IP."));
  queuec(new TextEvent(4*60+37, end, Point(WW-WIDTH+2, HWH-HEIGHT+19), [1, 0, .5], "It might encrypt your data a bit but\n it's /already/ encrypted via HTTPS."));
  queuec(new TextEvent(4*60+44, end, Point(WW-WIDTH+2, HWH-HEIGHT+21), [.5, 0, 1], "VPNs don't prevent companies from using\n tracking cookies, the main way\n companies track you."));
  string browser = readText("assets/browser.txt");
  queuec(new TranslationEvent(4*60+47, 4*60+49, Vector(WW-WIDTH*1.5, HWH-HEIGHT/2), easing!"easeOutCubic"));
  queuec(new TextEvent(4*60+47, end, Point(HWW+2, HWH-20), [1, 0, 0], browser));
  queuec(new TextEvent(4*60+47.5, end, Point(HWW+3, HWH-20+1), "https://www.google.com"));
  queuec(new BoxEvent(4*60+47.5, end, Point(HWW+2+(27/2)-6, HWH-20+5), Point(HWW+2+(27/2)+6, HWH-20+7), [1, 1, 1]));
  queuec(new TextEvent(4*60+50, end, Point(HWW+5, HWH-10), `
|
|
|
+--> [data]
  `));
  queuec(new TextEvent(4*60+53, end, Point(HWW+30, HWH-12), [.5, 1, 1], "These are neccesary for the modern \ninternet."));
  queuec(new TextEvent(4*60+55.5, end, Point(HWW+30, HWH-10), [.5, 1, 1], "They're how websites remember that \nyou're logged in."));
  queuec(new TextEvent(5*60+1.5, end, Point(HWW+7, HWH-8), [.5, 1, 1], "Typically, websites can only ask for cookies\n that were set on that website."));
  queuec(new TextEvent(5*60+4.8, end, Point(HWW+20, HWH-30), [0, 1, 0], browser));
  queuec(new TextEvent(5*60+5, end, Point(HWW+21, HWH-29), "https://www.example.com"));
  queuec(new TextEvent(5*60+7, end, Point(HWW+18, HWH-26), `
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
  queuec(new BoxEvent(5*60+7, end, Point(HWW+26, HWH-26), Point(HWW+30, HWH-23), [1, 0, 0]));
  queuec(new TextEvent(5*60+12, end, Point(HWW+2, HWH-31), [1, .5, 1], `
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
  queuec(new TextEvent(5*60+20, end, Point(HWW+48, HWH-31), [.5, 1, .5], `
These services
can still track
you, whether you
have a VPN or
not. 
`));
  queuec(new BoxEvent(5*60+24, end, Point(0, HWH+1), Point(HWW-2, WH-1), [0, 0, 0], [0, 1, 0]));
  queuec(new TextEvent(5*60+24.5, end, Point(0, HWH+1), [0, 0, 0], [0, .5, 0], "+"));
  queuec(new TextEvent(5*60+24.5, end, Point(0, WH-1), [0, 0, 0], [0, .5, 0], "+"));
  queuec(new TextEvent(5*60+24.5, end, Point(HWW-2, HWH+1), [0, 0, 0], [0, .5, 0], "+"));
  queuec(new TextEvent(5*60+24.5, end, Point(0, WH-1), [0, 0, 0], [0, .5, 0], "+"));
  queuec(new TranslationEvent(5*60+26.5, 5*60+30, Vector(HWW-1-WIDTH/2, HWH+1+HEIGHT/2), easing!"easeOutCubic"));
  queuec(new TextEvent(5*60+28, end, Point(HWW-WIDTH, HWH+2), [.5, 0, 1], "The only real way VPNs add privacy is that they hide\n websites you're using to your ISP."));
  queuec(new TextEvent(5*60+33.5, end, Point(HWW-WIDTH, HWH+4), [1, 0, 1], "However, even this isn't really that significant."));
  queuec(new TextEvent(5*60+35.5, end, Point(HWW-50, HWH+12), [1, 0, 0], "https://"));
  queuec(new TextEvent(5*60+35.5, end, Point(HWW-50+8, HWH+12), [0, 1, 0], "www.youtube.com"));
  queuec(new TextEvent(5*60+35.5, end, Point(HWW-50+23, HWH+12), [0, 0, 1], "/watch?v=DdQw4w9WgXc"));
  queuec(new TextEvent(5*60+37, 5*60+43.5, Point(HWW-50, HWH+12), `
|                     |
+---------------------+
      This bit  
`));
    queuec(new TextEvent(5*60+41, 5*60+43.5, Point(HWW-50+23, HWH+8), `
They can't see this
+------------------+
|                  |
`));
  queuec(new TextEvent(5*60+44, end, Point(HWW-50, HWH+8), `
    (With a VPN) They can't see this
+-----------------------------------------+
|                                         |
`));
  queuec(new TextEvent(5*60+47, end, Point(HWW-50, HWH+18), [1, 0, 1], "But there's a problem:"));
  queuec(new TextEvent(5*60+48, end, Point(HWW-50, HWH+19), [1, .5, 1], "While a lot of VPNs *promise* to not record\n your traffic, there's really nothing stopping\n them from doing so."));
  queuec(new TranslationEvent(5*60+53, 5*60+54, Vector(HWW-1-WIDTH/2, HWH+1+HEIGHT), easing!"easeOutQuad"));
  queuec(new ZoomEvent(5*60+53, 5*60+54, 1.5, easing!"easeOutQuad"));
  queuec(new TextEvent(5*60+53, end, Point(HWW-54, HWH+25), [.8, 1, 1], "- You're effectively just moving trust from"));
  queuec(new TextEvent(5*60+54.5, end, Point(HWW-28, HWH+30), "one institution"));
  queuec(new TextEvent(5*60+55.25, end, Point(HWW-55, HWH+30), [1, 0, 0], "Internet Service provider"));
  queuec(new TextEvent(5*60+56.5, end, Point(HWW-28, HWH+35), "to another"));
  queuec(new TextEvent(5*60+56.5, end, Point(HWW-53, HWH+30), [.5, .5, 0], `
|
|
|
V
`));
  // VPNs can be hacked / free VPNs
  queuec(new TextEvent(5*60+57, end, Point(HWW-55, HWH+35), [1, 1, 0], "VPN Provider"));
  queuec(new TextEvent(5*60+58, end, Point(HWW-54, HWH+37), [.8, 1, 1], "- VPNs, like any other service, can be\n hacked."));
  queuec(new TextEvent(6*60+1, end, Point(HWW-54, HWH+39), [.8, 1, 1],  "- This could have potentially\n disastorous results for your privacy."));
  queuec(new TranslationEvent(6*60+5.5, 6*60+7, Vector(HWW-1-WIDTH/2, HWH+55), easing!"easeOutCubic"));
  queuec(new TextEvent(6*60+5.5, end, Point(HWW-54, HWH+43), [1, 0, 0],"Free VPNs are especially bad with privacy."));
  queuec(new TextEvent(6*60+8, end, Point(HWW-54, HWH+45), [1, .5, .5], "VPNs need some money to stay afloat, and with\n free VPNs that money comes from selling your\n internet traffic to the highest bidder"));
  queuec(new TextEvent(6*60+13, end, Point(HWW-54, HWH+49), [.5, 1, .5], "That doesn't sound very private!"));
  queuec(new ZoomEvent(6*60+14, 6*60+16, 2, easing!"easeOutBack"));
  queuec(new TranslationEvent(6*60+14, 6*60+16, Vector(WIDTH/2, HWH+54), easing!"easeOutCubic"));
  queuec(new TextEvent(6*60+15, end, Point(2, WH-4), [1, 0, .5], "However, even paid VPNs don't solve the aformentioned problem\n of trust."));
  queuec(new TextEvent(6*60+20, end, Point(10, WH-20), [0, 1, 0], " ----> $$$$$$"));
  queuec(new BoxEvent(6*60+21, end, Point(2, WH-25), Point(8, WH-15), [1, 0, 0]));
  for(int i = 0; i < 9; i++) {
    string s = "";
    for(int j = 0; j < 5; j++)
      s ~= cast(char)'A'+uniform(0, 26);
    queuec(new TextEvent(6*60+21, end, Point(3, WH-24+i), s));
  }
  string govt = readText("assets/government.txt");
  queuec(new TextEvent(6*60+23, end, Point(20, WH-34), [1, 1, 0], govt));
  queuec(new TextEvent(6*60+23.5, end, Point(7, WH-30), `
+-------------
|
|
|
V
`));
  queuec(new TextEvent(6*60+25, end, Point(2, WH-6), [0, 1, 1], "So while VPNs could provide a /little/ more privacy, it might not\n be worth the risks."));
  queuec(new TranslationEvent(6*60+29, 6*60+32, Vector(WIDTH/2, HWH+1+HEIGHT/2), easing!"easeOutCubic"));
  // Accessing websites from a dif location
  queuec(new TextEvent(6*60+25, end, Point(2, HWH+3), [0, 1, 1], "Another use VPN companies advertise is to change your location to be\n able to access resources that may be banned in your current\n country, or to circumvent firewalls set up by authoritarian \n governments."));
  queuec(new TextEvent(6*60+38, end, Point(2, HWH+7), [0, 1, 0], "This is really the only thing VPN companies advertise that is actually\n what they say it is."));
  queuec(new TextEvent(6*60+43, end, Point(2, HWH+10), "However, you don't really need to pay for something like this."));
  queuec(new TextEvent(6*60+45, end, Point(2, HWH+13), "Tor allows you to do it by free by changing a config file."));
  enum H2 = (HWH+WH-1)/2;
  queuec(new TranslationEvent(6*60+49, 6*60+51, Vector(54, H2), easing!"easeOutCubic"));
  queuec(new ZoomEvent(6*60+49, 6*60+51, 1.25, easing!"easeOutBack"));
  queuec(new TextEvent(6*60+49, end, Point(35, H2-10), [0, 0, 1], "In conclusion, VPNs are generally not\n needed for a majority of people."));
  queuec(new TextEvent(6*60+53, end, Point(35, H2-7), [0, 1, 0],  "On top of that, the main things that\n they claim they provide (security and \n privacy) aren't really that much\n stronger with a VPN than without."));
  queuec(new TextEvent(6*60+59, end, Point(35, H2-2), [0, 1, 1],  "There are much better and cheaper\n ways of protecting your privacy online,\n and while VPNs add some small amount\n of security, they are one of the least\n important layers over all."));
  queuec(new TextEvent(7*60+6.5, end, Point(35, H2+4), [1, 0, 0], "They don't add much security to your\n data, and they don't keep you\n anonymous. And, if you want to access\n a website from a different location,\n you can always just use Tor."));
  queuec(new TextEvent(7*60+14, end, Point(35, H2+9),             "VPNs just really aren't a worthwile\n thing to have."));
  queuec(new TranslationEvent(7*60+18, 0.beat1, Vector(WW/2, WH/2), easing!"easeOutQuart"));
  queuec(new ZoomEvent(7*60+18, 0.beat1, 8, easing!"easeOutCubic"));

  // outro
  enum inf = float.infinity;
  queue(new TextEvent(32.beat1, inf, Point(WW/2-10, WH/2-5), "Thanks for watching!"));
  queue(new ZoomEvent(32.beat1, 36.beat1, 1, easing!"easeOutQuad"));
  queue(new BoxEvent(32.beat1, inf, Point(WW/2-15, WH/2-1), Point(WW/2-3, WH/2+7), [1, .5, 0]));
  queue(new BoxEvent(32.beat1, inf, Point(WW/2+2, WH/2-1), Point(WW/2+14, WH/2+7), [0, .5, 1]));
}

// float off = 7*60+40.8;
float off = 0;
