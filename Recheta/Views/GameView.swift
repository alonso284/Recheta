//
//  GameView.swift
//  Recheta
//
//  Created by Alonso Huerta on 01/01/24.
//

import SwiftUI

struct GameView: View {
    
    // self.presentationMode.wrappedValue.dismiss()
    // .navigationBarBackButtonHidden(true)
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let teams: [Team];
    @State private var livesLeft = [UUID: Int]()
    let categoriesIncluded:[WordCategories]
    @State private var roundsPassed = 0
    let rounds: Int
    let seconds: Int
    let lives: Int
    
    var body: some View {
        VStack {
            
            List {
                HStack {
                    Text("Rondas faltantes")
                    Spacer()
                    Text("\(rounds - roundsPassed)")
                }
                Section("Vidas Faltantes"){
                    ForEach(teams, id: \.self.id){
                        team in
                        HStack {
                            Text(team.name)
                                .foregroundStyle((livesLeft[team.id] ?? lives) == 0 ? .red: .primary)
                            Spacer()
                            Text("\((livesLeft[team.id] ?? lives))")
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true, content: {
                            if (livesLeft[team.id] ?? lives) > 0 {
                                Button("Strike"){
                                    if let l = livesLeft[team.id] {
                                        livesLeft[team.id] = max(0, l-1)
                                    }
                                }
                                .tint(.red)
                            }
                        })
                    }
                    
                }
            }
//            .environment(\.editMode, .constant(.active))
            .onAppear(perform: {
                if livesLeft.isEmpty {
                    for team in teams {
                        livesLeft[team.id] = lives
                    }
                }
            })
            Spacer()
            if rounds == roundsPassed {
                Button("Terminar"){
                    self.presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(.borderedProminent)
                .padding()
            } else {
                NavigationLink(destination:
                                RandomizerView(categoriesIncluded: categoriesIncluded, timeRemaining: seconds)
                               , label: {
                    Text("Empezar Ronda")
                })
                .buttonStyle(.borderedProminent)
                .padding()
            }
            
        }
        .onDisappear(){
            roundsPassed += 1
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        GameView(teams: [Team(name: "Big A"), Team(name: "Lud")], categoriesIncluded: [WordCategories.Fruit, WordCategories.Celebrities, WordCategories.Places], rounds: 2, seconds: 3, lives: 3)
    }
}
