import SwiftUI

struct MealDetailView: View {
    let mealId: String
    @State private var mealDetails: MealDetails?
    @State private var isLoading = false
    
    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView()
            } else if let mealDetails = mealDetails {
                VStack(alignment: .leading, spacing: 20) {
//                    AsyncImage(url: URL(string: mealDetails.strMealThumb)) 
                    AsyncImage(url: mealDetails.strMealThumb)
                    { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                    
                    VStack(alignment: .leading) {
                                        Text("Ingredients")
                                            .font(.headline)
                                        ForEach(mealDetails.ingredients, id: \.ingredient) { ingredientMeasure in
                                            Text("\(ingredientMeasure.ingredient): \(ingredientMeasure.measure)")
                                        }
                                    }
                                    .padding(.horizontal)

                    
                    Text(mealDetails.strMeal)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Instructions")
                        .font(.headline)
                    
                    Text(mealDetails.strInstructions)
                        .padding(.bottom, 20)
                    
                    if let url = mealDetails.strYoutube {
                        Link("Watch on YouTube", destination: url)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Meal Details")
        .onAppear {
            fetchMealDetails()
        }
    }
    
    private func fetchMealDetails() {
        isLoading = true
        APIManager.shared.fetchMealDetails(mealId: mealId) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let detailsResponse):
                    self.mealDetails = detailsResponse.meals.first
                case .failure(let error):
                    print(error.localizedDescription) // Handle the error more gracefully in a real app
                }
            }
        }
    }
}
