//
//  StudentTaskView.swift
//  Talent-Hunt
//
//  Created by MacBook Pro on 20/05/2025.
//

import SwiftUI

struct StudentTaskView: View {
    @State private var tasklist = [Task]()
    @Binding var Eventid: Int
    @Binding var Userid: Int
    var body: some View {
        VStack{
            List{
                ForEach(tasklist, id: \.self) { item in
                    VStack(alignment:.leading){
                        
                             
                        if let imageUrl = item.image,
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
                 
                        
                        Divider()
                         
                       
                            Text("Start Time: \(item.TaskStartTime ?? "No time")")
                                .foregroundColor(.secondary)
                            Text("End Time: \(item.TaskEndTime ?? "No time")")
                                
                                .foregroundColor(.secondary)
                        
                       
                    }
                     
                }
            }.navigationBarTitle("Task")
     
        }.onAppear{
            
            fetchTasksForEvent(eventId: Eventid, userId: Userid)
        }
    }
    
    
    
    
    func fetchTasksForEvent(eventId: Int, userId: Int) {
        do {
            
            let requestData = ["eventid": eventId, "userid": userId]
            let jsonData = try JSONEncoder().encode(requestData)
            let api = APIHelper()
            api.postMethodCall(controllerName: "Main",
                               actionName: "ShowTask",
                               httpBody: jsonData) { response in
                if let responseData = response.responseData {
                    DispatchQueue.main.async {
                        do {
                            let decoded = try JSONDecoder().decode([Task].self, from: responseData)
                            self.tasklist = decoded
                            print("Loaded tasks: \(tasklist)")
                        } catch {
                            print("Failed to decode task data: \(error)")
                        }
                    }
                } else {
                    print("No data received from ShowTask API.")
                }
            }
        } catch {
            print("Error encoding task request: \(error)")
        }
    }

}

//struct StudentTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentTaskView()
//    }
//}
