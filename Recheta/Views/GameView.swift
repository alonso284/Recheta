//
//  GameView.swift
//  Recheta
//
//  Created by Alonso Huerta on 01/01/24.
//

import SwiftUI

struct GameView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let teams: [Team]
    @State private var livesLeft = [UUID: Int]()
    let categoriesIncluded:Set<WordCategories>
    @State private var roundsPassed = 0
    let rounds: Int
    let seconds: Int
    let lives: Int
    
    @State private var alertPresent = false
    
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
                                .foregroundStyle((livesLeft[team.id] ?? lives == 0 ? .red: .primary))
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true, content: {
                            if (livesLeft[team.id] ?? lives) > 0 {
                                Button("Strike"){
                                    if let l = livesLeft[team.id] {
                                        livesLeft[team.id] = max(0, l-1)
                                    }
                                    checkForWinner()
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
                                RandomizerView(categoriesIncluded: categoriesIncluded, time: Double(seconds))
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
        .alert(isPresented: $alertPresent, content: {
            Alert(title: Text("Terminar Partida"), message: Text("Todo el progreso se perderá"), primaryButton: .destructive(Text("Confirm"), action: {
                    self.presentationMode.wrappedValue.dismiss()
            }),
                secondaryButton: .cancel()) })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(role: .destructive, action: {
                    alertPresent = true
                }, label: {
                    Image(systemName: "rectangle.portrait.and.arrow.forward")
                })
            }
        }
    }
    
    func checkForWinner(){
        let nonZeroCount = livesLeft.values.filter { $0 != 0 }.count
        
        if nonZeroCount == 1 {
            roundsPassed = rounds
        }
        
    }
}

#Preview {
    NavigationStack {
        GameView(teams: [Team(name: "Big A"), Team(name: "Lud")], categoriesIncluded: [WordCategories.Fruit, WordCategories.Celebrities, WordCategories.Places], rounds: 5, seconds: 7, lives: 3)
    }
}
