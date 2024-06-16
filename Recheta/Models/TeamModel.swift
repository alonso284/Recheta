//
//  TeamModel.swift
//  Recheta
//
//  Created by Alonso Huerta on 01/01/24.
//

import Foundation

enum WordCategories: Comparable {
    case Celebrities
    case Fruit
    case Places
}

let words = [
    WordCategories.Fruit : ["Apple", "Orange", "Grape"],
    WordCategories.Places : ["Monterrey", "Merida", "New York", "Paris"],
    WordCategories.Celebrities : ["Margo Robbie", "Dua Lipa", "Leonardo DiCaprio"],
]

let categoryNames = [
    WordCategories.Fruit : "Frutas",
    WordCategories.Places : "Lugares",
    WordCategories.Celebrities : "Celebridades"
]

struct Team {
    let id = UUID()
    var name: String
}
