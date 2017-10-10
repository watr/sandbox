
import Cocoa

func logPopUp(popUp: NSPopUpButton, label: String? = nil) {
    let labelText: String = (label != nil ? "(" + label! + ")" : "")
    
    print("pop up's menu " +  labelText + ":", (popUp.menu ?? "nil"))
}

class ViewController: NSViewController {
    override func viewDidAppear() {
        let popUp = NSPopUpButton()
        logPopUp(popUp: popUp, label: "init")
        
        popUp.menu = nil
        logPopUp(popUp: popUp, label: "set nil")
    }

}

