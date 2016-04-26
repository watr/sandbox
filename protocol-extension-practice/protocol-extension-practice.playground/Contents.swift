
import UIKit

protocol HelloProtocol {
}

extension HelloProtocol {
    func say() {
        print("protocol")
    }
}

struct HelloStruct : HelloProtocol {
    func say() {
        print("stcuct")
    }
}

/////////////////////////////////////////////
// demo
/////////////////////////////////////////////

let s: HelloStruct = HelloStruct()
s.say()

let p: HelloProtocol = s
p.say()
