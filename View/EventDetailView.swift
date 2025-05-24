//
//  EventDetailView.swift
//  Talent-Hunt
//
//  Created by MacBook Pro on 15/04/2025.
//
struct CountResponse: Codable {
    let count: String
}
import SwiftUI
 
struct EventDetailView: View {
    @Binding   var title:String
    @Binding   var description:String
    @Binding   var Imageurl:String
    @State     var navigateToAssignMamber=false
    @State     var showEventDatePicker = false
    @State     var contactImage: UIImage? = nil
    @State     var isImagePickerPresented: Bool = false
    @State     var showRegStartDatePicker = false
    @Binding   var regStartDate:Date
    @State     var showEventDate = false
    @Binding   var EventDate : Date
    @State     var showRegEndDatePicker = false
    @Binding   var regEndDate : Date
    @State     var showEventStartTimePicker = false
    @Binding   var EventStartTime : Date
    @State     var showEventEndTimePicker = false
    @Binding   var EventEndTime : Date
    @State     var showSuccessAlert = false
    @State     var NavigateToAssignMamber = false
    @State     var NavigateToCreateTask = false
    @State     var NavigateToApplyRequest = false

    @Binding   var Id:Int
    @State     var Count=""
    
    var body: some View {
        ZStack {
            // Background Gradient
//            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                .ignoresSafeArea()
            VStack(spacing:10){
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {

                        Button(action: {
                            UpdateEvent()
                        }) {
                            Text("Update")
                                .foregroundColor(Color.black.opacity(0.6))
                                .frame(width: 100, height: 30)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                        .alert(isPresented: $showSuccessAlert) {
                            Alert(
                                title: Text("Success"),
                                message: Text("Your Event has been Updated Successfully!"),
                                dismissButton: .default(Text("OK"))
                            )
                        }

                        Button(action: {
                            NavigateToCreateTask.toggle()
                        }) {
                            Text("AddTask")
                                .foregroundColor(Color.black.opacity(0.6))
                                .frame(width: 100, height: 30)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }

                        Button(action: {
                            navigateToAssignMamber.toggle()
                        }) {
                            Text("AssignMember")
                                .foregroundColor(Color.black.opacity(0.6))
                                .frame(width:140, height: 30)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                }

            
            ScrollView {
              
                VStack {
                  
                    VStack(alignment: .leading) {
                        Text("Event Title")
                            .font(.headline)
                            .foregroundColor(.black)
                        TextField("Enter Title",text: $title)
                            .padding()
                            .background(Color.white.opacity(4.0))
                            .cornerRadius(12)
                           // .border(.gray, width: 1)
                            .foregroundColor(.black)
                            .shadow(color:.black.opacity(0.1), radius: 1, x: 1, y: 1)
                    }
                  
                 
                  
                    .padding(.horizontal)

             
//
                    VStack {
                        DatePickerView(title: "Event Date", date: $EventDate, showDatePicker: $showEventDate)
                    }
                    
                    VStack {
                        Text("Registration Date")
                            .font(.headline)
                            .foregroundColor(.black)
                            .offset(x: -130, y: -24)
                        
                        DatePickerView(title: "Start Date", date: $regStartDate, showDatePicker: $showRegStartDatePicker)
                        DatePickerView(title: "End Date", date: $regEndDate, showDatePicker: $showRegEndDatePicker)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.3))
                    .border(Color.gray, width: 1)
                    .padding()
                    
                    VStack {
                        Text("Event Time")
                            .font(.headline)
                            .foregroundColor(.black)
                            .offset(x: -153, y: -24)
                        
                        TimePickerView(title: "Start Time", date: $EventStartTime, showDatePicker: $showEventStartTimePicker)
                        TimePickerView(title: "End Time", date: $EventEndTime, showDatePicker: $showEventEndTimePicker)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.3))
                    .border(Color.gray, width: 1)
                    .padding()
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.headline)
                            .foregroundColor(.black)
                        TextField("Enter description", text: $description)
                            .padding()
                            .background(Color.white.opacity(4.0))
                            .cornerRadius(12)
                           // .border(.gray, width: 1)
                            .foregroundColor(.black)
                            .shadow(color:.black.opacity(0.3), radius: 3, x: 1, y: 1)
                    }
                    .padding(.horizontal)
                    VStack {
                        if((contactImage) == nil){
                        if let imageUrl = Imageurl,
                           let url = URL(string: "\(APIHelper.baseImageURLString)\(imageUrl.replacingOccurrences(of: " ", with: "%20"))") {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 150)
                                        .clipped()
                                        .cornerRadius(10)
                                        .padding()
                                case .failure(_):
                                  
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 150)
                                        .foregroundColor(.gray)
                                case .empty:
                                    ProgressView()
                                        .frame(height: 150)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                        
                            
                             
                                // use image
                            
                      
                        }
                    VStack{
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
                    }
                    }
                    
                    .sheet(isPresented: $isImagePickerPresented) {
                        CustomImagePicker(contactImage: $contactImage)
                           }
  
                     
                }.navigationBarTitle("EventDetail")
                    
                    NavigationLink(destination: CommitteeMemberView(Eventid: $Id), isActive: $navigateToAssignMamber) {
                        EmptyView()
                    }
                    NavigationLink(destination:  TaskCreateView(Eventid: $Id), isActive: $NavigateToCreateTask) {
                        EmptyView()
                    }
                
                Spacer()
                
            }
            }.onAppear{
                fetchApplycount(Eventid: Id)
            }
         
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        NavigateToApplyRequest.toggle()
                    },
                           
                           label: {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "bell.fill")
                                 
                                .foregroundColor(.blue)

                            Text(Count)
                                .font(.caption2)
                                .foregroundColor(.white)
                                .padding(5)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: 7, y: -7)
                        }

                    })
                    

                }
                
                
                
                
            };  NavigationLink(destination:  StudentRequestView(Eventid:$Id), isActive: $NavigateToApplyRequest) {
                EmptyView()
            }
 
        }
    }

    private func UpdateEvent() {
        
        let timeFormatter = DateFormatter()
           timeFormatter.dateFormat = "HH:mm:ss"
        let event = EventCreate(
            Id: Id,
            Title: title,
            RegStartDate: dateFormatter.string(from: regStartDate),
            RegEndDate: dateFormatter.string(from: regEndDate),
            EventDate: dateFormatter.string(from: EventDate),
            EventStartTime: timeFormatter.string(from: EventStartTime),
            EventEndTime: timeFormatter.string(from: EventEndTime),
            Details: description,
            Image: nil
        )
        
        do {
            // Encode the event to JSON
            let jsonData = try JSONEncoder().encode(event)
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
                api.uploadImages(images: images, parameters: params, endPoint: "Main/UpdateEvent") { response in
                    // Handle the response inside the closure
                    let responseMessage = response.responseMessage
                    if(response.responseCode==200){
                        showSuccessAlert=true
                        
                    }
                    print("Response Message: \(responseMessage)")
                    
                    // Decode the response data if needed
                    if let responseData = response.responseData {
                        do {
                             
                            let events = try JSONDecoder().decode(EventCreate.self, from: responseData)
                            print("Decoded events: \(events)")
                           
                          
                        } catch {
                            print("Failed to decode response data: \(error)")
                        }
                    }
                    
                    // Show success alert
                    DispatchQueue.main.async {
                         
                    }
                }
            }
        } catch {
            print("Error encoding event: \(error)")
        }
    }
//
    func fetchApplycount(Eventid: Int) {
        let requestData = ["Eventid": Eventid]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestData, options: [])
            let api = APIHelper()

            api.postMethodCall(controllerName: "Main", actionName: "countofapply", httpBody: jsonData) { response in
                if let responseData = response.responseData {
                    DispatchQueue.main.async {
                        if let countString = String(data: responseData, encoding: .utf8) {
                            self.Count = countString
                        } else {
                            print("Failed to convert response to String")
                        }
                    }
                }
            }
        } catch {
            print("Error serializing request: \(error)")
        }
    }

       
    private var dateFormatter: DateFormatter {
          let formatter = DateFormatter()
          formatter.dateStyle = .medium
          return formatter
      }
    
    
   

}
  

//struct EventDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventDetailView()
//    }
//}
