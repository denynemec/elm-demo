# Elm demo

Functional language, which has its own syntax and patterns. Above Elm is thin JS layer, which is responsible for connectivity Elm app into web page. Elm app is compiled into JS.

At first view, Elm syntax is weird. Everything is function (pure function without side effects). It is extremely usefull - not only for testing - when you look at function type signature, you see return type. By return type you will know, if in function body can be BE called (HTTP request) or not. If not, you can skip all functions called inside this functions - when you try to find, which functions is calling BE.

## Overview

- Thinking in ELM - also in others functional languages - is different than in OOP languages
- Functional languge - no objects - everything is function (closure pattern)
- Each function (by design) returns something (if you need use local variables in functions/if-else statements/etc., you can use let-in block)
- No undefined, no null, Elm has its own safe types. For undefined/null/empty type, we have something called `Maybe`
- Each variable is by design immutable
- Absolute module path (no relative imports)
- Pseudo-html syntax (similar concept as React and JSX) - everything in single module
- Model - View - Update - Redux idea - to connect new pages, it is neccesary to do some boilerplate for it, but it has a lot of benefits
- Almost every time, I'm starting with types structure. Then I'm using compiler to `make it works`
- When Elm app compiles, it will won't crash in runtime! It's very easy to used on it :-D
- Elm has quite small bunch of options in syntax, but it is very powerfull - basically, when you understand basics, you are able to to quite a lot of stuffs!
- elm-format, elm-analyse - tools
- Elm has it's own dependency list - elm.json file

## Types

- Records - objects
- Custom types - `state` types with situationally payload (algebraic types)
- Opaque types, phanton types (advanced techniques) - today only mentioned, but its very powerfull tool. The way how to encapsule feature implementation, etc..

## Advanteges

- No runtime errors
- Refactoring + readable code
- Easy maintain and app extension
- In latest version (0.19) usefull compiler error messages
- It's own package eco-system (no NPM), where 99% packages has good documentation
- No null or undefined => safe types

## Disadvanteges

Mostly trade-offs for bunch of advanteges:

- For small apps, you need to do lot of boilerplate
- Can't to everything inside Elm app layer (JS-interops)
- Syntax and types structure limitations. (Create record of different type, from already existing record, you have to list all new properties - no spread operator, etc.)

## Decoders - advantege or disadvantege?

- Way how to "get" (decode) typically data from BE in JSON format into Elm types
- At first look very confusing and you are saying "Aaaa for what do I need them!?", but it's tradeoff for `once you get data into elm, you have all Elm type system advanteges`
- There 2 groups of people - ona hates decoders, second loves them!

## If you are interested...

- [Elm guide](https://guide.elm-lang.org/)
- [Ellie](https://ellie-app.com/new)
- [Elm packages](https://package.elm-lang.org/)
- [Elm awesome list](https://github.com/sporto/awesome-elm)
- [Make impossible states impossible](https://www.youtube.com/watch?v=IcgmSRJHu_8&ab_channel=elm-conf)
