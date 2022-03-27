//
//  SlotsApp.swift
//  Slots
//
//  Created by Owen Kern on 3/26/22.
//

import SwiftUI

@main
struct SlotsApp: App {
    
    @State var showingGame = false
    
    var body: some Scene {
        WindowGroup {
            MenuView()
        }
    }
}
