
import UIKit

protocol HelloProtocol {
    //func say()
}

extension HelloProtocol {
    func say() {
        print("protocol-extension")
    }
}

struct HelloStruct: HelloProtocol {
    func say() {
        print("stcuct")
    }
}

class HelloClass: HelloProtocol {
    func say() {
        print("class")
    }
}

/////////////////////////////////////////////
// demo
/////////////////////////////////////////////

do {
    let s: HelloStruct = HelloStruct()
    s.say()
    
    let p: HelloProtocol = s
    p.say()
}

print("========")

do {
    let c: HelloClass = HelloClass()
    c.say()
    
    let p: HelloProtocol = c
    p.say()
}
