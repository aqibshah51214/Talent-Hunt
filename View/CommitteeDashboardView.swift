//
//  CommitteeDashboardView.swift
//  Talent-Hunt
//
//  Created by MacBook Pro on 04/05/2025.
//

import SwiftUI

struct CommitteeDashboardView: View {
    @State private var searchQuery = ""
    @State private var listofEvent = [EventCreate]()
    @Binding var userid:Int
    @State private var navigateToCommitte=false
    
   
   // @State private var selectedEventDate = Date()
   
    
    
    var filteredEvents: [EventCreate] {
        if searchQuery.isEmpty {
            return listofEvent
        } else {
            return listofEvent.filter { $0.Title.localizedCaseInsensitiveContains(searchQuery) }
        }
    }

    var body: some View {
       
            ZStack {
                VStack {
                    VStack(spacing: 0) {
                         
                      
                       
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
                                  
                                    navigateToCommitte.toggle()
                                  
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
                          
                          
                        }
                        Spacer()
                    }
                   
                   
 
                 
                }
               
 
                
            }
        NavigationLink(destination: RequestListView(userId: $userid), isActive: $navigateToCommitte) {
            EmptyView()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Events")
         
           
           
            
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

 
}

//struct CommitteeDashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommitteeDashboardView()
//    }
//}
