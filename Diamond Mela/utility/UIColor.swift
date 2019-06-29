import UIKit

extension UIColor {
    
    static func blackColor() -> UIColor {
//        return UIColor(red: 23/255.0, green: 175/255.0, blue: 72/255.0, alpha: 1.0)
        return UIColor().colorFromHexString("000000")
    }
    
    static func whiteColor() -> UIColor {
//        return UIColor(red: 24/255.0, green: 175/255.0, blue: 72/255.0, alpha: 1.0)
         return UIColor().colorFromHexString("FFFFFF")
    }
    
    static func dmlLogoColor() -> UIColor {
         return UIColor().colorFromHexString("FFFFFF")
    }
    
    static func roundBack() -> UIColor {
        return UIColor().colorFromHexString("EEECED")
    }
    
    
    static func lineColor() -> UIColor {
        return UIColor().colorFromHexString("B7B7B7")
    }
  
    
    func colorFromHexString (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

//used
//myView.backgroundColor = UIColor.myCustomColor()
