import SwiftUI

class ThemeManager: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode = false {
        willSet { objectWillChange.send() } // Forces refresh when changed
    }
}
