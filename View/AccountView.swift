import SwiftUI

struct AccountView: View {
    @State private var navigateToSignUp = false
    @State private var navigateToLogin = false
    var Detail="Every talent has a moment to shine in the hunt for success. The best talent is hidden, waiting to be found in the hunt."
    var body: some View {
        NavigationView {
          
            GeometryReader { geometry in
                ZStack {
                    // Background Gradient (optional)
//                    LinearGradient(
//                        gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.5)]),
//                        startPoint: .topLeading,
//                        endPoint: .bottomTrailing
//                    )
                   // .ignoresSafeArea()

                    VStack(spacing: 20) {
                        // Logo or Image
                        
                        Image("projectimage2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.6)
                            .cornerRadius(10)
                            //.shadow(radius: 5)
                            //.padding(.top,100)
                        // App Title
                        VStack(spacing: 8) {
                            Text("Welcome To")
                                .font(.title2)
                                .foregroundColor(.black)

                            Text("Talent Hunt")
                                .font(.largeTitle)
                                .italic()
                                .bold()
                                .foregroundColor(.black)
                                .shadow(color: .black.opacity(0.3), radius: 5)
                        }.padding(.top,-120)

                        // Description
                        Text(Detail)
                            .foregroundColor(.gray)
                            .italic()
                            .multilineTextAlignment(.center) // allow center alignment
                            .frame(width: geometry.size.width * 0.8) // limit width to 80% of screen
                           // .padding()
  
                      //  Spacer()

                        // Buttons
                        VStack(spacing:0) {
                            // Create Account Button
                            Button(action: {
                                navigateToSignUp = true
                            }) {
                                Text("Create an Account")
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(width: geometry.size.width * 0.7, height: 55)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .shadow(color: .blue.opacity(0.5), radius: 5)
                            }
                            .padding()
                            // Login Button
                            Button(action: {
                                navigateToLogin = true
                            }) {
                                Text("Login")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                    .frame(width: geometry.size.width * 0.7, height: 55)
                                    .background(Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.blue, lineWidth: 2)
                                    )
                                    .cornerRadius(10)
                            }
                        }
                       // .padding(.bottom, 30)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }

                // Navigation Links
                .background(
                    NavigationLink(destination: SignUPView(), isActive: $navigateToSignUp) {
                        EmptyView()
                    }
                )
                .background(
                    NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
                        EmptyView()
                    }
                )
            
            }
            .navigationBarHidden(true)
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
//        Group {
//            AccountView()
//                .previewDevice("iPhone 14 Pro")
//            AccountView()
//                .previewDevice("iPhone SE (3rd generation)")
//            AccountView()
//                .previewDevice("iPad Pro (11-inch) (5th generation)")
//        }
        AccountView()
    }
}
