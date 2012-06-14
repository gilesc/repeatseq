# $* is prefix shared by target and dependent;  $@ is name of target file
CFLAGS = -c -O3 -Ibamtools/src
OBJS= repeatseq.o structures.o CLParse.o
NAME= repeatseq
PREFIX=/usr

$(NAME): $(OBJS) bamtools/lib/libbamtools.so
	g++ -o $@ $(OBJS) fastahack/Fasta.cpp fastahack/split.cpp -lbamtools -Lbamtools/lib 

# Suffix rules: tell how to  take file with first suffix and make it into
#	file with second suffix

install:
	cp repeatseq $(PREFIX)/bin
	cp repeatseq-parallel $(PREFIX)/bin
	cp bamtools/lib/* $(PREFIX)/lib	

.cpp.o:
	g++ $(CFLAGS) $*.cpp	
clean:
	rm *.o

bamtools/lib/libbamtools.so:
	mkdir -p bamtools/build
	cd bamtools/build && cmake .. && make


