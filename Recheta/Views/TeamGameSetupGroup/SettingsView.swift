//
//  SettingsView.swift
//  Recheta
//
//  Created by Alonso Huerta on 01/01/24.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var rounds: Int
    
    @Binding var seconds: Int
    @Binding var lives: Int
    
    var body: some View {
        List {
            Section("Longitud"){
                Stepper("Rondas \(rounds)", value: $rounds)
//                Stepp
            }
            
            Section("Ronda") {
                Stepper("Segundos \(seconds)", value: $seconds)
                Stepper("Vidas \(lives)", value: $lives)
            }

        }
    }
}

#Preview {
    NavigationStack {
        VStack {
            TabView {
                SettingsView(rounds: .constant(5), seconds: .constant(10), lives: .constant(3)).tabItem { Label("Configuraciones", systemImage: "gear") }
            }
            Spacer()
            Button("Empezar"){}
        }
    }
}
