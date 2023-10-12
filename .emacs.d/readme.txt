* Installation on Windows
Source: https://www.emacswiki.org/emacs/MsWindowsInstallation

** Configuration

Define an environment variable (user variable) called HOME and point it to the parent folder of the .emacs.d folder.
e.g:
HOME = %USERPROFILE%

Other environment variables you might consider to define are:
- GRAPHVIZ_DOT = C:\Users\rkiggen\Bin\graphviz\bin\dot.exe
- HTTP_PROXY = http://user:password@proxy.domain.com:port
- HTTPS_PROXY = http://user:password@proxy.domain.com:port

Notes:
How do you enter your password when it has special characters in it such as  !,@, and so on?
The solution is to use unicode characters in hexadecimal:

Octal  Decimal      Hex        HTML    Character   Unicode
    0100       64     0x40       @    "@"         COMMERCIAL AT
     072       58     0x3A       :    ":"         COLON
     041       33     0x21       !    "!"         EXCLAMATION MARK
     043       35     0x23       #    "#"         NUMBER SIGN
     044       36     0x24       $    "$"         DOLLAR SIGN

For example:
Aperam2018! becomes Aperam2018%21
e.g. http://adagility\rkiggen:Aperam2018%21@par2.sme.zscalertwo.net:80

You can use the following site for this: https://www.urlencoder.org/

** Windows Integration
Source: https://www.emacswiki.org/emacs/EmacsMsWindowsIntegration

This will connect to a running Emacs server if one exists.

Save the following text to a file with emacs_explorer.reg. Replace the paths to Emacs binaries to match the location on your system. 
Double click the file and confirm the security warning to add this to the registry:

Windows Registry Editor Version 5.00
;; Be sure to set the correct path to Emacs on your system!
[HKEY_CURRENT_USER\Software\Classes\*\shell]


;; Open file in existing frame
[HKEY_CURRENT_USER\Software\Classes\*\shell\emacsopencurrentframe]
@="&Emacs: Edit in existing window"
"icon"="C:\\EssentialIt\\Applications\\emacs\\bin\\emacsclientw.exe"
[HKEY_CURRENT_USER\Software\Classes\*\shell\emacsopencurrentframe\command]
@="C:\\EssentialIt\\Applications\\emacs\\bin\\emacsclientw.exe -n --alternate-editor=\"C:\\EssentialIt\\Applications\\emacs\\bin\\runemacs.exe\" \"%1\""

;; Open file in new frame
[HKEY_CURRENT_USER\Software\Classes\*\shell\emacsopennewframe]
@="&Emacs: Edit in new window"
"icon"="C:\\EssentialIt\\Applications\\emacs\\bin\\emacsclientw.exe"
[HKEY_CURRENT_USER\Software\Classes\*\shell\emacsopennewframe\command]
@="C:\\EssentialIt\\Applications\\emacs\\bin\\emacsclientw.exe -n --alternate-editor=\"C:\\EssentialIt\\Applications\\emacs\\bin\\runemacs.exe\" -c \"%1\""


** Extra software

Install MikText