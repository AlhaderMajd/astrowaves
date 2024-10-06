import SwiftUI

struct ContentView: View {
    @State private var nationalID = "200073"
    @State private var password = "majd2003"
    @State private var isSignUp = false
    @State private var showError = false

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Image(systemName: "leaf.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.green)
                    .padding(.top, 50)

                Text("Welcome to AstroWaves")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.green)

                Text("Smart Agricultural Solutions")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                VStack(alignment: .leading, spacing: 15) {
                    Text("National ID:")
                        .font(.headline)
                    TextField("Enter National ID", text: $nationalID)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .keyboardType(.numberPad)

                    Text("Password:")
                        .font(.headline)
                    SecureField("Enter Password", text: $password)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                // Login Button
                NavigationLink(destination: MainTabView()) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .cornerRadius(10)
                }

                Button(action: {
                    isSignUp.toggle()
                }) {
                    Text("Create Account")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                .sheet(isPresented: $isSignUp) {
                    SignUpView()
                }

                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .alert(isPresented: $showError) {
                Alert(title: Text("Error"), message: Text("Invalid credentials"), dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    ContentView()
}
