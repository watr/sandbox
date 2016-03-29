
import Cocoa

class ViewController: NSViewController {
    @IBOutlet var button: Button!
    @IBOutlet var label: NSTextField!
    
    var timeIntervals: [NSTimeInterval] = [] {
        didSet {
            self.updateLabelText()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateLabelText()
    }
    
    func updateLabelText() {
        if self.timeIntervals.count == 0 {
            self.label.stringValue = ""
            return
        }

        let timeIntervalAverage = (1000.0 * self.timeIntervals.reduce(0, combine: +) / Double(self.timeIntervals.count))
        
        self.label.stringValue = String(format: "%.2lf msec", timeIntervalAverage)
    }
    
    @IBAction func action(sender: AnyObject) {
        if let timeInterval = self.button.timeIntervalSinceMouseDown() {
            self.timeIntervals = self.timeIntervals + [timeInterval]
        }
    }
    
    @IBAction func export(sender: AnyObject) {
        if self.timeIntervals.count == 0 {
            return
        }
        
        let text = self.timeIntervals.map {
            String($0)
            }.joinWithSeparator("\n")
        let savePanel = NSSavePanel()
        savePanel.allowedFileTypes = ["txt"]
        savePanel.allowsOtherFileTypes = true
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH.mm.ss";
        savePanel.nameFieldStringValue = "Time Gaps " + dateFormatter.stringFromDate(NSDate())
        
        savePanel.beginSheetModalForWindow(self.view.window!) { (result) in
            if result == NSModalResponseOK, let url = savePanel.URL {
                text.dataUsingEncoding(NSUTF8StringEncoding)?.writeToURL(url, atomically: true)
            }
        }
    }
}

