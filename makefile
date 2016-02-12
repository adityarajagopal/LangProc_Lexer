bin/c_lexer : src/c_lexer.yy.c
	g++ src/c_lexer.yy.c -o bin/c_lexer

src/c_lexer.yy.c : src/c_lexer.l
	flex -o src/c_lexer.yy.c src/c_lexer.l

test : src/calendar.c bin/c_lexer
	cpp src/calendar.c | ./bin/c_lexer > src/output.txt

test_deetz : src/c_lexer_deetz.l
	flex -o src/c_lexer_deetz.yy.c src/c_lexer_deetz.l
	g++ src/c_lexer_deetz.yy.c -o bin/c_lexer_deetz
	cpp src/calendar.c | ./bin/c_lexer_deetz > src/output1.txt

clean:
	rm src/c_lexer.yy.c
	rm bin/c_lexer
	rm bin/c_lexer_deetz
	rm src/c_lexer_deetz.yy.c
