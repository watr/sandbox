
import UIKit
import XCPlayground

func createHueImage(imageSize: CGSize) -> UIImage? {
    UIGraphicsBeginImageContext(imageSize)
    
    guard let ctx = UIGraphicsGetCurrentContext() else {
        return nil
    }
    
    let components: [(red: CGFloat, green: CGFloat, blue: CGFloat)] =
    [
        (1, 0, 0),
        (1, 1, 0),
        (0, 1, 0),
        (0, 1, 1),
        (0, 0, 1),
        (1, 0, 1),
    ]
    
    let points = (0...components.count).reduce([]) { (v: [CGFloat], w: Int) -> [CGFloat] in
        return (v + [CGFloat(Double(w) * (1.0 / Double(components.count)))])
    }
    //print(points)
    
    let vPixels = Int(imageSize.height)
    
    for y in 0..<vPixels {
        
        let colors = ((components + components[0...0]).map { (red: CGFloat, green: CGFloat, blue: CGFloat) -> CGColor in
            let r = (y == 0) ? red : (red + (CGFloat(1 - red) / CGFloat(vPixels)) * CGFloat(y))
            let g = (y == 0) ? green : (green + (CGFloat(1 - green) / CGFloat(vPixels)) * CGFloat(y))
            let b = (y == 0) ? blue : (blue + (CGFloat(1 - blue) / CGFloat(vPixels)) * CGFloat(y))
            
            return UIColor(red: r, green: g, blue: b, alpha: 1.0).CGColor
            })
        
        
        let gr = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), colors, points)
        
        
        let beginPoint = CGPoint(x: 0, y: CGFloat(y))
        let endPoint =   CGPoint(x: imageSize.width, y: CGFloat(y + 1))
        //print("\(beginPoint), \(endPoint)")
        
        CGContextSaveGState(ctx)
        CGContextAddRect(ctx, CGRect(origin: beginPoint, size: CGSize(width: (endPoint.x - beginPoint.x), height: (endPoint.y - beginPoint.y))))
        CGContextClip(ctx)
        
        CGContextDrawLinearGradient(ctx, gr, beginPoint, endPoint, CGGradientDrawingOptions(rawValue: 0))
        CGContextRestoreGState(ctx)

    }
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    return image
}

func saveImageWithName(image:UIImage, name: String) -> Bool {
    if let pngData = UIImagePNGRepresentation(image) {
        let destinationDirectoryURL = XCPlaygroundSharedDataDirectoryURL.URLByAppendingPathComponent("hue-image")
        
        let fileManager = NSFileManager.defaultManager()
        
        if let path = destinationDirectoryURL.path where !fileManager.fileExistsAtPath(path) {
            do {
                try fileManager.createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
            }
            catch {
                return false
            }
        }
        
        let url = XCPlaygroundSharedDataDirectoryURL.URLByAppendingPathComponent("hue-image").URLByAppendingPathComponent(name).URLByAppendingPathExtension("png")
        print(url)
        return pngData.writeToURL(url, atomically: true)
    }
    else {
        return false
    }
}

let imageInfoArray: [(pixelSize: CGSize, name: String)] = [
    (CGSize(width: 256, height: 256), "hue"),
    (CGSize(width: 512, height: 512), "hue@2x"),
]

print("start generating images.")

let results = imageInfoArray.map { (pixelSize: CGSize, name: String) -> Bool in
    let image = createHueImage(pixelSize)
    if let image = image {
        return saveImageWithName(image, name: name)
    }
    else {
        return false
    }
}

print("fin.")
