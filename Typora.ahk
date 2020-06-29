SetTitleMatchMode, 2

; restrict to Typora windows.
#IfWinActive ahk_exe Typora.exe

^F1::Reload

; used to toggle all hotkeys
; F1::Suspend

; fire hotstrings even when preceding character is non-space.
#Hotstring ?

; inserts align marker and line break
::==::
SendInput, &=%A_Space%
return


; creates new math environment with a \begin{aligned}
::$$$::
SendInput, $${Enter}
Sleep, 100
SendInput, \begin{{}aligned{}}{Enter}\end{{}aligned{}}{Home}{Enter}{Up}
return

; inserts \begin{aligned} and matching end tag
::\bal::
SendInput, \begin{{}aligned{}}{Enter}\end{{}aligned{}}{Home}{Enter}{Up}
return

; inserts \begin{cases} and matching end tag
::\cases::
SendInput, \begin{{}cases{}}{Enter}\end{{}cases{}}{Home}{Enter}{Up}
return

; inserts \begin{bmatrix} and matching end tag
::\bmat::
SendInput, \begin{{}bmatrix{}}{Enter}\end{{}bmatrix{}}{Home}{Enter}{Up}
return

; inserts {}{} and places cursor inside first argument
::\2a::
SendInput, {{}{}}{{}{}}{Left 3}
return

; inserts \boldsymbol{}
::\bm::
SendInput, \boldsymbol{{}{}}{Left}
return

; inserts \hat{}
::\ha::
SendInput, \hat{{}{}}{Left}
return

; inserts \operatorname*{}
::\on::
SendInput, \operatorname*{{}{}}{Left}
return

; inserts \frac{}{}
::\fr::
SendInput, \frac {{}{}}{{}{}}{Left 3}
return

; inserts Res operator with subscript
::\res::
SendInput, \operatorname*{{}Res{}}_{{}z={}}{Left}
return

; takes the word immediately left of the \beg and wraps it in \begin and \end.
::\beg::
old := ClipboardAll
clipboard := ""
SendInput, +{Home}^c
ClipWait, 1
if ErrorLevel {
  clipboard := old
  return
}
SendInput, {Right}
words := StrSplit(Trim(clipboard), A_Space)
clipboard := old
c := Trim(words[words.MaxIndex()], " `r`n`t")
n := StrLen(c)
if (n > 0) {
  SendInput, +{Left %n%}\begin{{}%c%{}}{Enter}{Enter}\end{{}%c%{}}{Home}{Up}
}
return

EscapeBackslash(c) {
  if (c == "{" || c == "}") {
    return "\" . c
  } else {
    return c
  }
}

; wraps from the left { to \paren in parentheses
::\wr::
old := ClipboardAll
clipboard := ""
SendInput, +{Home}^c
ClipWait, 1
if ErrorLevel {
  clipboard := old
  return
}
SendInput, {Right}
t := clipboard
; limit to left $ in case we are in an inline equation
dollar := InStr(t, "$", false, 0)
t := SubStr(t, dollar + 1)
tl := StrLen(t)
d1 := SubStr(t, tl-1, 1)
d2 := SubStr(t, tl, 1)
l := InStr(t, "{", false, 0)
r := InStr(t, "}", false, 0)
while (r > l) {
  ;MsgBox, L %l% R %r%
  r := InStr(t, "}", false, -(tl - l + 1))
  l := InStr(t, "{", false, -(tl - l + 1))
}
;MsgBox, L %l% R %r%
lefts := StrLen(t) - l
; use clipboard to avoid Typora automatically inserting ()
Critical ; prevent other threads from interrupting our clipboard restore
clipboard := "\left" . EscapeBackslash(d1) . SubStr(t, l+1, -2) . "\right" . EscapeBackslash(d2)
SendInput, +{Left %lefts%}^v
Sleep, 400
clipboard := old
return

; inserts \left and \right on the two preceding characters, escaping braces
::\lr::
old := ClipboardAll
clipboard := ""
SendInput, +{Left 2}^c
ClipWait, 1
if ErrorLevel {
  clipboard := old
  return
}
SendInput, {Right}
t := Trim(clipboard)
clipboard := old
if (StrLen(t) != 2) {
  return
}
l := SubStr(t, 1, 1)
r := SubStr(t, 2, 1)
e1 := ""
e2 := ""
if (l == "{") {
  e1 := "\"
}
if (r == "}") {
  e2 := "\"
}
lefts := 6 + StrLen(e2) + 1
SendInput, {Left 2}\left%e1%{Right}  \right%e2%{Left %lefts%}
return

; smart tab. moves after next { or (, or failing that moves after next ) or }
Tab::
old := ClipboardAll
clipboard := ""
SendInput, +{END}^c
ClipWait, 1
if ErrorLevel {
  clipboard := old
  return
}
SendInput, {LEFT}
c := clipboard
clipboard := old
M := StrLen(c) + 10
if (M == 0) {
  SendInput {Right}
  return
}
n1 := InStr(c, "{")
n2 := InStr(c, "(")
if (n1 == 0) {
  n1 := M
}
if (n2 == 0) {
  n2 := M
}
n := Min(n1, n2)
if (n == M) {
  n1 := InStr(c, "}")
  n2 := InStr(c, ")")
  if (n1 == 0) {
    n1 := M
  }
  if (n2 == 0) {
    n2 := M
  }
  n := Min(n1, n2)
}
; MsgBox % "c >" . c . "< n: " . n
if (n != M) {
  SendInput {RIGHT %n%}
} else {
  SendInput {End}
}
; MsgBox % c
return
