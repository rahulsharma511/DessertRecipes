import Foundation

class APIManager {
    static let shared = APIManager()

    private let baseUrl = "https://www.themealdb.com/api/json/v1/1/"
    private init() {}

    func fetchMeals(category: String, completion: @escaping (Result<MealsResponse, Error>) -> Void) {
        let mealsUrl = "\(baseUrl)filter.php?c=\(category)"

        guard let url = URL(string: mealsUrl) else {
            completion(.failure(NSError(domain: "APIManagerError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "APIManagerError", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            do {
                let mealsResponse = try JSONDecoder().decode(MealsResponse.self, from: data)
                completion(.success(mealsResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchMealDetails(mealId: String, completion: @escaping (Result<MealDetailsResponse, Error>) -> Void) {
        let detailsUrl = "\(baseUrl)lookup.php?i=\(mealId)"

        guard let url = URL(string: detailsUrl) else {
            completion(.failure(NSError(domain: "APIManagerError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "APIManagerError", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            do {
                let mealDetailsResponse = try JSONDecoder().decode(MealDetailsResponse.self, from: data)
                completion(.success(mealDetailsResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
