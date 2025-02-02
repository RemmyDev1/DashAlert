import SwiftUI


struct Emergency: Identifiable {
    let id = UUID()
    let name: String
    let shortDescription: String
    let detailText: String
}

class EmergencyViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var emergencies: [Emergency] = [
        Emergency(name: "Car Accident",
                  shortDescription: "Steps to take if you're in a car accident",
                  detailText: "1. Call emergency services.\n2. Check for injuries.\n3. Document the scene."),
        Emergency(name: "Flat Tire",
                  shortDescription: "How to change a flat tire",
                  detailText: "1. Find a safe location.\n2. Use your spare tire.\n3. Call roadside assistance if needed.")
    ]
    
    var filteredEmergencies: [Emergency] {
        if searchText.isEmpty {
            return emergencies
        }
        return emergencies.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
}


struct EmergencyGuideView: View {
    @StateObject private var viewModel = EmergencyViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(viewModel.filteredEmergencies) { emergency in
                                NavigationLink(destination: EmergencyDetailView(emergency: emergency)) {
                                    EmergencyCardView(emergency: emergency)
                                }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    
                    Spacer()
                    
                    SearchBar2(text: $viewModel.searchText)
                        .padding(.bottom)
                }
            }
            .navigationBarTitle("Emergency Guide", displayMode: .large)
        }
    }
}

struct EmergencyCardView: View {
    let emergency: Emergency
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.green)
            
            Text(emergency.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 8)
            
            Text(emergency.shortDescription)
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.top, 4)
                .padding(.horizontal, 10)
            
            Spacer()
        }
        .padding()
        .background(Color.gray)
        .cornerRadius(12)
        .frame(maxWidth: .infinity)
    }
}

struct EmergencyDetailView: View {
    let emergency: Emergency
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text(emergency.name)
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.top)
                
                Text(emergency.detailText)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color.black)
        .navigationBarTitle(emergency.name, displayMode: .inline)
    }
}

struct SearchBar2: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.green)
            
            TextField("Search", text: $text)
                .foregroundColor(.white)
                .accentColor(.green)
        }
        .padding()
        .background(Color(white: 0.2))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct EmergencyView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyGuideView()
            .preferredColorScheme(.dark)
    }
}
