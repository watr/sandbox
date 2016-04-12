
import Cocoa

class ViewController: NSViewController {
    let anchorKey = "anchor"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func updateHelpBook() {
        let newAnchor = NSUUID().UUIDString
        
        do {
            var newHtmlString = ""
            let mainBundle = NSBundle.mainBundle()
            
            guard
            let url1 = mainBundle.URLForResource("source_from-beginning-to-title", withExtension: "txt", subdirectory: nil),
            let url2 = mainBundle.URLForResource("source_from-title-to-contents", withExtension: "txt", subdirectory: nil),
            let url3 = mainBundle.URLForResource("source_from-contents-to-end", withExtension: "txt", subdirectory: nil)
            
            else {
                return
            }
            
            newHtmlString += try String(contentsOfURL:url1)
            newHtmlString += "<title>\(newAnchor)</title>"
            newHtmlString += try String(contentsOfURL:url2)
            newHtmlString += "<p><a name=\"\(newAnchor)\"></a>\(newAnchor)</p>"
            newHtmlString += try String(contentsOfURL:url3)
            
            let helpbookUrl = mainBundle.URLForResource("helpbook", withExtension: "help", subdirectory: nil)
            
            try newHtmlString.writeToURL((helpbookUrl?.URLByAppendingPathComponent("\(newAnchor).html"))!, atomically: true, encoding: NSUTF8StringEncoding)
            
            NSUserDefaults.standardUserDefaults().setValue(newAnchor, forKey: anchorKey)
        }
        catch {
        
        }
    }
    
    @IBAction func updateAction(sender: AnyObject) {
        self.updateHelpBook()
    }

    func showHelp() {
        if let anchor = NSUserDefaults.standardUserDefaults().objectForKey(anchorKey) as? String {
            NSHelpManager.sharedHelpManager().openHelpAnchor(anchor, inBook: nil)
        }
    }
    
    @IBAction func showHelpAction(sender: AnyObject) {
        self.showHelp()
    }
}

