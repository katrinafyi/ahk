SetTitleMatchMode, 2

#IfWinActive  - Typora

F1::Suspend

::$$$::
SendInput, $${Enter}
Sleep, 100
SendInput, \begin{{}aligned{}}{Enter}\end{{}aligned{}}{Home}{Enter}{Up}
return

::\bal::
SendInput, \begin{{}aligned{}}{Enter}\end{{}aligned{}}{Home}{Enter}{Up}
return

::\cases::
SendInput, \begin{{}cases{}}{Enter}\end{{}cases{}}{Home}{Enter}{Up}
return

::\bmat::
SendInput, \begin{{}bmatrix{}}{Enter}\end{{}bmatrix{}}{Home}{Enter}{Up}
return

::\2a::
SendInput, {{}{}}{{}{}}{Left}{Left}{Left}
return

::\bm::
SendInput, \boldsymbol{{}{}}{Left}
return

::\ha::
SendInput, \hat{{}{}}{Left}
return

::\on::
SendInput, \operatorname{{}{}}{Left}
return

::\fr::
SendInput, \frac {{}{}}{{}{}}{Left 3}
return

::\res::
SendInput, \underset{{}res{}}{Left}{Left}{Left}{Left}{Left}{{}{}}{Left}
return

::\lr::
SendInput, {Left}{Left}\left{Right}\right{Left}{Left}{Left}{Left}{Left}{Left}
return

::\lr2::
SendInput, {Left}{Left}\left\{Right}\right\{Left}{Left}{Left}{Left}{Left}{Left}{Left}
return

::\beg::
clipboard := ""
SendInput, ^+{Left}^c
ClipWait
c := Trim(clipboard)
if (StrLen(c) > 0) {
SendInput, \begin{{}%c%{}}{Enter}{Enter}\end{{}%c%{}}{Home}{Up}
}
return

Tab::
clipboard := ""
SendInput, +{END}^c
ClipWait
SendInput, {LEFT}
c := clipboard
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
