
import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var imageView: NSImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func show() {
        if let mainScreen = NSScreen.mainScreen(),
            let url = NSWorkspace.sharedWorkspace().desktopImageURLForScreen(mainScreen),
            let image = NSImage(contentsOfURL: url)
        {
            self.imageView?.image = image
        }
    }
    
    func showHelp() {
        NSHelpManager.sharedHelpManager().openHelpAnchor("anchor", inBook: nil)
    }
    
    @IBAction func showAction(sender: AnyObject) {
        self.show()
    }
    @IBAction func showHelpAction(sender: AnyObject) {
        self.showHelp()
    }
}

