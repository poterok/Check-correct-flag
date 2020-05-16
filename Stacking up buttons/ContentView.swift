//
//  ContentView.swift
//  Stacking up buttons
//
//  Created by dimov_d on 14.05.2020.
//  Copyright © 2020 dimov_d. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia",
                                    "France",
                                    "Germany",
                                    "Ireland",
                                    "Italy",
                                    "Nigeria",
                                    "Poland",
                                    "Russia",
                                    "Spain",
                                    "UK",
                                    "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showAnswer = false
    @State private var scoreTitle = ""
    @State private var usersScore = 0
    
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing:30){
                
                VStack(){
                    
                    Text("Tap to the flag")
                        .foregroundColor(.white)

                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .fontWeight(.black)
                    
                    Text("Your score \(usersScore)")
                }
                
                ForEach(0..<3){number in
                    Button(action: {
                        self.flagTapped(number: number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black,lineWidth: 1))
                            .shadow(color: .black , radius: 10)
                    }
                }
                Spacer()
            }
            
        }
        .alert(isPresented: $showAnswer){
            Alert(title: Text(scoreTitle), message: Text("Your score \(usersScore)"), dismissButton: .default(Text("Continue")){
                self.askQuestion()
            })
        }
        
        }
        func flagTapped(number:Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            usersScore += 1
        } else {
            scoreTitle = "Wrong, it's flag of \(countries[number])"
            if usersScore > 0{
                usersScore -= 1
            }
            
        }
        showAnswer = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
