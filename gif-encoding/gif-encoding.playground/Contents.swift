
import UIKit
import ImageIO
import MobileCoreServices

enum GIFLoopCount {
    case Forever
    case Count(UInt16)
    
    var rawValue: UInt16 {
        switch self {
        case .Forever:
            return 0
        case .Count(let count):
            return count
        }
    }
}

struct GIFFrame {
    let image: CGImage
    let duration: CGFloat
}

protocol GIFEncoderDataSource {
    var gifFrameCount: Int {get}
    var loopCount: GIFLoopCount {get}
    func gifFrame(index: Int) -> GIFFrame
}

class GIFEncoder {
    let dataSource: GIFEncoderDataSource
    init(dataSource: GIFEncoderDataSource) {
        self.dataSource = dataSource
    }
    func encode(completion:(encodedData: NSData?) -> Void) {
        let data = CFDataCreateMutable(kCFAllocatorDefault, 0)!
        let frameCount = dataSource.gifFrameCount
        let loopCount = dataSource.loopCount
        
        let destination = CGImageDestinationCreateWithData(data,
                                                           kUTTypeGIF,
                                                           frameCount,
                                                           nil)
        
        for i in 0..<frameCount {
            let gifFrame = dataSource.gifFrame(i)
            
            let dic = [kCGImagePropertyGIFDictionary as NSString: ([kCGImagePropertyGIFDelayTime as NSString: gifFrame.duration] as NSDictionary)]
            
            CGImageDestinationAddImage(destination!, gifFrame.image, dic)
        }
        
        do {
            let dic = [kCGImagePropertyGIFDictionary as NSString: ([kCGImagePropertyGIFLoopCount as NSString: NSNumber(unsignedShort: loopCount.rawValue)] as NSDictionary)]
            CGImageDestinationSetProperties(destination!, dic)
        }
        CGImageDestinationFinalize(destination!)

        completion(encodedData:data as NSData)
    }
}

////////////////////////////////////////////////////////////////////////
// demo
////////////////////////////////////////////////////////////////////////

struct SomeWhatContainer {
    let recImage = UIImage(named: "rec.png")
    let blankImage = UIImage(named: "blank.png")
}

extension SomeWhatContainer: GIFEncoderDataSource {
    var gifFrameCount: Int {
        get {
            return 2
        }
    }
    
    var loopCount: GIFLoopCount {
        get{
            return .Count(5)
        }
    }
    
    func gifFrame(index: Int) -> GIFFrame {
        let rec = (index % 2 == 0)
        
        let image = (rec ? self.recImage : self.blankImage)
        return GIFFrame(image: (image?.CGImage)!, duration:(rec ? 0.5 : 0.1))
    }
}

let encoder = GIFEncoder(dataSource: SomeWhatContainer())

encoder.encode() { data in
    if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
        
        // print help for preview gif file
        func printHelp(url: NSURL) {
            print("open -a Safari \"\(url)\"")
        }
        
        let file = "demo.gif"
        let url = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(file)
        
        // print help
        printHelp(url)
        
        do {
            try data?.writeToURL(url, options: .DataWritingAtomic)
        }
        catch {
        }
    }
}
