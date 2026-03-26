import SwiftUI
// Quiz UI (Android Compose -> SwiftUI).
// iOS 16.0 compatible; full-screen with status bar hidden.
// This file focuses on UI drawing only (no business logic).

struct QuizApp: App {
    var body: some Scene {
        WindowGroup {
            QuizRootView()
                .statusBarHidden(true) // Full screen: hide status bar
                .background(QuizTokens.Colors.background.ignoresSafeArea())
        }
    }
}

// MARK: - Design Tokens (ported from Compose)
enum QuizTokens {
    enum Colors {
        static let primary        = Color(hexRGB: 0x7C3AED)
        static let secondary      = Color(hexRGB: 0x22C55E)
        static let tertiary       = Color(hexRGB: 0xF97316)
        static let background     = Color(hexRGB: 0xFAFAFF)
        static let surface        = Color(hexRGB: 0xFFFFFF)
        static let surfaceVariant = Color(hexRGB: 0xF1F5F9)
        static let outline        = Color(hexRGB: 0xE2E8F0)
        static let success        = Color(hexRGB: 0x16A34A)
        static let warning        = Color(hexRGB: 0xF59E0B)
        static let error          = Color(hexRGB: 0xEF4444)
        static let onPrimary      = Color(hexRGB: 0xFFFFFF)
        static let onSecondary    = Color(hexRGB: 0x0F172A)
        static let onTertiary     = Color(hexRGB: 0x111827)
        static let onBackground   = Color(hexRGB: 0x0B1220)
        static let onSurface      = Color(hexRGB: 0x0B1220)
    }
    enum Shapes {
        static let small  : CGFloat = 6
        static let medium : CGFloat = 8
        static let large  : CGFloat = 12
    }
    enum Spacing {
        static let xs  : CGFloat = 2
        static let sm  : CGFloat = 4
        static let md  : CGFloat = 6
        static let lg  : CGFloat = 8
        static let xl  : CGFloat = 12
        static let xxl : CGFloat = 16
        static let xxxl: CGFloat = 24
    }
    enum Typography {
        static let display  = Font.system(size: 24, weight: .semibold)
        static let headline = Font.system(size: 18, weight: .semibold)
        static let title    = Font.system(size: 14, weight: .medium)
        static let body     = Font.system(size: 12, weight: .regular)
        static let label    = Font.system(size: 10, weight: .medium)
    }
}

// MARK: - Root Screen
struct QuizRootView: View {
    @State private var selected: Int? = nil
    private let options = ["Earth", "Mars", "Venus", "Jupiter"]

    var body: some View {
        VStack(spacing: 0) {
            // Top App Bar
            HStack(spacing: QuizTokens.Spacing.sm) {
                RoundedRectangle(cornerRadius: QuizTokens.Shapes.small)
                    .fill(QuizTokens.Colors.primary)
                    .frame(width: 20, height: 20)
                Text("Quiz")
                    .font(QuizTokens.Typography.display)
                    .foregroundColor(QuizTokens.Colors.onSurface)
            }
            .frame(alignment: .center)
            .padding(.top, 24)
            .padding(.bottom, 16)
            .padding(.horizontal, QuizTokens.Spacing.lg)

            ScrollView {
                VStack(spacing: QuizTokens.Spacing.lg) {
                    // Card
                    VStack(alignment: .leading, spacing: QuizTokens.Spacing.lg) {
                        RoundedRectangle(cornerRadius: QuizTokens.Shapes.medium)
                            .fill(QuizTokens.Colors.surfaceVariant)
                            .frame(height: 120)
                            .overlay(
                                Text("Question 1/4")
                                    .font(QuizTokens.Typography.label)
                                    .foregroundColor(QuizTokens.Colors.onSurface)
                            )

                        Text("Which planet is known as the Red Planet?")
                            .font(QuizTokens.Typography.headline)
                            .foregroundColor(QuizTokens.Colors.onSurface)

                        VStack(alignment: .leading, spacing: QuizTokens.Spacing.sm) {
                            ForEach(options.indices, id: \.self) { i in
                                let active = (selected == i)
                                Button(action: { selected = i }) {
                                    Text(options[i])
                                        .font(active ? QuizTokens.Typography.title : QuizTokens.Typography.body)
                                        .foregroundColor(active ? QuizTokens.Colors.onPrimary : QuizTokens.Colors.onSurface)
                                        .frame(alignment: .leading)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 16)
                                        .background(
                                            RoundedRectangle(cornerRadius: QuizTokens.Shapes.medium)
                                                .fill(active ? QuizTokens.Colors.primary : QuizTokens.Colors.surface)
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: QuizTokens.Shapes.medium)
                                                .stroke(QuizTokens.Colors.outline, lineWidth: 1)
                                        )
                                }
                                .buttonStyle(.plain)
                                .padding(.vertical, 6)
                            }
                        }
                    }
                    .padding(QuizTokens.Spacing.lg)
                    .background(
                        RoundedRectangle(cornerRadius: QuizTokens.Shapes.large)
                            .fill(QuizTokens.Colors.surface)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: QuizTokens.Shapes.large)
                            .stroke(QuizTokens.Colors.outline, lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.08), radius: 3, x: 0, y: 1)
                    .padding(.horizontal, QuizTokens.Spacing.lg)

                    // Selected + Skip
                    HStack {
                        VStack(alignment: .leading, spacing: QuizTokens.Spacing.xs) {
                            Text("Selected")
                                .font(QuizTokens.Typography.label)
                                .foregroundColor(QuizTokens.Colors.onSurface)
                            Text(selected.map { options[$0] } ?? "None")
                                .font(QuizTokens.Typography.title)
                                .foregroundColor(QuizTokens.Colors.onSurface)
                        }
                        Spacer()
                        AssistChip(label: "Skip", isOn: false) { }
                    }
                    .padding(.horizontal, QuizTokens.Spacing.lg)
                }
                .padding(.vertical, QuizTokens.Spacing.md)
                .padding(.bottom, 120) // leave space for bottom bar
            }
        }
        Divider()
        .overlay(alignment: .bottom) { BottomBar() }
        .background(QuizTokens.Colors.background.ignoresSafeArea())
    }
}

// MARK: - Bottom Bar
struct BottomBar: View {
    @State private var reviewed = false
    @State private var progress: CGFloat = 0.25

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: QuizTokens.Spacing.xs) {
                Text("Progress")
                    .font(QuizTokens.Typography.label)
                    .foregroundColor(QuizTokens.Colors.onSurface)
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 3)
                            .fill(QuizTokens.Colors.surfaceVariant)
                            .frame(height: 6)
                        RoundedRectangle(cornerRadius: 3)
                            .fill(QuizTokens.Colors.primary)
                            .frame(width: max(0, min(1, progress)) * geo.size.width, height: 6)
                        // Small dot marker at end
                        Circle()
                            .fill(QuizTokens.Colors.primary)
                            .frame(width: 6, height: 6)
                            .offset(x: max(0, min(1, progress)) * geo.size.width - 3)
                    }
                }
                .frame(width: 140, height: 6)
            }

            Spacer()

            AssistChip(label: "Review", isOn: reviewed, onTap: { reviewed.toggle() })

            Button(action: {}) {
                Text("Next")
                    .font(QuizTokens.Typography.title)
                    .frame(width: 140, height: 44)
            }
            .buttonStyle(.plain)
            .background(QuizTokens.Colors.primary)
            .foregroundColor(QuizTokens.Colors.onPrimary)
            .clipShape(RoundedRectangle(cornerRadius: QuizTokens.Shapes.large))
        }
        .padding(.horizontal, QuizTokens.Spacing.lg)
        .padding(.vertical, QuizTokens.Spacing.md)
        .background(QuizTokens.Colors.background.opacity(0.65))
    }
}

// MARK: - Assist Chip
struct AssistChip: View {
    let label: String
    var isOn: Bool
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(label)
                .font(QuizTokens.Typography.label)
                .foregroundColor(isOn ? QuizTokens.Colors.onSecondary : QuizTokens.Colors.onSurface)
                .padding(.vertical, 10)
                .padding(.horizontal, 14)
                .background(isOn ? QuizTokens.Colors.secondary : QuizTokens.Colors.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: QuizTokens.Shapes.small)
                        .stroke(QuizTokens.Colors.outline, lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: QuizTokens.Shapes.small))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Helpers
extension Color {
    /// Create Color from 0xRRGGBB
    init(hexRGB: UInt32) {
        let r = Double((hexRGB & 0xFF0000) >> 16) / 255.0
        let g = Double((hexRGB & 0x00FF00) >> 8)  / 255.0
        let b = Double(hexRGB & 0x0000FF) / 255.0
        self.init(.sRGB, red: r, green: g, blue: b, opacity: 1.0)
    }
}
