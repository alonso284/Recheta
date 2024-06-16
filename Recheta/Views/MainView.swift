//
//  WelcomeView.swift
//  Recheta
//
//  Created by Alonso Huerta on 01/01/24.
//

import SwiftUI

struct MainView: View {
    @State var settingsPresent = false
    
    var body: some View {
        NavigationView {
            VStack {
//                Image("logo")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 200)
//                    .padding(.bottom, 50)
                Text("Recheta")
                    .font(.largeTitle)
                    .padding(.bottom, 50)
                
                HStack {
//                    NavigationLink("Individual", destination: TeamGameSetupView())
//                        .buttonStyle(.borderedProminent)
                    NavigationLink(destination: TeamGameSetupView(), label: {
                        Image(systemName: "button.programmable")
                            .frame(width: 150, height: 50)
                    })
                    .buttonStyle(.borderedProminent)
                    .font(.title)
                    
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading, content: {
                    Button(action: {
                        settingsPresent = true
                    }, label: {
                        Image(systemName: "gear")
                    })
                })
            })
        }
        .sheet(isPresented: $settingsPresent, content: {
            // Settings
            Text("Settings")
        })
    }
}



#Preview {
    MainView()
}
