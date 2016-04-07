
import Cocoa

class ViewController: NSViewController {
    var panelViewController: PanelViewController?
    var panel: NSPanel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (self.panelViewController == nil) {
            self.panelViewController = PanelViewController(nibName: "View", bundle: nil)
        }

        if self.panel == nil && self.panelViewController != nil {
            let panel = NSPanel(contentViewController: self.panelViewController!)
            panel.styleMask = panel.styleMask | NSUtilityWindowMask
            panel.floatingPanel = true
            panel.title = "Panel"
            self.panel = panel
        }
    }

    func showPanel() {
        if self.panelViewController != nil {
            self.panel?.makeKeyAndOrderFront(self)
        }
    }
    
    @IBAction func showPanelAction(sender: AnyObject) {
        showPanel()
    }
}
