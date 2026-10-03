import SwiftUI

struct AppTokens {
    struct Colors {
                static let primary = Color(red: 0x11 / 255.0, green: 0x18 / 255.0, blue: 0x27 / 255.0)
        static let secondary = Color(red: 0x37 / 255.0, green: 0x41 / 255.0, blue: 0x51 / 255.0)
        static let tertiary = Color(red: 0x6B / 255.0, green: 0x72 / 255.0, blue: 0x80 / 255.0)
        static let background = Color(red: 0xF9 / 255.0, green: 0xFA / 255.0, blue: 0xFB / 255.0)
        static let surface = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let surfaceVariant = Color(red: 0xE5 / 255.0, green: 0xE7 / 255.0, blue: 0xEB / 255.0)
        static let outline = Color(red: 0xD1 / 255.0, green: 0xD5 / 255.0, blue: 0xDB / 255.0)
        static let onPrimary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onSecondary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onBackground = Color(red: 0x11 / 255.0, green: 0x18 / 255.0, blue: 0x27 / 255.0)
        static let onSurface = Color(red: 0x1F / 255.0, green: 0x29 / 255.0, blue: 0x37 / 255.0)
    }

    struct TypographyTokens {
                static let display = Font.system(size: 26, weight: .bold)
        static let headline = Font.system(size: 18, weight: .semibold)
        static let title = Font.system(size: 14, weight: .medium)
        static let body = Font.system(size: 12, weight: .regular)
    }

    struct Shapes {
                static let smallCornerRadius: CGFloat = 6
        static let mediumCornerRadius: CGFloat = 10
        static let largeCornerRadius: CGFloat = 16
    }

    struct Spacing {
                static let sm: CGFloat = 6
        static let md: CGFloat = 10
        static let lg: CGFloat = 14
        static let xl: CGFloat = 22
    }
}

struct ParcelCanvas: View {
        @State private var dragOffset: CGPoint = .zero 
    @State private var parcelPoints: [CGPoint] = [] 

        private func generateRandomPoints(width: CGFloat, height: CGFloat) -> [CGPoint] {
        (0..<25).map { _ in
            CGPoint(x: CGFloat.random(in: 0...width), y: CGFloat.random(in: 0...height))
        }
    }

    var body: some View {
                GeometryReader { geometry in
                        let effectiveCanvasWidth = geometry.size.width - (AppTokens.Spacing.md * 2)
            let effectiveCanvasHeight = geometry.size.height - (AppTokens.Spacing.md * 2)

                        ZStack(alignment: .center) {
                                Canvas { context, size in
                                        for point in parcelPoints {
                                                let rect = CGRect(x: point.x - 4, y: point.y - 4, width: 8, height: 8)
                        context.fill(Path(ellipseIn: rect), with: .color(AppTokens.Colors.secondary))
                    }

                                        let circleRect = CGRect(x: dragOffset.x - 20, y: dragOffset.y - 20, width: 40, height: 40)
                    context.stroke(Path(ellipseIn: circleRect), with: .color(AppTokens.Colors.primary), lineWidth: 3)
                }
                                .padding(AppTokens.Spacing.md)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)

                                Text("Drag to locate parcel")
                    .font(AppTokens.TypographyTokens.body)
                    .foregroundColor(AppTokens.Colors.onSurface)
            }
                        .frame(maxWidth: .infinity)
            .frame(height: 300)
                        .background(AppTokens.Colors.surface)
                        .cornerRadius(AppTokens.Shapes.largeCornerRadius)
                                    .overlay(
                RoundedRectangle(cornerRadius: AppTokens.Shapes.largeCornerRadius)
                    .stroke(AppTokens.Colors.outline, lineWidth: 1)
            )
                        .gesture(
                DragGesture()
                    .onChanged { value in
                                                                        dragOffset = CGPoint(
                            x: max(20, min(value.location.x, effectiveCanvasWidth - 20)),
                            y: max(20, min(value.location.y, effectiveCanvasHeight - 20))
                        )
                    }
            )
                        .onAppear {
                                parcelPoints = generateRandomPoints(width: effectiveCanvasWidth, height: effectiveCanvasHeight)
                                dragOffset = CGPoint(
                    x: CGFloat.random(in: 20...(effectiveCanvasWidth - 20)),
                    y: CGFloat.random(in: 20...(effectiveCanvasHeight - 20))
                )
            }
        }
    }
}

struct RootScreen: View {
    var body: some View {
                VStack(spacing: AppTokens.Spacing.xl) { 
            Text("Parcel Tracker")
                .font(AppTokens.TypographyTokens.display) 
                .foregroundColor(AppTokens.Colors.onBackground) 

                        ParcelCanvas()
                                                                                                                                                                                                                                                                
            Text("Visualize parcel movements and positions.")
                .font(AppTokens.TypographyTokens.body) 
                .foregroundColor(AppTokens.Colors.onSurface) 
        }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
            LinearGradient(
                colors: [AppTokens.Colors.surfaceVariant, AppTokens.Colors.background],
                startPoint: .top,
                endPoint: .bottom
            )
        )
                .padding(AppTokens.Spacing.lg)
                .ignoresSafeArea(.all, edges: .all)
    }
}

@main
struct ParcelTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                                .statusBarHidden(true)
        }
    }
}