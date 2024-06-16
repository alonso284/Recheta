//
//  TeamGameSetupView.swift
//  Recheta
//
//  Created by Alonso Huerta on 01/01/24.
//

import SwiftUI

struct TeamGameSetupView: View {
    @State private var teams: [Team] = [Team(name: "Team A"), Team(name: "Team B")]
    @State private var categoriesIncluded = Set<WordCategories>()
    @State private var rounds: Int = 5
    @State private var seconds: Int = 10
    @State private var lives: Int = 3
    
    
    
    var body: some View {
        List {
            TeamsView(teams: $teams)
            SettingsView(rounds: $rounds, seconds: $seconds, lives: $lives)
            WordsView(categoriesIncluded: $categoriesIncluded)
        }
        .navigationTitle("Configuraciones")
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
                && (rounds > 0 && seconds >= 10 && lives > 0)
    }
}

#Preview {
    NavigationStack {
        TeamGameSetupView()
    }
}
