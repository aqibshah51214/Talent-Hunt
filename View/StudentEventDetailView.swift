 
import SwiftUI
 
struct StudentEventDetailView: View {
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
    @Binding  var userid:Int
    @Binding   var Id:Int
    @State     var SignUpsuccess = false
    @State     var Message = ""
    @State     var navgatetoTask = false
    
    var body: some View {
        ZStack {
 
            VStack(spacing:2){
  
                Form{
                    Section(header: Text("Title")){
                        Text("\(title)")
                    
                    }
                    Section(header: Text("Event Date")){
                       
                        Text(" \(dateFormatter.string(from:EventDate))")
                    }
                        

                    Section(header: Text("Registration Start Date")){
                        
                        Text(" \(dateFormatter.string(from:regStartDate))")
                    
                    }
                    Section(header: Text("Registration End Date")){
                        
                      
                        Text(" \(dateFormatter.string(from:regEndDate))")
                    }
                    Section(header: Text("Event Start")) {
                        
                        Text(" \(formattedTime(from: EventStartTime))")
                      
                    }
                    Section(header: Text("Event End")) {
                        
                        Text(" \(formattedTime(from: EventEndTime))")
                    }

                    
                    
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

                    }
                }.navigationBarTitle("EventDetail")
                    
              

 
              
                
            
            }.toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        ApplyForStudent(userid: userid, Eventid:Id)
                    },
                           
                           label: {Text("Apply")})
                    
                        .alert(isPresented: $SignUpsuccess) {
                            Alert(
                                title: Text("Message"),
                                message: Text(Message),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            navgatetoTask.toggle()
                        },
                               
                               label: {Text("Task")})
                        
                             
                    }
                    
                    
                
            }
            NavigationLink(
                destination: StudentTaskView(Eventid: $Id, Userid: $userid),
               isActive: $navgatetoTask
           ) {
               EmptyView()
           }
//
        }
    }

 
    func formattedTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a" // e.g., "2:30 PM"
        return formatter.string(from: date)
    }

       
    private var dateFormatter: DateFormatter {
          let formatter = DateFormatter()
          formatter.dateStyle = .medium
          return formatter
      }
    
    func ApplyForStudent(userid:Int,Eventid:Int){
         
        do {
            let apply =  ApplyStudent(UserID:userid, EventID:Eventid, Status:"Pending")
            let jsonData = try JSONEncoder().encode(apply)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print("JSON Sent to API: \(jsonString!)")  // Debugging log
         

                let api = APIHelper()
                
               api.postMethodCall(controllerName:"Main", actionName:"ApplyRequest", httpBody: jsonData) { response in
                print("Full Response: \(response.responseMessage)") // if this has a .responseBody or rawData, print that too
                if response.responseCode == 200 {
                    print("Signup Successful: \(response.responseMessage)")
                    Message="Apply Successfully!"
                    SignUpsuccess.toggle()
                } else {
                    Message=response.responseMessage
                    SignUpsuccess.toggle()
                    print("Signup Failed: \(response.responseMessage)")
                }
            
                    
                }
            } catch {
                print("Error encoding contact: \(error.localizedDescription)")
            }
    }
   

}

 

//struct StudentEventDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentEventDetailView()
//    }
//}
