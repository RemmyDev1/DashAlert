import SwiftUI

struct WarningSign: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let description: String
    let solution: String
    let isComplexRepair: Bool
    let averageCost: Double?
}

// View Model remains the same
class WarningSignsViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var signs = [
        WarningSign(
            name: "Check Engine Light",
            image: "exclamationmark.triangle.fill",
            description: "Indicates an issue with the engine or emissions system. Common causes include loose gas cap, faulty oxygen sensor, or catalytic converter issues.",
            solution: "First, check if the gas cap is loose and tighten it. If the light persists after driving for a while, professional diagnosis is needed.",
            isComplexRepair: true,
            averageCost: 350
        ),
        WarningSign(
            name: "Low Oil Pressure",
            image: "drop",
            description: "Indicates dangerous low oil pressure which can cause severe engine damage.",
            solution: "Immediately pull over safely and turn off the engine. Check oil level when engine is cool.",
            isComplexRepair: false,
            averageCost: nil
        ),
        WarningSign(
            name: "Battery Warning",
            image: "battery.100",
            description: "Indicates charging system problem or failing battery.",
            solution: "Check battery terminals for corrosion and ensure they're tight. If persists, battery or alternator may need replacement.",
            isComplexRepair: true,
            averageCost: 250
        ),
        WarningSign(
            name: "Coolant Temperature Warning",
            image: "sun",
            description: "Warns of an overheating engine due to low coolant or a failing cooling system.",
            solution: "Refill coolant, check for leaks, and inspect radiator, water pump, and thermostat.",
            isComplexRepair: true,
            averageCost: 250
            ),
        WarningSign(
            name: "Brake System Warning Light",
            image: "",
            description: "Indicates low brake fluid or an issue with the braking system.",
            solution: "Check brake fluid levels and brake pads; may require bleeding the brake system or replacing components.",
            isComplexRepair: true,
            averageCost: 300
        ),
        WarningSign(
            name: "ABS Warning Light",
            image: "",
            description: "Indicates a problem with the Anti-lock Braking System (ABS).",
            solution: "Diagnose with a scanner; repair may involve replacing ABS sensors or the control module.",
            isComplexRepair: true,
            averageCost: 400
        ),
        WarningSign(
            name: "Tire Pressure Warning Light (TPMS)",
            image: "",
            description: "Signals low tire pressure in one or more tires.",
            solution: "Check and inflate tires to the recommended pressure; replace faulty TPMS sensors if needed.",
            isComplexRepair: false,
            averageCost: 50
        ),
        WarningSign(
            name: "Airbag Warning Light",
            image: "",
            description: "Indicates a fault in the airbag system, which may prevent deployment in an accident.",
            solution: "Diagnose with a scanner; may require replacing airbag sensors or control module.",
            isComplexRepair: true,
            averageCost: 500
        ),
        WarningSign(
            name: "Power Steering Warning Light",
            image: "",
            description: "Indicates a failure in the power steering system, making steering harder.",
            solution: "Check power steering fluid levels and inspect the system for leaks or electronic faults.",
            isComplexRepair: true,
            averageCost: 350
        ),
        WarningSign(
            name: "Transmission Temperature Warning Light",
            image: "",
            description: "Indicates that the transmission is overheating.",
            solution: "Check transmission fluid level and condition; may require replacing the fluid or repairing the cooling system.",
            isComplexRepair: true,
            averageCost: 400
        ),
        WarningSign(
            name: "Fuel Cap Warning Light",
            image: "",
            description: "Indicates a loose or missing fuel cap, which can affect emissions.",
            solution: "Tighten or replace the fuel cap.",
            isComplexRepair: false,
            averageCost: 20
        ),
        WarningSign(
            name: "Glow Plug Indicator (Diesel Vehicles)",
            image: "",
            description: "Indicates an issue with the glow plugs or preheating system.",
            solution: "Check and replace faulty glow plugs.",
            isComplexRepair: true,
            averageCost: 250
        ),
        WarningSign(
            name: "Traction Control Warning Light",
            image: "",
            description: "Indicates an issue with the traction control system.",
            solution: "Check wheel speed sensors and ABS module; may require resetting or replacing sensors.",
            isComplexRepair: true,
            averageCost: 300
        ),
        WarningSign(
            name: "Engine Temperature Warning Light",
            image: "",
            description: "Signals an overheating engine.",
            solution: "Turn off the engine, let it cool, and check coolant levels; inspect the radiator and thermostat.",
            isComplexRepair: true,
            averageCost: 350
        ),
        WarningSign(
            name: "Seat Belt Sensor Error",
            image: "",
            description: "Indicates a malfunctioning seat belt sensor, which may prevent proper detection of a fastened seatbelt.",
            solution: "Check the seat belt sensor wiring and connections; replace the sensor if faulty.",
            isComplexRepair: true,
            averageCost: 200
        ),
        WarningSign(
            name: "ECU Failure",
            image: "",
            description: "Indicates a malfunction in the Engine Control Unit (ECU), which can affect engine performance and drivability.",
            solution: "Diagnose with an OBD-II scanner; may require reprogramming or replacing the ECU.",
            isComplexRepair: true,
            averageCost: 800
        ),
        WarningSign(
            name: "DPF Warning Light",
            image: "",
            description: "Indicates a blockage in the Diesel Particulate Filter (DPF), which can lead to reduced engine performance.",
            solution: "Perform a forced regeneration or replace the DPF if clogged.",
            isComplexRepair: true,
            averageCost: 1000
        ),
        WarningSign(
            name: "EGR Valve Failure",
            image: "",
            description: "Indicates a problem with the Exhaust Gas Recirculation (EGR) valve, leading to poor emissions and engine efficiency.",
            solution: "Clean or replace the EGR valve as needed.",
            isComplexRepair: true,
            averageCost: 400
        ),
        WarningSign(
            name: "Fuel Injector Failure",
            image: "",
            description: "Indicates a clogged or malfunctioning fuel injector, which can lead to poor fuel economy and engine misfires.",
            solution: "Clean or replace the faulty fuel injector.",
            isComplexRepair: true,
            averageCost: 500
        ),

        WarningSign(
            name: "Exhaust System Warning",
            image: "",
            description: "Indicates an issue with the exhaust system, such as a catalytic converter failure or an exhaust leak.",
            solution: "Inspect the exhaust system and replace damaged parts as needed.",
            isComplexRepair: true,
           averageCost: 600
        ),

        WarningSign(
            name: "Powertrain Malfunction Light",
            image: "",
            description: "Indicates a fault in the transmission, drivetrain, or related components.",
            solution: "Diagnose with a scanner; repairs may involve transmission fluid changes, sensor replacements, or full transmission repair.",
            isComplexRepair: true,
            averageCost: 1000
        ),

        WarningSign(
            name: "Differential Warning Light",
            image: "",
            description: "Indicates an issue with the differential, which can affect vehicle handling and power distribution.",
            solution: "Inspect the differential for fluid leaks or gear damage; may require fluid replacement or full differential repair.",
            isComplexRepair: true,
            averageCost: 800
        ),

        WarningSign(
            name: "Start/Stop System Failure",
            image: "",
            description: "Indicates a malfunction in the automatic start/stop system, which can affect fuel efficiency.",
            solution: "Check the battery, alternator, and system sensors; may require a system reset or component replacement.",
            isComplexRepair: true,
            averageCost: 300
        ),

        WarningSign(
            name: "Clutch System Warning Light",
            image: "",
            description: "Indicates a problem with the clutch system, such as low hydraulic fluid or worn clutch plates.",
            solution: "Check hydraulic fluid levels and inspect clutch components; may require clutch replacement.",
            isComplexRepair: true,
            averageCost: 900
        ),

        WarningSign(
            name: "Electric Parking Brake Failure",
            image: "",
            description: "Indicates a malfunction in the electronic parking brake system, which may prevent it from engaging or disengaging.",
            solution: "Inspect wiring and sensors; may require recalibration or replacement of the brake actuator.",
            isComplexRepair: true,
            averageCost: 450
        ),

        WarningSign(
            name: "Immobilizer System Warning",
            image: "",
            description: "Indicates a fault in the vehicle’s anti-theft system, which may prevent the engine from starting.",
            solution: "Check the key fob battery and immobilizer system; may require reprogramming or sensor replacement.",
            isComplexRepair: true,
            averageCost: 350
        ),

        WarningSign(
            name: "Lane Departure Warning System Failure",
            image: "",
            description: "Indicates an issue with the lane departure warning or lane-keeping assist system.",
            solution: "Check sensors and cameras for obstructions; may require recalibration or replacement.",
            isComplexRepair: true,
            averageCost: 500
        ),

        WarningSign(
            name: "Adaptive Cruise Control Failure",
            image: "",
            description: "Indicates a malfunction in the adaptive cruise control system, affecting speed and braking automation.",
            solution: "Inspect radar and camera sensors; may require a reset or sensor replacement.",
            isComplexRepair: true,
            averageCost: 600
        ),

        WarningSign(
            name: "Suspension System Warning",
            image: "",
            description: "Indicates an issue with the air suspension or adaptive dampers, leading to poor ride quality.",
            solution: "Check for air leaks, sensor faults, or worn suspension components; may require shock or strut replacement.",
            isComplexRepair: true,
            averageCost: 1200
        ),

        WarningSign(
            name: "Headlight Leveling System Failure",
            image: "",
            description: "Indicates a problem with the automatic headlight leveling system, which may affect nighttime visibility.",
            solution: "Inspect headlight sensors and motors; may require recalibration or replacement.",
            isComplexRepair: true,
            averageCost: 350
        ),

        WarningSign(
            name: "Hybrid System Warning",
            image: "",
            description: "Indicates an issue with the hybrid battery or electric motor system, which may reduce performance.",
            solution: "Check battery health and electrical connections; may require battery replacement or software updates.",
            isComplexRepair: true,
            averageCost: 3000
        ),
        WarningSign(
            name: "Fuel System Error",
            image: "",
            description: "Indicates an issue with the fuel system, such as a malfunctioning fuel pump or faulty fuel filter.",
            solution: "Check fuel pressure and inspect the fuel system for leaks or blockages; may require part replacement.",
            isComplexRepair: true,
            averageCost: 500
        ),

        WarningSign(
            name: "Power Steering Fluid Low",
            image: "",
            description: "Indicates low power steering fluid levels, leading to difficulty steering.",
            solution: "Check and top up power steering fluid; inspect for leaks in the power steering system.",
            isComplexRepair: false,
            averageCost: 100
        ),

        WarningSign(
            name: "Parking Brake Warning Light",
            image: "",
            description: "Indicates the parking brake is engaged while the vehicle is in motion or a fault in the parking brake system.",
            solution: "Disengage the parking brake and ensure it is properly functioning.",
            isComplexRepair: true,
            averageCost: 200
        ),

        WarningSign(
            name: "Engine Oil Change Warning",
            image: "",
            description: "Indicates the need for an engine oil change based on the vehicle's service schedule.",
            solution: "Schedule an oil change with the recommended oil type and filter replacement.",
            isComplexRepair: false,
            averageCost: 50
        ),

        WarningSign(
            name: "Cooling Fan Failure",
            image: "",
            description: "Indicates that the cooling fan is not working, which can cause the engine to overheat.",
            solution: "Check for faulty fan motor or sensor; may require fan motor replacement.",
            isComplexRepair: true,
            averageCost: 400
        ),

        WarningSign(
            name: "Hood Open Warning",
            image: "",
            description: "Indicates that the hood is not properly closed, which may cause the engine to overheat or affect vehicle safety.",
            solution: "Ensure the hood is securely latched.",
            isComplexRepair: false,
            averageCost: 0
        ),

        WarningSign(
            name: "Windshield Washer Fluid Warning",
            image: "",
            description: "Indicates low windshield washer fluid levels.",
            solution: "Top up the windshield washer fluid reservoir.",
            isComplexRepair: false,
            averageCost: 10
        ),

        WarningSign(
            name: "Clutch Fluid Warning",
            image: "",
            description: "Indicates low clutch fluid, which can affect shifting in manual transmission vehicles.",
            solution: "Check and refill clutch fluid; inspect for leaks in the clutch hydraulic system.",
            isComplexRepair: true,
            averageCost: 200
        ),

        WarningSign(
            name: "Engine Misfire Warning",
            image: "",
            description: "Indicates that one or more cylinders in the engine are misfiring, which can affect engine performance and fuel economy.",
            solution: "Check spark plugs, ignition coils, and fuel injectors; may require replacing faulty components.",
            isComplexRepair: true,
            averageCost: 400
        ),

        WarningSign(
            name: "Fuel Pressure Warning",
            image: "",
            description: "Indicates an issue with the fuel pressure regulator, which can affect engine performance and fuel delivery.",
            solution: "Check fuel pressure and inspect the fuel system for leaks or damage.",
            isComplexRepair: true,
            averageCost: 300
        )
    ]
    
    var filteredSigns: [WarningSign] {
        if searchText.isEmpty {
            return signs
        }
        return signs.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
}

// Main View
struct ContentView: View {
    @StateObject private var viewModel = WarningSignsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.dashAlertBlack
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    SearchBar(text: $viewModel.searchText)
                        .padding(.top)
                    
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(viewModel.filteredSigns) { sign in
                                NavigationLink(destination: DetailView(sign: sign)) {
                                    SignRowView(sign: sign)
                                }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationBarTitle("Dashboard Signs", displayMode: .large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.dashAlertBlack, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

// Search Bar Component
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.dashAlertGreen)
            
            TextField("Search", text: $text)
                .textFieldStyle(.plain)
                .foregroundColor(.white)
                .accentColor(.dashAlertGreen)
        }
        .padding()
        .background(Color.dashAlertDarkGray)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

// List Row Component
struct SignRowView: View {
    let sign: WarningSign
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: sign.image)
                .foregroundColor(.dashAlertRed)
                .font(.title2)
                .frame(width: 40, height: 40)
                .background(Color.dashAlertBlack)
                .clipShape(Circle())
            
            Text(sign.name)
                .font(.body)
                .foregroundColor(.white)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.dashAlertGreen)
                .font(.caption)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.dashAlertDarkGray)
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
}

// Detail View
struct DetailView: View {
    let sign: WarningSign
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                HStack(spacing: 20) {
                    Image(systemName: sign.image)
                        .font(.system(size: 60))
                        .foregroundColor(.dashAlertRed)
                        .frame(width: 120, height: 120)
                        .background(Color.dashAlertGray)
                        .clipShape(Circle())
                    VStack(alignment: .leading, spacing: 8) {
                        Text(sign.name)
                            .font(.title)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        
                        if sign.isComplexRepair {
                            Text("Complex Repair")
                                .font(.subheadline)
                                .foregroundColor(.dashAlertGreen)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.dashAlertGreen.opacity(0.2))
                                .cornerRadius(12)
                        }
                    }
                }
                .padding(.horizontal)
                
                // Content sections
                Group {
                    InfoSection(title: "Description", content: sign.description)
                    InfoSection(title: "Solution", content: sign.solution)
                    
                    if sign.isComplexRepair, let cost = sign.averageCost {
                        InfoSection(
                            title: "Average Repair Cost",
                            content: String(format: "$%.2f", cost)
                        )
                    }
                }
            }
            .padding(.vertical)
        }
        .background(Color.dashAlertBlack)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Helper view for detail sections
struct InfoSection: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundColor(.dashAlertGreen)
            
            Text(content)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.dashAlertGray)
                .cornerRadius(12)
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
