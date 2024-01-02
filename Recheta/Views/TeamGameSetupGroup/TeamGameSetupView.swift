//
//  TeamGameSetupView.swift
//  Recheta
//
//  Created by Alonso Huerta on 01/01/24.
//

import SwiftUI

struct TeamGameSetupView: View {
    @State var teams: [Team] = [Team(name: "Big A"), Team(name: "Lud")]
    @State var categoriesIncluded:[WordCategories] = []
    @State var rounds: Int = 5
    @State var seconds: Int = 10
    @State var lives: Int = 3
    
    var body: some View {

        TabView {
            // Team Selection Tab
            TeamsView(teams: $teams)
                .tabItem { Label("Equipos", systemImage: "person.3") }
            // Word Selection Tab
            WordsView(categoriesIncluded: $categoriesIncluded)
                .tabItem { Label("Palabras", systemImage: "list.bullet.circle") }
            // Settings Tab
            SettingsView(rounds: $rounds, seconds: $seconds, lives: $lives).tabItem { Label("Configuraciones", systemImage: "gear") }

        }
        .navigationTitle("Equipos")
        .toolbar(content: {
            ToolbarItem(placement: .primaryAction, content: {
                NavigationLink(destination: GameView(teams: teams, categoriesIncluded: categoriesIncluded, rounds: rounds, seconds: seconds, lives: lives), label: {
                    Image(systemName: "play")
                })
                .disabled(!validGameState())
            })
        })
    }
    
    func validGameState() -> Bool {
        return  (teams.count >= 2)
                && (categoriesIncluded.count > 0)
                && (rounds > 0 && seconds > 0 && lives > 0)
    }
}

#Preview {
    NavigationStack {
        TeamGameSetupView()
    }
}
