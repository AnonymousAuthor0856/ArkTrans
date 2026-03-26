import SwiftUI

@main
struct TaskDashboardApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        TaskDashboardScreen()
            .preferredColorScheme(.light)
            .statusBarHidden(true)
    }
}

// MARK: - Main Screen
struct TaskDashboardScreen: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Background
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Header
                TopHeader()
                    .padding(.top, 48) // Matching Android padding logic roughly for safe area
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                
                // Content
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        Spacer().frame(height: 16)
                        
                        WelcomeSection()
                        
                        Spacer().frame(height: 32)
                        
                        CategorySelector()
                        
                        Spacer().frame(height: 24)
                        
                        RecentTasksList()
                        
                        Spacer().frame(height: 80) // Bottom padding for FAB
                    }
                    .padding(.horizontal, 24)
                }
            }
            
            // FAB
            Button(action: {}) {
                Image(systemName: "plus")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 56, height: 56)
                    .background(Color(red: 0.13, green: 0.13, blue: 0.13)) // #212121
                    .clipShape(Circle())
                    .shadow(radius: 4, y: 4)
            }
            .padding(.trailing, 24)
            .padding(.bottom, 24)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

// MARK: - Header
struct TopHeader: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "line.3.horizontal")
                    .foregroundColor(.black)
                    .frame(width: 48, height: 48)
                    .background(Color(red: 0.96, green: 0.96, blue: 0.96)) // #F5F5F5
                    .clipShape(Circle())
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
                    .frame(width: 48, height: 48)
                    .background(Color(red: 0.96, green: 0.96, blue: 0.96)) // #F5F5F5
                    .clipShape(Circle())
            }
        }
    }
}

// MARK: - Sections
struct WelcomeSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Hello, Alex")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.black)
            
            Text("You have 5 incomplete tasks today.")
                .font(.system(size: 16))
                .foregroundColor(.gray)
        }
    }
}

struct CategorySelector: View {
    let categories = ["All", "Work", "Personal", "Design"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(categories, id: \.self) { category in
                    let isSelected = category == "All"
                    let backgroundColor = isSelected ? Color(red: 0.13, green: 0.13, blue: 0.13) : Color(red: 0.96, green: 0.96, blue: 0.96)
                    let textColor = isSelected ? Color.white : Color.black
                    
                    Text(category)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(textColor)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(backgroundColor)
                        .clipShape(Capsule())
                }
            }
        }
    }
}

struct RecentTasksList: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Recent Tasks")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
                .padding(.bottom, 0) // Padding handled by spacing in VStack
            
            TaskItem(
                title: "Team Meeting",
                time: "10:00 AM - 11:30 AM",
                tag: "Work",
                tagColor: Color(red: 0.89, green: 0.95, blue: 0.99), // #E3F2FD
                tagTextColor: Color(red: 0.08, green: 0.40, blue: 0.75), // #1565C0
                isChecked: true,
                icon: "calendar"
            )
            
            TaskItem(
                title: "Design Review",
                time: "02:00 PM - 03:00 PM",
                tag: "Design",
                tagColor: Color(red: 0.95, green: 0.90, blue: 0.96), // #F3E5F5
                tagTextColor: Color(red: 0.48, green: 0.12, blue: 0.64), // #7B1FA2
                isChecked: false,
                icon: "calendar"
            )
            
            TaskItem(
                title: "Grocery Shopping",
                time: "05:30 PM",
                tag: "Personal",
                tagColor: Color(red: 0.91, green: 0.96, blue: 0.91), // #E8F5E9
                tagTextColor: Color(red: 0.18, green: 0.49, blue: 0.20), // #2E7D32
                isChecked: false,
                icon: "face.smiling.fill" // Approx for Face
            )
            
            TaskItem(
                title: "Read Documentation",
                time: "08:00 PM",
                tag: "Study",
                tagColor: Color(red: 1.00, green: 0.95, blue: 0.88), // #FFF3E0
                tagTextColor: Color(red: 0.94, green: 0.42, blue: 0.00), // #EF6C00
                isChecked: false,
                icon: "calendar"
            )
        }
    }
}

// MARK: - Components
struct TaskItem: View {
    let title: String
    let time: String
    let tag: String
    let tagColor: Color
    let tagTextColor: Color
    @State var isChecked: Bool
    let icon: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            // Icon Box
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.white)
                    .frame(width: 48, height: 48)
                
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.black)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(isChecked ? .gray : .black)
                    .strikethrough(isChecked, color: .gray)
                
                HStack(alignment: .center, spacing: 8) {
                    Text(time)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    Text(tag)
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(tagTextColor)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(tagColor)
                        .cornerRadius(4)
                }
            }
            
            Spacer()
            
            Button(action: {
                isChecked.toggle()
            }) {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(isChecked ? .black : .gray)
            }
        }
        .padding(20)
        .background(Color(red: 0.98, green: 0.98, blue: 0.98)) // #FAFAFA
        .cornerRadius(20)
    }
}