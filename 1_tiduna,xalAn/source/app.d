import texit;

import std.stdio, std.random, std.string;

mixin Texit!("../qbicfeet_10x10.png", 10, 2, 500, 350, 64, 36, "tiduna,xalAn");

string repeat(string s, int n) {
  string res;
  for(int i = 0; i < n; i++)
    res ~= s;
  return res;
}

string tr(string s) {
	dchar[dchar] transTable = [
		'ɬ': '\x80',
		'ɴ': '\x81',
		'ɢ': '\x82',
		'ɑ': '\x83',
		'ɸ': '\x84',
		'β': '\x85',
		'ə': '\x86',
		'ʌ': '\x87'
	];
	return s.translate(transTable);
}

void setup() {
	enum WC = WW/2;
	offset = off;
	audio("./tiduna,xalAn.ogg");
	window.move(1200, 100);
	translation = Vector(WC, WH);
	zoom = 4;
	float end = float.infinity;
	for(int i = 0; i < WH/50; i++) {
		queue(new TextEvent(0, end, Point(0, i*50), [uniform(0.5, 1), uniform(0.5, 1), uniform(0.5, 1)], "/".repeat(WW)));
	}

	queue(new ZoomEvent(0, 11, 5, 1.2, easing!"easeOutQuad"));
	queue(new TranslationEvent(0, 11, Vector(WC, WH), Vector(WC, 10), easing!"easeOutQuad"));

	queue(new TextEvent(11.5, end, Point(WC-17, 2), "Most languages have the concept of"));
	queue(new TextEvent(13.4, end, Point(WC-15, 4), [1, 0, 1], "* the verb"));
	queue(new TextEvent(14, end, Point(WC-15, 6), [1, 0, .5], "* the noun"));
	queue(new TextEvent(15.25, end, Point(WC-5, 3), [0, 1, 1], "
--+
  | Fundamental
--+"));
	queue(new TextEvent(17.75, end, Point(WC-1, 4), [0, .5, .5], "they definitely are"));
	queue(new TextEvent(19, end, Point(WC-17, 8), [1, 1, 1],     "Pretty much every natural human\nlanguage has them"));
	queue(new TextEvent(22, end, Point(WC-17, 10), [.7, .7, .7], "Even many constructed languages that\nclaim not to have them\n/do/ have them."));
	queue(new TextEvent(27, end, Point(WC-17, 13),               "It is very, very difficult to avoid\nhaving them"));
	queue(new TranslationEvent(29, 31, Vector(WC+40, 10), easing!"easeOutQuad"));
	queue(new TextEvent(29.5, end, Point(WC+22, 1), "Semblance of meaning:"));
	queue(new TextEvent(33.25, end, Point(WC+22, 3), [0, 1, 0], "objects"));
	queue(new TextEvent(33.25, end, Point(WC+30, 3), [0, .5, 0], "<->"));
	queue(new TextEvent(33.25, end, Point(WC+34, 3), [0, 1, 0], "nouns"));
	queue(new TextEvent(33.75, end, Point(WC+22, 4), [0, 1, 0], "actions"));
	queue(new TextEvent(33.75, end, Point(WC+30, 4), [0, .5, 0], "<->"));
	queue(new TextEvent(33.75, end, Point(WC+34, 4), [0, 1, 0], "verbs"));
	queue(new TextEvent(36, end, Point(WC+22, 6), [.5, 1, 1],    "And here, I don't intend to remove\nthem."));
	queue(new TextEvent(38.25, end, Point(WC+22, 8), [1, .5, 1], "Instead, I intend to *construct*\nthem in a way that is fundamentally\ndifferent from other languages."));
	queue(new ZoomEvent(38.25, 43, 2, easing!"easeOutCubic"));
	queue(new TranslationEvent(38.25, 43, Vector(WC+51, 18), easing!"easeOutCubic"));
	queue(new TextEvent(43.25, end, Point(WC+40, 2), [1, 0, 0], "
+----------------- Instead of having
|                  roots for these,"));
	queue(new TextEvent(48.5, end, Point(WC+59, 5), [.7, 0, 0], "construct them from\na list of words\nthat describe them.\n(aka adjectives/adverbs)"));
	queue(new TranslationEvent(52.25, 54, Vector(WC+51, 25), easing!"easeOutQuad"));
	queue(new ZoomEvent(52.25, 54, 1.5, easing!"easeOutBack"));
	queue(new TextEvent(52.5, end, Point(WC+32, 19), "
This is the primary idea behind tiduna
                                xalAn"));
	queue(new TranslationEvent(54.75, 56, Vector(WC+51, 63), easing!"easeOutQuad"));
	queue(new TextEvent(54.75, end, Point(WC+38, 51), "How exactly do we turn"));
	queue(new TextEvent(56.5, end, Point(WC+39, 52), [.7, .7, .7], "adjectives"));
	queue(new TextEvent(57.25, end, Point(WC+50, 52), [.7, .7, .7], "-> nouns"));
	queue(new TextEvent(58.5, end, Point(WC+28, 55), [1, 1, .8], "When we think of an object,\nwe can list its properties."));
	queue(new TextEvent(60+2, end, Point(WC+29, 57), [.2, .2, 1], "WATER:"));
	queue(new TextEvent(60+2.75, end, Point(WC+29, 59), [.5, .5, 1], "Liquid"));
	queue(new TextEvent(60+3.5, end, Point(WC+29, 60), [.5, .5, 1], "Blue"));
	queue(new TextEvent(60+4, end, Point(WC+29, 61), [.5, .5, 1], "Edible"));
	queue(new TextEvent(60+5, end, Point(WC+37, 58), [.5, .3, 1], "
plaL
valal
viLt"));
	queue(new TextEvent(60+6.25, end, Point(WC+29, 58), [1, 1, 1], "(descriptors)"));
	queue(new TextEvent(60+13, end, Point(WC+43, 58), [0, 1, 1], "
---+
   | Spoken simultaneously
---+"));
	queue(new TextEvent(60+17.5, end, Point(WC+28, 65), "The hypothetical speakers of this language\nwould require a potentially infinite\namount of mouths."));
	queue(new TranslationEvent(60+22, 60+24, Vector(WC+51, 88), easing!"easeOutQuad"));
	queue(new TextEvent(60+22, end, Point(WC+28, 75), "We can do the same with verbs."));
	queue(new TextEvent(60+25.5, end, Point(WC+29, 76), [1, .2, .2], "TO FLY:"));
	queue(new TextEvent(60+27, end, Point(WC+29, 77), [1, .5, .5],    "Non-Stationary  tineq"));
	queue(new TextEvent(60+28.5, end, Point(WC+29, 78), [1, .5, .5],  "Above           qAxA"));
	queue(new TextEvent(60+32.75, end, Point(WC+29, 79), [1, .5, .5], "VERB            yax"));
	queue(new TextEvent(60+34.75, end, Point(WC+28, 81), [0, 1, 0], "Note that verbs are just a case;\nlike how nominative and accusative are cases."));
	queue(new TextEvent(60+39, end, Point(WC+28, 84), [1, 1, 0],    "They're not exactly cases of /nouns/, though;\nthey're cases of /compounds/."));
	queue(new TextEvent(60+42.5, end, Point(WC+28, 86), "(combinations of descriptors and particles)"));
	queue(new ZoomEvent(60+44, 60+45, 2, easing!"easeOutQuad"));
	queue(new TranslationEvent(60+44, 60+45, Vector(WC+28, 75), easing!"easeOutQuad"));
	queue(new TextEvent(60+46.5, end, Point(WC+10, 60), [.7, .7, 1], "plaL,valal,viLt ="));
	queue(new TextEvent(60+46.5, end, Point(WC+10, 78), [1, .7, .7], "yax,tineq,qAxA  ="));
	queue(new TextEvent(60+47.5, end, Point(WC, 69), "Comma shows simultaneous\npronounciation."));
	queue(new TranslationEvent(60+50, 60+53, Vector(WC-30, 63), easing!"easeOutBack"));
	queue(new ZoomEvent(60+50, 60+53, 1.5, easing!"easeOutCirc"));
	queue(new TextEvent(60+50, end, Point(WC-48, 51), "How do we create sentences, though?"));
	queue(new TextEvent(60+56, end, Point(WC-54, 52), [.5, 1, 0], "-> In order to start a group, you use\n   a group type."));
	queue(new TextEvent(2*60+1.25, end, Point(WC-54, 54), [.5, 1, 0], "-> u: Introduces a statement"));
	queue(new TextEvent(2*60+4.5, end, Point(WC-53, 56), "Let's translate the following sentence:"));
	queue(new TextEvent(2*60+6, end, Point(WC-43, 57), [.7, .7, .7],   `"The person ate the apple."`));
	queue(new TextEvent(2*60+9.5, end, Point(WC-43, 58), [.7, .7, .7], `"    person ate     apple."`));
	queue(new TextEvent(2*60+13, end, Point(WC-53, 60), [1, 1, 0], "PERSON:"));
	queue(new TextEvent(2*60+14.5, end, Point(WC-52, 61), [1, 1, .5], "alive    : yele"));
	queue(new TextEvent(2*60+16, end, Point(WC-52, 62), [1, 1, .5],   "sentient : ina"));
	queue(new TextEvent(2*60+19.5, end, Point(WC-30, 60), [.7, .7, .7], "yele,ina"));
	queue(new TextEvent(2*60+21, end, Point(WC-35, 60), [.7, .7, .7], "tuLx,"));
	queue(new TextEvent(2*60+21, end, Point(WC-52, 63), [1, 1, .5],   "NOM      : tuLx"));
	queue(new TextEvent(2*60+24, end, Point(WC-53, 64), [1, 0, 1], "EAT:"));
	queue(new TextEvent(2*60+27, end, Point(WC-52, 65), [1, .5, 1],   "edible : viLx"));
	queue(new TextEvent(2*60+30.5, end, Point(WC-52, 66), [1, .5, 1], "VERB   : yax"));
	queue(new TextEvent(2*60+34.5, end, Point(WC-35, 64), [.7, .7, .7], "yax,viLx"));
	queue(new TextEvent(2*60+35.5, end, Point(WC-53, 67), [1, 0, 0], "APPLE:"));
	queue(new TextEvent(2*60+36.75, end, Point(WC-52, 68), [1, .5, .5], "red     : tAq"));
	queue(new TextEvent(2*60+37.25, end, Point(WC-52, 69), [1, .5, .5], "edible  : viLt"));
	queue(new TextEvent(2*60+38, end, Point(WC-52, 70), [1, .5, .5],    "organic : uqele"));
	queue(new TextEvent(2*60+39.25, end, Point(WC-31, 67), [.7, .7, .7], "tAq,viLt,uqele"));
	queue(new TextEvent(2*60+40.25, 2*60+47, Point(WC-35, 68), "(could technically be any \nred, edible organic thing, so \nit could for example be \na tomato, but I'ma say \nthis is specific enough)"));
	queue(new TextEvent(2*60+47.5, end, Point(WC-52, 71), [1, .5, .5],  "ACC     : gut"));
	queue(new TextEvent(2*60+47.5, end, Point(WC-35, 67), [.7, .7, .7], "gut,"));
	queue(new TextEvent(2*60+50, end, Point(WC-53, 73), [.7, .7, .7], `"u tuLx,yele,ina yax,viLt gut,tAq,viLt,uqele."`));
	queue(new TextEvent(2*60+54.5, end, Point(WC-53, 75), "Those words (except for u) could be rearranged."));
	queue(new TranslationEvent(2*60+58, 3*60+2, Vector(WC-30, 125), easing!"easeOutCubic"));
	queue(new ZoomEvent(2*60+58, 3*60+2, 3, easing!"easeOutCubic"));
	queue(new TextEvent(3*60+2, end, Point(WC-40, 101), "== Phonology =="));
	queue(new TranslationEvent(3*60+2.75, 3*60+10.5, Vector(WC-32, 102)));
	queue(new ZoomEvent(3*60+2.75, 3*60+10.5, 0.25));
	queue(new TranslationEvent(3*60+10.5, 3*60+11.5, Vector(WC-30, 125), easing!"easeOutCubic"));
	queue(new ZoomEvent(3*60+10.5, 3*60+11.5, 3, easing!"easeOutCubic"));
	queue(new TextEvent(3*60+11.5, end, Point(WC-67, 110), [1, 0, 1], `
                    Bilabial    Dental Alveolar Palatal Velar Uvular

Plosive
Nasal
Fricative
Lateral Fricative
Approximant
Lateral Approximant

                    Front Mid Back

              Close
              Mid
              Open
`));
	queue(new TextEvent(3*60+11.5, end, Point(WC-48, 111), [.5, 0, 1], `
+--------------------------------------------------
|
|
|
|
|
|


+----------------
|
|
|
`));
	queue(new TextEvent(3*60+11.5, end, Point(WC-47, 112), `
p b         t d                           q g /ɢ/
                                            n /ɴ/
w /ɸ/ v /β/                         x
            L /ɬ/
                            y /j/
                   l /l/



i         u
      e /ə~ʌ/
a         A /ɑ/
`.tr));
	queue(new ZoomEvent(3*60+11.5, 3*60+14, 2.5, easing!"easeOutCubic"));
	queue(new TranslationEvent(3*60+11.5, 3*60+14, Vector(WC-30, 115), easing!"easeOutCubic"));
	queue(new TextEvent(3*60+18, 3*60+19, Point(WC-47, 109), [1, 0, 0], "(I forgot about /b/ lol)"));
	queue(new TranslationEvent(3*60+29, 3*60+30, Vector(WC-30, 130), easing!"easeOutCubic"));
	queue(new ZoomEvent(3*60+29, 3*60+30, 1.5, easing!"easeOutCubic"));
	queue(new TextEvent(3*60+29, end, Point(WC-53, 130), [1, 0, 1], "Phonotactics: (C)(C)V(C)(C)"));
	queue(new TextEvent(3*60+33, end, Point(WC-25, 130), "but mostly (C)V(C)"));
	queue(new TextEvent(3*60+34, end, Point(WC-53, 131), [1, 0, .5], "Vowels can not directly neighbor."));
	queue(new TextEvent(3*60+34, end, Point(WC-53, 132), "(e.g. 'iu', 'ae', 'Ai' are disallowed.)"));
	queue(new TranslationEvent(3*60+37, 3*60+40, Vector(WC-80, 63), easing!"easeOutCubic"));
	queue(new ZoomEvent(3*60+37, 3*60+38.5, 3, easing!"easeOutCubic"));
	queue(new ZoomEvent(3*60+38.5, 3*60+40, 1.5, easing!"easeInCubic"));
	queue(new TextEvent(3*60+40.25, end, Point(WC-100, 51), [0, 1, 1], "What are groups, anyway?"));
	queue(new TextEvent(3*60+43.5, end, Point(WC-102, 52), [0, .8, .8], "* While saying a phrase, you can, in the\nbackground, say a group phoneme"));
	queue(new TextEvent(3*60+47.25, end, Point(WC-102, 54), [0, .5, .5], "(l, x, n, j, or L)"));
	queue(new TextEvent(3*60+50.25, end, Point(WC-102, 55), [0, .8, .8], "for the entire duration of the phrase."));
	queue(new TextEvent(3*60+52, end, Point(WC-102, 56), [0, .8, .8], "* This /ties/ the entire phrase into a group,\nwhich can then be used as a single unit\nas a verb or noun."));
	queue(new TextEvent(3*60+58.5, end, Point(WC-100, 60), [1, .5, 0], "A case where this is useful:"));
	queue(new TextEvent(3*60+59.75, end, Point(WC-102, 61), [1, 1, 0], "iqu\nGenitive group type."));
	queue(new TextEvent(4*60+2.75, end, Point(WC-98, 61), [.5, .5, 0], "<posessee> <posessor>"));
	queue(new TextEvent(4*60+4, end, Point(WC-102, 64), [1, .25, 0],    "Untied: <posessor> has <posessee>"));
	queue(new TextEvent(4*60+7.25, end, Point(WC-102, 65), [1, .25, 0], "Tied:   <posessor>'s <posessee>"));
	queue(new TextEvent(4*60+11.5, end, Point(WC-100, 67), [.7, .7, .7], `"My house"`));
	queue(new TextEvent(4*60+11.5, end, Point(WC-102, 68), [.7, .7, .7], `"x[iqu wax,vAyele uqAx]"`));
	queue(new TextEvent(4*60+17.25, 4*60+19.5, Point(WC-102, 68), "
iqu - GEN
  wax - solid
  vAyele - used to live
uqAx - like me
"));
	queue(new TextEvent(4*60+20.5, 4*60+21, Point(WC-102, 69), [1, 0, 0], "*posessor"));
	queue(new TextEvent(4*60+19.6, end, Point(WC-102, 70), [1, .25, 0], "Posessor is optional."));
	queue(new TranslationEvent(4*60+23, 4*60+23.75, Vector(WC-80, 80), easing!"easeOutQuad"));
	queue(new TextEvent(4*60+23.75, end, Point(WC-102, 73), [0, 1, .5], "There's some more group types and\nsome more particles,"));
	queue(new TextEvent(4*60+28.25, end, Point(WC-102, 75), [0, .5, 1], "but there's not really any more\nunique rules."));
	queue(new TranslationEvent(4*60+31.25, 4*60+36, Vector(WC-80, 163), easing!"easeOutQuad"));
	queue(new ZoomEvent(4*60+31.25, 4*60+33.625, 5, easing!"easeOutQuart"));
	queue(new ZoomEvent(4*60+33.625, 4*60+36, 1.5, easing!"easeInQuart"));
	queue(new TextEvent(4*60+36.25, end, Point(WC-102, 151), [0, 1, 0], "The speakers are 4-dimensional.\nThis has a few implications..."));
	queue(new TextEvent(4*60+42, end, Point(WC-100, 153), [0, .7, 0], "* There's some adjectives for 4-dimensional\n  directions."));
	queue(new TextEvent(4*60+45.25, end, Point(WC-100, 155), [0, .7, 0], "* Their writing system utilizes 3\n  dimensions."));
	queue(new TextEvent(4*60+51.5, end, Point(WC-50, 152), `
+---------------------------------+
|                                 |
|                                 |
|                                 |
|                                 |
|                                 |
|                                 |
|                                 |
|                                 |
|                                 |
|                                 |
|                                 |
|                                 |
|                                 |
|                                 |
|                                 |
|                                 |
|                                 |
|                                 |
|                                 |
|                                 |
|                                 |
|                                 |
|                                 |
+---------------------------------+
`));
	queue(new TranslationEvent(4*60+51.5, 4*60+56, Vector(WC-33, 165), easing!"easeOutCubic"));
	queue(new TranslationEvent(5*60+35.75, 5*60+37.5, Vector(WC+20, 165), easing!"easeOutCubic"));
	queue(new TextEvent(5*60+35.75, end, Point(WC-2, 160), [1, 0, 0], "We've seen:"));
	queue(new TextEvent(5*60+38.5, end, Point(WC, 161), [1, .5, .5], "* The phonology"));
	queue(new TextEvent(5*60+39, end, Point(WC, 162), [1, .5, .5], "* A brief overview of the grammar"));
	queue(new TextEvent(5*60+40.5, end, Point(WC, 163), [1, .5, .5], "* The orthography"));
	queue(new TranslationEvent(5*60+41.25, 5*60+45, Vector(WC+20, 225), easing!"easeOutQuad"));
	queue(new ZoomEvent(5*60+41.25, 5*60+45, 3, easing!"easeOutQuad"));
	void phrase(float time, int x, int y, string english, string romanization, string gloss, string ipa, bool translate = false) {
		if(translate)
			queue(new TranslationEvent(time, time+1, Vector(x+45, y+25), easing!"easeOutQuad"));
		queue(new TextEvent(time, end, Point(x, y+1), english));
		queue(new TextEvent(time, end, Point(x, y+3), [.7, .7, .7], '"'~romanization~'"'));
		queue(new TextEvent(time, end, Point(x, y+5), [0, 1, 0], gloss));
		queue(new TextEvent(time, end, Point(x, y+7), [0, 1, 1], ipa.tr));
	}
	phrase(5*60+45, WC-25, 200, 
	"According to all known laws of aviation, there is no way a bee should be able to fly.",
	"ilu x[iqu Lat,xalt,tivulAn,Lex qAxA,valal] j[u tuLx,wix,ip,yele,tiduqu\nyax,waxAn,tiq,tineq,qAxA]",
	"because (GEN dictatorial-recorded-abstract-known above-blue) (STMT\nNOM-yellow-black-alive-small VERB-EPI-NEG-nonstationary-above)",
	`/ilu iqu ɬat     qɑxɑ  u tuɬx   jax   /
/        xalt    βalal   ɸix    ɸaxɑɴ /
/        tiβulɑɴ         ip     tiq   /
/        ɬəx             jələ   tiɴəq /
/                        tiduqu qɑxɑ  /
/    xxxxxxxxxxxxxxxxxxjjjjjjjjjjjjjjj/`);
	phrase(5*60+51, WC-25, 226,
	"Its wings are too small to get its fat little body off the ground.",
	"ilu j[u n[tuLx,iqu yele,vAtineq,vAqAxA xix] gut,tiduqu yanad] L[u \nl[iqu,tuLx xix,yanadtuqi,tiduqu xix] yax,lev,qAxA,tineq]",
	"because (STMT (NOM-GEN alive-[nonstationary-helper]-[above-helper] 3SG) ACC-small excessive)\n(STMT (NOM-GEN 3SG-[excessive-heavy]-small 3SG) VERB-R-above-nonstationary)",
	`/ilu u tuɬx jələ    xix ɢut    jaɴad u iqu  xix       xix jax   /
/      iqu  βɑtiɴəq     tiduqu         tuɬx jaɴadtuqi     ləβ   /
/           βɑqɑxɑ                          tiduqu        qɑxɑ  /
/                                                         tiɴəq /
/    jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjɬɬɬɬɬɬɬɬɬɬɬɬɬɬɬɬɬɬɬɬɬɬɬɬɬɬɬ/
/      ɴɴɴɴɴɴɴɴɴɴɴɴɴɴɴɴɴ               lllllllllllllllllll      /`);
	phrase(6*60+0.25, WC-120, 200,
	"The bee of course, flies anyway.",
	"ixA l[u tuLx,wix,ip,yele,tiduqu yax,tineq,qAxA]",
	"despite (STMT NOM-yellow-black-alive-small VERB-nonstationary-above)",
	`/ixɑ u tuɬx   jax   /
/      ɸix    tiɴəq /
/      ip     qɑxɑ  /
/      jələ         /
/      tiduqu       /
/    lllllllllllllll/`, true);
	phrase(6*60+3, WC-120, 226,
	"Because bees don't care what humans think is impossible.",
	"u x[tuLx,iqu Lat,xalt,tivulAn yele,ina] yax,tiq,Lat gut,wix,ip,yele,tiduqu",
	"STMT (NOM-GEN dictatorial-recorded-abstract alive-sentient) VERB-NEG-dictatorial\nACC-yellow-black-alive-small",
	`/u tuɬx ɬat     jələ jax ɢut    /
/  iqu  xalt    iɴa  tiq ɸix    /
/       tiβulɑɴ      ɬat ip     /
/                        jələ   /
/                        tiduqu /
/  xxxxxxxxxxxxxxxxxx           /`);
	queue(new TranslationEvent(6*60+8.75, 6*60+11, Vector(WC-75, 275), easing!"easeOutQuad"));
	phrase(6*60+11, WC-120, 250,
		"The North Wind and the Sun were disputing which was the stronger, when a traveler\ncame along wrapped in a warm cloak.",
		"u tuLx,aqan,qelt,tineq tuLx,uqu,qAxA,utiyi yax,ina,tivulAn,tixAna. u yax,daqen\nn[tuLx,u tuLx,ina,yele yax,tineq] gut,yiqan,ana.",
		"STMT NOM-north-gaseous-nonstationary NOM-big-above-[makes light]\nVERB-sentient-abstract-different. STMT VERB-inside (NOM-STMT NOM-sentient-alive\nVERB-nonstationary) ACC-flexible-hot.",
		`
/u tuɬx  tuɬx  jax     . u jax   tuɬx tuɬx jax   ɢut   . /
/  aqaɴ  uqu   iɴa     .   daqəɴ u    iɴa  tiɴəq jiqaɴ . /
/  qəlt  qɑxɑ  tiβulɑɴ .              jələ       aɴa   . /
/  tiɴəq utiji tixɑɴa  .                               . /
/                      .         ɴɴɴɴɴɴɴɴɴɴɴɴɴɴɴɴ      . /`);
	phrase(6*60+19, WC-120, 276,
		"They agreed that the one who first succeeded in making the traveler take his cloak off\nshould be considered stronger than the other.",
		"u yax,ina,tivulAn,xAna tuLx,xix,una x[gut,u l[tuLx,iqu tiLex,liqune n[u gut,yiqan,ana\nyax,tiq,daqen tuLx,ina,yele]] gut,nibavan]",
		"STMT VERB-sentient-abstract-same NOM-3SG-multiple (ACC-STMT (NOM-because unknown-first\n(STMT ACC-flexible-hot VERB-NEG-inside NOM-sentient-alive)) ACC-stronger)",
		`/u jax     tuɬx ɢut tuɬx tiɬəx  u ɢut   jax   tuɬx ɢut     /
/  iɴa     xix  u   iqu  liquɴə   jiqaɴ tiq   iɴa  ɴibaβaɴ /
/  tiβulɑɴ uɴa                    aɴa   daqəɴ jələ         /
/  xɑɴa                                                    /
/               xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/
/                   lllllllllllllllllllllllllllllll        /
/                               ɴɴɴɴɴɴɴɴɴɴɴɴɴɴɴɴɴɴɴ        /`);
	phrase(6*60+27.75, WC-25, 250,
		"Then the North Wind blew as hard as he could, but the more he blew the more closely did\nthe traveler fold his cloak around him;",
		"u tuLx,aqan,qelt,tineq yax,tineq,qelt,qAlitaqa. ilu j[u yax,litAqA,duqen gut,yiqan,ana \ntuLx,ina,yele].",
		"STMT NOM-north-gaseous-nonstationary VERB-nonstationary-gaseous-[very-intense]. because\n(STMT VERB-intense-around ACC-flexible-hot NOM-sentient-alive)",
		`/u tuɬx  jax      . ilu u jax    ɢut   tuɬx /
/  aqaɴ  tiɴəq    .       litɑqɑ jiqaɴ iɴa  /
/  qəlt  qəlt     .       duqəɴ  aɴa   jələ /
/  tiɴəq qɑlitaqa .                         /
/                 .     jjjjjjjjjjjjjjjjjjjj/`, true);
	phrase(6*60+34.5, WC-25, 276,
		"and at last the North Wind gave up the attempt. Then the Sun shined out warmly, and\nimmediately the traveler took off his cloak.",
		"u yax,tiq tuLx,aqan,qelt,tineq. u tuLx,uqu,qAxA,utiyi yax,ana,qAxA,utiyi gut,exe. ilu\nj[u yax,ixaqA,tidaqen l[iqu yiqan,ana xix]].",
		"STMT VERB-NEG NOM-north-gaseous-nonstationary. STMT NOM-big-above-[makes light]\nVERB-hot-[makes light] ACC-all. because (STMT VERB-immediate-outside\n(GEN flexible-hot 3SG))",
		`
/u jax tuɬx  . u tuɬx  jax   ɢut . ilu u jax     iqu jiqaɴ xix /
/  tiq aqaɴ  .   uqu   aɴa   əxə .       ixaqɑ       aɴa       /
/      qəlt  .   qɑxɑ  utiji     .       tidaqəɴ               /
/      tiɴəq .   utiji           .                             /
/            .                   .       jjjjjjjjjjjjjjjjjjjjjj/
/            .                   .               llllllllllllll/`);
	phrase(6*60+45, WC+70, 250,
		"And so the North Wind was obliged to confess that the Sun was the stronger of the two.",
		"iqu l[u yax,xalAn,ada tuLx,aqan,qelt,tineq j[gut,u tuLx,ana,qAxA,utiyi gut,nibavan]].",
		"because (STMT VERB-[makes sound]-necessary NOM-north-gaseous-nonstationary (ACC-STMT\nNOM-big-above-[makes light] ACC-stronger))",
		`/iqu u jax   tuɬx  ɢut tuɬx  ɢut     /
/      xalɑɴ aqaɴ  u   aɴa   ɴibaβaɴ /
/      ada   qəlt      qɑxɑ          /
/            tiɴəq     utiji         /
/    llllllllllllllllllllllllllllllll/
/                  jjjjjjjjjjjjjjjjjj/`, true);
	queue(new TranslationEvent(6*60+52, 7*60+16, Vector(WC-90, 25), easing!"easeOutQuad"));
	queue(new ZoomEvent(6*60+52, 7*60+6, 6, easing!"easeOutQuad"));
	queue(new ZoomEvent(7*60+16, 7*60+17, 1.5, easing!"easeOutCubic"));
	queue(new TextEvent(7*60+16.5, end, Point(WC-113, 13), "So, that's about it."));
	queue(new TextEvent(7*60+18.25, end, Point(WC-113, 14), [1, .2, .2], "In the description there's a link to a\ngithub repository containing:"));
	queue(new TextEvent(7*60+21, end, Point(WC-111, 16), [1, .5, .5], "* Word list"));
	queue(new TextEvent(7*60+21.5, end, Point(WC-111, 17), [1, .5, .5], "* Grammar"));
	queue(new TextEvent(7*60+22, end, Point(WC-111, 18), [1, .5, .5], "* Orthography"));
	queue(new TextEvent(7*60+22.75, end, Point(WC-111, 19), [1, .5, .5], "* Script for this video"));
	queue(new TextEvent(7*60+25, end, Point(WC-111, 21), [1, .5, .5], "* phoneticize.jar"));
	queue(new TextEvent(7*60+27.25, end, Point(WC-111, 22), [1, .5, .5], "* write.jar"));
	queue(new TranslationEvent(7*60+33.5, 7*60+34, Vector(WC-150, 25), easing!"easeOutQuad"));
	queue(new TextEvent(7*60+33.5, end, Point(WC-173, 13), "Remember to DISLIKE and UNSUBSCRIBE!!!1!1!11!!"));
	queue(new TextEvent(7*60+36.5, 7*60+36.9, Point(WC-160, 18), [.7, .7, .7], "(wow I'm so edgy and cool I said\nthe opposite thing most youtubers \nsay)"));
}

// float off = 5*60+45;
float off = 0;
