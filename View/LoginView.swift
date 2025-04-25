import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var navigateToAdmin = false
    @State private var navigateToCommittee = false
    @State private var signuplist = [CraeteAccount]()
    @State private var id: Int = 0

    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                Text("Welcome Back!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                // Email Input Field
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.headline)
                        .foregroundColor(.black)
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.black)
                        TextField("Enter your email", text: $email)
                            .padding(.vertical, 12)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .shadow(radius: 3)
                }
                .padding(.horizontal)

                // Password Input Field
                VStack(alignment: .leading) {
                    Text("Password")
                        .font(.headline)
                        .foregroundColor(.black)
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.black)
                        SecureField("Enter your password", text: $password)
                            .padding(.vertical, 12)
                    }
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .shadow(radius: 3)
                }
                .padding(.horizontal)

                // Login Button
                Button(action: {
                    let value = getdata(email: email, password: password)
                    if let user = value.first {
                        id = user.Id ?? 0
                        if user.Role == "Committee" {
                            navigateToCommittee = true
                        } else {
                            navigateToAdmin = true
                        }
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
                        .foregroundColor(.gray)
                }

                // Hidden Navigation Links
                NavigationLink(destination: AdminDashboardView(), isActive: $navigateToAdmin) {
                    EmptyView()
                }
                NavigationLink(destination: RequestListView(userId: $id), isActive: $navigateToCommittee) {
                    EmptyView()
                }
            }
            .onAppear {
                fetchUsers()
            }
        }
    }

    // Fetch users from API
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
    func getdata(email: String, password: String) -> [CraeteAccount] {
        signuplist.filter { $0.Email == email && $0.Password == password }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
     }
}
