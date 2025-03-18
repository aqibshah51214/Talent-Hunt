import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var navigateToAdmin = false
    @State private var isUserValid: Bool = false

    @State private var signuplist = [CraeteAccount]()

    var body: some View {
        
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(1.2), Color.purple.opacity(0.9)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 25) {
                    Text("Welcome Back!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    // Email Input Field
                    VStack(alignment: .leading) {
                        Text("Email")
                            .font(.headline)
                            .foregroundColor(.white)

                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.gray)
                            TextField("Enter your email", text: $email)
                                .padding(.vertical,12)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                
                        }
                        .padding(.horizontal)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.9)))
                        .shadow(radius: 3)
                    }
                    .padding(.horizontal)

                    // Password Input Field
                    VStack(alignment: .leading) {
                        Text("Password")
                            .font(.headline)
                            .foregroundColor(.white)

                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.gray)
                            SecureField("Enter your password", text: $password)
                                .padding(.vertical,12)  // **Reduced padding to decrease height**
                                  }
                                  .padding(.horizontal)
                                  .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.9)))
                                  .shadow(radius: 3)
                    }
                    .padding(.horizontal)

                    // Login Button
                    Button(action: {
                        if getdata(email: email, password: password) {
                            navigateToAdmin.toggle()
                            
                        }
                    }) {
                        Text("Login")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 355, height: 50)
                            .background(Color.blue)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }
                    .padding(.top, 10)

                    // Forgot Password
                    Button(action: {
                        print("Forgot Password tapped")
                    }) {
                        Text("Forgot Password?")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                    }

                    // Navigation Link (Hidden)
                    NavigationLink(destination: AdminDashboardView(), isActive: $navigateToAdmin)
                    {
                        EmptyView()
                    }
                }
               // .padding()
            }
    
            .onAppear {
                fetchUsers()  // **Load users when screen appears**
            }
            
        
    }

    // Fetch users from API when the view appears
    func fetchUsers() {
        let api = APIHelper()
        api.getMethodCall(controllerName: "Main", actionName: "getUser") { response in
            if response.responseCode == 200, let data = response.responseData {
                do {
                    signuplist = try JSONDecoder().decode([CraeteAccount].self, from: data)
                    print("Users Loaded: \(signuplist)")
                } catch {
                    print("Decoding Error: \(error.localizedDescription)")
                }
            } else {
                print("Failed to fetch users")
            }
        }
    }

    // Validate user login
    func getdata(email: String, password: String) -> Bool {
        let filteredUser = signuplist.filter { $0.Email == email && $0.Password == password }
        isUserValid = !filteredUser.isEmpty
        return isUserValid
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
