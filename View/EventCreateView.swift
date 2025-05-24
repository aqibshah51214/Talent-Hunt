//
//  EventCreateView.swift
//  Talent-Hunt
//
//  Created by MacBook Pro on 11/03/2025.
//

import SwiftUI
import UIKit
struct EventCreateView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var navigateToAssignMamber=false
 
   
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
 
            
            ScrollView {
              
                VStack(spacing: 20) {
                    
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
                                TextEditor(text: $description)
                               .frame(height: 150)
                               .padding(8)
                               .background(Color.white.opacity(0.2))
                                .cornerRadius(12)
                                .foregroundColor(.black)
                                .shadow(color: .black.opacity(0.5), radius: 3, x: 1, y: 1)
                                     }
                                     .padding(.horizontal, 10)
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
                
                  
                    
                   
                }.navigationBarTitle("Add Event")
                Spacer()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                             
                                createEvent()
                                
                            }) {
                                Text("Add")
                                    
                            }
                            .alert(isPresented: $showSuccessAlert) {
                                Alert(
                                    title: Text("Success"),
                                    message: Text("Your event has been created successfully!"),
                                    dismissButton: .default(Text("OK"))
                                )
                            }
                            
                                 
                        }
                    }
            
           }
 
        }
    }
//
    private func createEvent() {

        let timeFormatter = DateFormatter()
           timeFormatter.dateFormat = "HH:mm:ss"
        let event = EventCreate(
            Id:nil,
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


                    print("Response Message: \(response.responseMessage)")

                    DispatchQueue.main.async {
                        showSuccessAlert.toggle()
                    }
                }
            }
        } catch {
            print("Error encoding event: \(error)")
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
