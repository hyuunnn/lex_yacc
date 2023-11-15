## ch2

### <a href="https://github.com/hyuunnn/lex_yacc/blob/main/ch2/ch2-02.l">ch2-02.l</a>

```console
$ flex ch2-02.l
$ gcc lex.yy.c -o ch2-02
$ ./ch2-02 ch2-02.l
31 94 603
```

### <a href="https://github.com/hyuunnn/lex_yacc/blob/main/ch2/ch2-03.l">ch2-03.l</a>

```console
$ flex ch2-03.l
$ gcc lex.yy.c -o ch2-03
$ ./ch2-03 ch2-02.l ch2-03.l
      31       94      603 ch2-02.l
      78      332     2450 ch2-03.l
     109      426     3053 total
```

### <a href="https://github.com/hyuunnn/lex_yacc/blob/main/ch2/ch2-04.l">ch2-04.l</a>

### <a href="https://github.com/hyuunnn/lex_yacc/blob/main/ch2/ch2-05.l">ch2-05.l</a>

### <a href="https://github.com/hyuunnn/lex_yacc/tree/main/ch2/start_state">start_state/ch2-07.l</a>

```console
$ flex ch2-07.l
$ gcc lex.yy.c -o ch2-07
$ ./ch2-07 < magic.input
Magic.two
three
```

`ch2-08.l`은 `ch2-07.l` 예제 코드를 수정하여 고의적으로 동작하지 않게 했다.

### <a href="https://github.com/hyuunnn/lex_yacc/blob/main/ch2/ch2-09.l">ch2-09.l</a>

