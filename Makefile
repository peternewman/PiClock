all: piclock

piclock.o:	piclock.cpp blocking_tcp_client.cpp  piclock_messages.h
	gcc -O4 -Wall -I/opt/vc/include `pkg-config Magick++ --cflags` -Ilibmcp23s17/src -Ilibpifacedigital/src -I/opt/vc/include/interface/vcos/pthreads -Iopenvg -c -o piclock.o piclock.cpp
piclock:	piclock.o openvg/libshapes.o openvg/oglinit.o ntpstat.o libmcp23s17/libmcp23s17.a libpifacedigital/libpifacedigital.a
	gcc -O4 -Wall -o piclock piclock.o ntpstat.o openvg/libshapes.o openvg/oglinit.o -L/opt/vc/lib -Llibmcp23s17 -Llibpifacedigital -lbrcmGLESv2 -lbrcmEGL -lbcm_host -ljpeg -lpthread -lm -lpifacedigital -lmcp23s17 -lpthread -lstdc++ -lboost_system -lboost_program_options -lssl -lcrypto -std=c++11 `pkg-config Magick++ --libs` -lb64
ntpstat.o: ntpstat/ntpstat.c
	gcc -O2 -c ntpstat/ntpstat.c -o ntpstat.o
openvg/libshapes.o:
	$(MAKE) -C openvg

libmcp23s17/libmcp23s17.a:
	$(MAKE) -C libmcp23s17

libpifacedigital/libpifacedigital.a:
	$(MAKE) -C libpifacedigital

openvg/oglinit.o:
	$(MAKE) -C openvg

