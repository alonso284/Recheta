//
//  TeamView.swift
//  Recheta
//
//  Created by Alonso Huerta on 01/01/24.
//

import SwiftUI

struct TeamsView: View {
    @State var teams: [Team] = [Team(name: "Big A"), Team(name: "Lud")]
    @State var addTeam: Bool = false
    @State var teamName: String = ""
    
    var body: some View {
        
//        NavigationStack {
            VStack {
                List {
                    ForEach(teams, id: \.self.name){
                        team in
                        HStack {
                            Text("\(team.name)")
                        }
                    }
                    .onDelete(perform: { indexSet in
                        teams.remove(atOffsets: indexSet)
                    })
                }
                Spacer()
                Button("Empezar", action: {})
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity)
                    
                
            }
            .navigationTitle("Equipos")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button(action: {
                        addTeam = true
                    }, label: {
                        Image(systemName: "plus")
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
        TeamView()
    }
}
