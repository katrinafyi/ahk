SetTitleMatchMode, 2

#IfWinActive  - Typora

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

::\res::
SendInput, \underset{{}res{}}{Left}{Left}{Left}{Left}{Left}{{}{}}{Left}
return

::\lr::
SendInput, {Left}{Left}\left{Right}\right{Left}{Left}{Left}{Left}{Left}{Left}
return

::\lr2::
SendInput, {Left}{Left}\left\{Right}\right\{Left}{Left}{Left}{Left}{Left}{Left}{Left}
return
