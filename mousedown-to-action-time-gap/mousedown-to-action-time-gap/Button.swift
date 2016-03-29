
import AppKit

class Button : NSButton {
    private var mouseDownDate: NSDate?
    
    override func mouseDown(theEvent: NSEvent) {
        self.mouseDownDate = NSDate()
        super.mouseDown(theEvent)
    }
    
    func timeIntervalSinceMouseDown() -> NSTimeInterval? {
        if let date = self.mouseDownDate {
            return NSDate().timeIntervalSinceDate(date)
        }
        else {
            return nil
        }
    }
}