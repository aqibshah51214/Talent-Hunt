import SwiftUI

struct EventCreateView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var sem1 = false
    @State private var sem2 = false
    @State private var sem3 = false
    @State private var sem4 = false
    @State private var sem5 = false
    @State private var sem6 = false
    @State private var showEventDatePicker = false
    @State private var selectedEventDate = Date()
    @State private var contactImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false
    
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
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Title
                    Text("Create Event")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 40)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                    
                    // Title Input Field
                    VStack(alignment: .leading) {
                        Text("Event Title")
                            .font(.headline)
                            .foregroundColor(.black)
                        TextField("Enter title", text: $title)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(12)
                           // .foregroundColor(.black)
                    }
                    .padding(.horizontal)
                    
                    // Description Input Field
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.headline)
                            .foregroundColor(.black)
                        TextField("Enter description", text: $description)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(12)
                            //.foregroundColor(.black)
                    }
                    .padding(.horizontal)
                    
                    // Rules Checkboxes
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Rules")
                            .font(.headline)
                            .foregroundColor(.black)
                        HStack {
                            CheckboxView(SelectedText: $sem1, text: "1st")
                            CheckboxView(SelectedText: $sem2, text: "2nd")
                            CheckboxView(SelectedText: $sem3, text: "3rd")
                            CheckboxView(SelectedText: $sem4, text: "4th")
                            CheckboxView(SelectedText: $sem5, text: "5th")
                            CheckboxView(SelectedText: $sem6, text: "6th")
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Event Date Picker
                    DatePickerView(title: "Event Date", date: $EventDate, showDatePicker: $showEventDate)
                        //.padding(.horizontal)
                    
                    // Registration Date Pickers
                    VStack {
                        Text("Registration Date")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        DatePickerView(title: "Start Date", date: $regStartDate, showDatePicker: $showRegStartDatePicker)
                        DatePickerView(title: "End Date", date: $regEndDate, showDatePicker: $showRegEndDatePicker)
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Event Time Pickers
                    VStack {
                        Text("Event Time")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        TimePickerView(title: "Start Time", date: $EventStartTime, showDatePicker: $showEventStartTimePicker)
                        TimePickerView(title: "End Time", date: $EventEndTime, showDatePicker: $showEventEndTimePicker)
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Image Picker
                    VStack {
                        if let image = contactImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(12)
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
                            .padding()
                            .background(Color.blue.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }
                    }
                   
                    
                    // Submit Button
                    Button(action: {
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
                    
                    Spacer()
                }
            }
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
            let jsonData = try JSONEncoder().encode(event)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print("JSON Sent to API: \(jsonString!)")
            
            var params = [String: String]()
            params["submitInfo"] = jsonString!
            
            let api = APIHelper()
            if let EventImage = contactImage {
                let mediaImage = Media(withImage: EventImage, forKey: "image", imageName: "event.jpg")
                var images = [Media]()
                images.append(mediaImage!)
                
                api.uploadImages(images: images, parameters: params, endPoint: "Main/CreateEvent") { response in
                    print(response.responseMessage)
                    showSuccessAlert.toggle()
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
