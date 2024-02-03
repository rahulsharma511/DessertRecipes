//
//  Meals.swift
//  DessertRecipes
//
//  Created by Swaroop Patwari on 2/2/24.
//

import Foundation

// Model for the response from the first API - list of meals
struct MealsResponse: Codable {
    let meals: [Meal]
}

struct Meal: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
