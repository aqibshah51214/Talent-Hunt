import SwiftUI

struct RequestListView: View {
    let requests = [
        Request(title: "Design Creation", designer: "Awais Ali", description: "Design creating competition in BiIT"),
        Request(title: "Design Creation", designer: "Zeeshan Talat", description: "Design creating competition in BiIT"),
        Request(title: "Design Creation", designer: "Syad Agib", description: "Design creating competition in BiIT"),
        Request(title: "Design Creation", designer: "Fazyaab Khan", description: "Design creating competition in BiIT")
    ]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Requests").font(.headline)) {
                    ForEach(requests) { request in
                        RequestCard(request: request)
                    }
                }
            }
            .navigationTitle("9:41")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct Request: Identifiable {
    let id = UUID()
    let title: String
    let designer: String
    let description: String
}

struct RequestCard: View {
    let request: Request
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(request.title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Divider()
            
            Text(request.designer)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(request.description)
                .font(.body)
                .foregroundColor(.primary)
                .padding(.bottom, 8)
            
            HStack {
                Spacer()
                
                Button(action: {
                    // Reject action
                }) {
                    Text("Reject")
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Color.red)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    // Accept action
                }) {
                    Text("Accept")
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Color.green)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.vertical, 4)
    }
}

struct RequestListView_Previews: PreviewProvider {
    static var previews: some View {
        RequestListView()
    }
}
