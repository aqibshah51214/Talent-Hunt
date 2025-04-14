//
//  TabitemView.swift
//  Talent-Hunt
//
//  Created by MacBook Pro on 12/04/2025.
//

import SwiftUI

struct TabitemView: View {
    @State var showAdminDashboard=true
    var body: some View {
        TabView{
             
            NavigationView {
                          AdminDashboardView()
            }
                           .tabItem {
                               Image(systemName: "plus.square.on.square")

                                   //.foregroundColor(.black)
                               Text("Event")
                                   .bold()
                           }
                           .fullScreenCover(isPresented: $showAdminDashboard) {
                               AdminDashboardView()
                           }
            
            NavigationView {
                        // CommitteeMemberView() // Or create a separate SearchView
                      }
                           .tabItem {

                               Image(systemName: "magnifyingglass")

                                   //.foregroundColor(.black)
                               Text("Search")
                                   .bold()

                           } .fullScreenCover(isPresented: $showAdminDashboard) {
                               AdminDashboardView()
                           }
        }
    }
}

//struct TabitemView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabitemView()
//    }
//}
