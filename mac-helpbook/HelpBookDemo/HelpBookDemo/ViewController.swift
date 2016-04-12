
import Cocoa

class ViewController: NSViewController {
    @IBOutlet var popUpButton: NSPopUpButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.popUpButton.removeAllItems()
        
        if let helpBookContentsUrl = NSBundle.mainBundle().URLForResource("HelpBook", withExtension: "help", subdirectory: nil)?.URLByAppendingPathComponent("Contents").URLByAppendingPathComponent("Resources").URLByAppendingPathComponent("en.lproj")
        {
            for title in ["1st", "2nd", "3rd"] {
                if let path = helpBookContentsUrl.URLByAppendingPathComponent(title.stringByAppendingString(".html")).path {
                    if NSFileManager.defaultManager().fileExistsAtPath(path) {
                        self.popUpButton.menu?.addItemWithTitle(title, action: nil, keyEquivalent: "")
                    }
                }
            }
        }
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func showHelp() {
        if self.popUpButton.itemArray.count == 0 {
            return
        }
        
        if let key = self.popUpButton?.selectedItem?.title {
            NSHelpManager.sharedHelpManager().openHelpAnchor(key, inBook: nil)
        }
    }
    
    @IBAction func showHelpAction(sender: AnyObject) {
        showHelp()
    }

}

