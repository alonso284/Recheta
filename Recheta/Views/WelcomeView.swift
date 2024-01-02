//
//  WelcomeView.swift
//  Recheta
//
//  Created by Alonso Huerta on 01/01/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Recheta")
                    .font(.title)
                
                HStack {
                    NavigationLink("Individual", destination: TeamGameSetupView())
                        .buttonStyle(.borderedProminent)
                    
                    NavigationLink("Equipos", destination: TeamGameSetupView())
                        .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}



#Preview {
    WelcomeView()
}
