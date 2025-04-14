import SwiftUI

struct SignUPView: View {
    @State private var email = ""
    @State private var name = ""
    @State private var password = ""
    @State private var confirmpassword = ""
    @State private var navigateToLogin = false
    
 
    @State private var nameError = ""
    @State private var emailError = ""
    @State private var passwordError = ""
    @State public var role=["Admin","Student","Committee"]
    @State public var selectedOption="Select"
    var body: some View {
        ZStack {
//            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.1), Color.white.opacity(0.1)]),
//                           startPoint: .topLeading,
//                           endPoint: .bottomTrailing)
//                .ignoresSafeArea()
            
        
            VStack {
                Text("Create Account")
                    .font(.system(size: 35))
                    .foregroundColor(.black)
                    .bold()
                    .shadow(radius: 5)
                    .padding(.bottom, 20)
                    .offset(x:10, y: -100)
                    .padding(.horizontal, 50)
                
                VStack(spacing: 20) {
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.black)
                        TextField("Name", text: $name)
                            .disableAutocorrection(true)
                            .onChange(of: email) { newValue in
                                nameError = isValidName(newValue) ? "" : "Invalid email format"
                            }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .shadow(radius: 3)
                    
                    if !emailError.isEmpty {
                        Text(emailError)
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.leading, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    // Email Field with Validation
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.black)
                        TextField("Email", text: $email)
                            .disableAutocorrection(true)
                            .onChange(of: email) { newValue in
                                emailError = isValidEmail(newValue) ? "" : "Invalid email format"
                            }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .shadow(radius: 3)
                    
                    if !emailError.isEmpty {
                        Text(emailError)
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.leading, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    // Password Field with Validation
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.black)
                        SecureField("Password", text: $password)
                            .disableAutocorrection(true)
                            .onChange(of: password) { newValue in
                                passwordError = isValidPassword(newValue) ? "" : "Password must be 8+ characters with 1 uppercase, 1 number"
                            }
                    }
                  
                    
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .shadow(radius: 3)
                    
                    if !passwordError.isEmpty {
                        Text(passwordError)
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.leading, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    // Confirm Password Field
                    HStack {
                        Image(systemName: "key")
                            .foregroundColor(.black)
                        SecureField("Confirm Password", text: $confirmpassword)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .shadow(radius: 3)
                }
                .padding(.horizontal, 25)
                DropDownView(options:role, selectedOption:$selectedOption)
                    .offset(x:0,y:1)
                    .padding()
               
                // Sign Up Button
                Button(action: {
                    print("Selected Role: \(selectedOption)")
                    if emailError.isEmpty && passwordError.isEmpty && password == confirmpassword {
                        let account = CraeteAccount(Id: 1, Password: password, Name: name, Email: email, Role: selectedOption)
                        do {
                            let jsonData = try JSONEncoder().encode(account)
                            let jsonString = String(data: jsonData, encoding: .utf8)
                            print("JSON Sent to API: \(jsonString!)")  // Debugging log
                         

                                let api = APIHelper()
                                
                                api.postMethodCall(controllerName: "Main", actionName: "AddUser", httpBody: jsonData) { response in
                                   
                                        if response.responseCode == 200 {
                                            print("Signup Successful: \(response.responseMessage)")
                                            withAnimation{
                                            navigateToLogin = true
                                            }
                                        } else {
                                            print("Signup Failed: \(response.responseMessage)")
                                        }
                                    
                                }
                            } catch {
                                print("Error encoding contact: \(error.localizedDescription)")
                            }
                   
                    }
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 25)
                .padding(.top, 20)
                .disabled(!emailError.isEmpty || !passwordError.isEmpty || password != confirmpassword)
                
                // Already Have an Account?
                HStack {
                    Text("Already have an account...?")
                        .foregroundColor(.black)
                    //Spacer()
                    Button(action: {
                        withAnimation{
                        navigateToLogin = true
                            
                        }
                    }, label: {
                        Text("Login")
                            .foregroundColor(.green)
                    })
                       
                 }
                .padding(.top, 10)
                
                Spacer()
              
            }
            .frame(maxHeight: 890, alignment: .center)
            
            // Navigation Link to Login
            
            NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
                EmptyView()
            }
            
        
            
        }
    }
    
    // Regex Validation Functions
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = #"^(?=.*[A-Z])(?=.*\d).{8,}$"#
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    func isValidName(_ name: String) -> Bool {
        let nameRegex = #"^[A-Za-z]+$"#
        return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: name)
    }

}

// Preview
struct SignUPView_Previews: PreviewProvider {
    static var previews: some View {
           
            SignUPView()
        
       // .previewInterfaceOrientation(.portrait)
    }
}
