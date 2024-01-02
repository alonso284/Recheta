//
//  RandomizerView.swift
//  Recheta
//
//  Created by Alonso Huerta on 02/01/24.
//

import SwiftUI

struct RandomizerView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let categoriesIncluded:[WordCategories]
    
    @State var timeRemaining: Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var shownWord: String? = nil
    
    
    var body: some View {
        VStack {
            Text(shownWord ?? "Error")
                .font(.largeTitle)
            Text("\(timeRemaining)")
                .onReceive(timer) { time in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    } else {
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
                .font(.title2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .background(Color.accentColor)
        .onTapGesture {
            chooseWord()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            chooseWord()
        })
    }
    
    func chooseWord() {
        guard let category = categoriesIncluded.randomElement() else {
            return
        }
        
        if let list = words[category] {
            shownWord = list.randomElement()
        }
    }
}

#Preview {
    RandomizerView(categoriesIncluded: [WordCategories.Fruit, WordCategories.Celebrities, WordCategories.Places], timeRemaining: 15)
}
