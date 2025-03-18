import SwiftUI

struct AccountView: View {
    @State private var navigateToSignUp = false
    @State private var navigateToLogin = false

    var body: some View {
        NavigationView {
            ZStack {
                // Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(1.2), Color.purple.opacity(0.9)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    // Logo or Image
                    Image("createaccount")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 200)
                        .cornerRadius(10)
                        .shadow(radius: 5)

                    // App Title
                    VStack(spacing: 8) {
                        Text("Welcome To")
                            .font(.title2)
                            .foregroundColor(.white) // Changed to white for better contrast
                        Text("Talent Hunt")
                            .font(.largeTitle)
                            .italic()
                            .fontWeight(.bold)
                            .foregroundColor(.white) // Changed to white for better contrast
                            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 0)
                    }

                    // Description Text
                    Text("Every talent has a moment to shine in the hunt for success. The best talent is hidden, waiting to be found in the hunt.")
                        .font(.body)
                        .foregroundColor(.white) // Changed to white for better contrast
                        .italic()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding()
                        .padding()
                   // Spacer()

                    // Buttons
                    VStack(spacing: 16) {
                        // Create Account Button
                        Button(action: {
                            navigateToSignUp = true
                        }) {
                            Text("Create an Account")
                                .font(.headline)
                                .bold()
                                .foregroundColor(.white)
                                .frame(maxWidth: 300, maxHeight: 55)
                                .background(Color.blue.opacity(0.9))
                                .cornerRadius(10)
                                .shadow(color: .blue.opacity(0.5), radius: 5, x: 0, y: 2)
                        }

                        // Login Button
                        Button(action: {
                            navigateToLogin = true
                        }) {
                            Text("Login")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(maxWidth: 300, maxHeight: 55)
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue, lineWidth: 3)
                                )
                                .cornerRadius(10)
                        }
                    }
                    .padding(.bottom, 40)
                }
                .padding()

                // Navigation Links
                NavigationLink(destination: SignUPView(), isActive: $navigateToSignUp) {
                    EmptyView()
                }
                NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
                    EmptyView()
                }
            }
            .navigationBarHidden(true) // Hide navigation bar for a cleaner look
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
