import SwiftUI

struct AdminDashboardView: View {
    @State private var searchQuery = ""
    @State private var navigateToEventCreate = false
    @State private var listofEvent = [EventCreate]()
    @State private var scrollPosition: Int? = nil
    @State private var navgatetoAssignMember = false
    @State var Eventid=0
    var filteredEvents: [EventCreate] {
        if searchQuery.isEmpty {
            return listofEvent
        } else {
            return listofEvent.filter { $0.Title.localizedCaseInsensitiveContains(searchQuery) }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.white.opacity(0.5)]),
                             startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea(.all, edges: .top)
                
                VStack {
                    VStack(spacing: 0) {
                        // Header with Title & Add Button
                        HStack {
                            Spacer()
                            Text("Event Management")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Button(action: {
                                navigateToEventCreate = true
                                
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.green)
                                    .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                            }
                        }
                        .offset(y: -20)
                        .background(Color.gray.opacity(0.5))
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                        .padding(.bottom, 1)
                        
                        // Search Bar
                        HStack {
                            TextField("Search Events", text: $searchQuery)
                                .padding(10)
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                                .padding(.trailing, 10)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 40, alignment: .center)
                        .border(.black, width: 0.2)
                        .background(Color.white.opacity(0.95))
                        .shadow(color: .black.opacity(0.1), radius: 5)
                        
                        // Event List
                        List {
                            ForEach(filteredEvents.indices, id: \.self) { index in
                                let event = filteredEvents[index]
                                
                                Button(action: {
                                    navgatetoAssignMember = true
                                    Eventid=event.Id
                                }) {
                                    VStack(alignment: .leading, spacing: 10) {
                                        if let imageUrl = event.Image,
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
                                        
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(event.Title)
                                                .font(.headline)
                                                .foregroundColor(.black)
                                            
                                            HStack {
                                                Image(systemName: "calendar")
                                                    .foregroundColor(.blue)
                                                Text(event.EventDate)
                                                    .font(.footnote)
                                                    .foregroundColor(.secondary)
                                            }
                                            
                                            HStack {
                                                Image(systemName: "clock")
                                                    .foregroundColor(.blue)
                                                Text("\(event.EventStartTime) - \(event.EventEndTime)")
                                                    .font(.footnote)
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                        .padding(.horizontal, 10)
                                        .padding(.bottom, 10)
                                    }
                                    }
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 2)
                                    .padding(.vertical, 5)
                                
                                
                            }
                            .onMove { indices, newOffset in
                                listofEvent.move(fromOffsets: indices, toOffset: newOffset)
                            }
                            .onDelete { indices in
                                   listofEvent.remove(atOffsets: indices)
                                do {
                                    let jsonData = try JSONEncoder().encode(indices)
                                    let jsonString = String(data: jsonData, encoding: .utf8)
                                    print("JSON Sent to API: \(jsonString!)")  // Debugging log
                                 

                                        let api = APIHelper()
                                    
                                        api.postMethodCall(controllerName: "Main", actionName: "DeleteEvent", httpBody: jsonData) { response in
                                           
                                                if response.responseCode == 200 {
                                                    print("Delete Successful: \(response.responseMessage)")
                                                   
                                                } else {
                                                    print("Failed: \(response.responseMessage)")
                                                }
                                            
                                        }
                                    } catch {
                                        print("Error encoding  Rules: \(error.localizedDescription)")
                                    }
                            }
                        }
                       // .listStyle(PlainListStyle())
                    }
                    
                    NavigationLink(destination: EventCreateView(), isActive: $navigateToEventCreate) {
                        EmptyView()
                    }
                    NavigationLink(destination: CommitteeMemberView(Eventid: $Eventid), isActive: $navgatetoAssignMember) {
                        EmptyView()
                    }
                    
                    Spacer()
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
        .onAppear {
            fetchEvents()
        }
    }

    func fetchEvents() {
        let api = APIHelper()
        api.getMethodCall(controllerName: "Main", actionName: "ShowAllEvents") { response in
            DispatchQueue.main.async {
                if response.responseCode == 200, let data = response.responseData {
                    do {
                        let decodedEvents = try JSONDecoder().decode([EventCreate].self, from: data)
                        listofEvent = decodedEvents
                    } catch {
                        print("Decoding Error: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
      
    
    
}

struct AdminDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        AdminDashboardView()
    }
}
