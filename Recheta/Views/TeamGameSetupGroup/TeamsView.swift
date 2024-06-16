//
//  TeamView.swift
//  Recheta
//
//  Created by Alonso Huerta on 01/01/24.
//

import SwiftUI

struct TeamsView: View {
    @Binding var teams: [Team]
    @State private var addTeam: Bool = false
    @State private var teamName: String = ""
    
    var body: some View {
                Section("Equipos", content: {
                    ForEach(teams, id: \.self.name){
                        team in
                        HStack {
                            Text("\(team.name)")
                        }
                    }
                    .onDelete(perform: { indexSet in
                        teams.remove(atOffsets: indexSet)
                    })
                    Button(action: {
                        addTeam = true
                    }, label: {
                        VStack(alignment: .center) {
                            Image(systemName: "plus")
                        }
                        .frame(maxWidth: .infinity)
                    })
                })
            .alert("Nombre del Equipo", isPresented: $addTeam, actions: {
                TextField("Nombre del Equipo", text: $teamName)
                
                Button(action: {
                    teamName = ""
                }, label: {
                    Text("Cancel")
                })
                Button(action: {
                    if validateTeamName() {
                        teams.append(Team(name: teamName))
                        teamName = ""
                    }
                }, label: {
                    Text("Add")
                        .bold()
                })

            })
    }
    
    func validateTeamName() -> Bool {
        return teamName.count >= 3
    }
}

#Preview {
    NavigationStack {
        VStack {
            List {
                TeamsView(teams: .constant([Team(name: "Big A"), Team(name: "Lud")])).tabItem { Label("Equipos", systemImage: "person.3") }
            }
        }
    }
}
