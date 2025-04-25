import SwiftUI

struct CommitteeMemberView: View {
//    struct Value: Hashable {
//        var name: String
//        var selected: Bool
//    }

    @State private var listdata = [Committee]()
    @Binding public var Eventid:Int
    @State private var listofmemberid = [Int]()

    var body: some View {
      
        ZStack {
            VStack {
                Text("Assigned Member")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.vertical, 10)

                List {
                    ForEach($listdata, id: \.Id) { $item in
                        VStack{
                        HStack {
                            Text(item.Name)
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding(.leading, 10)

                            Spacer()

                            checkboxView(selected: $item.selectvalue)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .shadow(radius: 3))
                        .contentShape(Rectangle()) // Make the entire row tappable
                        .onTapGesture{
                            item.selectvalue.toggle()

                            if item.selectvalue {
                                listofmemberid.append(item.Id)
                            } else {
                                listofmemberid.removeAll { $0 == item.Id }
                            }
            
                        }
                            
                        }
                }
                }
                .listStyle(PlainListStyle())
              
                //.padding(.horizontal)
                
                VStack{
                    Button(action: {
                        
                        AssignedMembertoEvent()
                    }) {
                        Text("Assign Committee")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal,30)
                }
            }
        
            .onAppear {
                fetchCommitteMember()
            }
        
        }
        .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all))
    }

    func fetchCommitteMember() {
        
        let api = APIHelper()
        api.getMethodCall(controllerName: "Main", actionName: "GetCommitteeMember") { response in
            DispatchQueue.main.async {
                if response.responseCode == 200, let data = response.responseData {
                    do {
                        print("API Response Data: \(String(data: data, encoding: .utf8) ?? "No Data")")
                        let decodedCommittee = try JSONDecoder().decode([Committee].self, from: data)
                        listdata = decodedCommittee
                        print("Committee Members Loaded: \(listdata.count) members")
                    } catch {
                        print("Decoding Error: \(error.localizedDescription)")
                    }
                } else {
                    print("Failed to fetch committee members, Response Code: \(response.responseCode)")
                }
            }
        }
    }

    private func AssignedMembertoEvent() {
        let Memberobject = AssignedMember(Id: 1, EventId: Eventid, MemberIdList: listofmemberid, Status: "Pending")
        do {
            let jsonData = try JSONEncoder().encode(Memberobject)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print("JSON Sent to API: \(jsonString!)")

            let api = APIHelper()
            api.postMethodCall(controllerName: "Main", actionName: "AssignedMemberToEvent", httpBody: jsonData) { response in
                if response.responseCode == 200 {
                    print("Add Successful: \(response.responseMessage)")
                } else {
                    print("Failed: \(response.responseMessage)")
                }
            }
        } catch {
            print("Error encoding Rules: \(error.localizedDescription)")
        }
    }
}

struct checkboxView: View {
    @Binding var selected: Bool

    var body: some View {
        Image(systemName: selected ? "checkmark.square.fill" : "square")
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(selected ? .blue : .gray)
    }
}

//struct CommitteeMemberView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommitteeMemberView(Eventid:0)
//    }
//}
