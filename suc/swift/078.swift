import SwiftUI

@main
struct CourseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        CourseDashboardScreen()
            .preferredColorScheme(.light)
            .statusBarHidden(true)
    }
}

// MARK: - Models
struct Course: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let rating: String
    let bgColor: Color
    let accentColor: Color
    let iconName: String
}

// MARK: - Theme
struct AppTheme {
    static let primary = Color(red: 0.31, green: 0.19, blue: 0.67) // 0xFF4E31AA
    static let secondary = Color(red: 0.23, green: 0.11, blue: 0.44) // 0xFF3A1C71
    static let background = Color(red: 0.96, green: 0.96, blue: 0.97) // 0xFFF5F5F7
    static let surface = Color.white
    static let onBackground = Color(red: 0.11, green: 0.11, blue: 0.12) // 0xFF1C1B1F
    static let progressColor = Color(red: 1.0, green: 0.65, blue: 0.15) // 0xFFFFA726
    static let selectedCategoryColor = Color(red: 1.0, green: 0.44, blue: 0.26) // 0xFFFF7043
}

// MARK: - Main Screen
struct CourseDashboardScreen: View {
    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        HeaderSection()
                        SearchBarSection()
                        OngoingCourseSection()
                        CategoriesSection()
                        RecommendedSection()
                        Spacer().frame(height: 100) // Bottom padding for floating nav bar
                    }
                }
            }
            
            VStack {
                Spacer()
                BottomNavigationBar()
                    .padding(.bottom, 24)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

// MARK: - Sections

struct HeaderSection: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Hello, Sophie")
                    .font(.system(size: 28, weight: .bold)) // HeadlineMedium
                    .foregroundColor(AppTheme.onBackground)
                Text("Let's start learning!")
                    .font(.system(size: 16)) // BodyLarge
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            HStack(spacing: 8) {
                Button(action: {}) {
                    Image(systemName: "bell.fill")
                        .font(.system(size: 24))
                        .foregroundColor(AppTheme.onBackground)
                }
                
                ZStack {
                    Circle()
                        .fill(AppTheme.primary.opacity(0.2))
                        .frame(width: 48, height: 48)
                    
                    Image(systemName: "face.smiling.fill") // Replaced Face
                        .font(.system(size: 24))
                        .foregroundColor(AppTheme.primary)
                }
            }
        }
        .padding(24)
    }
}

struct SearchBarSection: View {
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            Spacer().frame(width: 16)
            
            Text("Search for course...")
                .foregroundColor(Color(UIColor.lightGray))
            
            Spacer()
            
            Image(systemName: "slider.horizontal.3") // Replaced Settings icon for filter
                .foregroundColor(AppTheme.primary)
        }
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background(Color.white)
        .cornerRadius(16)
        .padding(.horizontal, 24)
    }
}

struct OngoingCourseSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Ongoing Course")
                .font(.system(size: 20, weight: .bold)) // TitleLarge
                .foregroundColor(AppTheme.onBackground)
            
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(AppTheme.primary)
                    .frame(height: 140)
                
                HStack(spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("3D Modeling")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.7))
                        
                        Spacer().frame(height: 8)
                        
                        Text("Blender Basic")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                        
                        Spacer().frame(height: 16)
                        
                        HStack(alignment: .center) {
                            Text("75%")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                            
                            Spacer().frame(width: 8)
                            
                            GeometryReader { geometry in
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.white.opacity(0.2))
                                        .frame(height: 6)
                                    
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(AppTheme.progressColor)
                                        .frame(width: geometry.size.width * 0.75, height: 6)
                                }
                            }
                            .frame(height: 6)
                        }
                    }
                    
                    Spacer() // Spacer in HStack to push play button to right
                    
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 60, height: 60)
                        
                        Image(systemName: "play.fill")
                            .font(.system(size: 32)) // Adjusted size
                            .foregroundColor(AppTheme.primary)
                            .offset(x: 2) // Visual center adjustment
                    }
                }
                .padding(20)
            }
        }
        .padding(24)
    }
}

struct CategoriesSection: View {
    let categories = ["Coding", "Design", "Business", "Photo", "Music"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                // Leading padding
                Spacer().frame(width: 12)
                
                ForEach(categories, id: \.self) { category in
                    let isSelected = category == "Design"
                    Text(category)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(isSelected ? .white : .gray)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(isSelected ? AppTheme.selectedCategoryColor : Color.white)
                        .cornerRadius(12)
                }
                
                // Trailing padding
                Spacer().frame(width: 12)
            }
        }
    }
}

struct RecommendedSection: View {
    let courses = [
        Course(title: "Mobile Dev", subtitle: "Android Compose", rating: "4.9", bgColor: Color(red: 0.89, green: 0.95, blue: 0.99), accentColor: Color(red: 0.08, green: 0.40, blue: 0.75), iconName: "checkmark.circle.fill"),
        Course(title: "Photography", subtitle: "Master Lighting", rating: "4.7", bgColor: Color(red: 0.99, green: 0.89, blue: 0.93), accentColor: Color(red: 0.76, green: 0.09, blue: 0.36), iconName: "star.fill"),
        Course(title: "Finance", subtitle: "Crypto Trading", rating: "4.5", bgColor: Color(red: 0.91, green: 0.96, blue: 0.92), accentColor: Color(red: 0.18, green: 0.49, blue: 0.20), iconName: "star.fill")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Recommended")
                    .font(.system(size: 20, weight: .bold)) // TitleLarge
                    .foregroundColor(AppTheme.onBackground)
                Spacer()
                Text("See all")
                    .foregroundColor(.gray)
            }
            
            ForEach(courses) { course in
                CourseCard(course: course)
            }
        }
        .padding(24)
    }
}

struct CourseCard: View {
    let course: Course
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(height: 100)
            
            HStack(spacing: 0) {
                // Left Icon Box
                ZStack {
                    course.bgColor
                    Image(systemName: course.iconName)
                        .font(.system(size: 32))
                        .foregroundColor(course.accentColor)
                }
                .frame(width: 100)
                .clipShape(CustomCornerShape(radius: 20, corners: [.topLeft, .bottomLeft]))
                
                // Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(course.subtitle)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(AppTheme.primary)
                    
                    Text(course.title)
                        .font(.system(size: 16, weight: .bold)) // TitleMedium
                        .foregroundColor(AppTheme.onBackground)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 12)) // Adjusted size
                            .foregroundColor(Color(red: 1.0, green: 0.70, blue: 0.0)) // Amber
                        
                        Text(course.rating)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                .padding(16)
                
                Spacer()
                
                // Favorite Icon
                Button(action: {}) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(Color(UIColor.systemGray5)) // #EEEEEE equivalent usually very light gray
                }
                .padding(.trailing, 16)
            }
        }
        .frame(height: 100)
    }
}

struct BottomNavigationBar: View {
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            Image(systemName: "house.fill")
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            Spacer()
            Image(systemName: "heart.fill")
                .foregroundColor(.gray)
            Spacer()
            Image(systemName: "person.fill")
                .foregroundColor(.gray)
            Spacer()
        }
        .padding(.vertical, 16)
        .background(Color(red: 0.12, green: 0.12, blue: 0.12)) // #1E1E1E
        .cornerRadius(32)
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
        .padding(.horizontal, 24)
    }
}

// MARK: - Helper Shapes
struct CustomCornerShape: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}