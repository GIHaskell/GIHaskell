import Control.Monad
import Control.Monad.IO.Class
import Data.IORef
import Graphics.UI.Gtk hiding (Action, backspace)


main :: IO ()
main = do
  --Necessary, initializes GTK library
  void initGUI

  --Shows the window created by the function "createLogIn"
  window <- createLogIn
  widgetShowAll window

  --Main loop wait for events (doesnt do anything yet)
  mainGUI


--Returns the log in window
createLogIn :: IO Window
createLogIn = do
  --Creates new Window
  window <- windowNew

  --Makes the window close the main on exit
  onDestroy window mainQuit

  --Creates a Box that grows vertical
  vbox <- vBoxNew True 10

  --Adds the box to the window
  containerAdd window vbox

  --First layer: Welcome message
  titleLabel <- labelNew (Just "Bienvenido")
  boxPackStart vbox titleLabel PackGrow 0

  --Second layer: User

  --Create a box that grows horizontally
  hboxUser <- hBoxNew True 10

  --Add label and text entry to the horizontal box
  userLabel <- labelNew (Just "Usuario")
  userEntry <- entryNew

  boxPackStart hboxUser userLabel PackGrow 0
  boxPackStart hboxUser userEntry PackGrow 0

  --Adds horizontal box into vertical box
  boxPackStart vbox hboxUser PackGrow 0

  --Third layer: Password

  --Create a box that grows horizontally
  hboxPassword <- hBoxNew True 10

  --Add label and text entry to the horizontal box
  passwordLabel <- labelNew (Just "Password")
  passwordEntry <- entryNew

  boxPackStart hboxPassword passwordLabel PackGrow 0
  boxPackStart hboxPassword passwordEntry PackGrow 0

  --Adds horizontal box into vertical box
  boxPackStart vbox hboxPassword PackGrow 0

  --Fourth layer: Buttons

  --Create a box that grows horizontally
  hboxButtons <- hBoxNew True 100

  --Create a button and add a label to it
  okButton <- buttonNew
  okLabel <- labelNew (Just "OK")
  containerAdd okButton okLabel

  --Create a button and add a label to it... again
  cancelButton <- buttonNew
  cancelLabel <- labelNew (Just "CANCEL")
  containerAdd cancelButton cancelLabel

  --Add both buttons into the horizontal box
  boxPackStart hboxButtons okButton PackGrow 0
  boxPackStart hboxButtons cancelButton PackGrow 0

  --Adds horizontal box into vertical box
  boxPackStart vbox hboxButtons PackGrow 0

  --Set some window properties
  set window [ windowTitle := "Log in"
             , windowResizable := False
             , windowDefaultWidth := 400
             , windowDefaultHeight := 400]

  --Return builded window
  return window
