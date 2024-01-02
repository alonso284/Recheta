//
//  TeamView.swift
//  Recheta
//
//  Created by Alonso Huerta on 01/01/24.
//

import SwiftUI

struct TeamsView: View {
    @Binding var teams: [Team]
    @State var addTeam: Bool = false
    @State var teamName: String = ""
    
    var body: some View {
        
            List {
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
                
            }
            .alert("Nombre del Equipo", isPresented: $addTeam, actions: {
                TextField("Nombre del Equipo", text: $teamName)
                
                Button(action: {
                }, label: {
                    Text("Cancel")
                })
                Button(action: {
                    if validateTeamName() {
                        teams.append(Team(name: teamName))
                    }
                }, label: {
                    Text("Add")
                        .bold()
                })

            })
//        }
    }
    
    func validateTeamName() -> Bool {
        return teamName.count >= 3
    }
}

#Preview {
    NavigationStack {
        VStack {
            TabView {
                TeamsView(teams: .constant([Team(name: "Big A"), Team(name: "Lud")])).tabItem { Label("Equipos", systemImage: "person.3") }
            }
            Spacer()
            Button("Empezar"){}
        }
    }
}
