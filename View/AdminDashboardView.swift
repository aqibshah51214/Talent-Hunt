////
////  AdminDashboardView.swift
////  Talent-Hunt
////
////  Created by MacBook Pro on 14/03/2025.
////
//
//import SwiftUI
//
//struct AdminDashboardView: View {
//
//    @State private var searchQuery = ""
//    @State private var navigateToEventCreate = false
//    @State public var listofEvent = [EventCreate]()
//
//    var filteredEvents: [EventCreate] {
//        if searchQuery.isEmpty {
//            return listofEvent
//        } else {
//            return listofEvent.filter { $0.Title.localizedCaseInsensitiveContains(searchQuery) }
//        }
//    }
//
//    var body: some View {
//
//            VStack {
//                // 📌 Header with Title & Add Button
//                VStack{
//                    Text("Event Management")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .foregroundColor(.black)
//                        .background(.yellow)
//
//
//
//                }
//                .padding()
//
//                // 📌 Search Bar
//                HStack{
//                HStack {
//                    TextField("Search Events", text: $searchQuery)
//                        .padding(10)
//
//                        .cornerRadius(8)
//
//                    Image(systemName: "magnifyingglass")
//                        .foregroundColor(.gray)
//                        .padding(.trailing)
//                }.background(.white)
//                    Spacer()
//                    Button(action: {
//                        navigateToEventCreate = true
//                    }) {
//                        Image(systemName: "plus.circle.fill")
//                            .foregroundColor(.green)
//                            .font(.largeTitle)
//                    }
//
//                }
//                .padding(.horizontal)
//
//                // 📌 Navigation Link to Event Creation Page
//                NavigationLink(destination: EventCreateView(), isActive: $navigateToEventCreate) {
//                    EmptyView()
//                }
//
//                // 📌 Event List
//                List {
//                    ForEach(filteredEvents, id: \.self) { event in
//                        HStack(spacing: 10) {
//                            // 📌 Event Image (If Available)
//                            if let imageUrl = event.Image,
//                               let url = URL(string: "\(APIHelper.baseImageURLString)\(imageUrl.replacingOccurrences(of: " ", with: "%20"))") {
//
//                                AsyncImage(url: url) { phase in
//                                    switch phase {
//                                    case .success(let image):
//                                        image
//                                            .resizable()
//                                            .scaledToFill()
//                                            .frame(width: 80, height: 80)
//                                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                                    case .failure(_):
//                                        Image(systemName: "photo")
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: 80, height: 80)
//                                            .foregroundColor(.gray)
//                                    case .empty:
//                                        ProgressView()
//                                            .frame(width: 80, height: 80)
//                                    @unknown default:
//                                        EmptyView()
//                                    }
//                                }
//                            }
//
//                            // 📌 Event Details
//                            VStack(alignment: .leading, spacing: 5) {
//                                Text(event.Title)
//                                    .font(.headline)
//                                    .foregroundColor(.black)
//
//                                Text(event.Details)
//                                    .font(.subheadline)
//                                    .foregroundColor(.gray)
//                                    .lineLimit(2)
//
//                                HStack {
//                                    Image(systemName: "calendar")
//                                        .foregroundColor(.blue)
//                                    Text(event.EventDate)
//                                        .font(.footnote)
//                                        .foregroundColor(.secondary)
//                                }
//
//                                HStack {
//                                    Image(systemName: "clock")
//                                        .foregroundColor(.blue)
//                                    Text("\(event.EventStartTime) - \(event.EventEndTime)")
//                                        .font(.footnote)
//                                        .foregroundColor(.secondary)
//                                }
//                            }
//                            .padding(.vertical, 5)
//
//                            Spacer()
//                        }
//                        .padding(.vertical, 10)
//                    }
//                }
//                .listStyle(PlainListStyle())
//            }
//            .background(Color.black.opacity(0.05))
//            .onAppear {
//                fetchEvents()
//            }
//
//
//    }
//
//    // ✅ Helper Function to Format Date
//    func formattedDate(_ date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        return formatter.string(from: date)
//    }
//
//    // ✅ API Call to Fetch Events
//    func fetchEvents() {
//        let api = APIHelper()
//        api.getMethodCall(controllerName: "Main", actionName: "ShowAllEvents") { response in
//            DispatchQueue.main.async {
//                if response.responseCode == 200, let data = response.responseData {
//                    do {
//                        // Debug: Print raw data
//                        print("API Response Data: \(String(data: data, encoding: .utf8) ?? "No Data")")
//
//                        // ✅ Try decoding the JSON
//                        let decodedEvents = try JSONDecoder().decode([EventCreate].self, from: data)
//                        listofEvent = decodedEvents
//                        print("✅ Events Loaded: \(listofEvent.count) events")
//                    } catch {
//                        print("❌ Decoding Error: \(error.localizedDescription)")
//                    }
//                } else {
//                    print("❌ Failed to fetch events, Response Code: \(response.responseCode)")
//                }
//            }
//        }
//    }
//}
//
//struct AdminDashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        AdminDashboardView()
//    }
//}
import SwiftUI

struct AdminDashboardView: View {
    
    @State private var searchQuery = ""
    @State private var navigateToEventCreate = false
    @State public var listofEvent = [EventCreate]()
    
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
                // Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // 📌 Header with Title & Add Button
                    HStack {
                        Text("Event Management")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        // Add Event Button
                        Button(action: {
                            navigateToEventCreate = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
                        }
                    }
                    .padding()
                    .background(Color.blue.opacity(0.7))
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                    
                    // 📌 Search Bar
                    HStack {
                        TextField("Search Events", text: $searchQuery)
                            .padding(10)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.trailing, 10)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // 📌 Event List
                    List {
                        ForEach(filteredEvents, id: \.self) { event in
                            // Event Card
                            VStack(alignment: .leading, spacing: 10) {
                                // Event Image
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
                                
                                // Event Details
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(event.Title)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    
                                    Text(event.Details)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .lineLimit(2)
                                    
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
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                            .padding(.vertical, 5)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.clear)
                }
                
                // 📌 Navigation Link to Event Creation Page
                NavigationLink(destination: EventCreateView(), isActive: $navigateToEventCreate) {
                    EmptyView()
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                fetchEvents()
            }
        }
    }
    
    // ✅ Helper Function to Format Date
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }

    // ✅ API Call to Fetch Events
    func fetchEvents() {
        let api = APIHelper()
        api.getMethodCall(controllerName: "Main", actionName: "ShowAllEvents") { response in
            DispatchQueue.main.async {
                if response.responseCode == 200, let data = response.responseData {
                    do {
                        // Debug: Print raw data
                        print("API Response Data: \(String(data: data, encoding: .utf8) ?? "No Data")")

                        // ✅ Try decoding the JSON
                        let decodedEvents = try JSONDecoder().decode([EventCreate].self, from: data)
                        listofEvent = decodedEvents
                        print("✅ Events Loaded: \(listofEvent.count) events")
                    } catch {
                        print("❌ Decoding Error: \(error.localizedDescription)")
                    }
                } else {
                    print("❌ Failed to fetch events, Response Code: \(response.responseCode)")
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
