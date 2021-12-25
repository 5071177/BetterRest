//
//  ContentView.swift
//  BetterRest
//
//  Created by Yury Prokhorov on 14.12.2021.
//

import CoreML
import SwiftUI

struct ContentView: View {

    
//    func calculateBedTime() {
//        do {
//            let config = MLModelConfiguration()
//            let model = try SleepCalculator(configuration: config)
//
//            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
//            let hour = (components.hour ?? 0) * 60 * 60
//            let minute = (components.minute ?? 0) * 60
//
//            let prediction = try model.prediction(wake: Double(hour+minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
//
//            let sleepTime = wakeUp - prediction.actualSleep
//
//            alertTitle = "Your ideal bedtime is..."
//            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
//        } catch {
//            alertTitle = "Error"
//            alertMessage = "Sorry, there was a problem calculating your bedtime"
//        }
//        showingAlert = true
//
//    }
    
    
    var sleepResult: String {
        do {
                    let config = MLModelConfiguration()
                    let model = try SleepCalculator(configuration: config)
        
                    let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
                    let hour = (components.hour ?? 0) * 60 * 60
                    let minute = (components.minute ?? 0) * 60
        
                    let prediction = try model.prediction(wake: Double(hour+minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
        
                    let sleepTime = wakeUp - prediction.actualSleep
        
            return "Your ideal bedtime is " + sleepTime.formatted(date: .omitted, time: .shortened)
                } catch {
                    return "There was an error"
                }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents ()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
//    @State private var alertTitle = ""
//    @State private var alertMessage = ""
//    @State private var showingAlert = false
    
    
    
    
    
    
//    func exampleDates() {
//        // create a second Date instance set to one day in seconds from now
//        let tomorrow = Date.now.addingTimeInterval(86400)
//
//        // create a range from those two
//        let range = Date.now...tomorrow
//    }
//
    
    
    var body: some View {
        
        
        NavigationView {
            Form {
                Section("When do you want to wake up?") {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }

                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }

                Section("Daily coffee intake") {
                    Picker("Number of cups", selection: $coffeeAmount){
                        ForEach(1..<21){
                            Text(String($0))
                        }
                    }
                }
                Section {
                    Text(sleepResult)
                        .font(.title3)
                }
        }
            .navigationTitle("BetterRest")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
