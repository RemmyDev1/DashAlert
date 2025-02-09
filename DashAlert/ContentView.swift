import SwiftUI
import EventKit

// Custom shape to round specific corners
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
  
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// Main View
struct ContentView: View {
    @State var isReminder = false
    @State var isDashboardView = false
    @EnvironmentObject var themeManager: ThemeManager
    @State var isSettingsMenuOpen = false
    @State var showWelcomePopup = false
    
    @AppStorage("selectedCountry") private var selectedCountry = "United States"

    let countries = ["United States", "Canada", "Mexico", "United Kingdom", "Australia", "Germany", "France", "Italy", "Spain", "China", "Japan", "India"]
    
    let emergencyNumbers = [
        "United States": "911",
        "Canada": "911",
        "Mexico": "060",
        "United Kingdom": "999",
        "Australia": "000",
        "Germany": "110",
        "France": "15",
        "Italy": "113",
        "Spain": "112",
        "China": "110",
        "Japan": "110",
        "India": "100"
    ]

    var body: some View {
        ZStack {
            Color.dashAlertBlack
                .ignoresSafeArea()
            
            VStack {
                if isReminder {
                    ReminderView()
                } else if isDashboardView {
                    DashboardView()
                } else {
                    HomeView(
                        selectedCountry: $selectedCountry,
                        isDashboardView: $isDashboardView,
                        isReminder: $isReminder,
                        isSettingsMenuOpen: $isSettingsMenuOpen,
                        countries: countries	
                    )
                }
                Spacer()
            }
            .padding(.bottom, 70)
            
            VStack {
                HStack {
                    Spacer()
                    Menu {
                        Button(action: {
                            themeManager.isDarkMode.toggle()
                        }) {
                            Label(themeManager.isDarkMode ? "Switch to Light Mode" : "Switch to Dark Mode",
                                  systemImage: themeManager.isDarkMode ? "sun.max.fill" : "moon")
                        }
                        
                        Button(action: {
                            isSettingsMenuOpen.toggle()
                        }) {
                            Label("Settings", systemImage: "gear")
                        }
                        Button(action: {
                            callEmergencyNumber()
                        }) {
                            Text("Call \(selectedCountry) Road Police")							
                        }
                    } label: {
                        Image(systemName: "gearshape")
                            .font(.title)
                            .padding(6)
                            .background(Color.dashAlertGreen)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.top, 10)
                .padding(.trailing, 10)
                
                Spacer()
            }
            
            // Bottom Bar
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        isReminder = false
                        isDashboardView = true
                    }) {
                        Image(systemName: "brakesignal")
                            .font(.title)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.dashAlertGreen)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(maxHeight: 50, alignment: .top)
                    }
                    Button(action: {
                        isReminder = false
                        isDashboardView = false
                    }) {
                        Image(systemName: "house.fill")
                            .font(.title)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.dashAlertGreen)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(maxHeight: 50, alignment: .top)
                    }
                    Button(action: {
                        isReminder = true
                        isDashboardView = false
                    }) {
                        Image(systemName: "calendar.badge.checkmark")
                            .font(.title)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.dashAlertGreen)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(maxHeight: 50, alignment: .top)
                    }
                    Spacer()
                }
                .frame(height: 60)
                .background(Color.dashAlertDarkGray)
                .clipShape(RoundedCorner(radius: 15, corners: [.topLeft, .topRight]))
                .shadow(radius: 2)
                .padding(.horizontal)
            }
        }
        .ignoresSafeArea(.keyboard)
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
        .sheet(isPresented: $isSettingsMenuOpen) {
            SettingsMenu(selectedCountry: $selectedCountry, countries: countries, isSettingsMenuOpen: $isSettingsMenuOpen)
                .background(Color.dashAlertBlack)
        }
    }
    
    // Function to handle emergency call
    func callEmergencyNumber() {
        guard let number = emergencyNumbers[selectedCountry] else { return }
        guard let url = URL(string: "tel://\(number)") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
	

struct SettingsMenu: View {
    @Binding var selectedCountry: String
    let countries: [String]
    @Binding var isSettingsMenuOpen: Bool

    var body: some View {
        NavigationView {
            VStack {
                Text("Currently Selected Country: \(selectedCountry)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 20)
                
                List {
                    ForEach(countries, id: \.self) { country in
                        Button(action: {
                            selectedCountry = country
                        }) {
                            Text(country)
                                .padding(.vertical, 10)
                        }
                        .background(RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(selectedCountry == country ? Color.dashAlertGreen : Color.clear, lineWidth: 2))
                    }
                }
                .listStyle(PlainListStyle())
                
                Spacer()
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                isSettingsMenuOpen.toggle()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.red)
            })
            .background(Color.dashAlertBlack)
        }
    }
}

struct HomeView: View {
    @Binding var selectedCountry: String
    @Binding var isDashboardView: Bool
    @Binding var isReminder: Bool
    @Binding var isSettingsMenuOpen: Bool
    let countries: [String]
    
    @EnvironmentObject var themeManager: ThemeManager
    @State private var showWelcomePopup = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Image(systemName: "car")
                        .font(.largeTitle)
                        .foregroundColor(.dashAlertGreen)
                    Text("DashAlert")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.dashAlertGreen)
                    Spacer()
                }
                .padding(.top, 40)

                Text("Your personal road safety assistant")
                    .font(.subheadline)
                    .foregroundColor(.dashAlertWhite)
                    .padding(.bottom, 10)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("""
                    DashAlert was created with a clear vision - to empower drivers with \
                    instant access to critical vehicle information and safety resources. \
                    We believe every driver deserves peace of mind on the road.
                    """)
                    .foregroundColor(.dashAlertWhite)
                    
                    Text("Key Features:")
                        .font(.title3)
                        .bold()
                        .padding(.top)
                        .foregroundColor(.dashAlertGreen)
                    
                    FeatureRow(
                        icon: "exclamationmark.triangle.fill",
                        title: "Warning Sign Database",
                        description: "Instant access to 25+ vehicle warning signs with detailed repair information"
                    ) {
                        isDashboardView = true
                    }
                    
                    FeatureRow(
                        icon: "calendar.badge.clock",
                        title: "Maintenance Reminders",
                        description: "Create customized reminders for vehicle servicing"
                    ) {
                        isReminder = true
                    }
                    
                    FeatureRow(
                        icon: "globe",
                        title: "Global Emergency Support",
                        description: "Direct access to local emergency services in 12+ countries"
                    ) {
                        isSettingsMenuOpen = true
                    }
                    
                    FeatureRow(
                        icon: "paintbrush.pointed.fill",
                        title: "Custom Themes",
                        description: "Choose between light and dark mode for optimal visibility"
                    ) {
                        themeManager.isDarkMode.toggle()
                    }
                }
                .padding(.horizontal, 16)
                
                Spacer()
            }
            .padding(.vertical, 16)
        }
        .background(Color.dashAlertBlack)
    }
}

// Creates a clean orderly look for the text and makes them hae an animation when they are pressed
struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    var action: (() -> Void)?
    
    @State private var isPressed = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.dashAlertGreen)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(isPressed ? .dashAlertGreen : .dashAlertWhite)
                
                Text(description)
                    .foregroundColor(.dashAlertWhite.opacity(0.9))
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
        .onTapGesture {
            action?()
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
}
