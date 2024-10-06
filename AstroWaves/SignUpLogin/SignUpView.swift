import SwiftUI

struct SignUpView: View {
    @State private var nationalID = ""
    @State private var showConfirmation = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle)
                .bold()

            TextField("Enter National ID", text: $nationalID)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.numberPad)

            Button(action: sendSMS) {
                Text("Send SMS")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .alert(isPresented: $showConfirmation) {
                Alert(title: Text("SMS Sent"), message: Text("A password has been sent to your phone."), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }

    func sendSMS() {
        if !nationalID.isEmpty {
            showConfirmation = true
        }
    }
}

#Preview {
    SignUpView()
}
