//
//  SettingsView.swift
//  Recheta
//
//  Created by Alonso Huerta on 01/01/24.
//

import SwiftUI

// TODO
// Do not allow limit to go under

struct SettingsView: View {
    
    @Binding var rounds: Int
    @Binding var seconds: Int
    @Binding var lives: Int
    
    var body: some View {
            Section("Partida"){
                Stepper("Rondas \(rounds)", value: $rounds)
                Stepper("Duración (seg) \(seconds)", value: $seconds)
                Stepper("Vidas \(lives)", value: $lives)
            }
    }
}

#Preview {
    NavigationStack {
        VStack {
            List {
                SettingsView(rounds: .constant(5), seconds: .constant(10), lives: .constant(3)).tabItem { Label("Configuraciones", systemImage: "gear") }
            }
        }
    }
}
