import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var nationalID = "200073"
    @State private var password = "majd2003"
    @State private var showError = false

    var body: some View {
        NavigationView { // تأكد من أن NavigationView يحيط بـ VStack
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

                Button(action: {
                    // تحقق من بيانات الاعتماد
                    if nationalID == "200073" && password == "majd2003" {
                        isLoggedIn = true // تغيير الحالة إلى logged in
                    } else {
                        showError = true // عرض خطأ في حالة فشل تسجيل الدخول
                    }
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showError) {
                    Alert(title: Text("Error"), message: Text("Invalid credentials"), dismissButton: .default(Text("OK")))
                }

                // زر لإنشاء حساب جديد
                NavigationLink(destination: SignUpView()) { // ربط الزر بصفحة SignUpView
                    Text("Create Account")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                .padding(.top) // إضافة Padding أعلى الزر

                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false))
}
