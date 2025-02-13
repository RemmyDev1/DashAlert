import SwiftUI

public extension Color {
    static func dynamicColor(light: UIColor, dark: UIColor) -> Color {
        let uiColor = UIColor { $0.userInterfaceStyle == .light ? light : dark }
        
        return Color(uiColor: uiColor)
    }
    
    static func dynamicColor(light: Color, dark: Color) -> Color {
        dynamicColor(light: UIColor(light), dark: UIColor(dark))
    }
    
    static var dashAlertGreen: Self {
        dynamicColor(light: #colorLiteral(red: 0.114, green: 0.725, blue: 0.329, alpha: 1), dark: #colorLiteral(red: 0.114, green: 0.725, blue: 0.329, alpha: 1))
    }
    
    static var dashAlertRed: Self {
        dynamicColor(light: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), dark: #colorLiteral(red: 1.000, green: 0.227, blue: 0.184, alpha: 1))
    }
    
    static var dashAlertBlack: Self {
        dynamicColor(light: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), dark: #colorLiteral(red: 0.071, green: 0.071, blue: 0.071, alpha: 1))
    }
    
    static var dashAlertLightGray: Self {
        dynamicColor(light: #colorLiteral(red: 0.910, green: 0.910, blue: 0.910, alpha: 1), dark: #colorLiteral(red: 0.702, green: 0.702, blue: 0.702, alpha: 1))
    }
    
    static var dashAlertDarkGray: Self {
        dynamicColor(light: #colorLiteral(red: 0.627, green: 0.627, blue: 0.627, alpha: 1), dark: #colorLiteral(red: 0.129, green: 0.129, blue: 0.129, alpha: 1))
    }
    
    static var dashAlertGray: Self {
        dynamicColor(light: #colorLiteral(red: 0.827, green: 0.827, blue: 0.827, alpha: 1), dark: #colorLiteral(red: 0.325, green: 0.325, blue: 0.325, alpha: 1))
    }
    
    static var dashAlertWhite: Self {
    
        dynamicColor(light: #colorLiteral(red: 0.067, green: 0.067, blue: 0.067, alpha: 1), dark: #colorLiteral(red: 0.882, green: 0.925, blue: 0.890, alpha: 1))
    }
    
}
