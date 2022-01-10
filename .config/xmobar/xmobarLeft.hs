import Xmobar
import Data.List


volumesActions = [
  ("1", "amixer set Master 5%+"),
  ("2", "amixer set Master toggle"),
  ("3", "amixer set Master 5%-"),
  ("4", "amixer set Master 1%+"),
  ("5", "amixer set Master 1%-")
  ]

makeAction :: (String, String) -> String
makeAction (button, action) = "<action=`" ++ action ++ "` button=" ++ button ++">"

makeTpl :: [(String, String)] -> String -> String
makeTpl actions content = intercalate "" (map makeAction actions) ++ content ++ concat (replicate (length actions) "</action>")
tpl = makeTpl volumesActions "\61480 <volume>%"


config = defaultConfig { font = "xft:JetBrainsMono Nerd Font:weight=bold:pixelsize=12:antialias=true:hinting=true"
       , additionalFonts = [ "xft:Font Awesome 5 Free Solid:pixelsize=12"
                           , "xft:Font Awesome 5 Brands:pixelsize=12"
                           ]
       , borderColor = "black"
       , border = TopB
       , bgColor      = "#272727"
       , fgColor      = "#ebdbb2"
       , alpha = 255
       , position = OnScreen 1 $ TopSize L 100 32
       , textOffset = -1
       , iconOffset = -1
       , lowerOnStart = True
       , pickBroadest = False
       , persistent = False
       , hideOnStart = False
       , iconRoot = "."
       , allDesktops = False
       , overrideRedirect = True
       , commands = [
           Run $ Date "%a %b %_d %Y %H:%M:%S" "date" 10
           , Run $ UnsafeXPropertyLog "_XMONAD_LOG_TOP_LEFT"
           , Run $ Alsa "default" "Master"
                 [
                   "-t", tpl
                 ]

           ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%_XMONAD_LOG_TOP_LEFT% }{ %alsa:default:Master% | <fc=#ee9a00>%date%</fc>"
       }


main :: IO ()
main = do
  xmobar config
