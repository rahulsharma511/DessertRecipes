import SwiftUI

struct MealView: View {
    @State private var meals: [Meal] = []
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            List(meals, id: \.idMeal) { meal in
                NavigationLink(destination: MealDetailView(mealId: meal.idMeal)) {
                    HStack {
                        AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        Text(meal.strMeal)
                            .padding(.leading, 8)
                    }
                }
            }
            .navigationTitle("Meals")
            .onAppear {
                fetchMeals()
            }
        }
    }
    
    private func fetchMeals() {
        isLoading = true
        APIManager.shared.fetchMeals(category: "Dessert") { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let mealsResponse):
                    self.meals = mealsResponse.meals
                case .failure(let error):
                    print(error.localizedDescription) // Handle the error more gracefully in a real app
                }
            }
        }
    }
}
