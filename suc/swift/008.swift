import SwiftUI

enum HealthDashboardTokens {
    enum Colors {
        static let primary = Color(red: 99 / 255, green: 102 / 255, blue: 241 / 255)
        static let secondary = Color(red: 236 / 255, green: 72 / 255, blue: 153 / 255)
        static let tertiary = Color(red: 16 / 255, green: 185 / 255, blue: 129 / 255)
        static let background = Color(red: 248 / 255, green: 250 / 255, blue: 252 / 255)
        static let surface = Color.white
        static let surfaceVariant = Color(red: 241 / 255, green: 245 / 255, blue: 249 / 255)
        static let outline = Color(red: 226 / 255, green: 232 / 255, blue: 240 / 255)
        static let error = Color(red: 239 / 255, green: 68 / 255, blue: 68 / 255)
        static let onPrimary = Color.white
        static let onBackground = Color(red: 15 / 255, green: 23 / 255, blue: 42 / 255)
        static let onSurface = Color(red: 15 / 255, green: 23 / 255, blue: 42 / 255)
    }

    enum Typography {
        static let display = Font.system(size: 24, weight: .bold)
        static let headline = Font.system(size: 20, weight: .semibold)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
        static let small = Font.system(size: 10, weight: .regular)
    }

    enum Shapes {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
    }

    enum Spacing {
        static let xs: CGFloat = 2
        static let sm: CGFloat = 4
        static let md: CGFloat = 8
        static let lg: CGFloat = 12
        static let xl: CGFloat = 16
        static let xxl: CGFloat = 20
        static let xxxl: CGFloat = 24
    }

    struct ShadowSpec {
        let radius: CGFloat
        let y: CGFloat
        let opacity: Double
    }

    enum Elevation {
        static let level1 = ShadowSpec(radius: 4, y: 1, opacity: 0.15)
        static let level2 = ShadowSpec(radius: 8, y: 2, opacity: 0.18)
        static let level3 = ShadowSpec(radius: 12, y: 3, opacity: 0.22)
        static let level4 = ShadowSpec(radius: 16, y: 4, opacity: 0.25)
    }
}

struct HealthMetric: Identifiable {
    let id: Int
    let title: String
    let value: String
    let unit: String
    let color: Color
}

struct Workout: Identifiable {
    let id: Int
    let name: String
    let duration: String
    let calories: String
    let iconColor: Color
}

struct NavItem: Identifiable {
    let id: Int
    let label: String
}

struct HealthDashboardAppView: View {
    @State private var selectedNav: Int = 0

    private let metrics: [HealthMetric] = [
        HealthMetric(id: 1, title: "Heart", value: "72", unit: "bpm", color: HealthDashboardTokens.Colors.secondary),
        HealthMetric(id: 2, title: "Steps", value: "842", unit: "steps", color: HealthDashboardTokens.Colors.primary),
        HealthMetric(id: 3, title: "Sleep", value: "7.2", unit: "hours", color: HealthDashboardTokens.Colors.tertiary),
        HealthMetric(id: 4, title: "Calories", value: "420", unit: "kcal", color: HealthDashboardTokens.Colors.error)
    ]

    private let workouts: [Workout] = [
        Workout(id: 1, name: "Morning Run", duration: "32 min", calories: "284 kcal", iconColor: HealthDashboardTokens.Colors.primary),
        Workout(id: 2, name: "Yoga Flow", duration: "45 min", calories: "156 kcal", iconColor: HealthDashboardTokens.Colors.secondary),
        Workout(id: 3, name: "Strength Training", duration: "28 min", calories: "320 kcal", iconColor: HealthDashboardTokens.Colors.tertiary)
    ]

    private let navItems: [NavItem] = [
        NavItem(id: 0, label: "Dashboard"),
        NavItem(id: 1, label: "Workouts"),
        NavItem(id: 2, label: "Nutrition"),
        NavItem(id: 3, label: "Profile")
    ]

    private let bottomBarHeight: CGFloat = 72

    var body: some View {
        ZStack(alignment: .bottom) {
            HealthDashboardTokens.Colors.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                topBar
                    .padding(.top, 40)
                    .padding(.bottom, 20)
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: HealthDashboardTokens.Spacing.lg) {
                        heroCard
                        sectionTitle("Today's Metrics")
                        metricsRow
                        recentWorkoutsHeader
                            .padding(.vertical, 10)
                        ForEach(workouts) { workout in
                            workoutCard(workout)
                        }
                    }
                    .padding(.horizontal, HealthDashboardTokens.Spacing.md)
                    .padding(.bottom, bottomBarHeight + HealthDashboardTokens.Spacing.lg)
                }
            }

            bottomNavigation
                .padding(.horizontal, HealthDashboardTokens.Spacing.md)
                .padding(.bottom, HealthDashboardTokens.Spacing.md)
        }
        .statusBarHidden(true)
    }

    private var topBar: some View {
        Text("Health Dashboard")
            .font(HealthDashboardTokens.Typography.display)
            .foregroundColor(HealthDashboardTokens.Colors.onBackground)
            .frame(maxWidth: .infinity)
            .padding(.top, HealthDashboardTokens.Spacing.xxl)
            .padding(.bottom, HealthDashboardTokens.Spacing.md)
    }

    private var heroCard: some View {
        VStack(alignment: .leading, spacing: HealthDashboardTokens.Spacing.sm) {
            Text("Good Morning!")
                .font(HealthDashboardTokens.Typography.title)
                .foregroundColor(HealthDashboardTokens.Colors.onPrimary)
            Text("Ready for your workout?")
                .font(HealthDashboardTokens.Typography.headline)
                .foregroundColor(HealthDashboardTokens.Colors.onPrimary)
            Button(action: {}) {
                Text("Start Workout")
                    .font(HealthDashboardTokens.Typography.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(height: 44)
            .background(
                RoundedRectangle(cornerRadius: HealthDashboardTokens.Shapes.medium, style: .continuous)
                    .fill(HealthDashboardTokens.Colors.onPrimary)
            )
            .foregroundColor(HealthDashboardTokens.Colors.primary)
        }
        .padding(HealthDashboardTokens.Spacing.xl)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: HealthDashboardTokens.Shapes.large, style: .continuous)
                .fill(HealthDashboardTokens.Colors.primary)
        )
        .shadow(color: Color.black.opacity(HealthDashboardTokens.Elevation.level3.opacity),
                radius: HealthDashboardTokens.Elevation.level3.radius,
                x: 0,
                y: HealthDashboardTokens.Elevation.level3.y)
    }

    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 14))
            .foregroundColor(HealthDashboardTokens.Colors.onBackground)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, HealthDashboardTokens.Spacing.sm)
    }

    private var metricsRow: some View {
        HStack(spacing: HealthDashboardTokens.Spacing.md) {
            ForEach(metrics) { metric in
                HStack(){
                    VStack(spacing: HealthDashboardTokens.Spacing.xs) {
                        Circle()
                            .fill(metric.color)
                            .frame(width: 36, height: 36)
                        Text(metric.value)
                            .font(HealthDashboardTokens.Typography.headline)
                            .foregroundColor(HealthDashboardTokens.Colors.onSurface)
                        Text(metric.title)
                            .font(HealthDashboardTokens.Typography.label)
                            .foregroundColor(HealthDashboardTokens.Colors.onSurface.opacity(0.7))
                    }
                    Spacer()
                }
                .padding(HealthDashboardTokens.Spacing.md)
                .frame(alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: HealthDashboardTokens.Shapes.medium, style: .continuous)
                        .fill(HealthDashboardTokens.Colors.surface)
                )
                .shadow(color: Color.black.opacity(HealthDashboardTokens.Elevation.level2.opacity),
                        radius: HealthDashboardTokens.Elevation.level2.radius,
                        x: 0,
                        y: HealthDashboardTokens.Elevation.level2.y)
            }
        }
    }

    private var recentWorkoutsHeader: some View {
        HStack {
            Text("Recent Workouts")
                .font(HealthDashboardTokens.Typography.headline)
                .foregroundColor(HealthDashboardTokens.Colors.onBackground)
            Spacer()
            Button(action: {}) {
                Text("View All")
                    .font(HealthDashboardTokens.Typography.label)
                    .padding(.trailing, 20)
            }
            .buttonStyle(.plain)
            .foregroundColor(HealthDashboardTokens.Colors.primary)
        }
    }

    private func workoutCard(_ workout: Workout) -> some View {
        HStack(spacing: HealthDashboardTokens.Spacing.md) {
            RoundedRectangle(cornerRadius: HealthDashboardTokens.Shapes.medium, style: .continuous)
                .fill(workout.iconColor)
                .frame(width: 44, height: 44)

            VStack(alignment: .leading, spacing: HealthDashboardTokens.Spacing.xs) {
                Text(workout.name)
                    .font(HealthDashboardTokens.Typography.title)
                    .foregroundColor(HealthDashboardTokens.Colors.onSurface)
                HStack(spacing: HealthDashboardTokens.Spacing.lg) {
                    Text(workout.duration)
                        .font(HealthDashboardTokens.Typography.body)
                        .foregroundColor(HealthDashboardTokens.Colors.onSurface.opacity(0.7))
                    Text(workout.calories)
                        .font(HealthDashboardTokens.Typography.body)
                        .foregroundColor(HealthDashboardTokens.Colors.onSurface.opacity(0.7))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Button(action: {}) {
                Text("Start")
                    .font(HealthDashboardTokens.Typography.small)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: 70, height: 32)
            .background(
                RoundedRectangle(cornerRadius: HealthDashboardTokens.Shapes.small, style: .continuous)
                    .fill(HealthDashboardTokens.Colors.primary)
            )
            .foregroundColor(HealthDashboardTokens.Colors.onPrimary)
        }
        .padding(HealthDashboardTokens.Spacing.lg)
        .background(
            RoundedRectangle(cornerRadius: HealthDashboardTokens.Shapes.medium, style: .continuous)
                .fill(HealthDashboardTokens.Colors.surface)
        )
        .shadow(color: Color.black.opacity(HealthDashboardTokens.Elevation.level1.opacity),
                radius: HealthDashboardTokens.Elevation.level1.radius,
                x: 0,
                y: HealthDashboardTokens.Elevation.level1.y)
    }

    private var bottomNavigation: some View {
        HStack(spacing: HealthDashboardTokens.Spacing.md) {
            ForEach(navItems) { item in
                Button(action: { selectedNav = item.id }) {
                    VStack(spacing: HealthDashboardTokens.Spacing.xs) {
                        Circle()
                            .fill(selectedNav == item.id ? HealthDashboardTokens.Colors.primary : HealthDashboardTokens.Colors.outline)
                            .frame(width: 20, height: 20)
                        Text(item.label)
                            .font(HealthDashboardTokens.Typography.label)
                            .foregroundColor(HealthDashboardTokens.Colors.onSurface)
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, HealthDashboardTokens.Spacing.sm)
        .padding(.horizontal, HealthDashboardTokens.Spacing.md)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: HealthDashboardTokens.Shapes.large, style: .continuous)
                .fill(HealthDashboardTokens.Colors.surface)
        )
        .shadow(color: Color.black.opacity(HealthDashboardTokens.Elevation.level2.opacity),
                radius: HealthDashboardTokens.Elevation.level2.radius,
                x: 0,
                y: HealthDashboardTokens.Elevation.level2.y)
    }
}

struct HealthDashboardAppView_Previews: PreviewProvider {
    static var previews: some View {
        HealthDashboardAppView()
    }
}

@main
struct HealthDashboardApp: App {
    var body: some Scene {
        WindowGroup {
            HealthDashboardAppView()
                .statusBarHidden(true)
                .background(HealthDashboardTokens.Colors.background.ignoresSafeArea())
        }
    }
}
