import SwiftUI

struct FarmDetailsView: View {
    @Binding var ownedLands: [(landID: String, cropType: String, numberOfCropsString: String)]

    @State private var landID = "12345"
    @State private var cropType = "Apples"
    @State private var numberOfCropsString = "1" // Use a string for input

    var body: some View {
        VStack(spacing: 20) {
            Text("Tell Us About Your Farm")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.green)
                .multilineTextAlignment(.center)
                .padding(.top, 50)

            VStack(alignment: .leading, spacing: 15) {
                Text("Land ID:")
                    .font(.headline)
                    .foregroundColor(.green)
                TextField("Enter Land ID", text: $landID)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .keyboardType(.numberPad)

                Text("Crop Type:")
                    .font(.headline)
                    .foregroundColor(.green)
                TextField("Enter Crop Type", text: $cropType)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)

                Text("Number Of Crops:")
                    .font(.headline)
                    .foregroundColor(.green)
                TextField("Enter Number Of Crops", text: $numberOfCropsString)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .keyboardType(.numberPad)
                    .onChange(of: numberOfCropsString) { newValue in
                        // Validate and update the number of crops
                        if let intValue = Int(newValue) {
                            // If it's a valid integer, you can use it as needed
                            // For now, just printing it to the console
                            print("Valid number of crops: \(intValue)")
                        } else {
                            // Handle invalid input if necessary
                            print("Invalid number of crops")
                        }
                    }
            }
            .padding(.horizontal)

            Button(action: {
                if !landID.isEmpty && !cropType.isEmpty && !numberOfCropsString.isEmpty{
                    // Here you might want to convert numberOfCropsString to an integer
                    ownedLands.append((landID: landID, cropType: cropType, numberOfCropsString: numberOfCropsString))
                    landID = ""
                    cropType = ""
                    numberOfCropsString = "" // Reset the string input
                }
            }) {
                Text("Add")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.top)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    FarmDetailsView(ownedLands: .constant([]))
}
