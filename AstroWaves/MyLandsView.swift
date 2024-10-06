import SwiftUI

struct MyLandsView: View {
    @Binding var ownedLands: [(landID: String, cropType: String)]

    var body: some View {
        VStack(spacing: 20) {
            Text("Your Added Lands")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.green)
                .padding()

            List(ownedLands, id: \.landID) { land in
                // إضافة NavigationLink لربط كل أرض بصفحة WaterNeedsView
                NavigationLink(destination: WaterNeedsView(landID: land.landID, cropType: land.cropType)) {
                    VStack(alignment: .leading) {
                        Text("Land ID: \(land.landID)")
                            .font(.subheadline)
                        Text("Crop Type: \(land.cropType)")
                            .font(.subheadline)
                    }
                }
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    MyLandsView(ownedLands: .constant([("12345", "Wheat"), ("67890", "Corn")]))
}
