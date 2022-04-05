//
//  ShopView.swift
//  Slots
//
//  Created by Owen Kern on 3/27/22.
//

import SwiftUI

struct ShopView: View {
    
    @State private var symbols = ["seven", "diamond", "bell"]
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
    
    @State var movement0 = -500
    @State var movement1 = -300
    @State var movement2 = -100
    @State var movement3 = 100
    @State var movement4 = 300
    @State var movement5 = 500
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
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
                Spacer()
                Text("Shop")
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
                Text("Credits: 500")
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .padding(.horizontal, 35.0)
                    .padding(.vertical, 15.0)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(/*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                Spacer()
                HStack {
                    Spacer()
                    ShopItemView(symbol: $symbols[numbers[0]], background: $backgrounds[0])
                    ShopItemView(symbol: $symbols[numbers[0]], background: $backgrounds[0])
                    ShopItemView(symbol: $symbols[numbers[0]], background: $backgrounds[0])
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
    }
}
