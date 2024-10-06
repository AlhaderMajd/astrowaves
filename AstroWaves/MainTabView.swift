import SwiftUI

struct MainTabView: View {
    @State private var ownedLands: [(landID: String, cropType: String, numberOfCropsString: String)] = []

    var body: some View {
        TabView {
            FarmDetailsView(ownedLands: $ownedLands)
                .tabItem {
                    Image(systemName: "leaf.fill")
                    Text("Farm Details")
                }

            MyLandsView(ownedLands: $ownedLands)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("My Lands")
                }
        }
    }
}

#Preview {
    MainTabView()
}
