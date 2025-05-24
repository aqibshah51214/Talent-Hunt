//////import SwiftUI
//////
//////struct textView: View {
//////    @State private var searchQuery = ""
//////
//////    var body: some View {
//////        VStack {
//////            HStack {
//////                TextField("Search Events", text: $searchQuery)
//////                    .padding(10)
//////                    .background(Color(.systemGray6))
//////                    .cornerRadius(8)
//////                    .submitLabel(.done)
//////                    .keyboardType(.default)
//////
//////                Image(systemName: "magnifyingglass")
//////                    .foregroundColor(.gray)
//////            }
//////            .padding()
//////
//////            Spacer()
//////        }
//////        .background(Color.white)
//////        .onTapGesture {
//////            hideKeyboard()
//////        }
//////    }
//////
//////    private func hideKeyboard() {
//////        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
//////                                        to: nil, from: nil, for: nil)
//////    }
//////}
//////
//////struct textView_Previews: PreviewProvider {
//////    static var previews: some View {
//////        textView()
//////    }
//////}
////import SwiftUI
////
////struct LoginView1: View {
////    @State private var email: String = ""
////    @State private var password: String = ""
////    @State private var isPasswordVisible: Bool = false
////    @State private var isCustomerLogin = true
////    @State private var showDashboard = false
////    @State private var errorMessage = ""
////
////    var body: some View {
////        NavigationView {
////            ScrollView {
////                VStack {
////                    Spacer()
////
////                    VStack(spacing: 20) {
////                        Text("Hazir")
////                            .bold()
////                            .font(.system(size: 45))
////                            .foregroundColor(.green)
////                        Text("Service")
////                            .bold()
////                            .font(.system(size: 25))
////                            .foregroundColor(.green)
////                    }
////                    .padding(.horizontal)
////
////                    VStack {
////                        VStack(spacing: 16) {
////                            VStack(alignment: .leading, spacing: 8) {
////                                Text("Email")
////                                    .bold()
////                                    .foregroundColor(.black)
////                                HStack {
////                                    Image(systemName: "person.fill")
////                                    TextField("Enter your email", text: $email)
////                                        .keyboardType(.emailAddress)
////                                        .autocapitalization(.none)
////                                }
////                                .padding(.horizontal)
////                                .frame(height: 44)
////                                .background(.white)
////                                .cornerRadius(8)
////                                .overlay(
////                                    RoundedRectangle(cornerRadius: 8)
////                                        .stroke(.gray, lineWidth: 1)
////                                )
////                            }
////
////                            VStack(alignment: .leading, spacing: 8) {
////                                Text("Password")
////                                    .bold()
////                                    .foregroundColor(.black)
////                                HStack {
////                                    // Lock icon
////                                    Image(systemName: "lock")
////                                        .foregroundColor(.gray)
////
////                                    // Dynamic field - hidden by default
////                                    if isPasswordVisible {
////                                        TextField("Enter password", text: $password)
////                                    } else {
////                                        SecureField("Enter password", text: $password)
////                                    }
////                            Button {
////                                        withAnimation {
////                                            isPasswordVisible.toggle()
////                                        }
////                                    } label: {
////                                        Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
////                                            .foregroundColor(.gray)
////                                    }
////                                }
////                                .padding(.horizontal)
////                                .frame(height: 44)
////                                .background(.white)
////                                .cornerRadius(8)
////                                .overlay(
////                                    RoundedRectangle(cornerRadius: 8)
////                                        .stroke(.gray, lineWidth: 1)
////                                )
////                            }
////                        }
////                        .padding()
////                        .background(Color(.systemGray6))
////                        .cornerRadius(15)
////                        .shadow(radius: 5)
////                        .padding(.horizontal)
////
////                        Spacer()
////
////                        // Login Button
////                        Button(action: {
////                            guard !email.isEmpty, !password.isEmpty else {
////                                errorMessage = "Please enter both email and password."
////                                return
////                            }
////
////                            let api = AuthAPIHelper()
////                            api.loginUser(email: email, password: password, isCustomer: isCustomerLogin) { result in
////                                DispatchQueue.main.async {
////                                    switch result {
////                                    case .success(let response):
////                                        if response.success {
////                                            errorMessage = ""
////                                            showDashboard = true
////                                        } else {
////                                            errorMessage = response.message
////                                        }
////                                    case .failure(let error):
////                                        errorMessage = "Login failed: \(error.localizedDescription)"
////                                    }
////                                }
////                            }
////                        }) {
////                            Text("Login")
////                                .bold()
////                                .frame(width: 250, height: 44)
////                                .background(Color.green)
////                                .foregroundColor(.white)
////                                .cornerRadius(10)
////                        }
////                        .padding()
////
////                        .padding()
////
////                        .padding()
////
////                        if !errorMessage.isEmpty {
////                            Text(errorMessage)
////                                .foregroundColor(.red)
////                                .padding(.horizontal)
////                        }
////                        Picker("Login Type", selection: $isCustomerLogin) {
////                        Text("Customer").tag(false)
////                        Text("Courier").tag(false)
////                        }
//////                        .pickerStyle(SegmentedPickerStyle())
//////                        .padding(.horizontal, 40)
//////                        .padding(.bottom, 20)
////
////                        Text("Don't have an Account?")
////
////                        VStack(spacing: 10) {
////                            NavigationLink(destination: CSignupView()) {
////                                Text("Signup as Courier")
////                                    .foregroundColor(.green)
////                                    .frame(maxWidth: .infinity)
////                            }
////
////                            Text("OR")
////       NavigationLink(destination: SignupView()) {
////                                Text("Signup as Customer")
////                                    .foregroundColor(.green)
////                                    .frame(maxWidth: .infinity)
////                            }
////                        }
////                        .padding(.horizontal, 40)
////
////                        // Navigation Trigger
////                        NavigationLink(
////                            destination: isCustomerLogin ? AnyView(CuDashView()) : AnyView(CDashView()),
////                            isActive: $showDashboard
////                        ) {
////                            EmptyView()
////                        }
////                    }
////                }
////            }
////            .navigationTitle("Login")
////            .navigationBarTitleDisplayMode(.inline)
////        }
////    }
////
//////    private func login() {
//////        if isCustomerLogin {
//////           // AuthService.shared.loginCustomer(email: email, password: password) { result in
//////               // DispatchQueue.main.async {
//////                 //   switch result {
////////                    case .success(let response):
////////                        if response.success {
////////                            showDashboard = true
////////                        } else {
////////                            errorMessage = response.message
////////                        }
////////                    case .failure(let error):
////////                        errorMessage = error.localizedDescription
////////                    }
////////                }
////////            }
////////        } else {
////////            // Add courier login API logic here when available
////////            errorMesvsage = "Courier login not implemented."
//////        }
////}
////struct LoginView1_Previews: PreviewProvider {
////    static var previews: some View {
////        LoginView1()
////    }
////}
////
////ScrollView(.horizontal, showsIndicators: false) {
////    HStack(spacing: 16) {
////        Button(action: {
////            // All events
////        }) {
////            Text("All")
////                .foregroundColor(Color.black.opacity(0.6))
////                .frame(width: 50, height: 30)
////                .background(Color(.systemGray6))
////                .cornerRadius(10)
////        }
////        Button(action: {
////            // Upcoming
////        }) {
////            Text("UpComing")
////                .foregroundColor(Color.black.opacity(0.6))
////                .frame(width: 100, height: 30)
////                .background(Color(.systemGray6))
////                .cornerRadius(10)
////        }
////        Button(action: {
////            // Expired
////        }) {
////            Text("Expaired")
////                .foregroundColor(Color.black.opacity(0.6))
////                .frame(width: 100, height: 30)
////                .background(Color(.systemGray6))
////                .cornerRadius(10)
////        }
////        Button(action: {
////            navigateToEventCreate.toggle()
////        }) {
////            HStack {
////                Text("AddEvent")
////                Image(systemName: "plus.circle.fill")
////                    .foregroundColor(Color.black.opacity(0.6))
////            }
////            .foregroundColor(Color.black.opacity(0.6))
////            .frame(width: 120, height: 30)
////            .background(Color(.systemGray6))
////            .cornerRadius(10)
////        }
////    }
////    .padding(.horizontal)
////}
////
////  EventCreateView.swift
////  Talent-Hunt
////
////  Created by MacBook Pro on 11/03/2025.
////
//
//import SwiftUI
//
//struct EventCreateView: View {
//    @State private var title = ""
//    @State private var description = ""
//    @State private var navigateToAssignMamber=false
// 
//    @State private var showEventDatePicker = false
//    @State private var selectedEventDate = Date()
//    @State private var contactImage: UIImage? = nil
//    @State private var isImagePickerPresented: Bool = false
//    @State private var listofrules = [String]()
//    // Registration Dates
//    @State private var showRegStartDatePicker = false
//    @State private var regStartDate = Date()
//    @State private var showEventDate = false
//    @State private var EventDate = Date()
//    @State private var showRegEndDatePicker = false
//    @State private var regEndDate = Date()
//    
//    // Event Time
//    @State private var showEventStartTimePicker = false
//    @State private var EventStartTime = Date()
//    @State private var showEventEndTimePicker = false
//    @State private var EventEndTime = Date()
//    
//    @State private var showSuccessAlert = false
//    
//    var body: some View {
//        ZStack {
//            // Background Gradient
////            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
////                .ignoresSafeArea()
//            
//            ScrollView {
//              
//                VStack(spacing: 20) {
//                    Text("Create Event")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .foregroundColor(.black)
//                        .padding(.top, 40)
//
//                    // Title Input Field
//                    VStack(alignment: .leading) {
//                        Text("Event Title")
//                            .font(.headline)
//                            .foregroundColor(.black)
//                        TextField("Enter title", text: $title)
//                            .padding()
//                            .background(Color.white.opacity(4.0))
//                            .cornerRadius(12)
//                           // .border(.gray, width: 1)
//                            .foregroundColor(.black)
//                            .shadow(color:.black.opacity(0.3), radius: 3, x: 1, y: 1)
//                    }
//                  
//                    //  .background(Color.white.opacity(4.0))
//                  
//                    .padding(.horizontal)
//
// 
////
//                    VStack {
//                        DatePickerView(title: "Event Date", date: $EventDate, showDatePicker: $showEventDate)
//                    }
//                    
//                    VStack {
//                        Text("Registration Date")
//                            .font(.headline)
//                            .foregroundColor(.black)
//                            .offset(x: -130, y: -24)
//                        
//                        DatePickerView(title: "Start Date", date: $regStartDate, showDatePicker: $showRegStartDatePicker)
//                        DatePickerView(title: "End Date", date: $regEndDate, showDatePicker: $showRegEndDatePicker)
//                    }
//                    .frame(maxWidth: .infinity)
//                    .background(Color.white.opacity(0.3))
//                    .border(Color.gray, width: 1)
//                    .padding()
//                    
//                    VStack {
//                        Text("Event Time")
//                            .font(.headline)
//                            .foregroundColor(.black)
//                            .offset(x: -153, y: -24)
//                        
//                        TimePickerView(title: "Start Time", date: $EventStartTime, showDatePicker: $showEventStartTimePicker)
//                        TimePickerView(title: "End Time", date: $EventEndTime, showDatePicker: $showEventEndTimePicker)
//                    }
//                    .frame(maxWidth: .infinity)
//                    .background(Color.white.opacity(0.3))
//                    .border(Color.gray, width: 1)
//                    .padding()
//                    VStack(alignment: .leading) {
//                        Text("Description")
//                            .font(.headline)
//                            .foregroundColor(.black)
//                        TextField("Enter description", text: $description)
//                            .padding()
//                            .background(Color.white.opacity(4.0))
//                            .cornerRadius(12)
//                           // .border(.gray, width: 1)
//                            .foregroundColor(.black)
//                            .shadow(color:.black.opacity(0.3), radius: 3, x: 1, y: 1)
//                    }
//                    .padding(.horizontal)
////                    VStack {
////                        if let image = contactImage {
////                            Image(uiImage: image)
////                                .resizable()
////                                .scaledToFit()
////                                .frame(height: 200)
////                        } else {
////                            Text("No Image Selected")
////                                .foregroundColor(.black)
////                        }
////                        Button(action: {
////                            isImagePickerPresented = true
////                        }) {
////                            HStack {
////                                Image(systemName: "photo")
////                                Text("Select Image").bold()
////                            }
////
////                        }
////                    }//.sheet(isPresented: $isImagePickerPresented) {
//                      //  CustomImagePicker(contactImage: $contactImage)
//                          // }
//                   
//                    
////                    // Submit Button
////                    Button(action: {
////                       // AddInListRules()
////                        createEvent()
////
////                    }) {
////                        Text("Create Event")
////                            .font(.title2)
////                            .fontWeight(.bold)
////                            .foregroundColor(.white)
////                            .padding()
////                            .frame(maxWidth: .infinity)
////                            .background(.blue)
////                            .cornerRadius(12)
////                            .shadow(radius: 5)
////                    }
////                    .padding(.horizontal)
////                    .alert(isPresented: $showSuccessAlert) {
////                        Alert(
////                            title: Text("Success"),
////                            message: Text("Your event has been created successfully!"),
////                            dismissButton: .default(Text("OK"))
////                        )
////                    }
////                    .padding(.horizontal)
//
//
//                }
//                Spacer()
//            }
//
//        }
//    }
////
////    private func createEvent() {
////
////        let timeFormatter = DateFormatter()
////           timeFormatter.dateFormat = "HH:mm:ss"
////        let event = EventCreate(
////            Id:nil,
////            Title: title,
////            RegStartDate: dateFormatter.string(from: regStartDate),
////            RegEndDate: dateFormatter.string(from: regEndDate),
////            EventDate: dateFormatter.string(from: EventDate),
////            EventStartTime: timeFormatter.string(from: EventStartTime),
////            EventEndTime: timeFormatter.string(from: EventEndTime),
////            Details: description,
////            Image: nil
////        )
////
////        do {
////            // Encode the event to JSON
////            let jsonData = try JSONEncoder().encode(event)
////            let jsonString = String(data: jsonData, encoding: .utf8)
////            print("JSON Sent to API: \(jsonString ?? "Invalid JSON")")
////
////            // Prepare parameters for the API call
////            var params = [String: String]()
////            params["submitInfo"] = jsonString!
////
////            let api = APIHelper()
////
////            if let contactImage = contactImage {
////                // Create a media image object
////                let mediaImage = Media(withImage: contactImage, forKey: "image", imageName: "event.jpg")
////                var images = [Media]()
////                images.append(mediaImage!)
////
////                // Upload images and handle the response
////                api.uploadImages(images: images, parameters: params, endPoint: "Main/CreateEvent") { response in
////
////                    print("Response Message: \(response.responseMessage)")
////
////
////
////                    DispatchQueue.main.async {
////                        showSuccessAlert.toggle()
////                    }
////                }
////            }
////        } catch {
////            print("Error encoding event: \(error)")
////        }
////    }
////
////    private var dateFormatter: DateFormatter {
////          let formatter = DateFormatter()
////          formatter.dateStyle = .medium
////          return formatter
////      }
//}
//struct EventCreateView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventCreateView()
//       
// 
//    }
//}
