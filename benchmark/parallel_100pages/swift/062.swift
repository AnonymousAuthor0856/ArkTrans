import SwiftUI
import UIKit

struct AppTokens {
    struct Colors {
                static let primary = Color(red: 59/255, green: 130/255, blue: 246/255) 
                static let secondary = Color(red: 6/255, green: 182/255, blue: 212/255) 
                static let tertiary = Color(red: 14/255, green: 165/255, blue: 233/255) 
                static let background = Color(red: 240/255, green: 249/255, blue: 255/255) 
                static let surface = Color(red: 255/255, green: 255/255, blue: 255/255) 
                static let surfaceVariant = Color(red: 224/255, green: 242/255, blue: 254/255) 
                static let outline = Color(red: 203/255, green: 213/255, blue: 225/255) 
                static let onPrimary = Color(red: 255/255, green: 255/255, blue: 255/255) 
                static let onBackground = Color(red: 15/255, green: 23/255, blue: 42/255) 
                static let onSurface = Color(red: 30/255, green: 41/255, blue: 59/255) 
    }

    struct TypographyTokens {
                static let display = Font.system(size: 26, weight: .bold)
                static let headline = Font.system(size: 18, weight: .semibold)
                static let title = Font.system(size: 14, weight: .medium)
                static let body = Font.system(size: 12, weight: .regular)
    }

    struct Shapes {
                static let smallCornerRadius: CGFloat = 8
                static let mediumCornerRadius: CGFloat = 12
                static let largeCornerRadius: CGFloat = 18
    }

    struct Spacing {
                static let sm: CGFloat = 8
                static let md: CGFloat = 12
                static let lg: CGFloat = 18
                static let xl: CGFloat = 26
    }
}

class HostingController<Content: View>: UIHostingController<Content> {
        override var prefersStatusBarHidden: Bool {
        return true
    }

        override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return .all
    }
}

struct FullScreenView<Content: View>: UIViewControllerRepresentable {
    var content: Content

        func makeUIViewController(context: Context) -> HostingController<Content> {
        return HostingController(rootView: content)
    }

        func updateUIViewController(_ uiViewController: HostingController<Content>, context: Context) {
            }
}

struct ModeButton: View {
    let label: String 
    let iconName: String 
    let currentMode: String 
    let onSelect: (String) -> Void 

    var body: some View {
        let isSelected = label == currentMode
        Button(action: {
            onSelect(label)
        }) {
            VStack(alignment: .center) {
                Image(systemName: iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32) 
                Text(label)
                    .font(AppTokens.TypographyTokens.body)
            }
            .frame(width: 100, height: 100) 
            .background(isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
            .foregroundColor(isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
            .clipShape(Circle()) 
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5) 
        }
    }
}

struct RootScreen: View {
        @State private var targetTemp: Int = 22
    @State private var mode: String = "Cool"

    var body: some View {
        GeometryReader { geometry in 
            VStack(spacing: 0) { 
                                HStack(spacing: 0) {
                    Image(systemName: "thermometer.medium") 
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(AppTokens.Colors.primary)
                        .padding(.leading, AppTokens.Spacing.md) 

                    Spacer() 

                    Text("ThermoCurve")
                        .font(AppTokens.TypographyTokens.display)
                        .foregroundColor(AppTokens.Colors.onSurface) 

                    Spacer() 

                    Button(action: {
                        targetTemp += 1 
                    }) {
                        Image(systemName: "sun.max.fill") 
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundColor(AppTokens.Colors.secondary)
                    }
                    .padding(.trailing, AppTokens.Spacing.md) 
                }
                .frame(height: 56) 
                .background(AppTokens.Colors.surfaceVariant) 

                                VStack(spacing: AppTokens.Spacing.xl) { 
                    Text("Target Temperature")
                        .font(AppTokens.TypographyTokens.headline)
                        .foregroundColor(AppTokens.Colors.onSurface)

                    Text("\(targetTemp)°C")
                        .font(.system(size: 48, weight: .bold)) 
                        .foregroundColor(AppTokens.Colors.primary)

                    HStack(spacing: AppTokens.Spacing.md) { 
                        Button(action: {
                            if targetTemp > 10 { targetTemp -= 1 } 
                        }) {
                            Text("–")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(AppTokens.Colors.onPrimary)
                                .frame(width: 60, height: 60) 
                                .background(AppTokens.Colors.primary)
                                .cornerRadius(AppTokens.Shapes.smallCornerRadius) 
                        }

                        Button(action: {
                            if targetTemp < 35 { targetTemp += 1 } 
                        }) {
                            Text("+")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(AppTokens.Colors.onPrimary)
                                .frame(width: 60, height: 60) 
                                .background(AppTokens.Colors.primary)
                                .cornerRadius(AppTokens.Shapes.smallCornerRadius) 
                        }
                    }

                    Divider() 
                        .frame(width: geometry.size.width * 0.8, height: 1) 
                        .overlay(AppTokens.Colors.outline.opacity(0.5)) 

                    Text("Mode")
                        .font(AppTokens.TypographyTokens.headline)
                        .foregroundColor(AppTokens.Colors.onSurface)

                    HStack(spacing: AppTokens.Spacing.lg) { 
                        ModeButton(label: "Cool", iconName: "wind", currentMode: mode) { selectedMode in
                            mode = selectedMode 
                        }
                        ModeButton(label: "Heat", iconName: "sun.max.fill", currentMode: mode) { selectedMode in
                            mode = selectedMode 
                        }
                    }

                    Text("Current Mode: \(mode)")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.onSurface)
                }
                .padding(AppTokens.Spacing.lg) 
                .frame(maxWidth: .infinity, maxHeight: .infinity) 
                .background(
                    LinearGradient( 
                        gradient: Gradient(colors: [
                            AppTokens.Colors.secondary.opacity(0.15), 
                            AppTokens.Colors.primary.opacity(0.2)    
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .background(AppTokens.Colors.background) 
            }
            .ignoresSafeArea() 
        }
    }
}

@main
struct ThermoCurveApp: App {
    var body: some Scene {
        WindowGroup {
                                    FullScreenView(content: RootScreen())
        }
    }
}

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
