
import SwiftUI

struct AppTokens {
    struct Colors {
        static let primary = Color(red: 1.0, green: 123/255.0, blue: 0/255.0) 
        static let secondary = Color(red: 1.0, green: 209/255.0, blue: 102/255.0) 
        static let background = Color(red: 1.0, green: 246/255.0, blue: 229/255.0) 
        static let surface = Color(red: 1.0, green: 1.0, blue: 1.0) 
        static let surfaceVariant = Color(red: 1.0, green: 240/255.0, blue: 193/255.0) 
        static let outline = Color(red: 224/255.0, green: 192/255.0, blue: 128/255.0) 
        static let onPrimary = Color(red: 1.0, green: 1.0, blue: 1.0) 
        static let onSecondary = Color(red: 62/255.0, green: 39/255.0, blue: 35/255.0) 
        static let onBackground = Color(red: 62/255.0, green: 39/255.0, blue: 35/255.0) 
        static let onSurface = Color(red: 62/255.0, green: 39/255.0, blue: 35/255.0) 
    }

    struct TypographyTokens {
                static let display = Font.system(size: 28, weight: .bold)
        static let headline = Font.system(size: 20, weight: .semibold)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
        
                static let labelFontSize: CGFloat = 12.0
    }

    struct Shapes {
                static let small: CGFloat = 6.0
        static let medium: CGFloat = 10.0
        static let large: CGFloat = 14.0
    }

    struct Spacing {
                static let sm: CGFloat = 8.0
        static let md: CGFloat = 12.0
        static let lg: CGFloat = 16.0
    }

    struct ShadowSpec {
        let elevation: CGFloat 
        let radius: CGFloat 
        let dy: CGFloat 
        let opacity: Double 
    }

    struct ElevationMapping {
                static let level2 = ShadowSpec(elevation: 4.0, radius: 8.0, dy: 4.0, opacity: 0.12)
    }
}

struct ResultItem: Identifiable {
    let id: Int
    let title: String
}

struct RootScreen: View {
        @State private var query: String = ""
        @State private var knobOffset: CGSize = CGSize(width: 144, height: 104) 
    
        let results: [ResultItem] = Array(0..<6).map { i in ResultItem(id: i, title: "Result \(i + 1)") }

        @FocusState private var isTextFieldFocused: Bool

    var body: some View {
                ZStack {
            AppTokens.Colors.background.ignoresSafeArea() 

            VStack(spacing: AppTokens.Spacing.md) { 
                Text("Retro Filter Search")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onBackground)
                    .frame(maxWidth: .infinity, alignment: .leading) 

                                TextField("", text: $query) 
                    .font(AppTokens.TypographyTokens.body)
                    .foregroundColor(AppTokens.Colors.onSurface)
                                        .placeholder(when: query.isEmpty, alignment: .leading) {
                        Text("Search products")
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onSurface.opacity(0.4))
                            .padding(.leading, AppTokens.Spacing.lg) 
                    }
                    .padding(.horizontal, AppTokens.Spacing.lg) 
                    .frame(height: 56) 
                    .background(AppTokens.Colors.surface)
                    .cornerRadius(AppTokens.Shapes.medium)
                                        .overlay(
                        RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                            .stroke(isTextFieldFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline, lineWidth: 1)
                    )
                    .focused($isTextFieldFocused) 
                    .textInputAutocapitalization(.never) 
                    .autocorrectionDisabled() 

                                HStack(spacing: AppTokens.Spacing.sm) { 
                    ForEach(["Popular", "New", "Discount", "Premium"], id: \.self) { text in
                        Button(action: {
                                                    }) {
                            Text(text)
                                .font(AppTokens.TypographyTokens.label)
                                .foregroundColor(AppTokens.Colors.onSecondary)
                                .padding(.horizontal, AppTokens.Spacing.md) 
                                                                .padding(.vertical, (36 - AppTokens.TypographyTokens.labelFontSize) / 2)
                        }
                        .frame(height: 36) 
                        .background(AppTokens.Colors.secondary)
                        .cornerRadius(AppTokens.Shapes.small)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading) 

                                ZStack {
                                        AppTokens.Colors.surface
                        .cornerRadius(AppTokens.Shapes.large)

                    Canvas { context, size in
                                                context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(AppTokens.Colors.surfaceVariant))

                                                let center = CGPoint(x: size.width / 2, y: size.height / 2)
                        let radialGradient = Gradient(colors: [AppTokens.Colors.secondary, AppTokens.Colors.primary])
                        context.fill(
                            Path(ellipseIn: CGRect(x: center.x - 60, y: center.y - 60, width: 120, height: 120)),
                            with: .radialGradient(radialGradient, center: center, startRadius: 0, endRadius: 60)
                        )

                                                let knobCenter = CGPoint(x: knobOffset.width, y: knobOffset.height)
                        context.fill(
                            Path(ellipseIn: CGRect(x: knobCenter.x - 16, y: knobCenter.y - 16, width: 32, height: 32)),
                            with: .color(AppTokens.Colors.primary)
                        )
                    }
                    .padding(AppTokens.Spacing.lg) 
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                                                let minX: CGFloat = 8
                                let maxX: CGFloat = 8
                                let minY: CGFloat = 8
                                let maxY: CGFloat = 8
                                let clampedX = max(minX, min(value.location.x, maxX))
                                let clampedY = max(minY, min(value.location.y, maxY))

                                knobOffset = CGSize(width: clampedX, height: clampedY)
                            }
                    )
                }
                .frame(height: 180) 
                .frame(maxWidth: .infinity) 

                                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: AppTokens.Spacing.lg), 
                        GridItem(.flexible(), spacing: AppTokens.Spacing.lg)
                    ],
                    spacing: AppTokens.Spacing.lg 
                ) {
                    ForEach(results) { item in
                        CardView(item: item) 
                    }
                }
                .padding(.bottom, 24) 
            }
            .padding(AppTokens.Spacing.lg) 
        }
    }
}

struct CardView: View {
    let item: ResultItem

    var body: some View {
        VStack(spacing: AppTokens.Spacing.sm) { 
                        RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                .fill(AppTokens.Colors.surfaceVariant)
                .frame(width: 96, height: 96)

            Text(item.title)
                .font(AppTokens.TypographyTokens.title)
                .foregroundColor(AppTokens.Colors.onSurface)

                        Button(action: {
                            }) {
                Text("Add")
                    .font(AppTokens.TypographyTokens.label)
                    .foregroundColor(AppTokens.Colors.onPrimary)
                    .frame(maxWidth: .infinity) 
                                        .padding(.vertical, 10) 
            }
            .background(AppTokens.Colors.primary) 
            .cornerRadius(AppTokens.Shapes.medium) 
        }
        .padding(AppTokens.Spacing.lg) 
        .background(AppTokens.Colors.surface) 
        .cornerRadius(AppTokens.Shapes.large) 
                .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),
                radius: AppTokens.ElevationMapping.level2.radius,
                x: 0, 
                y: AppTokens.ElevationMapping.level2.dy)
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

@main
struct SingleFileUIApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                                .statusBarHidden(true)
                                .ignoresSafeArea()
        }
    }
}

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
