import SwiftUI

struct WaterNeedsView: View {
    @State var landID: String
    @State var cropType: String
    @State var numberOfCropsString: String
    @State var waterNeeds = 0.0
    @State var isLoading = false

    var body: some View {
        VStack(spacing: 20) {
            // Header with Icon
            VStack(spacing: 10) {
                Image(systemName: "drop.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
                Text("Water Needs for \(cropType)")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 20)

            // Water Needs Information
            VStack(spacing: 15) {
                Text("Land ID: \(landID)")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                if isLoading {
                    ProgressView()
                        .padding()
                } else {
                    let cropsWaterNeeds: [String: Double] = [
                        "Wheat": 4.0,
                        "Corn": 6.5,
                        "Rice": 7.5,
                        "Cotton": 5.0,
                        "Barley": 3.5,
                        "Potatoes": 4.5,
                        "Tomatoes": 5.0,
                        "Carrots": 3.5,
                        "Cucumber": 4.0,
                        "Onions": 4.0,
                        "Strawberries": 3.0,
                        "Olives": 2.5,
                        "Apples": 4.0,
                        "Oranges": 4.5,
                        "Grapes": 3.5,
                        "Watermelon": 5.5,
                        "Melon": 4.5,
                        "Dates": 3.0,
                        "Soybeans": 4.5,
                        "Beans": 4.0,
                        "Eggplant": 4.0
                    ]
                    Text("Estimated Water Needs: \(((waterNeeds + cropsWaterNeeds[cropType]!) *  Double(numberOfCropsString)!), specifier: "%.2f") mm/day")
                        .font(.title2)
                        .bold()
                        .foregroundColor(waterNeeds > 0 ? .green : .red)
                        .multilineTextAlignment(.center)

                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .shadow(radius: 5)

            // Refresh Button
            Button(action: {
                calculateWaterNeeds()
            }) {
                Text("Refresh Data")
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
        }
        .padding()
        .onAppear {
            calculateWaterNeeds()
        }
    }

    func calculateWaterNeeds() {
        isLoading = true
        let apiRequest = APIRequest()
        print("Sending API request...") // Before sending the request

        apiRequest.sendRequest { result in
            isLoading = false
            switch result {
            case .success(let data):
                print("Received data from API: \(data.count) bytes") // Check byte size

                // Print the raw data as a string for debugging
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON response: \(jsonString)") // Print raw JSON response
                } else {
                    print("Failed to convert data to String") // If conversion fails
                }

                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        print("Parsed JSON array: \(jsonArray)") // After parsing JSON

                        // Extract the 'et' values
                        let etValues = jsonArray.compactMap { $0["et"] as? Double }
                        print("Extracted ET values: \(etValues)") // After extracting ET values

                        // Compute the average ET value (or any other logic you prefer)
                        if !etValues.isEmpty {
                            let totalET = etValues.reduce(0, +)
                            print("Total ET: \(totalET)") // After calculating total ET
                            waterNeeds = totalET / Double(etValues.count) // Average ET value
                            print("Calculated average water needs: \(waterNeeds)") // After calculating average
                        } else {
                            waterNeeds = 0.0 // Set to 0 if no ET values
                            print("No ET values found. Setting water needs to: \(waterNeeds)") // When no ET values
                        }
                    }
                } catch {
                    print("Error parsing JSON: \(error)") // On JSON parsing error
                }
            case .failure(let error):
                print("Error during API request: \(error)") // On API request failure
            }
        }
    }
}

