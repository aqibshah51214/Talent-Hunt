//
//  AddCommitteeMemeberView.swift
//  Talent-Hunt
//
//  Created by MacBook Pro on 15/04/2025.
//

import SwiftUI

struct AddCommitteeMemeberView: View {
    
     @State private var email = ""
     @State private var name = ""
     @State private var password = ""
     @State private var confirmpassword = ""
     @State private var navigateToLogin = false
     
     @State private var contactImage: UIImage? = nil
     @State private var isImagePickerPresented: Bool = false
     @State private var nameError = ""
     @State private var emailError = ""
     @State private var passwordError = ""
   //  @State public var role=["Admin","Student","Committee"]
     @State public var Gender=["Male","Female"]
     @State public var  SelectGender="Male"
     @State public var SelectedRoleOption="Committee"
     var body: some View {
         ZStack {
 //            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.1), Color.white.opacity(0.1)]),
 //                           startPoint: .topLeading,
 //                           endPoint: .bottomTrailing)
 //                .ignoresSafeArea()
             
         
             VStack {
                 Text("Add Committee")
                    // .font(.system(size: 35))
                     //.foregroundColor(.black)
                     .bold()
                     .shadow(radius: 5)
                    // .padding(.bottom, 20)
                    // .offset(x:10, y: -100)
                     .padding()
                 
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
//                 DropDownView(options:role, selectedOption:$SelectedRoleOption)
//                     .offset(x:0,y:1)
//                     .padding()
                 DropDownView(options:Gender, selectedOption:$SelectGender)
                     .offset(x:0,y:-9)
                     .padding()
                 VStack {
                     if let image = contactImage {
                         Image(uiImage: image)
                             .resizable()
                             .scaledToFit()
                             .frame(height: 200)
                     } else {
                         Text("No Image Selected")
                             .foregroundColor(.black)
                     }
                     Button(action: {
                         isImagePickerPresented = true
                     }) {
                         HStack {
                             Image(systemName: "photo")
                             Text("Select Image").bold()
                         }
                        // .padding()
    //                            .background(Color.blue.opacity(0.8))
    //                            .foregroundColor(.white)
    //                            .cornerRadius(12)
                     }
                 }.sheet(isPresented: $isImagePickerPresented) {
                     CustomImagePicker(contactImage: $contactImage)
                        }
                 // Sign Up Button
                 Button(action: {
                      
                         AddMember()
                 }) {
                     Text("Add")
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
                
                // Spacer()
               
             }
            // .frame(maxHeight: 890, alignment: .center)
     
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
    func AddMember(){
    if emailError.isEmpty && passwordError.isEmpty && password == confirmpassword {
        let account = Addcommittee(Name: name, Email: email, Password: password, UserId:0, Gender: SelectGender, Role: SelectedRoleOption, Image: nil)
        do {
            // Encode the event to JSON
            let jsonData = try JSONEncoder().encode(account)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print("JSON Sent to API: \(jsonString ?? "Invalid JSON")")
            
            // Prepare parameters for the API call
            var params = [String: String]()
            params["submitInfo"] = jsonString!
            
            let api = APIHelper()
            
            if let contactImage = contactImage {
                // Create a media image object
                let mediaImage = Media(withImage: contactImage, forKey: "image", imageName: "event.jpg")
                var images = [Media]()
                images.append(mediaImage!)
                
                // Upload images and handle the response
                api.uploadImages(images: images, parameters: params, endPoint: "Main/AddCommitteeMember") { response in
                    // Handle the response inside the closure
                    let responseMessage = response.responseMessage
                    print("Response Message: \(responseMessage)")
                    
                    // Decode the response data if needed
//                    if let responseData = response.responseData {
//                        do {
//
//                            let events = try JSONDecoder().decode(EventCreate.self, from: responseData)
//                            print("Decoded events: \(events)")
//
//                            AddRules(eventid: events.Id, list: listofrules)
//
//
//                            // Perform any additional actions with the decoded data
//                            // For example, update the UI or save the data
//                        } catch {
//                            print("Failed to decode response data: \(error)")
//                        }
//                    }
                    
                    // Show success alert
//                    DispatchQueue.main.async {
//                        showSuccessAlert.toggle()
//                    }
                }
            }
        } catch {
            print("Error encoding event: \(error)")
        }
    }
             
}
}
struct AddCommitteeMemeberView_Previews: PreviewProvider {
    static var previews: some View {
        AddCommitteeMemeberView()
    }
}
