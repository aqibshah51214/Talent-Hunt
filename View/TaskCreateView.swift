import SwiftUI

struct TaskCreateView: View {
    @State var StartTime = Date()
    @State var EndTime = Date()
    @State var ShowStartTimePicker = false
    @State var ShowEndTimePicker = false
    @State var Description = ""
    @Binding var Eventid:Int
    @State var showSuccessAlert = false
    @State var TaskImage:UIImage?=nil
    @State private var isImagePickerPresented: Bool = false

    var body: some View {
         
            ZStack {
                // Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 25) {
                    Text("Create Task")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top, 20)

                    VStack(spacing: 20) {
                        // Time Pickers
                        TimePickerView(title: "Start Time", date: $StartTime, showDatePicker: $ShowStartTimePicker)
                        TimePickerView(title: "End Time", date: $EndTime, showDatePicker: $ShowEndTimePicker)

                        // Description Input
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description")
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding(.horizontal,5)
                            TextEditor(text: $Description)
                                //.padding()
   
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(10)
                                .shadow(radius:0)
                               // .padding()
                        }.padding(.horizontal)
                        VStack{
                            if let image = TaskImage {
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
                                    Text("Select Image")
                                }
                               // .padding()
    //                            .background(Color.blue.opacity(0.8))
    //                            .foregroundColor(.white)
    //                            .cornerRadius(12)
                            }
                        }.sheet(isPresented: $isImagePickerPresented) {
                            CustomImagePicker(contactImage: $TaskImage)
                               }
                       

                        // Done Button
                        Button(action: {
                            CreateTask()
                        }) {
                            Text("Done")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .alert(isPresented: $showSuccessAlert) {
                            Alert(
                                title: Text("Success"),
                                message: Text("Task Added Successfully!"),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.95))
                    .cornerRadius(20)
                    .shadow(radius: 8)
                    .padding(.horizontal, 20)

                    Spacer()
                }
            }
        
        }
    private func CreateTask() {
 

        do {
            
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss" // you can customize this
            formatter.string(from: date)
            let requestData=Task(EventID:Eventid, Description: Description, TaskStartTime: formatter.string(from: StartTime), TaskEndTime: formatter.string(from: EndTime), image: nil)
            // Encode the event to JSON
            let jsonData = try JSONEncoder().encode(requestData)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print("JSON Sent to API: \(jsonString ?? "Invalid JSON")")

            // Prepare parameters for the API call
            var params = [String: String]()
            params["submitInfo"] = jsonString!

            let api = APIHelper()

            if let contactImage = TaskImage {
                // Create a media image object
                let mediaImage = Media(withImage: contactImage, forKey: "image", imageName: "event.jpg")
                var images = [Media]()
                images.append(mediaImage!)

                // Upload images and handle the response
                api.uploadImages(images: images, parameters: params, endPoint: "Main/AddTask") { response in

                    if response.responseCode==200{
                        DispatchQueue.main.async {
                            showSuccessAlert.toggle()
                        }
                    print("Response Message: \(response.responseMessage)")
                    }
                    else{
                        print("Response Message: \(response.responseMessage)")
                    }

                  
                }
            }
        } catch {
            print("Error encoding event: \(error)")
        }
    }
//    func Addtask() {
//        do {
//            let date = Date()
//            let formatter = DateFormatter()
//            formatter.dateFormat = "HH:mm:ss" // you can customize this
//            let dateString = formatter.string(from: date)
//            let requestData=Task(EventID:Eventid, Description: Description, TaskStartTime: formatter.string(from: StartTime), TaskEndTime: formatter.string(from: EndTime))
//            let jsonData = try JSONEncoder().encode(requestData)
//            let api = APIHelper()
//            api.postMethodCall(controllerName: "Main",
//                               actionName: "AddTask",
//                               httpBody: jsonData) { response in
//                if response.responseCode == 200 {
//                    SignUpsuccess.toggle()
//                } else {
//                    print("Failed : \(response.responseMessage)")
//                }
//            }
//        } catch {
//            print("Error encoding delete request: \(error)")
//        }
//    }
}

//struct TaskCreateView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskCreateView()
//    }
//}
