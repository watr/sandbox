
import Cocoa

func crash() {
    let `nil`: AnyObject? = nil
    let _: AnyObject = `nil`!
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let delay: TimeInterval = 3.0
        Timer.scheduledTimer(withTimeInterval: delay, repeats: false, block: {_ in crash()})
    }
}

