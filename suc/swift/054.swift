import SwiftUI
import UIKit // Required for UIWindowScene and UIHostingController

// MARK: - AppTokens (Kotlin to Swift Translation)

// Dp values in Kotlin Compose are typically 1:1 with CGFloat points on iOS.
// Using CGFloat for all dimensions for consistency and easy modification.
struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF0EA5E9)
        static let secondary = Color(hex: 0xFF6366F1)
        static let tertiary = Color(hex: 0xFF06B6D4)
        static let background = Color(hex: 0xFFF1F5F9)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFE2E8F0)
        static let outline = Color(hex: 0xFFD1D5DB)
        static let success = Color(hex: 0xFF10B981)
        static let warning = Color(hex: 0xFFF59E0B)
        static let error = Color(hex: 0xFFEF4444)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFFFFFFFF)
        static let onTertiary = Color(hex: 0xFF0F172A)
        static let onBackground = Color(hex: 0xFF1E293B)
        static let onSurface = Color(hex: 0xFF1E293B)
    }

    struct TypographyTokens {
        // SwiftUI's Font system is slightly different; we map to system fonts with specified size and weight.
        static let display = Font.system(size: 26, weight: .bold)
        static let headline = Font.system(size: 18, weight: .semibold)
        static let title = Font.system(size: 14, weight: .medium)
        static let body = Font.system(size: 12, weight: .regular)
        static let label = Font.system(size: 11, weight: .medium)
    }

    struct Shapes {
        // Corner radius values
        static let small: CGFloat = 6.0
        static let medium: CGFloat = 10.0
        static let large: CGFloat = 14.0
    }

    struct Spacing {
        // Spacing values
        static let xs: CGFloat = 2.0
        static let sm: CGFloat = 6.0
        static let md: CGFloat = 10.0
        static let lg: CGFloat = 14.0
        static let xl: CGFloat = 20.0
        static let xxl: CGFloat = 28.0
    }

    // Kotlin's ShadowSpec maps to SwiftUI's .shadow(color:radius:x:y:)
    // Note: elevation in Compose often relates to shadow spread/blur (radius) and opacity.
    // dy maps to y, radius to radius.
    struct ShadowSpec {
        let radius: CGFloat
        let x: CGFloat
        let y: CGFloat
        let opacity: Double // SwiftUI uses Double for opacity
    }

    struct ElevationMapping {
        // Kotlin: elevation: Dp, radius: Dp, dy: Dp, opacity: Float
        // Swift: radius: CGFloat, x: CGFloat, y: CGFloat, opacity: Double
        static let level1 = ShadowSpec(radius: 2, x: 0, y: 1, opacity: 0.1)
        static let level2 = ShadowSpec(radius: 4, x: 0, y: 2, opacity: 0.14)
        static let level3 = ShadowSpec(radius: 6, x: 0, y: 3, opacity: 0.16)
    }
}

// MARK: - Color Extension for Hex Initialization

extension Color {
    /// Initializes a Color from a 32-bit hex integer (0xAARRGGBB or 0xRRGGBB).
    /// If alpha is not provided in hex (e.g., 0xRRGGBB), it defaults to opaque (0xFF).
    init(hex: UInt) {
        let r = Double((hex >> 16) & 0xFF) / 255.0
        let g = Double((hex >> 8) & 0xFF) / 255.0
        let b = Double(hex & 0xFF) / 255.0
        let a = Double((hex >> 24) & 0xFF) / 255.0 // Extract alpha component
        
        // If alpha component is 0, it means it was likely a 0xRRGGBB format, so default to 1.0 (opaque)
        self.init(red: r, green: g, blue: b, opacity: a == 0 ? 1.0 : a)
    }
}

// MARK: - Data Models

// Identifiable protocol is required for ForEach loops in SwiftUI
struct Homework: Identifiable {
    let id: Int
    let title: String
    let status: String
}

struct ChartData: Identifiable {
    let id: Int
    let label: String
    let progress: Float // Using Float to match Kotlin's Float
}

// MARK: - RootScreen (Main UI View)

struct RootScreen: View {
    // Data for assignments, equivalent to `remember { listOf(...) }`
    let works: [Homework] = [
        Homework(id: 1, title: "Linear Algebra HW1", status: "Submitted"),
        Homework(id: 2, title: "Data Structures HW2", status: "Pending"),
        Homework(id: 3, title: "Algorithm HW3", status: "Graded"),
        Homework(id: 4, title: "Probability HW4", status: "Pending")
    ]
    
    // Data for charts, equivalent to `remember { mutableStateListOf(...) }`
    @State private var charts: [ChartData] = [
        ChartData(id: 1, label: "Week 1", progress: 0.7),
        ChartData(id: 2, label: "Week 2", progress: 0.9),
        ChartData(id: 3, label: "Week 3", progress: 0.5),
        ChartData(id: 4, label: "Week 4", progress: 0.8)
    ]

    var body: some View {
        // Equivalent to Scaffold with containerColor and contentWindowInsets(0)
        // For full screen and status bar hidden, we use ignoresSafeArea() and
        // a custom UIHostingController setup in the App entry point.
        ZStack {
            // Background color for the entire screen, including under the top bar
            AppTokens.Colors.background.ignoresSafeArea()

            VStack(spacing: 0) { // Scaffold typically has no spacing between topBar and content
                // MARK: - TopAppBar Equivalent
                HStack {
                    Text("Homework Submit")
                        .font(AppTokens.TypographyTokens.display)
                        .foregroundColor(AppTokens.Colors.onBackground)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, AppTokens.Spacing.lg) // Adjust padding to match Material3 TopAppBar height
                .background(AppTokens.Colors.surface) // Top bar background
                // If a shadow is desired for the top bar, add it here:
                // .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity), radius: AppTokens.ElevationMapping.level1.radius, x: AppTokens.ElevationMapping.level1.x, y: AppTokens.ElevationMapping.level1.y)

                // MARK: - Main Content Area
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: AppTokens.Spacing.lg) { // verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
                        Text("Assignments")
                            .font(AppTokens.TypographyTokens.headline)
                            .foregroundColor(AppTokens.Colors.onBackground)

                        // MARK: - LazyVerticalGrid Equivalent
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: AppTokens.Spacing.md), // GridCells.Fixed(2)
                                GridItem(.flexible())
                            ],
                            spacing: AppTokens.Spacing.md // verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md), horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
                        ) {
                            ForEach(works) { w in
                                AssignmentCard(homework: w)
                            }
                        }
                        .padding(.bottom, AppTokens.Spacing.lg) // contentPadding = PaddingValues(bottom = AppTokens.Spacing.lg)

                        Text("Progress Chart")
                            .font(AppTokens.TypographyTokens.headline)
                            .foregroundColor(AppTokens.Colors.onBackground)

                        // MARK: - LazyColumn Equivalent
                        VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) { // verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
                            ForEach(charts) { c in
                                ChartProgressBar(chartData: c)
                            }
                        }

                        // MARK: - Submit Button
                        Button(action: {
                            // Handle Submit New HW action
                            print("Submit New HW Tapped")
                        }) {
                            Text("Submit New HW")
                                .font(AppTokens.TypographyTokens.title)
                                .foregroundColor(AppTokens.Colors.onSecondary)
                                .frame(maxWidth: .infinity) // Ensures text fills button width
                                .frame(height: 40) // height(40.dp)
                                .background(AppTokens.Colors.secondary)
                                .cornerRadius(AppTokens.Shapes.large) // shape = AppTokens.Shapes.large
                        }
                        // Modifier.align(Alignment.CenterHorizontally).height(40.dp).fillMaxWidth(0.6f)
                        // fillMaxWidth(0.6f) is relative to the parent's available width *after* padding.
                        // The parent Column has .padding(AppTokens.Spacing.lg).
                        // So, available width = screen_width - 2 * AppTokens.Spacing.lg.
                        // Button width = (available_width) * 0.6
                        .frame(maxWidth: (UIScreen.main.bounds.width - 2 * AppTokens.Spacing.lg) * 0.6)
                        .frame(height: 40) // Ensure button height is applied to the button itself
                        .padding(.top, AppTokens.Spacing.lg) // Add some padding above the button for visual separation
                        .frame(maxWidth: .infinity, alignment: .center) // align(Alignment.CenterHorizontally)
                    }
                    .padding(AppTokens.Spacing.lg) // .padding(AppTokens.Spacing.lg) applied to the Column
                }
                .background(
                    LinearGradient( // Brush.verticalGradient
                        gradient: Gradient(colors: [
                            AppTokens.Colors.primary.opacity(0.15),
                            AppTokens.Colors.secondary.opacity(0.1)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
        .ignoresSafeArea(.all) // Make content go under status bar and home indicator
    }
}

// MARK: - AssignmentCard Component (Equivalent to Card in LazyVerticalGrid)

struct AssignmentCard: View {
    let homework: Homework

    var body: some View {
        VStack(alignment: .center, spacing: AppTokens.Spacing.sm) { // verticalArrangement = Arrangement.Center, horizontalAlignment = Alignment.CenterHorizontally
            // Box(modifier = Modifier.size(40.dp).background(AppTokens.Colors.tertiary, AppTokens.Shapes.small))
            Rectangle()
                .fill(AppTokens.Colors.tertiary)
                .frame(width: 40, height: 40) // size(40.dp)
                .cornerRadius(AppTokens.Shapes.small) // background(..., AppTokens.Shapes.small)
            
            Spacer() // Spacer(modifier = Modifier.height(AppTokens.Spacing.sm)) - this is handled by VStack spacing
            
            Text(homework.title)
                .font(AppTokens.TypographyTokens.title)
                .foregroundColor(AppTokens.Colors.onSurface)
            Text(homework.status)
                .font(AppTokens.TypographyTokens.label)
                .foregroundColor(AppTokens.Colors.onSurface)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // fillMaxSize()
        .padding(AppTokens.Spacing.md) // padding(AppTokens.Spacing.md)
        .background(AppTokens.Colors.surface) // containerColor = MaterialTheme.colorScheme.surface
        .cornerRadius(AppTokens.Shapes.medium) // shape = AppTokens.Shapes.medium
        .overlay(
            // border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.medium)
            RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                .stroke(AppTokens.Colors.outline, lineWidth: 1)
        )
        .aspectRatio(1.0, contentMode: .fit) // aspectRatio(1f)
    }
}

// MARK: - ChartProgressBar Component (Equivalent to Row in LazyColumn)

struct ChartProgressBar: View {
    let chartData: ChartData

    var body: some View {
        VStack(alignment: .leading, spacing: 0) { // No explicit spacing between bar and text in Kotlin, so 0
            GeometryReader { geometry in
                HStack(spacing: 0) { // Row equivalent
                    // Box(modifier = Modifier.fillMaxWidth(c.progress).background(AppTokens.Colors.primary, AppTokens.Shapes.small))
                    Rectangle()
                        .fill(AppTokens.Colors.primary)
                        .frame(width: geometry.size.width * CGFloat(chartData.progress))
                        .cornerRadius(AppTokens.Shapes.small)
                    Spacer() // To push the filled part to the left
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) // fillMaxWidth(), height(24.dp)
                .background(AppTokens.Colors.surfaceVariant) // background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.small)
                .cornerRadius(AppTokens.Shapes.small) // Apply corner radius to the whole bar container
            }
            .frame(height: 24) // height(24.dp)
            .frame(maxWidth: .infinity) // fillMaxWidth()

            // Text("${c.label}: ${(c.progress * 100).toInt()}%", style = MaterialTheme.typography.bodyMedium, color = MaterialTheme.colorScheme.onSurface)
            Text("\(chartData.label): \(Int(chartData.progress * 100))%")
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.onSurface)
        }
    }
}

// MARK: - App Entry Point (Equivalent to MainActivity)

// Custom UIHostingController to hide the status bar
class CustomHostingController<Content>: UIHostingController<Content> where Content : View {
    override var prefersStatusBarHidden: Bool {
        return true // Hide the status bar
    }
    
    // Ensure the view extends to the edges
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear // Make sure the hosting controller's background is clear
    }
}

@main
struct SingleFileUIApp: App {
    var body: some Scene {
        WindowGroup {
            // Wrap RootScreen in a custom UIHostingController to hide the status bar
            RootScreen()
                .preferredColorScheme(.light) // Match Kotlin's lightColorScheme
                // The CustomHostingController handles prefersStatusBarHidden.
                // We need to explicitly set the root view controller of the window
                // to our CustomHostingController. This is typically done in SceneDelegate
                // or by directly creating the UIHostingController in the WindowGroup.
                // For a simple @main App, SwiftUI handles the UIHostingController creation,
                // so we need to override its behavior.
                // The common way to achieve this for a SwiftUI App is to use a custom
                // UIHostingController and ensure it's the root.
                .onAppear {
                    // This block ensures the status bar preference is updated when the view appears.
                    // It's a common pattern for SwiftUI apps that need to control the status bar.
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        if let rootVC = windowScene.windows.first?.rootViewController as? UIHostingController<RootScreen> {
                            // Replace the default UIHostingController with our custom one
                            // This part is tricky in @main App lifecycle.
                            // A more robust solution for status bar hiding in @main App
                            // is to create a custom App structure that manages the window directly,
                            // or rely solely on the CustomHostingController's prefersStatusBarHidden
                            // which should be picked up by SwiftUI's internal UIHostingController.
                            // For iOS 16, prefersStatusBarHidden in UIHostingController is the primary mechanism.
                            rootVC.setNeedsStatusBarAppearanceUpdate()
                        } else {
                            // Fallback if the rootVC isn't directly our type (e.g., if SwiftUI wraps it)
                            windowScene.windows.first?.rootViewController?.setNeedsStatusBarAppearanceUpdate()
                        }
                    }
                }
                .statusBarHidden(true) // Ensure status bar is hidden for the entire app
        }
    }
}

// MARK: - Preview (Equivalent to @Preview)

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
            .previewDisplayName("Homework Submit UI")
    }
}