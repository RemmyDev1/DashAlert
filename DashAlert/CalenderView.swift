import SwiftUI
import EventKit

struct CalenderView: View {
    @State private var title: String = ""
    @State private var dueDate: Date = Date()
    @State private var notes: String = ""
    @State private var priority: String = "Medium"
    
    let priorities = ["Low", "Medium", "High"]
    
    @State private var eventStore: EKEventStore = EKEventStore()
    @State private var hasAccessToReminders = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @EnvironmentObject var themeManager: ThemeManager
    
    
    var body: some View {
        // Main UI for the Calender View With Text Fields for User Input.
        ZStack {
            Color.dashAlertBlack
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        HStack(spacing: 20) {
                            Text("Create Reminder")
                                .font(.title)
                                .foregroundColor(Color.dashAlertWhite)
                                .fontWeight(.bold)
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Title:")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            TextField("Title", text: $title)
                                .textFieldStyle(.plain)
                                .foregroundColor(Color.dashAlertWhite)
                                .accentColor(.dashAlertGreen)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.dashAlertBlack)
                                .cornerRadius(12)
                            
                            Text("Due Date:")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            DatePicker("Due Date", selection: $dueDate)
                                .padding()		
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.dashAlertBlack)
                                .cornerRadius(12)
                            
                            Text("Priority:")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Picker("Priority", selection: $priority) {
                                ForEach(priorities, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.segmented)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.dashAlertBlack)
                            .cornerRadius(12)
                            
                            Text("Notes:")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            TextField("Notes", text: $notes)
                                .textFieldStyle(.plain)
                                .foregroundColor(Color.dashAlertWhite    )
                                .accentColor(.dashAlertGreen)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.dashAlertBlack)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.dashAlertDarkGray)
                        )
                        
                        Button("Create Reminder") {
                            if hasAccessToReminders {
                                createReminder()
                            } else {
                                requestAccessToReminders()
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color.dashAlertGreen)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            checkAccessToReminders()
        }
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Reminder Created"), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                title = ""
                notes = ""
                dueDate = Date()
                priority = "Medium"
            })
            
        }
    }
    // Makes Sure that the application has authorization to the reminders app.
    func checkAccessToReminders() {
        let status = EKEventStore.authorizationStatus(for: .reminder)
        switch status {
        case .authorized:
            hasAccessToReminders = true
        case .notDetermined:
            hasAccessToReminders = false
        case .restricted, .denied:
            hasAccessToReminders = false
        @unknown default:
            hasAccessToReminders = false
        }
    }
    /*
     Asks for Permission For reminder So the app can create Reminders.
     */
    func requestAccessToReminders() {
        eventStore.requestAccess(to: .reminder) { (granted, error) in
            if let error = error {
                print(error)
                return
            }
            if granted {
                checkAccessToReminders()
            }
        }
    }
    
    /*
     This function Creates a reminder by checking if you have access to your calender for correct Date and time.
     This Function Will not be able to Run unless you have acces to Reminders and The Calender
     */
    func createReminder() {
        if let calendar = eventStore.defaultCalendarForNewReminders() {
            let reminder = EKReminder(eventStore: eventStore)
            reminder.title = title
            reminder.dueDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
            reminder.notes = notes
            let alarm = EKAlarm(absoluteDate: dueDate)
            reminder.addAlarm(alarm)
            
            // Convert priority string to Int
            var priorityValue: Int = 0
            switch priority {
            case "Low":
                priorityValue = 0
            case "Medium":
                priorityValue = 1
            case "High":
                priorityValue = 2
            default:
                priorityValue = 1
            }
            reminder.priority = priorityValue
            
            reminder.calendar = calendar
            
            do {
                try eventStore.save(reminder, commit: true)
                alertMessage = "Your reminder has been created successfully."
                showAlert = true
            } catch {
                print("Error creating reminder: \(error)")
                alertMessage = "Failed to create reminder."
                showAlert = true
            }
        } else {
            print("No default calendar available")
        }
    }
}
