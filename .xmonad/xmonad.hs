--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import Data.Monoid
import Data.Ratio ((%))
import System.Exit
import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ICCCMFocus
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Grid
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import XMonad.Actions.UpdatePointer
import qualified Data.Map        as M
import qualified XMonad.StackSet as W

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
--myTerminal      = "xterm"
myTerminal      = "urxvt"

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
-- myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]
myWorkspaces    = ["ffox1","ffox2","idea","sources","tomcat","database","root","chrome","chat", "10", "11", "12", "14", "15", "16", "17", "18", "19"]

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
    , className =? "Do"             --> doFloat
    , className =? "Pidgin"         --> doF (W.shift "9")
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    -- Allows focusing other monitors without killing the fullscreen
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)
	]

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
-- http://bbs.archlinux.org/viewtopic.php?pid=744649
myStartupHook = setWMName "LG3D"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
newKeys x = M.union (M.fromList (myKeys x)) (keys defaultConfig x)
myKeys conf@(XConfig {XMonad.modMask = modm}) =
	[ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
	, ((0, xK_Print), spawn "scrot")
	, ((mod4Mask, xK_Up),           spawn "amixer -c 0 set Master 2dB+")
	, ((mod4Mask, xK_Down),         spawn "amixer -c 0 set Master 1dB-")
	, ((mod4Mask, xK_Page_Up),      spawn "quodlibet --previous")
	, ((mod4Mask, xK_Page_Down),    spawn "quodlibet --next")
	, ((mod4Mask, xK_Home),         spawn "quodlibet --play-pause")
	, ((mod4Mask, xK_quoteleft),    spawn "rotatexkbmap") -- with qwerty keyboard
	, ((mod4Mask, xK_twosuperior),  spawn "rotatexkbmap") -- with azerty keyboard
	, ((mod4Mask, xK_p),            spawn "dmenu_run")
	]
	++
	[((m .|. modm, k), windows $ f i)
		| (i, k) <- zip (workspaces conf) $ [xK_1 .. xK_9] ++ [xK_F1 .. xK_F9]
		, (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]



--myLogHook xmproc = dynamicLogWithPP $ xmobarPP
--			       { ppOutput = hPutStrLn xmproc
--             	    , ppTitle = xmobarColor "green" "" . shorten 50
--    	           }
myLogHook = dynamicLogWithPP dzenPP

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.


-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
	xmproc <- spawnPipe "xmobar" 
	xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig {
		manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
		, terminal = myTerminal
		, modMask = myModMask
        , normalBorderColor="#000044"
        , focusedBorderColor="#00FF00" 
        , borderWidth = 1
 	, startupHook = myStartupHook
        , layoutHook = smartBorders (avoidStruts  $ Grid ||| layoutHook defaultConfig)
		, workspaces = myWorkspaces
		, keys = newKeys
		, logHook = (dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
			,  ppCurrent = xmobarColor "#09F" "" . wrap "[" "]"
                        , ppTitle = xmobarColor "pink" "" . shorten 50
                        }) >> updatePointer (Relative 0.5 0.5) >> takeTopFocus
	}
