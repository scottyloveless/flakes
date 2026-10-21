//@ pragma UseQApplication
// UseQApplication: tray menus are rendered as native QMenus, which need a QApplication.

import Quickshell
import qs.bar

ShellRoot {
    // One bar per monitor; hotplugged monitors get a bar automatically
    Variants {
        model: Quickshell.screens

        Bar {}
    }
}
