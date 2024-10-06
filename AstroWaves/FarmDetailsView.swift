import SwiftUI

struct FarmDetailsView: View {
    @Binding var ownedLands: [(landID: String, cropType: String)]

    @State private var landID = ""
    @State private var cropType = ""

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
            }
            .padding(.horizontal)

            Button(action: {
                if !landID.isEmpty && !cropType.isEmpty {
                    ownedLands.append((landID: landID, cropType: cropType))
                    landID = ""
                    cropType = ""
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
