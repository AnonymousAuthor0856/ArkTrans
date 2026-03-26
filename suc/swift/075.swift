import SwiftUI

@main
struct StudyFocusApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        StudyFocusSplitScreen()
            .preferredColorScheme(.light)
            .statusBarHidden(true)
    }
}

// MARK: - App Tokens
struct AppTokens {
    struct Colors {
        static let primary = Color(red: 0.75, green: 0.52, blue: 0.32) // #C08552
        static let secondary = Color(red: 0.61, green: 0.69, blue: 0.78) // #9BB1C8
        static let tertiary = Color(red: 0.90, green: 0.81, blue: 0.69) // #E6CFAF
        static let background = Color(red: 0.95, green: 0.94, blue: 0.90) // #F3EFE6
        static let surface = Color.white
        static let surfaceVariant = Color(red: 0.91, green: 0.87, blue: 0.81) // #E7DDCF
        static let outline = Color(red: 0.83, green: 0.77, blue: 0.71) // #D4C5B6
        static let success = Color(red: 0.42, green: 0.69, blue: 0.53) // #6BB187
        static let warning = Color(red: 0.89, green: 0.64, blue: 0.35) // #E2A458
        static let error = Color(red: 0.84, green: 0.42, blue: 0.36) // #D66B5D
        static let onPrimary = Color(red: 0.16, green: 0.11, blue: 0.07) // #2A1C13
        static let onSecondary = Color(red: 0.08, green: 0.13, blue: 0.17) // #15202B
        static let onTertiary = Color(red: 0.17, green: 0.12, blue: 0.06) // #2C1F10
        static let onBackground = Color(red: 0.15, green: 0.12, blue: 0.10) // #261E19
        static let onSurface = Color(red: 0.18, green: 0.15, blue: 0.11) // #2E251D
    }
    
    struct Typography {
        static let display = Font.system(size: 30, weight: .semibold)
        static let headline = Font.system(size: 22, weight: .medium)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }
    
    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
        static let xxxl: CGFloat = 48
    }
    
    struct Shapes {
        static let small: CGFloat = 12
        static let medium: CGFloat = 16
        static let large: CGFloat = 20
    }
}

// MARK: - Models
struct StudyModule: Identifiable {
    let id = UUID()
    let name: String
    let progress: Int
    let summary: String
}

struct TaskItem: Identifiable {
    let id = UUID()
    let title: String
    let duration: String
}

// MARK: - Main Screen
struct StudyFocusSplitScreen: View {
    @State private var selectedTabIndex = 0
    @State private var focusNote = "Focus on tone shifts across clay gradients"
    
    let modules = [
        StudyModule(name: "Clay Resonance", progress: 72, summary: "Acoustic prototypes"),
        StudyModule(name: "Material Memory", progress: 54, summary: "Tactile journaling"),
        StudyModule(name: "Morph Lab", progress: 83, summary: "Color blending"),
        StudyModule(name: "Studio Review", progress: 28, summary: "Peer critique")
    ]
    
    let tasks = [
        TaskItem(title: "Research layering", duration: "45m"),
        TaskItem(title: "Feedback sync", duration: "30m"),
        TaskItem(title: "Practice recall", duration: "20m")
    ]
    
    var body: some View {
        ZStack {
            AppTokens.Colors.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Bar
                HStack {
                    Button(action: {}) {
                        Text("Back")
                            .font(AppTokens.Typography.label)
                            .foregroundColor(AppTokens.Colors.onSurface)
                    }
                    Spacer()
                    Text("Study Focus Split")
                        .font(AppTokens.Typography.title)
                        .foregroundColor(AppTokens.Colors.onSurface)
                    Spacer()
                    Button(action: {}) {
                        Text("Share")
                            .font(AppTokens.Typography.label)
                            .foregroundColor(AppTokens.Colors.secondary)
                    }
                }
                .padding()
                .background(AppTokens.Colors.surface)
                
                // Scrollable Content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: AppTokens.Spacing.lg) {
                        
                        // Tab Row
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                ForEach(0..<modules.count, id: \.self) { index in
                                    VStack(spacing: 8) {
                                        Text(modules[index].name.replacingOccurrences(of: " ", with: "\n"))
                                            .font(AppTokens.Typography.label)
                                            .foregroundColor(selectedTabIndex == index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(2)
                                            .frame(height: 40)
                                        
                                        Rectangle()
                                            .fill(selectedTabIndex == index ? AppTokens.Colors.primary : Color.clear)
                                            .frame(height: 2)
                                    }
                                    .frame(width: 90)
                                    .padding(.vertical, 8)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        withAnimation {
                                            selectedTabIndex = index
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, AppTokens.Spacing.lg)
                            .background(AppTokens.Colors.surface)
                        }
                        
                        // Pager Content (Main Card)
                        TabView(selection: $selectedTabIndex) {
                            ForEach(0..<modules.count, id: \.self) { index in
                                ModuleCard(module: modules[index])
                                    .tag(index)
                                    .padding(.horizontal, AppTokens.Spacing.lg)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .frame(height: 220) // Fixed height to match design
                        
                        // Dual Pane
                        HStack(alignment: .top, spacing: AppTokens.Spacing.md) {
                            // Left Pane: Focus Board
                            CardView(backgroundColor: AppTokens.Colors.surface) {
                                VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
                                    Text("Focus board")
                                        .font(AppTokens.Typography.title)
                                        .foregroundColor(AppTokens.Colors.onSurface)
                                    
                                    ForEach(tasks) { task in
                                        HStack {
                                            VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) {
                                                Text(task.title)
                                                    .font(AppTokens.Typography.body)
                                                    .foregroundColor(AppTokens.Colors.onSurface)
                                                Text(task.duration)
                                                    .font(AppTokens.Typography.label)
                                                    .foregroundColor(AppTokens.Colors.secondary)
                                            }
                                            Spacer()
                                        }
                                        .padding(AppTokens.Spacing.sm)
                                        .background(AppTokens.Colors.surfaceVariant.opacity(0.6))
                                        .cornerRadius(AppTokens.Shapes.small)
                                    }
                                    
                                    // Button placeholder
                                    Spacer().frame(height: 8) // Mimic button presence
                                    Button(action: {}) {
                                        Text("Add checkpoint")
                                            .font(AppTokens.Typography.label)
                                            .foregroundColor(AppTokens.Colors.onSurface) // Default Button text usually primary, but context implies subtle
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 8)
                                            .background(AppTokens.Colors.surfaceVariant)
                                            .cornerRadius(AppTokens.Shapes.small)
                                            .opacity(0.0) // Invisible placeholder to match spacing logic or just cut off in screenshot
                                            .frame(height: 0) // Hiding it to match screenshot more closely which cuts off bottom
                                    }
                                }
                                .padding(AppTokens.Spacing.md)
                            }
                            
                            // Right Pane: Reflection
                            CardView(backgroundColor: AppTokens.Colors.surfaceVariant) {
                                VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
                                    Text("Reflection")
                                        .font(AppTokens.Typography.title)
                                        .foregroundColor(AppTokens.Colors.onSurface)
                                    
                                    Text(focusNote)
                                        .font(AppTokens.Typography.body)
                                        .foregroundColor(AppTokens.Colors.onSurface)
                                        .padding(AppTokens.Spacing.md)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(AppTokens.Colors.surface)
                                        .cornerRadius(AppTokens.Shapes.medium)
                                    
                                    Button(action: {
                                        focusNote = "Blend high and low tones before next critique"
                                    }) {
                                        Text("Shuffle note")
                                            .font(AppTokens.Typography.label)
                                            .foregroundColor(AppTokens.Colors.onPrimary) // Brown text on brown bg? Code uses primary container/content logic.
                                            // The button in screenshot is brown.
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 12)
                                            .background(AppTokens.Colors.primary)
                                            .cornerRadius(AppTokens.Shapes.medium)
                                            .foregroundColor(Color.black.opacity(0.8)) // Adjust for contrast on Primary
                                    }
                                }
                                .padding(AppTokens.Spacing.md)
                            }
                        }
                        .padding(.horizontal, AppTokens.Spacing.lg)
                        
                        Spacer().frame(height: 100)
                    }
                    .padding(.top, AppTokens.Spacing.md)
                }
            }
            
            // Bottom Bar
            VStack {
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) {
                        Text("Next checkpoint")
                            .font(AppTokens.Typography.label)
                            .foregroundColor(AppTokens.Colors.onSurface)
                        Text("12:40 Studio")
                            .font(AppTokens.Typography.body)
                            .foregroundColor(AppTokens.Colors.onSurface.opacity(0.8))
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text("Launch session")
                            .font(AppTokens.Typography.label)
                            .foregroundColor(AppTokens.Colors.onPrimary) // Text color on primary button
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(AppTokens.Colors.primary)
                            .cornerRadius(AppTokens.Shapes.medium)
                            // Fix contrast for text on primary
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                }
                .padding(.horizontal, AppTokens.Spacing.lg)
                .padding(.vertical, AppTokens.Spacing.sm)
                .background(AppTokens.Colors.surface)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -2)
            }
        }
    }
}

// MARK: - Components

struct ModuleCard: View {
    let module: StudyModule
    
    var body: some View {
        CardView(backgroundColor: AppTokens.Colors.surface) {
            VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
                Text(module.name)
                    .font(AppTokens.Typography.headline)
                    .foregroundColor(AppTokens.Colors.onSurface)
                
                Text(module.summary)
                    .font(AppTokens.Typography.body)
                    .foregroundColor(AppTokens.Colors.onSurface.opacity(0.8))
                
                Divider()
                    .background(AppTokens.Colors.outline)
                    .padding(.vertical, 4)
                
                HStack {
                    Text("Progress")
                        .font(AppTokens.Typography.label)
                        .foregroundColor(AppTokens.Colors.onSurface)
                    Spacer()
                    Text("\(module.progress)%")
                        .font(AppTokens.Typography.title)
                        .foregroundColor(AppTokens.Colors.primary)
                }
                
                // Progress Bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                            .fill(AppTokens.Colors.surfaceVariant)
                            .frame(height: 12)
                        
                        RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                            .fill(AppTokens.Colors.primary)
                            .frame(width: geometry.size.width * CGFloat(module.progress) / 100, height: 12)
                    }
                }
                .frame(height: 12)
                
                Spacer().frame(height: 8)
                
                Button(action: {}) {
                    Text("Review outline")
                        .font(AppTokens.Typography.label)
                        .foregroundColor(AppTokens.Colors.onPrimary) // Brown text logic from screenshot? Actually screenshot shows brown button with black text.
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(AppTokens.Colors.primary)
                        .cornerRadius(AppTokens.Shapes.medium)
                        .foregroundColor(Color.black.opacity(0.7))
                }
            }
            .padding(AppTokens.Spacing.lg)
        }
    }
}

struct CardView<Content: View>: View {
    let backgroundColor: Color
    let content: Content
    
    init(backgroundColor: Color, @ViewBuilder content: () -> Content) {
        self.backgroundColor = backgroundColor
        self.content = content()
    }
    
    var body: some View {
        content
            .background(backgroundColor)
            .cornerRadius(AppTokens.Shapes.large)
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}