//
//  RandomizerView.swift
//  Recheta
//
//  Created by Alonso Huerta on 02/01/24.
//

import SwiftUI
import AudioToolbox

struct RandomizerView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    let categoriesIncluded:Set<WordCategories>
    
    let time: Double
    @State private var timePassed: Double = 0
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State var countDown:Int = 5
    
    @State private var shownWord: String? = nil
    @State private var shownCategory: String? = nil
    
    
    var body: some View {
        VStack {
            ProgressView(value: timePassed, total: time)
                .onReceive(timer) { timerS in
                    if timePassed < time {
                        
                        if countDown == Int(timePassed){
                            countDown += 1
                            AudioServicesPlaySystemSound(SystemSoundID(1052))
                        }
                        
                        timePassed +=  0.01
                    } else {
                        
                        self.presentationMode.wrappedValue.dismiss()
                        if countDown == Int(time) {
                            AudioServicesPlaySystemSound(SystemSoundID(1109))
                            countDown = 0
                        }
                    }
            }
                .animation(.easeIn, value: timePassed)
                .padding(.all, 50)
                .colorMultiply(.black)
                .colorInvert()
            Spacer()
            Spacer()
            Group {
                Text(shownWord ?? "Error")
                    .font(.largeTitle)
                Text(shownCategory ?? "Error")
                    .font(.title2)
//                Text("\(Int(timePassed))")
            }
            .foregroundColor(.white)
            
            Spacer()
            Spacer()
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.orange)
//        .background((colorScheme == .dark ? .black : .white))
        .onTapGesture {
//            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            chooseWord()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            chooseWord()
            countDown = Int(time) - min(countDown, Int(time))
        })
    }
    
    func chooseWord() {
        guard let category = categoriesIncluded.randomElement() else {
            return
        }
        
        guard let cat = categoryNames[category] else {
            return
        }
        
        shownCategory = cat
        
        if let list = words[category] {
            shownWord = list.randomElement()
        }
    }
}

#Preview {
    RandomizerView(categoriesIncluded: [WordCategories.Fruit, WordCategories.Celebrities, WordCategories.Places], time: 5.0)
}
