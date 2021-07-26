//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Douglas Cardoso Ferreira on 12/07/21.
//

import SwiftUI

struct FlagImage: View {
    var image: String
    
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
    
    init(show image: String) {
        self.image = image
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var messageAlert = ""
    @State private var score = 0
    @State private var isCorrect = false
    @State private var selectedNumber = 0
    @State private var isFadeOutOpacity = false
    @State private var isWrong = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        withAnimation {
                            self.flagTapped(number)
                        }
                    }) {
                        FlagImage(show: self.countries[number])
                    }
                    .rotation3DEffect(.degrees(self.isCorrect && self.selectedNumber == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                    .opacity(isFadeOutOpacity && selectedNumber != number ? 0.25 : 1)
                    .rotation3DEffect(.degrees(isWrong && selectedNumber == number ? 90 : 0), axis: (x: 0, y: 0, z: 0.5))
                }
                
                Text("Your score is \(score)")
                    .foregroundColor(.white)
                    .font(.title)
                
                Spacer()
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text(messageAlert), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        selectedNumber = number
        if number == correctAnswer {
            scoreTitle = "Correct"
            messageAlert = "Congratulations! You guessed the flag."
            score += 1
            isCorrect = true
            isFadeOutOpacity = true
        } else {
            scoreTitle = "Wrong"
            messageAlert = "That’s the flag of \(countries[number])."
            score -= 1
            isWrong = true
            isFadeOutOpacity = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        isCorrect = false
        isFadeOutOpacity = false
        isWrong = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
