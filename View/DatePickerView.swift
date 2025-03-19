//
//  DatePickerView.swift
//  Talent-Hunt
//
//  Created by MacBook Pro on 12/03/2025.
//

import SwiftUI

struct DatePickerView: View {
   
        
            let title: String
            @Binding var date: Date
            @Binding var showDatePicker: Bool

            private var dateFormatter: DateFormatter {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                return formatter
            }

            var body: some View {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.black)

                    HStack {
                        Text("\(date, formatter: dateFormatter)")
                            .font(.headline)
                            .foregroundColor(.black)

                        Spacer()

                        Button(action: {
                            showDatePicker.toggle()
                        }) {
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.gray.opacity(1))
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.2)).shadow(radius: 2))
                    .padding(.horizontal, 1)

//                    if showDatePicker {
//                        DatePicker("Choose \(title)", selection: $date, displayedComponents: [.hourAndMinute])
//                            .datePickerStyle(GraphicalDatePickerStyle())
//                            .labelsHidden()
//                            .padding()
//                    }
                    VStack{
                    if showDatePicker {
                        DatePicker("Select Date", selection: $date, displayedComponents: .date)
                                       .datePickerStyle(GraphicalDatePickerStyle())
                                       .padding()
                                       .background(Color.white)
                                       .cornerRadius(15)
                                       .padding(.horizontal)

                                   Button("Done") {
                                       showDatePicker=false
                                   }
                                   .font(.headline)
                                   .foregroundColor(.white)
                                   .padding()
                                   .background(Color.blue)
                                   .cornerRadius(10)
                                   .padding(.bottom, 20)

                                   Spacer()
                               }
                    }

                               .transition(.move(edge: .bottom))
                               .animation(.easeInOut)
                
                }
                .padding(.horizontal)
            }
    }


//struct DatePickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        DatePickerView()
//    }
//}
