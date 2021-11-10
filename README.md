# Paras

Embedded trivial Lisp-dialect.

## Installation

```
$ ros install fukamachi/paras
```

## Usage

```
$ paras
> (equal 1 1.0)
NIL

> (equal 2 2)
T

> (use :time)
("PARAS/MODULES/TIME" "PARAS/MODULES/CORE")

> (month-of (now))
5

> (day-of (now))
31
```

## Functions

### Conditions

- `equal`
- `and`
- `or`
- `<`
- `<=`

### Operators

- `+`
- `-`
- `*`

### Controls

- `progn`
- `when`
- `if`
- `let`

### Importing Modules

- `require`
- `use`

## Modules

- `list`
- `time`
- `db`

## Author

* Eitaro Fukamachi (e.arrows@gmail.com)

This product is developed with the generous support of [Pocket Change, K.K.](https://www.pocket-change.jp/)

## Copyright

Copyright (c) 2018 Eitaro Fukamachi (e.arrows@gmail.com)

## License

Licensed under the LLGPL License.
