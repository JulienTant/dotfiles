{-# OPTIONS_GHC -Wno-overlapping-patterns #-}
--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import           Control.Monad
import qualified Data.Bifunctor
import qualified Data.Map as M
import           Data.Maybe
import           Data.Monoid
import           System.Exit
import           System.IO
import           Text.Pretty.Simple.Internal.Color (colorBold)
import           XMonad
import           XMonad.Actions.OnScreen
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.SetWMName
import           XMonad.Layout.Spacing
import qualified XMonad.StackSet as W
import           XMonad.Util.EZConfig
import           XMonad.Util.NamedScratchpad
import           XMonad.Util.PureX (greedyView)
import           XMonad.Util.Run
import           XMonad.Util.SpawnOnce (spawnOnce, spawnOnOnce, spawnNOnOnce)
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.StatusBar
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.ClickableWorkspaces





---
-- Theme
---
colorBack   = "#2E3440"
colorFore   = "#D8DEE9"
color01     = "#343d46"
color02     = "#EC5f67"
color03     = "#99C794"
color04     = "#FAC863"
color05     = "#6699cc"
color06     = "#c594c5"
color07     = "#5fb3b3"
color08     = "#d8dee9"
color09     = "#343d46"
color10     = "#EC5f67"
color11     = "#99C794"
color12     = "#FAC863"
color13     = "#6699cc"
color14     = "#c594c5"
color15     = "#5fb3b3"
color16     = "#d8dee9"



myTerminal                  = "kitty"
myEditor                    = "emacsclient -c -a 'emacs'"
myFocusFollowsMouse         = True
myClickJustFocuses          = False
myBorderWidth               = 2
myModMask                   = mod4Mask
myNormalBorderColor         = colorBack
myFocusedBorderColor        = color15

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
---------------------------------------------------------------------------------------------------
-- myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $                                  --
--                                                                                               --
--     -- Resize viewed windows to the correct size                                              --
--     , ((modm,               xK_n     ), refresh)                                              --
--                                                                                               --
--     -- Move focus to the next window                                                          --
--     , ((modm,               xK_Tab   ), windows W.focusDown)                                  --
--                                                                                               --
--     -- Move focus to the next window                                                          --
--     , ((modm,               xK_j     ), windows W.focusDown)                                  --
--                                                                                               --
--     -- Move focus to the previous window                                                      --
--     , ((modm,               xK_k     ), windows W.focusUp  )                                  --
--                                                                                               --
--     -- Move focus to the master window                                                        --
--     , ((modm,               xK_m     ), windows W.focusMaster  )                              --
--                                                                                               --
--     -- Swap the focused window and the master window                                          --
--     , ((modm,               xK_Return), windows W.swapMaster)                                 --
--                                                                                               --
--     -- Swap the focused window with the next window                                           --
--     , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )                                 --
--                                                                                               --
--     -- Swap the focused window with the previous window                                       --
--     , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )                                 --
--                                                                                               --
--     -- Shrink the master area                                                                 --
--     , ((modm,               xK_h     ), sendMessage Shrink)                                   --
--                                                                                               --
--     -- Expand the master area                                                                 --
--     , ((modm,               xK_l     ), sendMessage Expand)                                   --
--                                                                                               --
--     -- Push window back into tiling                                                           --
--     , ((modm,               xK_t     ), withFocused $ windows . W.sink)                       --
--                                                                                               --
--     -- Increment the number of windows in the master area                                     --
--     , ((modm              , xK_comma ), sendMessage (IncMasterN 1))                           --
--                                                                                               --
--     -- Deincrement the number of windows in the master area                                   --
--     , ((modm              , xK_period), sendMessage (IncMasterN (-1)))                        --
--                                                                                               --
--     -- Toggle the status bar gap                                                              --
--     -- Use this binding with avoidStruts from Hooks.ManageDocks.                              --
--     -- See also the statusBar function from Hooks.DynamicLog.                                 --
--     --                                                                                        --
--     -- , ((modm              , xK_b     ), sendMessage ToggleStruts)                          --
--                                                                                               --
--     ]                                                                                         --
--     ++                                                                                        --
--     --                                                                                        --
---------------------------------------------------------------------------------------------------


leftScreen :: ScreenId
rightScreen :: ScreenId
leftScreen = 1
rightScreen = 0

workspaceConfig :: [(String, String, ScreenId)]
workspaceConfig = [ ("www", "1", leftScreen)
  , ("code", "2", rightScreen)
  , ("sys", "3", leftScreen)
  , ("chat", "4", rightScreen)
  , ("5", "5", leftScreen)
  , ("6", "6", leftScreen)
  , ("7", "7", leftScreen)
  , ("8", "8", leftScreen)
  , ("email", "9", leftScreen)
  , ("music", "0", leftScreen)
  ]



myWorkspaces :: [String]
wsKeys :: [String]
wsScreen :: [ScreenId]
(myWorkspaces, wsKeys, wsScreen) = unzip3 workspaceConfig

myWorkspaceIndices :: M.Map String Int
myWorkspaceIndices = M.fromList $ zip myWorkspaces (map (read::String->Int) wsKeys)

myKeys c = mkKeymap c $
  [
  -- Start applications
  ("M-<Return>", spawn $ XMonad.terminal c)
  , ("M-p", spawn "j4-dmenu-desktop")
  , ("M-<Backspace>", spawn "dmenu-power")
  , ("M-e", spawn myEditor)

  -- Screenshots
  ,  ("M-S-s", spawn "scrot -s '/home/a/screenshots/%F_%T.png' -e 'xclip -selection clipboard -target image/png -i $f'")

  -- Kill applications
  , ("M-w", kill)


  -- Layout Control
  , ("M-<Space>", sendMessage NextLayout)
  , ("M-S-<Space>", setLayout $ XMonad.layoutHook c)

  -- Window control
  , ("M-t", withFocused $ windows . W.sink)

  -- Scratchpads
  , ("M-`", namedScratchpadAction myScratchpads "ScratchyKitty")



  -- XMONAD CONTROL
  , ("M-S-r", spawn "killall -r 'xmobar*'; xmonad --recompile; xmonad --restart")
  , ("M-S-q", io exitSuccess)

  ] ++ [
  -- focus on workspace
  ("M-" ++ key, windows $ greedyViewOnScreen screen workspace) | (workspace, key, screen) <- workspaceConfig
  ] ++ [
  -- move window to workspace
  ("M-S-" ++ key, windows $ W.shift workspace) | (workspace, key, _) <- workspaceConfig
  ]



------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings :: XConfig l -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), \w -> focus w >> windows W.shiftMaster)

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), \w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = do
  avoidStruts $ spacingWithEdge 10 $ tiled ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100


------------------------------------------------------------------------
-- Scratchpads
--
myScratchpads =
  [
    NS "ScratchyKitty" (myTerminal ++ " --class ScratchyKitty") (className =? "ScratchyKitty") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
  ]




------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore


    -- www
    , className =? "Brave-browser"    --> doShift "www"
    -- code
    , className =? "Emacs"            --> doShift "code"
    -- sys
    , className =? "kitty"            --> doShift "sys"
    -- chat
    , className =? "discord"          --> doShift "chat"
    , className =? "matterhorn"       --> doShift "chat"
    ] <+> namedScratchpadManageHook myScratchpads


------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--


myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook :: X ()
myStartupHook = do
  -- set WMName to make java happy
  setWMName "LG3D"

  -- system utilities
  spawnOnce "feh --bg-scale --no-xinerama ~/wallpapers/reef2.jpg"
  spawnOnce "picom"
  spawnOnce "nm-applet"
  spawnOnce "emacs --daemon"
  spawn "numlockx"


  -- upon startup, start some app on their workspaces
  spawnOnOnce "www" "brave"
  spawnNOnOnce 4 "sys" myTerminal


ppTopLeft = xmobarPP {
        -- Current workspace
      ppCurrent = xmobarColor color06 "" . wrap
                    ("<box type=Bottom width=2 mb=2 color=" ++ color06 ++ ">") "</box>"
        -- Visible but not current workspace
      , ppVisible = xmobarColor color06 ""
        -- Hidden workspace
      , ppHidden = xmobarColor color05 "" . wrap
                   ("<box type=Top width=2 mt=2 color=" ++ color05 ++ ">") "</box>"
        -- Hidden workspaces (no windows)
      , ppHiddenNoWindows = xmobarColor color05 ""
        -- Title of active window
      , ppTitle = xmobarColor color16 "" . shorten 60
        -- Separator character
      , ppSep =  "<fc=" ++ color09 ++ "> <fn=1>|</fn> </fc>"
        -- Urgent workspace
      , ppUrgent = xmobarColor color02 "" . wrap "!" "!"
        -- order of things in xmobar
      , ppOrder  = \(ws:l:t:ex) -> [ws,l]
    }
ppTopRight = ppTopLeft

xmobarTopLeft    = statusBarPropTo "_XMONAD_LOG_TOP_LEFT" "xmobarLeft"    (clickablePP ppTopLeft)
xmobarTopRight      = statusBarPropTo "_XMONAD_LOG_TOP_RIGHT" "xmobarRight"       (clickablePP ppTopRight)

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do

  xmonad $ withSB (xmobarTopLeft <> xmobarTopRight) $ ewmhFullscreen . ewmh $ docks def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
