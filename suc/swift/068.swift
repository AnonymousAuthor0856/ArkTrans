import SwiftUI

@main
struct MacroTrainerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .statusBar(hidden: true)
                .ignoresSafeArea()
        }
    }
}

struct ContentView: View {
    @State private var timerValue = "02:34"
    @State private var targetPhase = "Macro tempo"
    
    let sets = [
        MacroSet(title: "Warm circuit", reps: "3 sets", phase: "Energy"),
        MacroSet(title: "Core push", reps: "4 rounds", phase: "Explosive"),
        MacroSet(title: "Cooldown flow", reps: "6 min", phase: "Calm")
    ]
    
    let metrics = [
        PerformanceMetric(label: "Load", value: "72%", change: "+4%"),
        PerformanceMetric(label: "VO2", value: "41", change: "+1"),
        PerformanceMetric(label: "Focus", value: "88%", change: "stable")
    ]
    
    let tags = ["Macro", "Tempo", "Breath"]
    
    var body: some View {
        ZStack {
            DesignTokens.Colors.background
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                TopAppBar()
                
                MainContent(
                    sets: sets,
                    metrics: metrics,
                    tags: tags,
                    timerValue: timerValue
                )
                
                BottomBar(targetPhase: targetPhase)
            }
        }
    }
}

// MARK: - Top App Bar
struct TopAppBar: View {
    var body: some View {
        ZStack {
            DesignTokens.Colors.surface
                .opacity(0.95)
            
            HStack {
                Circle()
                    .fill(DesignTokens.Colors.surfaceVariant)
                    .frame(width: 24, height: 24)
                    .onTapGesture {}
                
                Spacer()
                
                VStack(spacing: 0) {
                    Text("MacroTrainer")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(DesignTokens.Colors.onSurface)
                    
                    Text("Neon workout stack")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(DesignTokens.Colors.onSurface.opacity(0.7))
                }
                
                Spacer()
                
                Circle()
                    .fill(DesignTokens.Colors.surfaceVariant)
                    .frame(width: 24, height: 24)
                    .onTapGesture {}
            }
            .padding(.horizontal, DesignTokens.Spacing.lg)
            .padding(.vertical, DesignTokens.Spacing.md)
        }
        .frame(height: 60)
    }
}

// MARK: - Main Content
struct MainContent: View {
    let sets: [MacroSet]
    let metrics: [PerformanceMetric]
    let tags: [String]
    let timerValue: String
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: DesignTokens.Spacing.lg) {
                TimerSection(timerValue: timerValue, tags: tags, metrics: metrics)
                SetsListSection(sets: sets)
            }
            .padding(.horizontal, DesignTokens.Spacing.lg)
            .padding(.vertical, DesignTokens.Spacing.md)
        }
    }
}

// MARK: - Timer Section
struct TimerSection: View {
    let timerValue: String
    let tags: [String]
    let metrics: [PerformanceMetric]
    
    var body: some View {
        HStack(spacing: DesignTokens.Spacing.sm) {
            TimerRing(timerValue: timerValue, tags: tags)
            MetricsColumn(metrics: metrics)
        }
    }
}

struct TimerRing: View {
    let timerValue: String
    let tags: [String]
    
    var body: some View {
        ZStack {
            DesignTokens.Colors.surface
                .cornerRadius(28)
                .shadow(color: .black.opacity(0.26), radius: 6, x: 0, y: 4)
            
            VStack(spacing: DesignTokens.Spacing.sm) {
                ZStack {
                    Circle()
                        .stroke(
                            AngularGradient(
                                gradient: Gradient(colors: [
                                    DesignTokens.Colors.primary,
                                    DesignTokens.Colors.secondary,
                                    DesignTokens.Colors.tertiary,
                                    DesignTokens.Colors.primary
                                ]),
                                center: .center,
                                startAngle: .degrees(0),
                                endAngle: .degrees(360)
                            ),
                            lineWidth: 10
                        )
                        .frame(width: 160, height: 160)
                    
                    VStack(spacing: 4) {
                        Text(timerValue)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(DesignTokens.Colors.onSurface)
                        
                        Text("Timer")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(DesignTokens.Colors.onSurface.opacity(0.7))
                    }
                }
                
                HStack(spacing: DesignTokens.Spacing.xxs) {
                    ForEach(tags, id: \.self) { tag in
                        Text(tag)
                            .font(.system(size: 12, weight: .medium))
                            .padding(.horizontal, DesignTokens.Spacing.xs)
                            .padding(.vertical, DesignTokens.Spacing.xxs)
                            .background(DesignTokens.Colors.surfaceVariant)
                            .foregroundColor(DesignTokens.Colors.onSurface)
                            .cornerRadius(8)
                    }
                }
            }
            .padding(DesignTokens.Spacing.md)
        }
    }
}

struct MetricsColumn: View {
    let metrics: [PerformanceMetric]
    
    var body: some View {
        VStack(spacing: DesignTokens.Spacing.sm) {
            ForEach(metrics, id: \.label) { metric in
                MetricCard(metric: metric)
            }
        }
        .frame(width: 120)
    }
}

struct MetricCard: View {
    let metric: PerformanceMetric
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.xxs) {
            Text(metric.label)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(DesignTokens.Colors.onSurface)
            
            Text(metric.value)
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(DesignTokens.Colors.secondary)
            
            Text(metric.change)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(DesignTokens.Colors.onSurface.opacity(0.7))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(DesignTokens.Spacing.sm)
        .background(DesignTokens.Colors.surfaceVariant)
        .cornerRadius(18)
    }
}

// MARK: - Sets List Section
struct SetsListSection: View {
    let sets: [MacroSet]
    
    var body: some View {
        ForEach(sets, id: \.title) { set in
            SetListItemView(set: set)
        }
    }
}

struct SetListItemView: View {
    let set: MacroSet
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.xxs) {
                Text(set.title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(DesignTokens.Colors.onSurface)
                
                Text(set.phase)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(DesignTokens.Colors.onSurface.opacity(0.7))
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: DesignTokens.Spacing.xxs) {
                Text(set.reps)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(DesignTokens.Colors.primary)
                
                Button("Start") {
                    // Start action
                }
                .font(.system(size: 12, weight: .medium))
                .padding(.horizontal, DesignTokens.Spacing.xs)
                .padding(.vertical, DesignTokens.Spacing.xxs)
                .background(DesignTokens.Colors.secondary)
                .foregroundColor(DesignTokens.Colors.onSecondary)
                .cornerRadius(8)
            }
        }
        .padding(DesignTokens.Spacing.md)
        .background(DesignTokens.Colors.surfaceVariant.opacity(0.9))
        .cornerRadius(18)
    }
}

// MARK: - Bottom Bar
struct BottomBar: View {
    let targetPhase: String
    
    var body: some View {
        ZStack {
            DesignTokens.Colors.surfaceVariant
                .shadow(color: .black.opacity(0.26), radius: 12, x: 0, y: -6)
            
            HStack {
                VStack(alignment: .leading, spacing: DesignTokens.Spacing.xxs) {
                    Text("Next macro")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(DesignTokens.Colors.onSurface)
                    
                    Text(targetPhase)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(DesignTokens.Colors.onSurface)
                }
                
                Spacer()
                
                Button("Prime") {
                    // Prime action
                }
                .font(.system(size: 16, weight: .medium))
                .padding(.horizontal, DesignTokens.Spacing.xl)
                .padding(.vertical, DesignTokens.Spacing.xs)
                .background(DesignTokens.Colors.secondary)
                .foregroundColor(DesignTokens.Colors.onSecondary)
                .cornerRadius(18)
            }
            .padding(.horizontal, DesignTokens.Spacing.lg)
            .padding(.vertical, DesignTokens.Spacing.md)
        }
        .frame(height: 80)
    }
}

// MARK: - Data Models
struct MacroSet {
    let title: String
    let reps: String
    let phase: String
}

struct PerformanceMetric {
    let label: String
    let value: String
    let change: String
}

// MARK: - Design Tokens
struct DesignTokens {
    struct Colors {
        static let primary = Color(hex: 0x7C4DFF)
        static let secondary = Color(hex: 0x08D6FF)
        static let tertiary = Color(hex: 0xFF8E3C)
        static let background = Color(hex: 0x05030A)
        static let surface = Color(hex: 0x0D0616)
        static let surfaceVariant = Color(hex: 0x1A0F2C)
        static let outline = Color(hex: 0x3A2759)
        static let success = Color(hex: 0x56F0A6)
        static let warning = Color(hex: 0xFFC857)
        static let error = Color(hex: 0xFF5B7A)
        static let onPrimary = Color(hex: 0x05030A)
        static let onSecondary = Color(hex: 0x05030A)
        static let onTertiary = Color(hex: 0x120601)
        static let onBackground = Color(hex: 0xF4ECFF)
        static let onSurface = Color(hex: 0xF8F4FF)
    }
    
    struct Spacing {
        static let xxs: CGFloat = 4
        static let xs: CGFloat = 8
        static let sm: CGFloat = 12
        static let md: CGFloat = 16
        static let lg: CGFloat = 20
        static let xl: CGFloat = 28
        static let xxl: CGFloat = 40
        static let xxxl: CGFloat = 56
    }
}

// MARK: - Color Extension
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}