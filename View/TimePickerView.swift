//
//  TimePickerView.swift
//  Talent-Hunt
//
//  Created by MacBook Pro on 17/03/2025.
//

import SwiftUI

struct TimePickerView: View {
    
    
    
        let title: String
        @Binding var date: Date
        @Binding var showDatePicker: Bool

        private var TimeFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.timeStyle = .medium
            return formatter
        }
                    var body: some View {
                        VStack(alignment: .leading) {
                            Text(title)
                                .font(.headline)
                                .foregroundColor(.black)

                            HStack {
                                Text("\(date, formatter: TimeFormatter)")
                                    .font(.headline)
                                    .foregroundColor(.black)

                                Spacer()

                                Button(action: {
                                    showDatePicker.toggle()
                                }) {
                                    Image(systemName: "clock")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(.gray.opacity(1.0))
                                }
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(1)).shadow(radius: 2))
                            .padding(.horizontal, 1)

        //                    if showDatePicker {
        //                        DatePicker("Choose \(title)", selection: $date, displayedComponents: [.hourAndMinute])
        //                            .datePickerStyle(GraphicalDatePickerStyle())
        //                            .labelsHidden()
        //                            .padding()
        //                    }
                            VStack{
                            if showDatePicker {
                                DatePicker("Select Date", selection: $date, displayedComponents: .hourAndMinute)
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

 
//
//struct TimePickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimePickerView()
//    }
//}
