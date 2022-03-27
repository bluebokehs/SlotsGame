//
//  ContentView.swift
//  Slots
//
//  Created by Owen Kern on 3/26/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var symbols = ["apple", "cherry", "star"]
    @State private var credits = 500
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
    @State private var win = false
    private var betAmount = 5
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack {
            //Background
            Rectangle()
                .foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
            Rectangle()
                .foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255))
                .rotationEffect(Angle(degrees: 45))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Text("Slots")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .navigationBarBackButtonHidden(true)
                    .toolbar(content: {
                        ToolbarItem (placement: .navigation)  {
                            Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .onTapGesture {
                                // code to dismiss the view
                                self.presentation.wrappedValue.dismiss()
                            }
                        }
                    })
                Spacer()
                Text("Credits: " + String(credits))
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .padding(.horizontal, 35.0)
                    .padding(.vertical, 15.0)
                    .background(win ? Color.green.opacity(0.5) : Color.white.opacity(0.5))
                    .animation(.none, value: win)
                    .cornerRadius(/*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .scaleEffect(win ? 1.2 : 1)
                    .animation(.spring(response: 0.7, dampingFraction: 0.35), value: win)
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        CardView(symbol: $symbols[numbers[0]], background: $backgrounds[0])
                        CardView(symbol: $symbols[numbers[1]], background: $backgrounds[1])
                        CardView(symbol: $symbols[numbers[2]], background: $backgrounds[2])
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        CardView(symbol: $symbols[numbers[3]], background: $backgrounds[3])
                        CardView(symbol: $symbols[numbers[4]], background: $backgrounds[4])
                        CardView(symbol: $symbols[numbers[5]], background: $backgrounds[5])
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        CardView(symbol: $symbols[numbers[6]], background: $backgrounds[6])
                        CardView(symbol: $symbols[numbers[7]], background: $backgrounds[7])
                        CardView(symbol: $symbols[numbers[8]], background: $backgrounds[8])
                        Spacer()
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            // process a regular spin
                            self.processResults()
                        }, label: {
                            Text("Spin")
                                .font(.headline)
                                .foregroundColor(Color.black)
                                .padding(.horizontal, 35.0)
                                .padding(.vertical, 15.0)
                                .background(Color.white)
                                .cornerRadius(/*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                
                        })
                        
                        Text("\(betAmount) credits")
                    }
                    
                    Spacer()
                    
                    VStack {
                        Button(action: {
                            // process a plus spin
                            self.processResults(true)
                        }, label: {
                            Text("Spin+")
                                .font(.headline)
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 35.0)
                                .padding(.vertical, 15.0)
                                .background(Color.pink)
                                .cornerRadius(/*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                
                        })
                        Text("\(betAmount * 5) credits")
                    }
                    Spacer()
                }
                Spacer()
            }
        }
        .animation(.easeOut)
    }
    
    func processResults(_ isPlus:Bool = false) {
        // Update backgrounds to white
        self.backgrounds = self.backgrounds.map { _ in
            Color.white
        }
        
        // Change images
        if isPlus {
            // Spin all cards
            self.numbers = self.numbers.map { _ in
                Int.random(in: 0...self.symbols.count - 1)
            }
        } else {
            // Spin middle row
            self.numbers[3] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[4] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[5] = Int.random(in: 0...self.symbols.count - 1)
        }
        
        // Update Credits
        processWin(isPlus)
        
    }
    
    func processWin(_ isPlus:Bool = false) {
        
        var matches = 0
        
        
        if !isPlus {
            // For a regular spin
            if isMatch(3, 4, 5) {
                matches += 1
            }
        } else {
            // For a plus spin
            
            // Top Row
            if isMatch(0, 1, 2) {
                matches += 1
            }
            // Middle Row
            if isMatch(3, 4, 5) {
                matches += 1
            }
            // Bottom Row
            if isMatch(6, 7, 8) {
                matches += 1
            }
            // Top Left to Bottom Right
            if isMatch(0, 4, 8) {
                matches += 1
            }
            // Top Right to Bottom Left
            if isMatch(2, 4, 6) {
                matches += 1
            }
            
        }
        
        self.win = false
        
        // Check matches and distribute
        if matches > 0 {
            // At least 1 win
            self.credits += matches * self.betAmount * 3
            self.win = true
        } else if !isPlus {
            // 0 wins, regular spin
            self.credits -= self.betAmount
        } else {
            // 0 wins, plus spin
            self.credits -= self.betAmount * 5
        }
    }
    
    func isMatch(_ index1:Int, _ index2:Int, _ index3:Int) -> Bool {
        if self.numbers[index1] == self.numbers[index2] && self.numbers[index2] == self.numbers[index3] {
            
            self.backgrounds[index1] = Color.green
            self.backgrounds[index2] = Color.green
            self.backgrounds[index3] = Color.green
            
            return true
        }
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
