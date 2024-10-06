import SwiftUI

struct WaterNeedsView: View {
    @State var landID: String
    @State var cropType: String
    @State var waterNeeds = 0.0

    var body: some View {
        VStack(spacing: 20) {
            Text("Water Needs for \(cropType)")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)

            Text("Land ID: \(landID)")
            Text("Estimated Water Needs: \(waterNeeds, specifier: "%.2f") liters/day")
        }
        .padding()
        .onAppear {
            calculateWaterNeeds()
        }
    }

    func calculateWaterNeeds() {
        let apiRequest = APIRequest()
        print("Sending API request...") // Before sending the request

        apiRequest.sendRequest { result in
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

#Preview {
    WaterNeedsView(landID: "12345", cropType: "Wheat")
}
