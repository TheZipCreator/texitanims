import std.stdio, texit;

float beat(float n) {
	return 5+(60f/180f)*n;
}

int ybeat(float n) {
	return cast(int)(n+HEIGHT/2);
}

string rep(string s, int n) {
	string res;
	for(int i = 0; i < n; i++)
		res ~= s;
	return res;
}

string tr(string s) {
	import std.string;
	dchar[dchar] transTable = [
		'ö': '\x88'
	];
	return s.translate(transTable);
}

mixin Texit!("../qbicfeet_10x10.png", 10, 2, 32, 440, 64, 36, "The Hydrogen Atom");

void setup() {
	offset = off;
	audio("the-hydrogen-atom.ogg");
	zoom = 1;
	enum end = float.infinity;
	queue(
		new TextEvent(1, 0.beat, Point(WIDTH/4-12, HEIGHT/4-1), [1, 0, 1], "FLASHING LIGHTS WARNING"),
		new TextEvent(2, 0.beat, Point(WIDTH/4-2, HEIGHT/4+1), [0, 1, 0], "3"),
		new TextEvent(3, 0.beat, Point(WIDTH/4, HEIGHT/4+1), [1, 1, 0], "2"),
		new TextEvent(4, 0.beat, Point(WIDTH/4+2, HEIGHT/4+1), [1, 0, 0], "1"),
	);
	// edges
	for(int i = 0; i < 104*4; i += 16) {
		float[] hits = [0, .5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14];
		foreach(size_t j, float h; hits) {
			foreach(int x; [0, WW-1]) {
				queue(new TextEvent((i+hits[j]).beat, (j+1 == hits.length ? i+j+16 : i+hits[j+1]).beat, Point(x, 0), [1, 0, 0], "|\n".rep(WORLD_HEIGHT)));
			}
		}
		float[3] col = [1, 1, 0];
		queue(
			new TextEvent((i+14).beat, (i+14.5).beat, Point(1, 0), col, "|\n".rep(WORLD_HEIGHT)),
			new TextEvent((i+14.5).beat, (i+15).beat, Point(2, 0), col, "|\n".rep(WORLD_HEIGHT)),
			new TextEvent((i+15).beat, (i+15.5).beat, Point(WORLD_WIDTH-1, 0), col, "|\n".rep(WORLD_HEIGHT)),
			new TextEvent((i+15.5).beat, (i+16).beat, Point(WORLD_WIDTH-2, 0), col, "|\n".rep(WORLD_HEIGHT)),
		);
	}
	for(int i = 16*4; i < 96*4; i += 32) {
		float[3][] cols = [
			[1f, 0f, 1f],
			[0f, 1f, 1f],
			[0f, 1f, 0f],
			[0f, .5f, 1f]
		];
		foreach(size_t j, float hit; [0, 8, 16, 24]) {
			foreach(int x; [4, WW-5])
				queue(new TextEvent((i+hit).beat, (96*4).beat, Point(x, 0), cols[j], "#\n\n\n".rep(WORLD_HEIGHT)));
		}
	}
	queue(
		new TranslationEvent(0.beat, (110*4).beat, Vector(WIDTH/4, HEIGHT/4), Vector(WIDTH/4, WORLD_HEIGHT)),
		new TextEvent(8.beat, end, Point(WIDTH/4-13, 8.ybeat), [0, 1, 0],    "title  / The Hydrogen Atom"),
		new TextEvent(16.beat, end, Point(WIDTH/4-13, 16.ybeat), [0, 1, 1],  "artist / NPE"),
		new TextEvent(24.beat, end, Point(WIDTH/4-13, 24.ybeat), [0, 1, .5], "daw    / LMMS v1.3.0"),
		new TextEvent(32.beat, end, Point(WIDTH/4-13, 32.ybeat), [0, .5, 1], "engine / Texit v1.3.1"),
		new TextEvent(128.beat, end, Point(5, 128+HEIGHT/4), [1, 1, 1], "It's a measurable\nquantity,"),
		new TextEvent(131.beat, end, Point(7, 131+HEIGHT/4), [1, 1, 1], "it has about the\nvalue of"),
		new TextEvent(135.beat, end, Point(9, 135+HEIGHT/4), [1, 1, 1], "1.05457"),
		new TextEvent(139.beat, end, Point(12, 139+HEIGHT/4), [1, 1, 1], "times 10^-34\njoule-seconds."),
		new TextEvent(149.beat, end, Point(5, 149+HEIGHT/4), [1, 1, 1], "This is a very\nmysterious number,"),
		new TextEvent(154.beat, end, Point(7, 154+HEIGHT/4), [1, 1, 1], "it is what it is"),
		new TextEvent(157.beat, end, Point(9, 157+HEIGHT/4), [1, 1, 1], "and noone knows\nwhy it is"),
		new TextEvent(160.beat, end, Point(12, 160+HEIGHT/4), [1, 1, 1], "it just is."),
		new TextEvent(164.beat, end, Point(5, 164+HEIGHT/4), [1, 1, 1], "and so, you'll see\nthis in many"),
		new TextEvent(168.beat, end, Point(5, 168+HEIGHT/4), [1, 1, 1], "of our equations\ntoday,"),
		new TextEvent(173.beat, end, Point(6, 173+HEIGHT/4), [1, 1, 1], "it defines the\nrelationship between"),
		new TextEvent((177.5).beat, end, Point(7, 177+HEIGHT/4), [1, 1, 1], "energy"),
		new TextEvent(179.beat, end, Point(9, 179+HEIGHT/4), [1, 1, 1], "frequency"),
		new TextEvent(181.beat, end, Point(12, 181+HEIGHT/4), [1, 1, 1], "momentum"),
		new TextEvent(184.beat, end, Point(14, 184+HEIGHT/4), [1, 1, 1], "space"),
		new TextEvent(186.beat, end, Point(5, 186+HEIGHT/4), [1, 1, 1], "all kinds of stuff"),
	);
	// number all d is
	for(int i = 192; i < 256; i += 8) {
		// this is bad and dumb but it doesn't matter
		int y = (i/6)*6+HEIGHT/4;
		if((i/8)%2 == 0) {
			int start = 5;
			queue(
				new TextEvent(i.beat, end, Point(start, y), [1, 1, 1], "number"),
				new TextEvent((i+1).beat, end, Point(start, y), [.5, .5, .5], "number"),
				new TextEvent((i+1).beat, end, Point(start+6, y), [1, 1, 1], "all"),
				new TextEvent((i+1.5).beat, end, Point(start+6, y), [.5, .5, .5], "all"),
				new TextEvent((i+1.5).beat, end, Point(start+9, y), [1, 1, 1], "d"),
				new TextEvent((i+3).beat, end, Point(start+9, y), [.5, .5, .5], "d"),
				new TextEvent((i+3).beat, end, Point(start+10, y), [1, 1, 1], "is"),
				new TextEvent((i+3.25).beat, end, Point(start+10, y), [.5, .5, .5], "is"),
				new TextEvent((i+3.25).beat, end, Point(start+12, y), [1, 1, 1], "is"),
				new TextEvent((i+3.5).beat, end, Point(start+12, y), [.5, .5, .5], "is"),
				new TextEvent((i+3.5).beat, end, Point(start+14, y), [1, 1, 1], "is"),
				new TextEvent((i+3.75).beat, end, Point(start+14, y), [.5, .5, .5], "is"),
				new TextEvent((i+3.75).beat, end, Point(start+16, y), [1, 1, 1], "is"),
				new TextEvent((i+4).beat, end, Point(start+16, y), [.5, .5, .5], "is"),
				new TextEvent((i+4).beat, end, Point(start, y), [1, 1, 1], "number"),
				new TextEvent((i+5).beat, end, Point(start, y), [.5, .5, .5], "number"),
				new TextEvent((i+5).beat, end, Point(start+6, y), [1, 1, 1], "all"),
				new TextEvent((i+5.5).beat, end, Point(start+6, y), [.5, .5, .5], "all"),
				new TextEvent((i+5.5).beat, end, Point(start+9, y), [1, 1, 1], "d"),
				new TextEvent((i+6).beat, end, Point(start+9, y), [.5, .5, .5], "d"),
				new TextEvent((i+6).beat, end, Point(start+10, y), [1, 1, 1], "is"),
				new TextEvent((i+7).beat, end, Point(start+10, y), [.5, .5, .5], "is"),
			);
		}
		else {
			int start = WORLD_WIDTH-11;
			queue(
				new TextEvent(i.beat, end, Point(start, y), [1, 1, 1], "number"),
				new TextEvent((i+1).beat, end, Point(start, y), [.5, .5, .5], "number"),
				new TextEvent((i+1).beat, end, Point(start-3, y), [1, 1, 1], "all"),
				new TextEvent((i+1.5).beat, end, Point(start-3, y), [.5, .5, .5], "all"),
				new TextEvent((i+1.5).beat, end, Point(start-4, y), [1, 1, 1], "d"),
				new TextEvent((i+3).beat, end, Point(start-4, y), [.5, .5, .5], "d"),
				new TextEvent((i+3).beat, end, Point(start-6, y), [1, 1, 1], "is"),
				new TextEvent((i+3.25).beat, end, Point(start-6, y), [.5, .5, .5], "is"),
				new TextEvent((i+3.25).beat, end, Point(start-8, y), [1, 1, 1], "is"),
				new TextEvent((i+3.5).beat, end, Point(start-8, y), [.5, .5, .5], "is"),
				new TextEvent((i+3.5).beat, end, Point(start-10, y), [1, 1, 1], "is"),
				new TextEvent((i+3.75).beat, end, Point(start-10, y), [.5, .5, .5], "is"),
				new TextEvent((i+3.75).beat, end, Point(start-12, y), [1, 1, 1], "is"),
				new TextEvent((i+4).beat, end, Point(start-12, y), [.5, .5, .5], "is"),
				new TextEvent((i+4).beat, end, Point(start, y), [1, 1, 1], "number"),
				new TextEvent((i+5).beat, end, Point(start, y), [.5, .5, .5], "number"),
				new TextEvent((i+5).beat, end, Point(start-3, y), [1, 1, 1], "all"),
				new TextEvent((i+5.5).beat, end, Point(start-3, y), [.5, .5, .5], "all"),
				new TextEvent((i+5.5).beat, end, Point(start-4, y), [1, 1, 1], "d"),
				new TextEvent((i+6).beat, end, Point(start-4, y), [.5, .5, .5], "d"),
				new TextEvent((i+6).beat, end, Point(start-6, y), [1, 1, 1], "is"),
				new TextEvent((i+7).beat, end, Point(start-6, y), [.5, .5, .5], "is"),
			);

		}
	}
	// text during last part
	queue(
		new TextEvent(220.beat, end, Point(5, 219+HEIGHT/4), [.5, 1, .5], "it stays put"),
		new TextEvent(252.beat, end, Point(WORLD_WIDTH-20, 249+HEIGHT/4), [.5, 1, .5], "azimuthal angle"),
	);
	// bars 65-81
	{
		int times = 17;
		queue(new TextEvent(0, end, Point(6, 255+HEIGHT/4), [.4, .2, 0], "OOOOOOOOOOOOOOOOOOOO\n\n\n".rep(times)));
		foreach(int i; [256, 288]) {
			float[] hits = [0, 8, 12, 13, 16, 24, 28, 29];
			foreach(float hit; hits) {
				enum interval = .125f;
				for(int j = 6; j < 26; j++) {
					float t = i+hit+(j-6)*interval;
					queue(new TextEvent(t.beat, end, Point(j, 255+HEIGHT/4), [.8, .4, 0], "O\n\n\n".rep(times)));
					queue(new TextEvent((t+interval).beat, end, Point(j, 255+HEIGHT/4), [.4, .2, 0], "O\n\n\n".rep(times)));
				}
			}
		}
	}
	// text
	queue(
		new TextEvent(286.beat, end, Point(5, 283+HEIGHT/4), "Alright, well now that\nwe have our hamiltonian"),
		new TextEvent(292.beat, end, Point(7, 289+HEIGHT/4), "we can plug it into\nthe time-independent"),
		new TextEvent(292.beat, end, Point(7, 289+HEIGHT/4), "we can plug it into\nthe time-independent"),
		new TextEvent(298.beat, end, Point(12, 295+HEIGHT/4), "Schr\x88dinger\nequation"),
		new TextEvent(302.beat, end, Point(14, 302+HEIGHT/4), "that is,"),
		new TextEvent(304.beat, end, Point(16, 305+HEIGHT/4), "\x89\x8A=E\x8A"),
		new TextEvent(310.beat, end, Point(5, 310+HEIGHT/4), "where E is the energy\neigenvalue, and"),
		new TextEvent(314.beat, end, Point(7, 314+HEIGHT/4), "\x8A is the energy\neigenstate."),
	);
	// beeps
	{
		bool first = true;
		Point last;
		for(int i = 320; i < 384; i += 8) {
			float[] hits = [0, .25, .5, .75, 1, 2, 2.25, 2.5, 2.75, 3, 4, 4.375, 4.75, 5, 6.375, 6.75, 7];
			foreach(hit; hits) {
				int t = cast(int)(i+hit+HEIGHT/4);
				Point curr = (first || last.x == 6) ? Point(WORLD_WIDTH-6, t) : Point(last.x-1, t);
				queue(new TextEvent((i+hit).beat, end, curr, [0, 1, 1], "*"));
				if(!first)
					queue(new TextEvent((i+hit).beat, end, last, [0, .5, .5], "*"));
				first = false;
				last = curr;
			}
		}
		queue(new TextEvent(384.beat, end, last, [0, .5, .5], "*"));
	}
	// more text, and some translation
	queue(
		new TextEvent(400.beat, end, Point(3, 400+HEIGHT/8), "Wow, look at this thing,"),
		new TextEvent(406.beat, end, Point(5, 406+HEIGHT/8), [.7, .7, .7], "ugh, what a mess"),
		new TextEvent(412.beat, end, Point(7, 412+HEIGHT/8), "But there it is."),
		new TextEvent(414.beat, end, Point(7, 414+HEIGHT/8), "This is a beautiful\nequation, in a way"),
		new TextEvent(422.beat, end, Point(9, 422+HEIGHT/8), "So, let's solve it!"),
		new TextEvent(428.beat, end, Point(2, 428+HEIGHT/8), "Let's solve it for \x8A,"),
		new TextEvent(432.beat, end, Point(8, 439), "How hard can it be?"),
		new TranslationEvent(440.beat, 444.beat, Vector(26, 439.5), easing!"easeOutCubic"),
		new ZoomEvent(440.beat, 444.beat, 1, .01, easing!"easeOutCubic"),
	);
	endTime = 448.beat;
}

float off = 0;
// float off = 430.beat;
