import Xmobar
import Data.List

config = defaultConfig { font = "xft:JetBrainsMono Nerd Font:weight=bold:pixelsize=12:antialias=true:hinting=true"
       , additionalFonts = [ "xft:Font Awesome 5 Free Solid:pixelsize=12"
                           , "xft:Font Awesome 5 Brands:pixelsize=12"
                           ]
       , borderColor = "black"
       , border = TopB
       , bgColor      = "#272727"
       , fgColor      = "#ebdbb2"
       , alpha = 255
       , position = OnScreen 0 $ TopSize L 100 32
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
           Run $ WeatherX "KIWA"
             [ ("clear", "盛 ")
             , ("sunny", "盛 ")
             , ("mostly clear", "🌤")
             , ("mostly sunny", "🌤")
             , ("partly sunny", "⛅")
             , ("fair", "🌑")
             , ("cloudy","☁")
             , ("overcast","☁")
             , ("partly cloudy", "⛅")
             , ("mostly cloudy", "🌧")
             , ("considerable cloudiness", "⛈")]
             ["-t", "<fn=0><skyConditionS></fn> <tempF>°"
             , "-L","50", "-H", "95", "--normal", "black"
             , "--high", "lightgoldenrod4", "--low", "#257ca3"]
             18000
           , Run $ Cpu ["-L","3","-H","50", "--normal","green","--high","red"] 10
           , Run $ Memory ["-t","Mem: <usedratio>%"] 10
           , Run $ Date " %a %b %_d %Y %H:%M:%S" "date" 10
           , Run $ UnsafeXPropertyLog "_XMONAD_LOG_TOP_RIGHT"
           ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%_XMONAD_LOG_TOP_RIGHT% }{ %cpu% | %memory% | %KIWA% |<fc=#ee9a00>%date%</fc>"

       }

main :: IO ()
main = do
  xmobar config
