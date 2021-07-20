//
//  ContentView.swift
//  Jokempo
//
//  Created by Douglas Cardoso Ferreira on 17/07/21.
//

import SwiftUI

struct CustomMyButton: View {
    var text: String
    
    var body: some View {
        Text(text)
            .padding()
            .padding()
            .cornerRadius(25)
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 2))
            .font(.largeTitle)
    }
}

struct YouMustText: View {
    var text: String
    var winOrLose: Bool = false
    
    var body: some View {
        HStack {
            Text("Você precisa:")
            Text(text)
                .foregroundColor(winOrLose ? .green : .red)
        }
    }
}

struct ContentView: View {
    private let possibleMoves = ["🪨", "📄", "✂️"]
    
    @State private var randomComputeChoice = Int.random(in: 0...2)
    @State private var winOrLose = Bool.random()
    @State private var totalScore = 0
    @State private var totalMatches = 0
    @State private var showingScore = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 100) {
                Text("Jokempô")
                    .font(.largeTitle)
                
                VStack(spacing: 50) {
                    Text("Sua pontuação: \(totalScore)")
                    
                    CustomMyButton(text: "\(possibleMoves[randomComputeChoice])")
                    
                    if winOrLose {
                        YouMustText(text: "GANHAR", winOrLose: winOrLose)
                    } else {
                        YouMustText(text: "PERDER", winOrLose: winOrLose)
                    }
                    
                    HStack {
                        ForEach(0..<3) { number in
                            Button(action: {
                                checkMatch(selectedOption: number)
                            }) {
                                Text("\(possibleMoves[number])")
                                    .padding()
                                    .padding()
                                    .cornerRadius(25)
                                    .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 2))
                                    .font(.largeTitle)
                            }
                        }
                    }
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text("Placar"), message: Text("Você acertou \(totalScore) em \(totalMatches) partidas"), dismissButton: .default(Text("OK")) {
                self.startNewGame()
            })
        }
    }
    
    func checkMatch(selectedOption: Int) {
        if winOrLose {
            if randomComputeChoice == 0 && selectedOption == 1 {
                totalScore+=1
            } else if randomComputeChoice == 0 && selectedOption == 2 {
                totalScore-=1
            }
            
            if randomComputeChoice == 1 && selectedOption == 0 {
                totalScore-=1
            } else if randomComputeChoice == 1 && selectedOption == 2 {
                totalScore+=1
            }
            
            if randomComputeChoice == 2 && selectedOption == 0 {
                totalScore+=1
            } else if randomComputeChoice == 2 && selectedOption == 1 {
                totalScore-=1
            }
        } else {
            if randomComputeChoice == 0 && selectedOption == 1 {
                totalScore-=1
            } else if randomComputeChoice == 0 && selectedOption == 2 {
                totalScore+=1
            }
            
            if randomComputeChoice == 1 && selectedOption == 0 {
                totalScore+=1
            } else if randomComputeChoice == 1 && selectedOption == 2 {
                totalScore-=1
            }
            
            if randomComputeChoice == 2 && selectedOption == 0 {
                totalScore-=1
            } else if randomComputeChoice == 2 && selectedOption == 1 {
                totalScore+=1
            }
        }

        totalMatches+=1
        startNewMatch()
    }
    
    func startNewMatch() {
        if totalMatches == 10 {
            showingScore = true
        } else {
            randomComputeChoice = Int.random(in: 0...2)
            winOrLose = Bool.random()
        }
    }
    
    func startNewGame() {
        totalScore = 0
        totalMatches = 0
        startNewMatch()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
