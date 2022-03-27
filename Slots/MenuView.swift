//
//  MenuView.swift
//  Slots
//
//  Created by Owen Kern on 3/27/22.
//

import SwiftUI

struct MenuView: View {
    
    @State var movement0 = -500
    @State var movement1 = -300
    @State var movement2 = -100
    @State var movement3 = 100
    @State var movement4 = 300
    @State var movement5 = 500
    
    
    var body: some View {
        NavigationView {
            ZStack {
                //Background
                Rectangle()
                    .foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255))
                    .edgesIgnoringSafeArea(.all)
                Group {
                    RectangleView(x: $movement0)
                    RectangleView(x: $movement1)
                    RectangleView(x: $movement2)
                    RectangleView(x: $movement3)
                    RectangleView(x: $movement4)
                    RectangleView(x: $movement5)
                }
                VStack {
                    Text("Slots")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    Spacer()
                    Spacer()
                    VStack {
                        NavigationLink {
                            ContentView()
                        } label: {
                            Text("Play")
                                .font(.headline)
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 35.0)
                                .padding(.vertical, 15.0)
                                .background(Color.pink)
                                .cornerRadius(/*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            
                        }
                        NavigationLink {
                            ShopView()
                        } label: {
                            Text("Shop")
                                .font(.headline)
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 35.0)
                                .padding(.vertical, 15.0)
                                .background(Color.pink)
                                .cornerRadius(/*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            
                        }
                    }
                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
