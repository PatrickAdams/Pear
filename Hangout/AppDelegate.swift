import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    var hangouts = [
        (roomName: "Registry iOS Standup", roomId: "gbs-csej-mca"),
        (roomName: "Hangout 1", roomId: "mjw-raqj-rfp"),
        (roomName: "Hangout 2", roomId: "xpg-vvut-wzg"),
        (roomName: "Hangout 3", roomId: "ory-ruoq-smt")
    ]

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusBarItem.button?.image = NSImage(named: NSImage.Name("hangout"))
        constructMenu()
    }

    @objc func openHangout(_ sender: Any?) {
        hangouts.forEach { hangout in
            if hangout.roomName == (sender as? NSMenuItem)?.title {
                NSWorkspace.shared.openFile("https://meet.google.com/\(hangout.roomId)", withApplication: "/Applications/Google Chrome.app")
            }
        }
    }

    func constructMenu() {
        let menu = NSMenu()
        for (index, hangout) in hangouts.enumerated() {
            menu.addItem(NSMenuItem(title: hangout.roomName, action: #selector(AppDelegate.openHangout(_:)), keyEquivalent: "\(index + 1)"))
            if hangout.roomName == "Registry iOS Standup" {
                menu.addItem(NSMenuItem.separator())
            }
        }
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

        statusBarItem.menu = menu
    }

}
