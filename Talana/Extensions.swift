import UIKit

extension UIView {
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
    }
}

extension CGFloat {
    func columns(in lanaStack: TalanaStackView) -> CGFloat {
        let colTotal = self * lanaStack.lanaCol
        let gutterTotal = (self - 1) * lanaStack.gutter
        
        return (colTotal + gutterTotal)/lanaStack.stackWidth
    }
}

extension UIColor {
    /// EZSE: init method with hex string and alpha(default: 1)
    public convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        
        guard let hex = Int(formatted, radix: 16) else { return nil }
        
        let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
        let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
        let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

public extension UIStackView {
    
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach({
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        })
    }
}

public struct ez {
    
    public static var screenOrientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    
    public static var screenWidth: CGFloat {
        
        #if os(iOS)
            
            if UIInterfaceOrientationIsPortrait(screenOrientation) {
                return UIScreen.main.bounds.size.width
            } else {
                return UIScreen.main.bounds.size.height
            }
            
        #elseif os(tvOS)
            
            return UIScreen.mainScreen().bounds.size.width
            
        #endif
    }
}
