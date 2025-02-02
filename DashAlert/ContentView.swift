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
    @State private var isReminder = false
    @State private var isDashboardView = false
    @State private var isEmergencyGuideView = false
    @EnvironmentObject var themeManager: ThemeManager
    @State private var isSettingsMenuOpen = false
    
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
                } else if isEmergencyGuideView{
                    EmergencyGuideView()
                } else {
                    HomeView(isDashboardView: $isDashboardView, isEmergencyGuideView: $isEmergencyGuideView ,selectedCountry: $selectedCountry, countries: countries)
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
    @Binding var isDashboardView: Bool
    @Binding var isEmergencyGuideView: Bool
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var selectedCountry: String
    let countries: [String]

    var body: some View {
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
            
            Button(action: {
                isDashboardView = true
            }) {
                Text("Get Started")
                    .font(.headline)
                    .foregroundColor(.dashAlertWhite)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.dashAlertGreen)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 16)
            Spacer()
            
            Button(action: {
                isEmergencyGuideView = true
            }) {
                Text("Emergency Guide")
                    .font(.headline)
                    .foregroundColor(.dashAlertWhite)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.dashAlertRed)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 16)
            Spacer()
        }
        .padding(.vertical, 16)
        .background(Color.dashAlertBlack)
        .cornerRadius(15)
        .padding(.horizontal, 16)
        .frame(maxHeight: .infinity, alignment: .center)
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
    }
}
