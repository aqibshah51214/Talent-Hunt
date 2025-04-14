//
//  EventCreateView.swift
//  Talent-Hunt
//
//  Created by MacBook Pro on 11/03/2025.
//

import SwiftUI

struct EventCreateView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var navigateToAssignMamber=false
    @State private var sem1 = false
    @State private var sem2 = false
    @State private var sem3 = false
    @State private var sem4 = false
    @State private var sem5 = false
    @State private var sem6 = false
    @State private var semester1 = "1st"
    @State private var semester2 = "2nd"
    @State private var semester3 = "3rd"
    @State private var semester4 = "4th"
    @State private var semester5 = "5th"
    @State private var semester6 = "6th"
    @State private var showEventDatePicker = false
    @State private var selectedEventDate = Date()
    @State private var contactImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false
    @State private var listofrules = [String]()
    // Registration Dates
    @State private var showRegStartDatePicker = false
    @State private var regStartDate = Date()
    @State private var showEventDate = false
    @State private var EventDate = Date()
    @State private var showRegEndDatePicker = false
    @State private var regEndDate = Date()
    
    // Event Time
    @State private var showEventStartTimePicker = false
    @State private var EventStartTime = Date()
    @State private var showEventEndTimePicker = false
    @State private var EventEndTime = Date()
    
    @State private var showSuccessAlert = false
    
    var body: some View {
        ZStack {
            // Background Gradient
//            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                .ignoresSafeArea()
            
            ScrollView {
              
                VStack(spacing: 20) {
                    Text("Create Event")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top, 40)

                    // Title Input Field
                    VStack(alignment: .leading) {
                        Text("Event Title")
                            .font(.headline)
                            .foregroundColor(.black)
                        TextField("Enter title", text: $title)
                            .padding()
                            .background(Color.white.opacity(4.0))
                            .cornerRadius(12)
                           // .border(.gray, width: 1)
                            .foregroundColor(.black)
                            .shadow(color:.black.opacity(0.3), radius: 3, x: 1, y: 1)
                    }
                  
                    //  .background(Color.white.opacity(4.0))
                  
                    .padding(.horizontal)

                    // Description Input Field
                 

                    // Rules Checkboxes
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text("Rules")
//                            .font(.headline)
//                            .foregroundColor(.black)
//                        HStack {
//                            CheckboxView(SelectedText: $sem1, text: semester1)
//                            CheckboxView(SelectedText: $sem2, text: semester2)
//                            CheckboxView(SelectedText: $sem3, text: semester3)
//                            CheckboxView(SelectedText: $sem4, text: semester4)
//                            CheckboxView(SelectedText: $sem5, text: semester5)
//                            CheckboxView(SelectedText: $sem6, text: semester6)
//                        }
//
//                    }
//                    .padding()
//                    .background(Color.white.opacity(0.6))
//                    .cornerRadius(12)
//                    .padding(.horizontal)
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
                   
                    
                    // Submit Button
                    Button(action: {
                        AddInListRules()
                        createEvent()
                        showSuccessAlert.toggle()
                    }) {
                        Text("Create Event")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal)
                    .alert(isPresented: $showSuccessAlert) {
                        Alert(
                            title: Text("Success"),
                            message: Text("Your event has been created successfully!"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    .padding(.horizontal)
                    
                   
                }
                Spacer()
            }
//            NavigationLink(destination: CommitteeMemberView(), isActive: $navigateToAssignMamber) {
//                EmptyView()
//            }
//            if showEventDate || showRegStartDatePicker || showRegEndDatePicker || showEventStartTimePicker || showEventEndTimePicker {
//                Color.black.opacity(0.4)
//                    .edgesIgnoringSafeArea(.all)
//            }
        }
    }

    private func createEvent() {
        print("Event Created")
        let timeFormatter = DateFormatter()
           timeFormatter.dateFormat = "HH:mm:ss"
        let event = EventCreate(
            Id: 1,
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
                api.uploadImages(images: images, parameters: params, endPoint: "Main/CreateEvent") { response in
                    // Handle the response inside the closure
                    let responseMessage = response.responseMessage
                    print("Response Message: \(responseMessage)")
                    
                    // Decode the response data if needed
                    if let responseData = response.responseData {
                        do {
                            
                            let events = try JSONDecoder().decode(EventCreate.self, from: responseData)
                            print("Decoded events: \(events)")
                           
                            AddRules(eventid: events.Id, list: listofrules)
                                
                           
                            // Perform any additional actions with the decoded data
                            // For example, update the UI or save the data
                        } catch {
                            print("Failed to decode response data: \(error)")
                        }
                    }
                    
                    // Show success alert
                    DispatchQueue.main.async {
                        showSuccessAlert.toggle()
                    }
                }
            }
        } catch {
            print("Error encoding event: \(error)")
        }
    }
    private func AddInListRules() {
        if(sem1){
            listofrules.append(semester1)
        }
        if(sem2){
            listofrules.append(semester2)
        }
        if(sem3){
            listofrules.append(semester3)
        }
        if(sem4){
            listofrules.append(semester4)
        }
        if(sem5){
            listofrules.append(semester5)
        }
        if(sem6){
            listofrules.append(semester6)
        }
      }
    private func AddRules(eventid:Int,list:[String]) {
        let rulesobject=Rules(Id: 0, Eventid: eventid, Rules: list)
        do {
            let jsonData = try JSONEncoder().encode(rulesobject)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print("JSON Sent to API: \(jsonString!)")  // Debugging log
         

                let api = APIHelper()
                
                api.postMethodCall(controllerName: "Main", actionName: "AddRules", httpBody: jsonData) { response in
                   
                        if response.responseCode == 200 {
                            print("Add Successful: \(response.responseMessage)")
                           
                        } else {
                            print("Failed: \(response.responseMessage)")
                        }
                    
                }
            } catch {
                print("Error encoding  Rules: \(error.localizedDescription)")
            }
    }
    private var dateFormatter: DateFormatter {
          let formatter = DateFormatter()
          formatter.dateStyle = .medium
          return formatter
      }
}
struct EventCreateView_Previews: PreviewProvider {
    static var previews: some View {
        EventCreateView()
       
 
    }
}
