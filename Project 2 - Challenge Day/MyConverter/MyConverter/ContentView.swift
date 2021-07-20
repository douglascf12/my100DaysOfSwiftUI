//
//  ContentView.swift
//  MyConverter
//
//  Created by Douglas Cardoso Ferreira on 11/07/21.
//

import SwiftUI

struct ContentView: View {
    @State private var convertFrom = 0
    @State private var convertTo = 0
    @State private var valueStr = ""
    @State private var typesTimes = ["Seconds", "Minutes", "Hours", "Days"]
    
    var conversionValue: Double {
        let value = Double(valueStr) ?? 0
        
        var valueInSeconds: Double {
            switch convertFrom {
            case 0:
                return 60
            case 1:
                return value * 60
            case 2:
                return value * 3600
            default:
                return value * 86400
            }
        }
        
        if convertFrom == convertTo {
            return value
        } else if(convertFrom > convertTo) {
            switch convertTo {
            case 0:
                return valueInSeconds
            case 1:
                return valueInSeconds * 60 / 3600
            case 2:
                return valueInSeconds * 24 / 86400
            default:
                return value * valueInSeconds
            }
        } else {
            switch convertTo {
            case 0:
                return value / valueInSeconds
            case 1:
                return value / valueInSeconds
            case 2:
                return value / valueInSeconds
            default:
                return value / valueInSeconds
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("From")) {
                    Picker("From", selection: $convertFrom) {
                        ForEach(0 ..< typesTimes.count) {
                            Text("\(self.typesTimes[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("To")) {
                    Picker("To", selection: $convertTo) {
                        ForEach(0 ..< self.typesTimes.count) {
                            Text("\(self.typesTimes[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Enter the value")) {
                    TextField("Value", text: $valueStr)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Total")) {
                    Text("\(conversionValue, specifier: "%.0f") \(typesTimes[convertTo])")
                }
            }
            .navigationBarTitle("My Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
