import SwiftUI

class TourManager: ObservableObject {
    @Published var currentStep: Int = 0
    @Published var isTourActive: Bool = false
    @AppStorage("hasCompletedTour") var hasCompletedTour: Bool = false
    
    let totalSteps = 6
    let coordinateSpaces: [Int: String] = [
        1: "emergencyCallButton",
        2: "themeToggleButton",
        3: "settingsButton",
        4: "bottomNavigation",
        5: "dashboardSearch",
        6: "reminderButton"
    ]
    
    func startTour() {
        currentStep = 1
        isTourActive = true
        hasCompletedTour = true
    }
    
    func endTour() {
        currentStep = 0
        isTourActive = false
    }
}
