all:
	bison -y --defines=artefacts/y.tab.h --output=artefacts/y.tab.c lexyacc-code/calc3.y
	flex -o artefacts/lex.yy.c lexyacc-code/calc3.l
	gcc -Ilexyacc-code -c -o obj/y.tab.o artefacts/y.tab.c
	gcc -Ilexyacc-code -c -o obj/lex.yy.o artefacts/lex.yy.c
	gcc obj/y.tab.o obj/lex.yy.o lexyacc-code/calc3i.c -o bin/calc3i.bin
	gcc -c src/my_lib.s -o obj/my_lib.o
	ar -rc lib/libmy_lib.a obj/my_lib.o
	ranlib lib/libmy_lib.a

clean:
	rm -f artefacts/*
	rm -f bin/*
	rm -f obj/*
	rm -f lib/*
	mv src/my_lib.s ./
	rm -f src/*
	mv ./my_lib.s src/my_lib.s
	