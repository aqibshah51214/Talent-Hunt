import SwiftUI

struct DrawerMenuView: View {
    @State private var activeScreen = "Home"
    @State private var isDrawerOpen = false

    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    // Active screen content
                    switch activeScreen {
                    case "Home":
                        Text("Home Screen")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .background(activeScreen == "Home" ? .blue : .red)
                    case "Counter":
                        Text("Counter Screen")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(activeScreen == "Counter" ? .blue : .black)
                    case "Calculator":
                        Text("Calculator Screen")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(activeScreen == "Calculator" ? .blue : .black)
                    case "Discount":
                        Text("Discount Screen")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(activeScreen == "Discount" ? .blue : .black)
                    default:
                        Text("Unknown Screen")
                            .foregroundColor(.black)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            withAnimation {
                                isDrawerOpen.toggle()
                            }
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .imageScale(.large)
                                .padding()
                        }
                    }
                }
            }
            // Drawer menu
            if isDrawerOpen {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isDrawerOpen = false
                        }
                    }

                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.black)
                            Text("User Name")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        .padding(.bottom, 20)

                        Divider()

                        Button(action: {
                            setActiveScreen("Home")
                        }) {
                            DrawerMenuItem(icon: "house", title: "Home", isSelected: activeScreen == "Home")
                        }

                        Button(action: {
                            setActiveScreen("Counter")
                        }) {
                            DrawerMenuItem(icon: "number", title: "Counter", isSelected: activeScreen == "Counter")
                        }

                        Button(action: {
                            setActiveScreen("Calculator")
                        }) {
                            DrawerMenuItem(icon: "plus.slash.minus", title: "Calculator", isSelected: activeScreen == "Calculator")
                        }

                        Button(action: {
                            setActiveScreen("Discount")
                        }) {
                            DrawerMenuItem(icon: "percent", title: "Discount", isSelected: activeScreen == "Discount")
                        }

                        Spacer()
                    }
                    .padding()
                    .frame(width: 250)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)

                    Spacer()
                }
                .transition(.move(edge: .leading))
                .ignoresSafeArea()
            }
        }
    }

    private func setActiveScreen(_ screen: String) {
        activeScreen = screen
        withAnimation {
            isDrawerOpen = false
        }
    }
}

struct DrawerMenuItem: View {
    let icon: String
    let title: String
    let isSelected: Bool

    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 30)
                .foregroundColor(isSelected ? .blue : .gray)
            Text(title)
                .font(.body)
                .foregroundColor(isSelected ? .blue : .black)
        }
        .padding(.vertical, 10)
    }
}

struct DrawerMenuView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerMenuView()
    }
}
