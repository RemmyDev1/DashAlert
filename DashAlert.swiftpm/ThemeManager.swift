import SwiftUI

//Manages Light and Dark Theme's in the app so when ever you change the theme it auto refreshes without having to click on another tab to see the changed theme
class ThemeManager: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode = true{
        willSet { objectWillChange.send() } // Forces refresh when changed
    }
}
