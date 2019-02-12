import Cocoa

["1.0",
 "2.0",
 "2.2.0",
 "2.3",
 "2.3.0",
 "2.3.3",
 "2.10.0"].forEach({
    let result = ("2.3.0".compare($0,
                                  options: [.numeric]))
    print((result != .orderedDescending))
 })
