import SwiftUI

struct RequestToMember: Codable, Hashable {
    var Id: Int
    var EventId: Int
    var Status: String?
    var Title: String?
    var Image: String
     
   
}
struct RequestUpdate: Codable, Hashable {
    var Id: Int
    var Status: String
}

struct RequestListView: View {
    @State private var request = [RequestToMember]()
    @Binding var userId: Int
    @State private var Status=""
   

    var body: some View {
        VStack{
        
        List {
            ForEach(request, id: \.self) { item in
                HStack {
                    // Load image from URL if valid
                    AsyncImage(url: URL(string: "\(APIHelper.baseImageURLString)\(item.Image)")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 90, height: 90)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 0))

                    Divider()
                    Spacer()
                    VStack(alignment: .leading, spacing: 8) {
                        Text(item.Status ?? "No status")
                            .font(.headline)
                            .foregroundColor(.primary)

                        Divider()

                        Text(item.Title ?? "No title")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                      

                        HStack {
                            Spacer()
                            Button(action: {
                              
                              
                            
                                ChangeStatus(data:RequestUpdate(Id: item.Id, Status:"Reject"))
                            }) {
                                Text("Reject")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 8)
                                    .background(Color.gray.opacity(0.7))
                                    .cornerRadius(8)
                            }

                            Button(action: {
                                
                                ChangeStatus(data:RequestUpdate(Id: item.Id, Status:"Accept"))
                              
                            }) {
                                Text("Accept")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 8)
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                .padding(.vertical, 4)
            }
        }.navigationBarTitle("Requests")
        .onAppear {
              fetchAssignedMember(userId: userId)
        }
        }
    }
    func fetchAssignedMember(userId: Int) {
        do {
            let requestData = ["UserId": userId]
            let jsonData = try JSONEncoder().encode(requestData)
            let api = APIHelper()
            api.postMethodCall(controllerName: "Main",
                               actionName: "NotificationToAssignMember", // <-- Update if needed
                               httpBody: jsonData) { response in
                if let responseData = response.responseData {
                    DispatchQueue.main.async {
                        do {
                            let decoded = try JSONDecoder().decode([RequestToMember].self, from: responseData)
                            request = decoded
                            print("Decoded requests: \(request)")
                        } catch {
                            print("Failed to decode response data: \(error)")
                        }
                    }
                }
            }
        } catch {
            print("Error encoding request: \(error)")
        }
    }
    
    
    
    
    
    func ChangeStatus(data:RequestUpdate) {
        do {
            
            let jsonData = try JSONEncoder().encode(data)
            let api = APIHelper()
            
            api.postMethodCall(controllerName: "Main",
                               actionName: "RequestAcceptReject", // <-- update to your actual backend function
                               httpBody: jsonData) { response in
                print("Response Message: \(response.responseMessage)")
                
                // Optionally, refresh data after status change
                DispatchQueue.main.async {
                    fetchAssignedMember(userId: userId)
                }
            }
        } catch {
            print("Error encoding request: \(error)")
        }
    }

    }

