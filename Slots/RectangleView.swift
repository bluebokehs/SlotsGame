//
//  RectangleView.swift
//  Slots
//
//  Created by Owen Kern on 3/27/22.
//

import SwiftUI

struct RectangleView: View {
    
    @Binding var x:Int
    @State private var animating = false
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255))
                .edgesIgnoringSafeArea(.all)
                .scaleEffect(x: 0.5, y: 2)
                .rotationEffect(Angle(degrees: 45))
                .offset(x: CGFloat(animating ? x + 300: x - 300), y: CGFloat(animating ? x + 300 : x - 300))
                .animation(Animation.easeInOut(duration: 10).repeatForever(), value: animating)
                
        }
        .onAppear {
            DispatchQueue.main.async {
                self.animating.toggle()
            }
        }
        
    }
}

struct RectangleView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleView(x: Binding.constant(0))
    }
}
