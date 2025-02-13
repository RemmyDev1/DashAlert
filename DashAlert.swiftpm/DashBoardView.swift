import SwiftUI
import EventKit

// The causes of each Warning Sign
struct Cause: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let description: String
    let solution: String
    let isComplexRepair: Bool
    let continueDriving: String
    let averageCost: Double?
}

// warning signs in the dashboard a struct to keep all of them
struct WarningSign: Identifiable, Hashable {
    let id = UUID()			
    let name: String
    let image: String
    let causes: [Cause]
}

// an observable object that stores all the signs and filters the signs using a function to search through them using a function
class WarningSignsViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var signs = [
        WarningSign(
            name: "Check Engine Light",
            image: "EngineCheck",
            causes: [
                Cause(
                    name: "Engine Misfire Warning",
                    description: "Indicates that one or more cylinders in the engine are misfiring, which can affect engine performance and fuel economy.",
                    solution: "Check spark plugs, ignition coils, and fuel injectors; may require replacing faulty components.",
                    isComplexRepair: true,
                    continueDriving: "No, do not continue driving. Misfires can cause further damage to the engine.",
                    averageCost: 400

                ),
                Cause(
                    name: "Issue with the engine or emissions system",
                    description: "Indicates an issue with the engine or emissions system. Common causes include loose gas cap, faulty oxygen sensor, or catalytic converter issues.",
                    solution: "First, check if the gas cap is loose and tighten it. If the light persists after driving for a while, professional diagnosis is needed.",
                    isComplexRepair: true,
                    continueDriving: "Yes, but only to a nearby repair shop. Avoid long trips.",
                    averageCost: 350

                ),
                Cause(
                    name: "ECU Failure",
                    description: "Indicates a malfunction in the Engine Control Unit (ECU), which can affect engine performance and drivability.",
                    solution: "Diagnose with an OBD-II scanner; may require reprogramming or replacing the ECU.",
                    isComplexRepair: true,
                    continueDriving: "No, do not continue driving. ECU failure can cause unpredictable behavior.",
                    averageCost: 800
                )
            ]
        ),
        WarningSign(
            name: "Low Oil Pressure",
            image: "LowOilPressure",
            causes: [
                Cause(
                    name: "Low Oil Pressure",
                    description: "Indicates dangerous low oil pressure which can cause severe engine damage.",
                    solution: "Immediately pull over safely and turn off the engine. Check oil level when engine is cool.",
                    isComplexRepair: false,
                    continueDriving: "No, do not continue driving. Low oil pressure can cause engine failure.",
                    averageCost: nil
                )
            ]
        ),
        WarningSign(
            name: "Battery Warning",
            image: "BatteryWarning",
            causes: [
                Cause(
                    name: "Battery Warning",
                    description: "Indicates charging system problem or failing battery.",
                    solution: "Check battery terminals for corrosion and ensure they're tight. If persists, battery or alternator may need replacement.",
                    isComplexRepair: true,
                    continueDriving: "Yes, but only to a nearby repair shop. Avoid long trips.",
                    averageCost: 600
                )
            ]
        ),
        WarningSign(	
            name: "Coolant Temperature Warning",
            image: "CoolantTemperatureWarning",
            causes: [
                Cause(
                    name: "Coolant Temperature Warning",
                    description: "Warns of an overheating engine due to low coolant or a failing cooling system.",
                    solution: "Refill coolant, check for leaks, and inspect radiator, water pump, and thermostat.",
                    isComplexRepair: true,
                    continueDriving: "No, do not continue driving. Overheating can cause engine damage.",
                    averageCost: 500
                )
            ]
        ),
        WarningSign(
            name: "Brake System Warning Light",
            image: "BrakeSystemWarningLight",
            causes: [
                Cause(
                    name: "Brake System Warning Light",
                    description: "Indicates low brake fluid or an issue with the braking system.",
                    solution: "Check brake fluid levels and brake pads; may require bleeding the brake system or replacing components.",
                    isComplexRepair: true,
                    continueDriving: "No, do not continue driving. Brake failure can cause accidents.",
                    averageCost: 300
                )
            ]
        ),
        WarningSign(
            name: "ABS Warning Light",
            image: "ABSWarningLight",
            causes: [
                Cause(
                    name: "ABS Warning Light",
                    description: "Indicates a problem with the Anti-lock Braking System (ABS).",
                    solution: "Diagnose with a scanner; repair may involve replacing ABS sensors or the control module.",
                    isComplexRepair: true,
                    continueDriving: "Yes, but exercise caution. ABS failure can affect braking performance.",
                    averageCost: 400
                )
            ]
        ),
        WarningSign(
            name: "Tire Pressure Warning Light (TPMS)",
            image: "TirePressureWarningLight",
            causes: [
                Cause(
                    name: "Tire Pressure Warning Light (TPMS)",
                    description: "Signals low tire pressure in one or more tires.",
                    solution: "Check and inflate tires to the recommended pressure; replace faulty TPMS sensors if needed.",
                    isComplexRepair: false,
                    continueDriving: "Yes, but check tire pressure as soon as possible.",
                    averageCost: 50
                )
            ]
        ),
        WarningSign(
            name: "Airbag Warning Light",
            image: "AirbagWarningLight",
            causes: [
                Cause(
                    name: "Airbag Warning Light",
                    description: "Indicates a fault in the airbag system, which may prevent deployment in an accident.",
                    solution: "Diagnose with a scanner; may require replacing airbag sensors or control module.",
                    isComplexRepair: true,
                    continueDriving: "Yes, but get serviced as soon as possible. Airbags may not deploy in an accident.",
                    averageCost: 400
                )
            ]
        ),
        WarningSign(
            name: "Power Steering Warning Light",
            image: "PowerSteeringWarningLight",
            causes: [
                Cause(
                    name: "Power Steering Warning Light",
                    description: "Indicates a failure in the power steering system, making steering harder.",
                    solution: "Check power steering fluid levels and inspect the system for leaks or electronic faults.",
                    isComplexRepair: true,
                    continueDriving: "Yes, but exercise caution. Power steering failure can affect steering performance.",
                    averageCost: 650
                )
            ]
        ),
        WarningSign(
            name: "Transmission Temperature Warning Light",
            image: "TransmissionTemperatureWarningLight",
            causes: [
                Cause(
                    name: "Transmission Temperature Warning Light",
                    description: "Indicates that the transmission is overheating.",
                    solution: "Check transmission fluid level and condition; may require replacing the fluid or repairing the cooling system.",
                    isComplexRepair: true,
                    continueDriving: "No, do not continue driving. Transmission overheating can cause damage.",
                    averageCost: 400
                )
            ]
        ),
        WarningSign(
            name: "Fuel Cap Warning Light",
            image: "FuelCapWarningLight",
            causes: [
                Cause(
                    name: "Fuel Cap Warning Light",
                    description: "Indicates a loose or missing fuel cap, which can affect emissions.",
                    solution: "Tighten or replace the fuel cap.",
                    isComplexRepair: false,
                    continueDriving: "Yes, but check the fuel cap as soon as possible.",
                    averageCost: 20
                )
            ]
        ),
        WarningSign(
            name: "Glow Plug Indicator (Diesel Vehicles)",
            image: "GlowPlugIndicator",
            causes: [
                Cause(
                    name: "Glow Plug Indicator (Diesel Vehicles)",
                    description: "Indicates an issue with the glow plugs or preheating system.",
                    solution: "Check and replace faulty glow plugs.",
                    isComplexRepair: true,
                    continueDriving: "Yes, but only to a nearby repair shop. Avoid long trips.",
                    averageCost: 250
                )
            ]
        ),
        WarningSign(
            name: "Traction Control Warning Light",
            image: "TractionControlWarningLight",
            causes: [
                Cause(
                    name: "Traction Control Warning Light",
                    description: "Indicates an issue with the traction control system.",
                    solution: "Check wheel speed sensors and ABS module; may require resetting or replacing sensors.",
                    isComplexRepair: true,
                    continueDriving: "Yes, but exercise caution. Traction control failure can affect vehicle stability.",
                    averageCost: 300
                )
            ]
        ),
        WarningSign(
            name: "Engine Temperature Warning Light",
            image: "EngineTemperatureWarningLight",
            causes: [
                Cause(
                    name: "Engine Temperature Warning Light",
                    description: "Signals an overheating engine.",
                    solution: "Turn off the engine, let it cool, and check coolant levels; inspect the radiator and thermostat.",
                    isComplexRepair: true,
                    continueDriving: "No, do not continue driving. Overheating can cause engine damage.",
                    averageCost: 350
                )
            ]
        ),
        WarningSign(
            name: "Seat Belt Sensor Error",
            image: "SeatBeltSensorError",
            causes: [
                Cause(
                    name: "Seat Belt Sensor Error",
                    description: "Indicates a malfunctioning seat belt sensor, which may prevent proper detection of a fastened seatbelt.",
                    solution: "Check the seat belt sensor wiring and connections; replace the sensor if faulty.",
                    isComplexRepair: true,
                    continueDriving: "Yes, safe to drive. Get serviced soon to prevent potential starting issues. Seat belt failure can cause injury.",
                    averageCost: 150
                )
            ]
        ),
        WarningSign(
            name: "DPF Warning Light",
            image: "DPFWarningLight",
            causes: [
                Cause(
                    name: "DPF Warning Light",
                    description: "Indicates a blockage in the Diesel Particulate Filter (DPF), which can lead to reduced engine performance.",
                    solution: "Perform a forced regeneration or replace the DPF if clogged.",
                    isComplexRepair: true,
                    continueDriving: "Yes, but only to a nearby repair shop. Avoid long trips.",
                    averageCost: 1000
                )
            ]
        ),
        WarningSign(
            name: "Exhaust System Warning",
            image: "ExhaustSystemWarning",
            causes: [
                Cause(
                    name: "Exhaust System Warning",
                    description: "This failure is usually represented by the 'Check Engine Light' or 'Exhaust System Light'. It indicates an issue with the exhaust system, such as a catalytic converter failure or an exhaust leak.",
                    solution: "Inspect the exhaust system and replace damaged parts as needed.",
                    isComplexRepair: true,
                    continueDriving: "Yes, but only to a nearby repair shop. Avoid long trips.",
                    averageCost: 600
                )
            ]
        ),
        WarningSign(
            name: "Powertrain Malfunction Light",
            image: "PowertrainMalfunctionLight",
            causes: [
                Cause(
                    name: "Powertrain Malfunction Light",
                    description: "This failure is usually represented by the 'Powertrain Malfunction Light'. It indicates a fault in the transmission, drivetrain, or related components.",
                    solution: "Diagnose with a scanner; repairs may involve transmission fluid changes, sensor replacements, or full transmission repair.",
                    isComplexRepair: true,
                    continueDriving: "No, do not continue driving. Powertrain failure can cause unpredictable behavior.",
                    averageCost: 1000
                )
            ]
        ),
        WarningSign(
            name: "Differential Warning Light",
            image: "DifferentialWarningLight",
            causes: [
                Cause(
                    name: "Differential Warning Light",
                    description: "This failure is usually represented by the 'Differential Warning Light'. It indicates an issue with the differential, which can affect vehicle handling and power distribution.",
                    solution: "Inspect the differential for fluid leaks or gear damage; may require fluid replacement or full differential repair.",
                    isComplexRepair: true,
                    continueDriving: "Yes, but only to a nearby repair shop. Avoid long trips.",
                    averageCost: 800
                )
            ]
        ),
        WarningSign(
            name: "Start/Stop System Failure",
            image: "StartStopSystemFailure",
            causes: [
                Cause(
                    name: "Start/Stop System Failure",
                    description: "This failure is usually represented by the 'Auto Start/Stop Warning Light'. It indicates a malfunction in the automatic start/stop system, which can affect fuel efficiency.",
                    solution: "Check the battery, alternator, and system sensors; may require a system reset or component replacement.",
                    isComplexRepair: true,
                    continueDriving: "Yes, but only to a nearby repair shop. Avoid long trips.",
                    averageCost: 250
                )
            ]
        ),
        WarningSign(
            name: "Clutch System Warning Light",
            image: "ClutchSystemWarningLight",
            causes: [
                Cause(
                    name: "Clutch System Warning Light",
                    description: "This failure is usually represented by the 'Clutch Warning Light'. It indicates a problem with the clutch system, such as low hydraulic fluid or worn clutch plates.",
                    solution: "Check hydraulic fluid levels and inspect clutch components; may require clutch replacement.",
                    isComplexRepair: true,
                    continueDriving: "No, do not continue driving. Clutch failure can cause loss of control.",
                    averageCost: 1400
                )
            ]
        ),
        WarningSign(
            name: "Electric Parking Brake Failure",
            image: "ElectricParkingBrakeFailure",
            causes: [
                Cause(
                    name: "Electric Parking Brake Failure",
                    description: "This failure is usually represented by the 'Parking Brake Warning Light'. It indicates a malfunction in the electronic parking brake system, which may prevent it from engaging or disengaging.",
                    solution: "Inspect wiring and sensors; may require recalibration or replacement of the brake actuator.",
                    isComplexRepair: true,
                    continueDriving: "Yes, safe to drive. Get serviced soon to prevent potential starting issues.",
                    averageCost: 450
                )
            ]
        ),
        WarningSign(
            name: "Immobilizer System Warning",
            image: "ImmobilizerSystemWarning",
            causes: [
                Cause(
                    name: "Immobilizer System Warning",
                    description: "This failure is usually represented by the 'Immobilizer Warning Light'. It indicates a fault in the vehicle’s anti-theft system, which may prevent the engine from starting.",
                    solution: "Check the key fob battery and immobilizer system; may require reprogramming or sensor replacement.",
                    isComplexRepair: true,
                    continueDriving: "Yes, safe to drive. Get serviced soon to prevent potential starting issues.",
                    averageCost: 350
                )
            ]
        ),
        WarningSign(
            name: "Lane Departure Warning System Failure",
            image: "LaneDepartureWarningSystemFailure",
            causes: [
                Cause(
                    name: "Lane Departure Warning System Failure",
                    description: "This failure is usually represented by the 'Lane Departure Warning Light'. It indicates an issue with the lane departure warning or lane-keeping assist system.",
                    solution: "Check sensors and cameras for obstructions; may require recalibration or replacement.",
                    isComplexRepair: true,
                    continueDriving: "Yes, but exercise caution. Lane departure failure can cause accidents.",
                    averageCost: 500
                )
            ]
        ),
        WarningSign(
            name: "Adaptive Cruise Control Failure",
            image: "AdaptiveCruiseControlFailure",
            causes: [
                Cause(
                    name: "Adaptive Cruise Control Failure",
                    description: "This failure is usually represented by the 'Cruise Control Warning Light'. It indicates a malfunction in the adaptive cruise control system, affecting speed and braking automation.",
                    solution: "Inspect radar and camera sensors; may require a reset or sensor replacement.",
                    isComplexRepair: true,
                    continueDriving: "Yes, but exercise caution. Adaptive cruise control failure can cause accidents.",
                    averageCost: 600
                )
            ]
        ),
        WarningSign(
            name: "Suspension System Warning",
            image: "SuspensionSystemWarning",
            causes: [
                Cause(
                    name: "Suspension System Warning",
                    description: "This failure is usually represented by the 'Suspension Warning Light'. It indicates an issue with the air suspension or adaptive dampers, leading to poor ride quality.",
                    solution: "Check for air leaks, sensor faults, or worn suspension components; may require shock or strut replacement.",
                    isComplexRepair: true,
                    continueDriving: "Yes, but exercise caution. Suspension failure can cause accidents.",
                    averageCost: 1200
                )
            ]
        ),
        WarningSign(
            name: "Hybrid System Warning",
            image: "HybridSystemWarning",
            causes: [
                Cause(
                    name: "Hybrid System Warning",
                    description: "This failure is usually represented by the 'Hybrid System Warning Light'. It indicates a fault in the hybrid powertrain, such as battery or inverter issues.",
                    solution: "Check the hybrid battery and power control module; may require battery replacement or system reset.",
                    isComplexRepair: true,
                    continueDriving: "No, do not continue driving. Hybrid system failure can cause unpredictable behavior.",
                    averageCost: 2000
                )
            ]
        )
        
    ]
    
    var filteredSigns: [WarningSign] {
        if searchText.isEmpty {
            return signs
        }
        return signs.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
}

// Helper view for detail sections
struct InfoSection: View {
    @EnvironmentObject var themeManager: ThemeManager
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundColor(.dashAlertGreen)
            
            Text(content)
                .foregroundColor(Color.dashAlertWhite)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.dashAlertGray)
                .cornerRadius(12)
        }
        .padding(.horizontal)
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
    }
}
// GroupDetailView is for when multiple causes have the same sign It controls the multiple causes and displays them in a neat orderly manor.
struct GroupedDetailView: View {
    let sign: WarningSign
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                HStack(spacing: 20) {
                    Image(sign.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .background(Color.black)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    VStack(alignment: .leading, spacing: 8) {
                        Text(sign.name)
                            .font(.title)
                            .foregroundColor(Color.dashAlertWhite)
                            .fontWeight(.bold)
                    }
                }
                .padding(.horizontal)
                
                // Content sections
                ForEach(sign.causes, id: \.self) { cause in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(cause.name)
                            .font(.headline)
                            .foregroundColor(.dashAlertRed)
                            .fontWeight(.bold)
                
                        Text("Description:")
                            .font(.subheadline)
                            .foregroundColor(Color.dashAlertWhite)
                        Text(cause.description)
                            .foregroundColor(Color.dashAlertWhite)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.dashAlertGray)
                            .cornerRadius(12)
                        
                        Text("Solution:")
                            .font(.subheadline)
                            .foregroundColor(Color.dashAlertWhite)
                        Text(cause.solution)
                            .foregroundColor(Color.dashAlertWhite)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.dashAlertGray)
                            .cornerRadius(12)
                        Text("Can You Keep Driving:")
                            .font(.subheadline)
                            .foregroundColor(Color.dashAlertWhite)
                        Text(cause.continueDriving)
                            .foregroundColor(Color.dashAlertWhite)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.dashAlertGray)
                            .cornerRadius(12)
                        
                        if cause.isComplexRepair, let cost = cause.averageCost {
                            Text("Average Repair Cost:")
                                .font(.subheadline)
                                .foregroundColor(Color.dashAlertWhite)
                            Text(String(format: "$%.2f", cost))
                                .foregroundColor(Color.dashAlertWhite)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.dashAlertGray)
                                .cornerRadius(12)
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.dashAlertDarkGray)
                    )
                }
            }
            .padding(.vertical)
        }
        .background(Color.dashAlertBlack)
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
    }
    
}


// SignRowView SetsUp the signs in a nice and neat structure for people to look at.
struct SignRowView: View {
    let sign: WarningSign
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        HStack(spacing: 16) {
            Image(sign.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .background(Color.black)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.dashAlertDarkGray)
        )
        .padding(.vertical, 4)
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
    }
}
// Main DashBoardView
struct DashboardView: View {
    @StateObject private var viewModel = WarningSignsViewModel()
    @EnvironmentObject var themeManager: ThemeManager
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.dashAlertBlack
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(viewModel.filteredSigns) { sign in
                                NavigationLink(destination: GroupedDetailView(sign: sign)) {
                                    SignRowView(sign: sign)
                                }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    	
                    Spacer()
                    SearchBar(text: $viewModel.searchText)
                        .padding(.bottom)
                }
            }
            .navigationBarTitle("Dashboard Signs", displayMode: .large)
            .toolbarColorScheme(themeManager.isDarkMode ? .dark : .light, for: .navigationBar)
            .toolbarBackground(themeManager.isDarkMode ? Color.black : Color.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
        }
    }
}

// Search Bar Component
struct SearchBar: View {
    @Binding var text: String
    @EnvironmentObject var themeManager: ThemeManager
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
        .padding(.bottom)
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
    }
}
	
