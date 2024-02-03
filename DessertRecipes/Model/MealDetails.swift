
import Foundation

struct MealDetailsResponse: Codable {
    let meals: [MealDetails]
}

struct MealDetails: Codable {
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: URL
    let strTags: String?
    let strYoutube: URL?
    var ingredients: [IngredientMeasure] = []
    
    struct IngredientMeasure: Codable {
        let ingredient: String
        let measure: String
    }
    
    private enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strCategory, strArea, strInstructions, strMealThumb, strTags, strYoutube
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strCategory = try container.decode(String.self, forKey: .strCategory)
        strArea = try container.decode(String.self, forKey: .strArea)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(URL.self, forKey: .strMealThumb)
        strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
        strYoutube = try container.decodeIfPresent(URL.self, forKey: .strYoutube)
        
        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        for key in dynamicContainer.allKeys {
            if key.stringValue.starts(with: "strIngredient"), let index = key.stringValue.components(separatedBy: CharacterSet.decimalDigits.inverted).last, let measureKey = DynamicCodingKeys(stringValue: "strMeasure\(index)"), let ingredient = try dynamicContainer.decodeIfPresent(String.self, forKey: key), !ingredient.isEmpty, let measure = try dynamicContainer.decodeIfPresent(String.self, forKey: measureKey), !measure.isEmpty {
                let ingredientMeasure = IngredientMeasure(ingredient: ingredient, measure: measure)
                ingredients.append(ingredientMeasure)
            }
        }
    }
    
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) { return nil }
    }
}
