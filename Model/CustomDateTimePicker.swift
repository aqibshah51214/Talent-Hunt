//
//  CustomDateTimePicker.swift
//  Talent-Hunt
//
//  Created by MacBook Pro on 11/03/2025.
//

import Foundation
import SwiftUI

struct CustomDateTimePicker: View {
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Select Date & Time")
                .font(.headline)
                .padding()
            
            DatePicker("Choose Date & Time", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 3))
        }
        .padding()
    }
}

// Preview
//struct CustomDateTimePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomDateTimePicker(selectedDate: .constant(Date()))
//    }
//}

