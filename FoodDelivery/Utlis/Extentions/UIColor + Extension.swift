
import UIKit

extension UIColor {
    
    convenience init(_ hex: String, alpha: CGFloat = 1.0) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) { cString.removeFirst() }
        
        if ((cString.count) != 6) {
            self.init("ff0000") // return red color for wrong hex input
          return
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
      }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension UIColor {
    convenience init(
            light lightModeColor: @escaping @autoclosure () -> UIColor,
            dark darkModeColor: @escaping @autoclosure () -> UIColor
         ) {
            self.init { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .light:
                    return lightModeColor()
                case .dark:
                    return darkModeColor()
                case .unspecified:
                    return darkModeColor()
                @unknown default:
                    return lightModeColor()
                }
            }
        }
    //#D20E0E
    class var primary_color : UIColor {#colorLiteral(red: 0.9058823529, green: 0.05882352941, blue: 0.05882352941, alpha: 1)}
    
    //##FDE7E7
    class var button_active_color : UIColor {#colorLiteral(red: 0.9921568627, green: 0.9058823529, blue: 0.9058823529, alpha: 1)}
    
    //#222325
    class var dark_gray_color : UIColor {#colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.09019607843, alpha: 1)}
    
    //#D1D3D8
    class var stoke_color : UIColor {#colorLiteral(red: 0.8196078431, green: 0.8274509804, blue: 0.8470588235, alpha: 1)}
    
    //#6B7280
    class var text_light_color : UIColor {#colorLiteral(red: 0.4196078431, green: 0.4470588235, blue: 0.5019607843, alpha: 1)}
    
    //#F0F1F2
    class var stoke_colorII : UIColor {#colorLiteral(red: 0.9411764706, green: 0.9450980392, blue: 0.9490196078, alpha: 1)}
}
