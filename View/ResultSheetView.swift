import SwiftUI

struct ResultSheetView: View {
    @State private var searchText = ""
    
    let results = [
        Result(name: "Awais Ali", marks: 9.5),
        Result(name: "Zeeshan", marks: 9.5),
        Result(name: "Fazyaab", marks: 9.5),
        Result(name: "syad Agib", marks: 9.5),
        Result(name: "Qasim Ali", marks: 9.0),
        Result(name: "Kamran", marks: 8.5),
        Result(name: "Hania Shah", marks: 8.5),
        Result(name: "Naeema", marks: 8.0)
    ]
    
    var filteredResults: [Result] {
        if searchText.isEmpty {
            return results
        } else {
            return results.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                Text("Result sheet")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search...", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                // Title Row
                HStack {
                    Text("Title")
                        .font(.headline)
                    Spacer()
                    Text("Design Creation")
                        .font(.subheadline)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color(.systemGray5))
                
                // Column Headers
                HStack {
                    Text("Name")
                        .font(.headline)
                        .frame(width: 150, alignment: .leading)
                    Spacer()
                    Text("Marks")
                        .font(.headline)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                // Results List
                List(filteredResults) { result in
                    HStack {
                        Text(result.name)
                            .frame(width: 150, alignment: .leading)
                        Spacer()
                        Text(String(format: "%.1f", result.marks))
                            .fontWeight(.medium)
                    }
                    .padding(.vertical, 8)
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarHidden(true)
        }
    }
}

struct Result: Identifiable {
    let id = UUID()
    let name: String
    let marks: Double
}

struct ResultSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ResultSheetView()
    }
}
