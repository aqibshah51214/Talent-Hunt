import SwiftUI
//import UIKit
struct AdminDashboardView: View {
    @State private var searchQuery = ""
    @State private var navigateToEventCreate = false
    @State private var listofEvent = [EventCreate]()
    @State private var scrollPosition: Int? = nil
    @State private var navgatetoAssignMember = false
    @State private var activeScreen = ""
    @State private var isDrawerOpen = false
    @State private var navigateToAddCommittee=false
    @State var Eventid = 0
    
    @State private var Id = 0
   // @State private var selectedEventDate = Date()
    @State private var contactImage=""
 
    @State private var regStartDate = Date()
    @State private var EventDate = Date()
    @State private var regEndDate = Date()
    @State private var EventStartTime = Date()
    @State private var EventEndTime = Date()
    @State private var title = ""
    @State private var description = ""
    
    
    var filteredEvents: [EventCreate] {
        if searchQuery.isEmpty {
            return listofEvent
        } else {
            return listofEvent.filter { $0.Title.localizedCaseInsensitiveContains(searchQuery) }
        }
    }

    var body: some View {
//        NavigationView {
            ZStack {
                VStack {
                    VStack(spacing: 0) {
                        // Header with Title & Add Button
                        Text("Events")
                            .bold()
                            //.offset(y: -30)
                        HStack {
                             
                             
                            Spacer()
                            Button(action: {
                                navigateToEventCreate.toggle()
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.green)
                                    .shadow(color: .black.opacity(0.1), radius: 2, x: 1, y: 1)
                            }
                        }
                        
                        .offset(y: -2)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                        .padding(.bottom, 1)
                        .padding(.horizontal,6)
                        NavigationLink(destination: EventCreateView(), isActive: $navigateToEventCreate) {
                            EmptyView()
                        }
                        // Search Bar
                        VStack {
                            HStack {
                                TextField("Search Events", text: $searchQuery)
                                    .padding(10)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                    .submitLabel(.done)
                                    .keyboardType(.default)

                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                            }
                            .padding()

                          //  Spacer()
                        }
                        .background(Color.white)
                        .onTapGesture {
                            hideKeyboard()
                        }
                        // Event List
                        List {
                            ForEach(filteredEvents.indices, id: \.self) { index in
                                let event = filteredEvents[index]

                                Button(action: {
                                    navgatetoAssignMember = true
                                    Eventid = event.Id!
                                    
                                    let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "yyyy-MM-dd" // adjust based on your date string format
                                        
                                    let timeFormatter = DateFormatter()
                                        timeFormatter.dateFormat = "HH:mm:ss"
                                    Id=event.Id!
                                    title=event.Title
                                    description=event.Details
                                    EventDate=dateFormatter.date(from: event.EventDate) ?? Date()
                                    regStartDate=dateFormatter.date(from: event.RegStartDate) ?? Date()
                                    regEndDate=dateFormatter.date(from: event.RegEndDate) ?? Date()
                                    EventStartTime=timeFormatter.date(from: event.EventStartTime) ?? Date()
                                    EventEndTime=timeFormatter.date(from: event.EventEndTime) ?? Date()
                                    contactImage=event.Image ?? ""
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
//                                .onTapGesture{
//
//
//                                }
                            }
                            .onMove { indices, newOffset in
                                listofEvent.move(fromOffsets: indices, toOffset: newOffset)
                            }
                            .onDelete { indices in
                                let idsToDelete = indices.map { filteredEvents[$0].Id }

                                idsToDelete.forEach { id in
                                    deleteEvent(eventId: id!)
                                }

                                listofEvent.removeAll { idsToDelete.contains($0.Id) }
                            }
                        }
                    }

                  
//                    NavigationLink(destination: CommitteeMemberView(Eventid: $Eventid), isActive: $navgatetoAssignMember) {
//                        EmptyView()
//                    }
                    NavigationLink(
                        destination: EventDetailView(
                            title: $title,
                            description: $description,
                            //selectedEventDate: $selectedEventDate,
                            Imageurl: $contactImage,
                            regStartDate: $regStartDate,
                            EventDate: $EventDate,
                            regEndDate: $regEndDate,
                            EventStartTime: $EventStartTime,
                            EventEndTime: $EventEndTime, Id: $Eventid
                        ),
                        isActive: $navgatetoAssignMember
                    ) {
                        EmptyView()
                    }
                    NavigationLink(destination: AddCommitteeMemeberView(), isActive: $navigateToAddCommittee) {
                        EmptyView()
                        
                        }

                    Spacer()
                }
               

               
                if isDrawerOpen {
                    ZStack {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation {
                                    isDrawerOpen = false
                                }
                            }
                            .navigationBarBackButtonHidden(true)
                        HStack(spacing:0) {
                          
                            VStack(alignment:.leading, spacing: 20) {
                               
                                HStack {
                                    Image(systemName: "person.crop.circle")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.black)
                                    Text("User Name")
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                }
                                .padding(.bottom, 20)

                                Divider()

                                Button(action: {
                                    setActiveScreen("AddCommittee")
                                    navigateToAddCommittee.toggle()
                                }) {
                                    DrawerMenuItem1(icon: "plus", title: "AddCommittee", isSelected: activeScreen == "AddCommittee")
                                }

                                Button(action: {
                                    setActiveScreen("Counter")
                                }) {
                                    DrawerMenuItem1(icon: "number", title: "Counter", isSelected: activeScreen == "Counter")
                                }

                                Button(action: {
                                    setActiveScreen("Calculator")
                                }) {
                                    DrawerMenuItem1(icon: "plus.slash.minus", title: "Calculator", isSelected: activeScreen == "Calculator")
                                }

                                Button(action: {
                                    setActiveScreen("Discount")
                                }) {
                                    DrawerMenuItem1(icon: "percent", title: "Discount", isSelected: activeScreen == "Discount")
                                }
                             Spacer()
                              
                            }
                            .frame(maxWidth: 250, maxHeight: .infinity,alignment: .leading)
                           // .frame(maxHeight: .infinity)
                           // .edgesIgnoringSafeArea(.all)
                            .padding()
                            .offset(y:40)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            
                            
                            Spacer()
                        } .transition(.move(edge: .trailing))
                            .edgesIgnoringSafeArea(.all)
                        
                          
                    }
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
               
                
                    ToolbarItem(placement: .navigationBarLeading) {
                        if !isDrawerOpen {
                            Button(action: {
                                withAnimation {
                                    isDrawerOpen.toggle()
                                }
                            }) {
                                Image(systemName: "line.horizontal.3")
                                    .imageScale(.large)
                                    .padding()
                            }
                        }
                    }
                

            }
            
   // }
        .onAppear {
            fetchEvents()
        }
    }

    private func setActiveScreen(_ screen: String) {
        activeScreen = screen
        withAnimation {
            isDrawerOpen = false
            
            }
            
        
    }
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
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

    func deleteEvent(eventId: Int) {
        do {
            let requestData = ["EventId": eventId]
            let jsonData = try JSONEncoder().encode(requestData)
            let api = APIHelper()
            api.postMethodCall(controllerName: "Main",
                               actionName: "DeleteEvent",
                               httpBody: jsonData) { response in
                if response.responseCode == 200 {
                    print("Successfully deleted event \(eventId)")
                } else {
                    print("Failed to delete event \(eventId): \(response.responseMessage)")
                }
            }
        } catch {
            print("Error encoding delete request: \(error)")
        }
    }
}

struct DrawerMenuItem1: View {
    let icon: String
    let title: String
    let isSelected: Bool

    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 30)
                .foregroundColor(isSelected ? .blue : .gray)
            Text(title)
                .font(.body)
                .foregroundColor(isSelected ? .blue : .black)
        }
        .padding(.vertical, 10)
    }
}

struct AdminDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        AdminDashboardView()
    }
}
