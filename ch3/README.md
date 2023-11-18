## ch3

### <a href="https://github.com/hyuunnn/lex_yacc/blob/main/ch3/ch3-01">ch3-01</a>

```console
$ flex ch3-01.l
$ bison -dy ch3-01.y
$ gcc lex.yy.c y.tab.c -o ch3-01
$ ./ch3-01
1 + 3
= 4
```

### <a href="https://github.com/hyuunnn/lex_yacc/blob/main/ch3/ch3-02">ch3-02</a>

```console
$ flex ch3-02.l
$ bison -dy ch3-02-explicit.y or bision -dy ch3-02-implicit.y
$ gcc lex.yy.c y.tab.c -o ch3-02
$ ./ch3-02
2+3+4*5
= 25
$ ./ch3-02
3 * 3 * (2 + 3)
= 45
```

### <a href="https://github.com/hyuunnn/lex_yacc/blob/main/ch3/ch3-03">ch3-03</a>

```console
$ flex ch3-03.l
$ bison -dy ch3-03.y
$ gcc lex.yy.c y.tab.c -o ch3-03
$ ./ch3-03
123 + 3
= 126
a = 123
a + 256
= 379
a - 222
= -99
```