//
//  ContentView.swift
//  BetterRest
//
//  Created by Douglas Cardoso Ferreira on 18/07/21.
//

import SwiftUI

struct drawText: ViewModifier {
    let font = Font.system(size: 20, weight: .heavy, design: .default)
    
    func body(content: Content) -> some View {
        content
            .font(font)
    }
}

struct DrawHorizontalText: View {
    var text: String
    var textResult: String
    
    var body: some View {
        HStack {
            Text(text)
                .modifier(drawText())
                .foregroundColor(.blue)
            
            Text(textResult)
                .modifier(drawText())
                .foregroundColor(.red)
        }
    }
}

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    private let rangeOfCoffee = 1...20
    
    private var recomendedBadTime: String {
        calculateBedtime()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text("Desired amount of sleep")) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                
                Section(header: Text("Daily coffe intake")) {
                    Picker("Daily coffee intake", selection: $coffeeAmount) {
                        ForEach(rangeOfCoffee, id: \.self) {
                            Text($0 == 1 ? "1 cup" : "\($0) cups")
                        }
                    }
                }
                DrawHorizontalText(text: "Your ideal bedtime is:", textResult: "\(recomendedBadTime)")
            }
            .navigationBarTitle("BetterRest")
        }
    }
    
    func calculateBedtime() -> String {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return formatter.string(from: sleepTime)
        } catch {
            return "Error"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
