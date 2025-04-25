import SwiftUI

struct RequestToMember: Codable, Hashable {
    var Id: Int
    var EventId: Int
    var Status: String?
    var Title: String?
    var Image: String
     
   
}

struct RequestListView: View {
    @State private var request = [RequestToMember]()
    @Binding var userId: Int

    var body: some View {
        VStack{
        Text("Request")
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
                                // Reject action here
                            }) {
                                Text("Reject")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 8)
                                    .background(Color.gray.opacity(0.7))
                                    .cornerRadius(8)
                            }

                            Button(action: {
                                // Accept action here
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
        }
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
    
    
    
    
    
    func ChangeStatus(Id: Int) {
        do {
            let requestData = ["AssignId": userId]
            let jsonData = try JSONEncoder().encode(requestData)
            let api = APIHelper()
            api.postMethodCall(controllerName: "Main",
                               actionName: "DeleteEvent", // <-- Update if needed
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
    }

