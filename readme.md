We should have a proper readme about the project ¯\\\_(ツ)\_\/¯


**About [connection.hs](connection.hs)**
Run the command: `cabal install myqsl-haskell` to install de necesary libraries


**About [logInWindow.hs](logInWindow.hs)**

Uses gtk2hs library

Links:
* [Example on doing a calculator:](https://www.stackbuilders.com/tutorials/haskell/gui-application/)
* [Installation of the gtk2hs library:](https://wiki.haskell.org/Gtk2Hs/Installation)
* [Closest thing to "documentation" about the gtk2hs:](http://muitovar.com/gtk2hs/index.html)
* [gtk2hs accepts GUIs built on Glade](https://glade.gnome.org/)

Tested only on Linux, compiled with [ghc](https://www.haskell.org/ghc/). But in theory should work on any platform as gtk is [multiplatform](https://www.gtk.org/features.php)

Select.hs tiene una funciones que devuelven `IO()`:

* la función main, pide el nombre de la consulta por teclado

Select.hs tiene una funciones que devuelven `IO [[String]]`:

* la función consulta requiere que se le pase el nombre de la consulta como parametro

El nombre de la consulta es un dato de tipo [Char]

Consultas:

De tablas

['A'] = "SELECT * FROM tUsuario"

['B'] = "SELECT * FROM tRol"

['C'] = "SELECT * FROM tPermiso"

['D'] = "SELECT * FROM tPiezas"

['E'] = "SELECT * FROM tTipoPieza"

De campos de las tablas

['a'] = "SELECT nombre FROM tUsuario"

['b'] = "SELECT password FROM tUsuario"

['c'] = "SELECT rolName FROM tUsuario"

['d'] = "SELECT rolName FROM tRol"

['e'] = "SELECT rolDes FROM tRol"

['f'] = "SELECT admin FROM tRol"

['g'] = "SELECT rolName FROM tPermiso"

['h'] = "SELECT pantalla FROM tPermiso"

['i'] = "SELECT acceso FROM tPermiso"

['j'] = "SELECT modificacion FROM tPermiso"

['k'] = "SELECT ID FROM tPiezas"

['l'] = "SELECT NOMBRE FROM tPiezas"

['m'] = "SELECT FABRICANTE FROM tPiezas"

['n'] = "SELECT ID_TIPO FROM tPiezas"

['o'] = "SELECT ID_TIPO FROM tTipoPieza"

['p'] = "SELECT NOMBRE FROM tTipoPieza"
