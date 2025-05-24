//
//  StudentDashboardView.swift
//  Talent-Hunt
//
//  Created by MacBook Pro on 09/05/2025.
//

import SwiftUI
//import UIKit
struct StudentDashboardView: View {
    
    @Binding var userid:Int
    @State private var searchQuery = ""
    @State private var navigateToEventCreate = false
    @State private var listofEvent = [EventCreate]()
    @State private var scrollPosition: Int? = nil
    @State private var navgatetoEventDetail = false
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
    @State private var Expired=false
    @State private var Upcoming=false
    @State private var All=false
    @State private var Current=false
    
    var filteredEvents: [EventCreate] {
          filterEvents()
      }

    var body: some View {
       
            ZStack {
                VStack {
                    VStack(spacing: 0) {
                       
                            HStack {
                                Button(action: {
                                    Current = false
                                    All = true
                                    Expired = false
                                    Upcoming=false
                                    }) {
                                    Text("All")
                                        .foregroundColor(All ? .white : Color.black.opacity(0.6))
                                        .frame(width: 70, height: 30)
                                        .background(All ? Color.blue.opacity(0.7) : Color(.systemGray6))
                                        .cornerRadius(10)
                                }
                                Button(action: {
                                    Current = true
                                    All = false
                                    Expired = false
                                    Upcoming=false
                                }) {
                                    Text("Current")
                                        .foregroundColor(Current ? .white : Color.black.opacity(0.6))
                                        .frame(width:100, height: 30)
                                        .background(Current ? Color.blue.opacity(0.7): Color(.systemGray6))
                                        .cornerRadius(10)
                                }
                                Button(action: {
                                    Current = false
                                    All = false
                                    Expired = false
                                    Upcoming=true
                                }) {
                                    Text("Upcoming")
                                        .foregroundColor(Upcoming ? .white : Color.black.opacity(0.6))
                                        .frame(width:100, height: 30)
                                        .background(Upcoming ? Color.blue.opacity(0.7): Color(.systemGray6))
                                        .cornerRadius(10)
                                }
                                Button(action: {
                                    Current = false
                                    All = false
                                    Expired = true
                                    Upcoming=false
                                    
                                }) {
                                    Text("Expaired")
                                        .foregroundColor(Expired ? .white : Color.black.opacity(0.6))
                                        .frame(width:100, height: 30)
                                        .background(Expired ? Color.blue.opacity(0.7) : Color(.systemGray6))
                                        .cornerRadius(10)
                                }
                               
                            
                            }
                            
                        
 
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
                                    navgatetoEventDetail.toggle()
                                     
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
                        Spacer()
                    }
                   
                  
                     NavigationLink(
                        destination: StudentEventDetailView(
                            title: $title,
                            description: $description,
                            Imageurl: $contactImage,
                            regStartDate: $regStartDate,
                            EventDate: $EventDate,
                            regEndDate: $regEndDate,
                            EventStartTime: $EventStartTime,
                            EventEndTime: $EventEndTime,
                            userid:$userid,
                            Id: $Id
                        ),
                        isActive: $navgatetoEventDetail
                    ) {
                        EmptyView()
                    }
                 

                 
                }
               
 
                
            }
            .navigationBarTitle("Dashboard")
            .navigationBarBackButtonHidden(true)
           
         
            
   // }
        .onAppear {
            fetchEvents()
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
    func filterEvents() -> [EventCreate] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M d, yyyy" // Matches "5 3, 2025" format (no leading zero, no month name)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensures consistent parsing
        
        let calendar = Calendar.current
        let currentDate = Date()
        let currentDay = calendar.startOfDay(for: currentDate) // Normalize to midnight
        
        if !searchQuery.isEmpty {
            return listofEvent.filter { $0.Title.localizedCaseInsensitiveContains(searchQuery) }
        }
        
        if Expired {
            return listofEvent.filter { event in
                guard let endDate = dateFormatter.date(from: event.RegEndDate) else {
                    print("Failed to parse date string: '\(event.RegEndDate)' with format '\(String(describing: dateFormatter.dateFormat) )'")
                    return false
                }
                let endDay = calendar.startOfDay(for: endDate)
                print(" Comparing: '\(event.RegEndDate)' → \(endDay) < \(currentDay) = \(endDay < currentDay)")
                return endDay < currentDay
            }
        }
        
        if Current {
            return listofEvent.filter { event in
                guard let endDate = dateFormatter.date(from: event.RegEndDate),
                      let startDate = dateFormatter.date(from: event.RegStartDate) else {
                    print(" Failed to parse dates for event: \(event.Title)")
                    return false
                }
                let startDay = calendar.startOfDay(for: startDate)
                let endDay = calendar.startOfDay(for: endDate)
                return currentDay >= startDay && currentDay <= endDay
            }
        }
        
        return listofEvent
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

 

 
//
//struct StudentDashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentDashboardView()
//    }
//}
