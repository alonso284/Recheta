//
//  WordsView.swift
//  Recheta
//
//  Created by Alonso Huerta on 01/01/24.
//

import SwiftUI

struct WordsView: View {
    
    @Binding var categoriesIncluded: Set<WordCategories>
    
    var body: some View {
//        List {
            Section("Categorias") {
                Button((categoriesIncluded.count != categoryNames.count ? "Agragar todos" : "Eliminar todos")){
                    
                    if categoriesIncluded.count == categoryNames.count {
                        categoriesIncluded = []
                    } else {
                        for key in Array(categoryNames.keys) {
                            categoriesIncluded.insert(key)
                        }
                    }
                }
                .bold()
                ForEach(Array(categoryNames.keys).sorted(), id: \.self){
                    key in
                    HStack {
                        Text("\(categoryNames[key]!)")
                            
                        Spacer()
                        Image(systemName: (categoriesIncluded.contains(key) ?  "checkmark.circle.fill": "circle"))
                    }
                    .onTapGesture {
                        if categoriesIncluded.contains(key) {
                            categoriesIncluded.remove(key)
                        } else {
                            categoriesIncluded.insert(key)
                        }
                    }
                    
                }
            }
        }
//    }
}



#Preview {
    NavigationStack {
        VStack {
            List {
                WordsView(categoriesIncluded: .constant([]))
//                WordsView()
                    .tabItem { Label("Palabras", systemImage: "list.bullet.circle") }
            }
        }
    }
}
