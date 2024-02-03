//
//  MealDetails.swift
//  DessertRecipes
//
//  Created by Swaroop Patwari on 2/2/24.
//

import Foundation

// Model for the response from the second API - details of a single meal
struct MealDetailsResponse: Codable {
    let meals: [MealDetails]
}

struct MealDetails: Codable {
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strTags: String?
    let strYoutube: String?
    let strIngredient1: String?
    // Include other ingredients as needed
    let strMeasure1: String?
    // Include other measures as needed
    let strSource: String?
}

