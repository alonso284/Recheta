//
//  WordsView.swift
//  Recheta
//
//  Created by Alonso Huerta on 01/01/24.
//

import SwiftUI

struct WordsView: View {
    
    @Binding var categoriesIncluded: [WordCategories]
//    @State var categoriesIncluded: [WordCategories] = []
    
    var body: some View {
        List {
            Section("Seleccionados"){
                ForEach(categoriesIncluded, id: \.self){
                    key in
                    Text("\(categoryNames[key]!)")
                }
                .onDelete(perform: { indexSet in
                    categoriesIncluded.remove(atOffsets: indexSet)
                })
            }
            Section("Categorias") {
                Button("Agregar Todos"){
                    for key in Array(categoryNames.keys) {
                        if !categoriesIncluded.contains([key]){
                            categoriesIncluded.append(key)
                        }
                    }
                }
                ForEach(Array(categoryNames.keys), id: \.self){
                    key in
                    Button("\(categoryNames[key]!)"){
                        if !categoriesIncluded.contains([key]){
                            categoriesIncluded.append(key)
                        }
                    }
                }
            }
        }
    }
}



#Preview {
    NavigationStack {
        VStack {
            TabView {
                WordsView(categoriesIncluded: .constant([]))
//                WordsView()
                    .tabItem { Label("Palabras", systemImage: "list.bullet.circle") }
            }
            Spacer()
            Button("Empezar"){}
        }
    }
}
