import SwiftUI

struct NextPageView: View {
    var ownedLands: [(landID: String, cropType: String, numberOfCropsString: String)] // البيانات الممررة من الصفحة السابقة

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Your Added Lands")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .padding()

                // عرض قائمة الأراضي المضافة
                List(ownedLands, id: \.landID) { land in
                    VStack(alignment: .leading) {
                        Text("Land ID: \(land.landID)")
                            .font(.subheadline)
                        Text("Crop Type: \(land.cropType)")
                            .font(.subheadline)
                        Text("Number Of Crops: \(land.numberOfCropsString)")
                            .font(.subheadline)
                    }
                }

                Spacer()
            }
            .navigationBarTitle("Lands Information", displayMode: .inline)
            .padding()
        }
    }
}
