import SwiftUI
import EventKit


// Main View
struct ContentView: View {
    @State private var isCalender = false
    @State private var isDashboardView = false
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        //Switch Between Views
        ZStack {
            if isCalender {
                CalenderView()
            } else if isDashboardView {
                DashboardView()
            } else {
                HomeView()
            }
            //Theme Switch Button
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        //FlipFlop Between Values
                        themeManager.isDarkMode.toggle()
                    }) {
                        if themeManager.isDarkMode == true {
                            Image(systemName: "moon")
                                .font(.title)
                                .padding(.vertical, 3)
                                .padding(.horizontal, 6)
                                .background(Color.dashAlertGreen)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }else {
                            Image(systemName: "sun.max.fill")
                                .font(.title)
                                .padding(.vertical, 3)
                                .padding(.horizontal, 6)
                                .background(Color.dashAlertGreen)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.top, 10)
                .padding(.trailing, 10)

                Spacer()
                //Bottom Bar
                HStack {
                    Spacer()
                    //DashBoard View
                    Button(action: {
                        isCalender = false
                        isDashboardView = true
                    }) {
                        Image(systemName: "brakesignal")
                            .font(.title)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.dashAlertGreen)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(maxHeight: 20, alignment: .top)
                    }
                    //Home View
                    Button(action: {
                        isCalender = false
                        isDashboardView = false
                    }) {
                        Image(systemName: "house.fill")
                            .font(.title)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.dashAlertGreen)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(maxHeight: 20, alignment: .top)
                    }
                    //Calender View
                    Button(action: {
                        isCalender = true
                        isDashboardView = false
                    }) {
                        Image(systemName: "calendar.badge.checkmark")
                            .font(.title)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.dashAlertGreen)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(maxHeight: 20, alignment: .top)
                    }

                    Spacer()
                }
                .padding(.bottom, 1)
                .background(Color.dashAlertDarkGray)
                .shadow(radius: 2)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
    }
}

//Home View
struct HomeView: View {
    var body: some View {
        Text("Home View")
    }
}
