
(

// see http://doc.sccode.org/Classes/ServerOptions.html

s.options.numBuffers = 1024 * 256;
s.options.memSize = 8192 * 32;
s.options.numWireBufs = 128;
s.options.maxNodes = 1024 * 64;
s.options.numOutputBusChannels = 12;
s.options.numInputBusChannels = 0;

s.waitForBoot {
    ~dirt = SuperDirt(2, s);
    ~dirt.loadSoundFiles();
    ~dirt.loadSoundFiles("/home/rs/mus/samples/*");

    s.sync;
    ~dirt.start(57120, 0 ! 12);
    //~dirt.start(57120, [0, 2, 4, 6, 8, 10]);


    (
        ~d1 = ~dirt.orbits[0]; ~d2 = ~dirt.orbits[1]; ~d3 = ~dirt.orbits[2];
        ~d4 = ~dirt.orbits[3]; ~d5 = ~dirt.orbits[4]; ~d6 = ~dirt.orbits[5];
        ~d7 = ~dirt.orbits[6]; ~d8 = ~dirt.orbits[7]; ~d9 = ~dirt.orbits[8];
        ~d10 = ~dirt.orbits[9]; ~d11 = ~dirt.orbits[10]; ~d12 = ~dirt.orbits[11];
    );

    /*
	MIDIClient.init;
    ~midiOut = MIDIOut.newByName("TidalMidi", "M1");
    ~midiOut.latency = 0.11;
    ~dirt.soundLibrary.addMIDI(\midi, ~midiOut);

    ~midiOut2 = MIDIOut.newByName("TidalMidi", "M2");
    ~midiOut2.latency = 0.11;
    ~dirt.soundLibrary.addMIDI(\midi2, ~midiOut2);
	*/

};
s.latency = 0;
);

