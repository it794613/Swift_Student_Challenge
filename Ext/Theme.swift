import SwiftUI

struct Theme {
    static func myBackgroundColor(forScheme scheme: ColorScheme) -> Color {
        let lightColor = Color.init(hex: "F2F2F7")
        let darkColor = Color.init(hex: "1E1E1E")
        
        switch scheme {
        case .light : return lightColor
        case .dark : return darkColor
        @unknown default: return lightColor
        }
    }
    
    static func black(forScheme scheme: ColorScheme) -> Color {
        let lightColor = Color.black
        let darkColor = Color.white
        
        switch scheme {
        case .light : return lightColor
        case .dark : return darkColor
        @unknown default: return lightColor
        }
    }
    static func white(forScheme scheme: ColorScheme) -> Color {
        let lightColor = Color.white
        let darkColor = Color.black
        
        switch scheme {
        case .light : return lightColor
        case .dark : return darkColor
        @unknown default: return lightColor
        }
    }
    
}
