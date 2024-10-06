import SwiftUI

struct NextPageView: View {
    var ownedLands: [(landID: String, cropType: String)] // البيانات الممررة من الصفحة السابقة

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
                    }
                }

                Spacer()
            }
            .navigationBarTitle("Lands Information", displayMode: .inline)
            .padding()
        }
    }
}

#Preview {
    NextPageView(ownedLands: [("12345", "Wheat"), ("67890", "Corn")])
}
