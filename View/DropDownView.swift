//
//  DropDownView.swift
//  Talent-Hunt
//
//  Created by MacBook Pro on 10/03/2025.
//

import SwiftUI

struct DropDownView: View {
    public var options: [String]
    @State   public var isDropdownOpen: Bool = false
    @Binding public var selectedOption: String
    var body: some View {
       
          
           
          
               VStack(alignment: .leading, spacing: 8) {
                   // Dropdown Button
                   Button(action: {
                       withAnimation(.easeInOut) {
                           isDropdownOpen.toggle()
                           print("Selected Role in drop side: \(selectedOption)")
                       }
                   }) {
                       HStack {
                           Text(selectedOption)
                               .foregroundColor(.black)
                               .padding(.vertical, 10)
                           
                           Spacer()
                           
                           Image(systemName: isDropdownOpen ? "chevron.up" : "chevron.down")
                               .foregroundColor(.gray)
                       }
                       .padding(.horizontal)
                       .padding(.vertical,10)
                       .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                       .shadow(color: Color.black.opacity(0.1), radius: 5)
                   }
                   
                   // Dropdown List
                   if isDropdownOpen {
                       VStack(spacing: 5) {
                           ForEach(options, id: \.self) { option in
                               Button(action: {
                                   withAnimation {
                                       selectedOption = option
                                       isDropdownOpen = false
                                   }
                               }) {
                                   HStack {
                                       Text(option)
                                           .foregroundColor(.black)
                                       
                                       Spacer()
                                       
                                       if selectedOption == option {
                                           Image(systemName: "checkmark")
                                               .foregroundColor(.blue)
                                           
                                       }
                                       
                                   }
                                   .padding()
                                   .background(Color.white)
                               }
                               .cornerRadius(8)
                               
                           }
                           
                       }
                       .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                       .shadow(color: Color.black.opacity(0.1), radius: 5)
                       .transition(.opacity.combined(with: .move(edge: .top)))
                   }
               }
               .padding(.horizontal)
           }
       }
    


//struct DropDownView_Previews: PreviewProvider {
//    static var previews: some View {
//        DropDownView()
//    }
//}
