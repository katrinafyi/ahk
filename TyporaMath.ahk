SetTitleMatchMode, 2

#IfWinActive  - Typora

Tab::
SendInput, +{END}^c
ClipWait
Sleep, 50
SendInput, {LEFT}
c := clipboard
M := StrLen(c)
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
SendInput {End}{Right}
}
; MsgBox % c
return
