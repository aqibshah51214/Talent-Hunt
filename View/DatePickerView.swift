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
        VStack(alignment: .leading, spacing: 8) {
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
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        }
        .padding()

        .sheet(isPresented: $showDatePicker) {
            VStack(spacing: 20) {
                Text("Select \(title)")
                    .font(.headline)
                    .padding(.top)

                DatePicker("", selection: $date, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding(.horizontal)

                Button("Done") {
                    showDatePicker = false
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.bottom, 20)
            }
            .padding()
        }
    }
}
