////import SwiftUI
////
////struct textView: View {
////    @State private var searchQuery = ""
////
////    var body: some View {
////        VStack {
////            HStack {
////                TextField("Search Events", text: $searchQuery)
////                    .padding(10)
////                    .background(Color(.systemGray6))
////                    .cornerRadius(8)
////                    .submitLabel(.done)
////                    .keyboardType(.default)
////
////                Image(systemName: "magnifyingglass")
////                    .foregroundColor(.gray)
////            }
////            .padding()
////
////            Spacer()
////        }
////        .background(Color.white)
////        .onTapGesture {
////            hideKeyboard()
////        }
////    }
////
////    private func hideKeyboard() {
////        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
////                                        to: nil, from: nil, for: nil)
////    }
////}
////
////struct textView_Previews: PreviewProvider {
////    static var previews: some View {
////        textView()
////    }
////}
//import SwiftUI
//
//struct LoginView1: View {
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var isPasswordVisible: Bool = false
//    @State private var isCustomerLogin = true
//    @State private var showDashboard = false
//    @State private var errorMessage = ""
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack {
//                    Spacer()
//
//                    VStack(spacing: 20) {
//                        Text("Hazir")
//                            .bold()
//                            .font(.system(size: 45))
//                            .foregroundColor(.green)
//                        Text("Service")
//                            .bold()
//                            .font(.system(size: 25))
//                            .foregroundColor(.green)
//                    }
//                    .padding(.horizontal)
//
//                    VStack {
//                        VStack(spacing: 16) {
//                            VStack(alignment: .leading, spacing: 8) {
//                                Text("Email")
//                                    .bold()
//                                    .foregroundColor(.black)
//                                HStack {
//                                    Image(systemName: "person.fill")
//                                    TextField("Enter your email", text: $email)
//                                        .keyboardType(.emailAddress)
//                                        .autocapitalization(.none)
//                                }
//                                .padding(.horizontal)
//                                .frame(height: 44)
//                                .background(.white)
//                                .cornerRadius(8)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .stroke(.gray, lineWidth: 1)
//                                )
//                            }
//
//                            VStack(alignment: .leading, spacing: 8) {
//                                Text("Password")
//                                    .bold()
//                                    .foregroundColor(.black)
//                                HStack {
//                                    // Lock icon
//                                    Image(systemName: "lock")
//                                        .foregroundColor(.gray)
//
//                                    // Dynamic field - hidden by default
//                                    if isPasswordVisible {
//                                        TextField("Enter password", text: $password)
//                                    } else {
//                                        SecureField("Enter password", text: $password)
//                                    }
//                            Button {
//                                        withAnimation {
//                                            isPasswordVisible.toggle()
//                                        }
//                                    } label: {
//                                        Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
//                                            .foregroundColor(.gray)
//                                    }
//                                }
//                                .padding(.horizontal)
//                                .frame(height: 44)
//                                .background(.white)
//                                .cornerRadius(8)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .stroke(.gray, lineWidth: 1)
//                                )
//                            }
//                        }
//                        .padding()
//                        .background(Color(.systemGray6))
//                        .cornerRadius(15)
//                        .shadow(radius: 5)
//                        .padding(.horizontal)
//
//                        Spacer()
//
//                        // Login Button
//                        Button(action: {
//                            guard !email.isEmpty, !password.isEmpty else {
//                                errorMessage = "Please enter both email and password."
//                                return
//                            }
//
//                            let api = AuthAPIHelper()
//                            api.loginUser(email: email, password: password, isCustomer: isCustomerLogin) { result in
//                                DispatchQueue.main.async {
//                                    switch result {
//                                    case .success(let response):
//                                        if response.success {
//                                            errorMessage = ""
//                                            showDashboard = true
//                                        } else {
//                                            errorMessage = response.message
//                                        }
//                                    case .failure(let error):
//                                        errorMessage = "Login failed: \(error.localizedDescription)"
//                                    }
//                                }
//                            }
//                        }) {
//                            Text("Login")
//                                .bold()
//                                .frame(width: 250, height: 44)
//                                .background(Color.green)
//                                .foregroundColor(.white)
//                                .cornerRadius(10)
//                        }
//                        .padding()
//
//                        .padding()
//
//                        .padding()
//
//                        if !errorMessage.isEmpty {
//                            Text(errorMessage)
//                                .foregroundColor(.red)
//                                .padding(.horizontal)
//                        }
//                        Picker("Login Type", selection: $isCustomerLogin) {
//                        Text("Customer").tag(false)
//                        Text("Courier").tag(false)
//                        }
////                        .pickerStyle(SegmentedPickerStyle())
////                        .padding(.horizontal, 40)
////                        .padding(.bottom, 20)
//
//                        Text("Don't have an Account?")
//
//                        VStack(spacing: 10) {
//                            NavigationLink(destination: CSignupView()) {
//                                Text("Signup as Courier")
//                                    .foregroundColor(.green)
//                                    .frame(maxWidth: .infinity)
//                            }
//
//                            Text("OR")
//       NavigationLink(destination: SignupView()) {
//                                Text("Signup as Customer")
//                                    .foregroundColor(.green)
//                                    .frame(maxWidth: .infinity)
//                            }
//                        }
//                        .padding(.horizontal, 40)
//
//                        // Navigation Trigger
//                        NavigationLink(
//                            destination: isCustomerLogin ? AnyView(CuDashView()) : AnyView(CDashView()),
//                            isActive: $showDashboard
//                        ) {
//                            EmptyView()
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Login")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//
////    private func login() {
////        if isCustomerLogin {
////           // AuthService.shared.loginCustomer(email: email, password: password) { result in
////               // DispatchQueue.main.async {
////                 //   switch result {
//////                    case .success(let response):
//////                        if response.success {
//////                            showDashboard = true
//////                        } else {
//////                            errorMessage = response.message
//////                        }
//////                    case .failure(let error):
//////                        errorMessage = error.localizedDescription
//////                    }
//////                }
//////            }
//////        } else {
//////            // Add courier login API logic here when available
//////            errorMesvsage = "Courier login not implemented."
////        }
//}
//struct LoginView1_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView1()
//    }
//}
//
