
import Foundation

let processInfo = NSProcessInfo.processInfo()

if processInfo.arguments.count > 1 {
    let message = processInfo.arguments[1]
    vsyslog(LOG_NOTICE, message, getVaList([]))
}
