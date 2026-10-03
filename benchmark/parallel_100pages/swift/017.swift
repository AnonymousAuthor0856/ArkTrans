
import SwiftUI
import UIKit 

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB, 
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}

struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF00FF66)
        static let secondary = Color(hex: 0xFFCCCCCC)
        static let tertiary = Color(hex: 0xFF999999)
        static let background = Color(hex: 0xFF000000)
        static let surface = Color(hex: 0xFF0A0A0A)
        static let surfaceVariant = Color(hex: 0xFF141414)
        static let outline = Color(hex: 0xFF2A2A2A)
        static let success = Color(hex: 0xFF22C55E)
        static let warning = Color(hex: 0xFFF59E0B)
        static let error = Color(hex: 0xFFEF4444)
        static let onPrimary = Color(hex: 0xFF000000)
        static let onSecondary = Color(hex: 0xFFFFFFFF)
        static let onTertiary = Color(hex: 0xFFFFFFFF)
        static let onBackground = Color(hex: 0xFFE0E0E0)
        static let onSurface = Color(hex: 0xFFE0E0E0)
    }

    struct TypographyTokens {
                                static let display = Font.system(size: 26, weight: .bold)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 13, weight: .regular)
        static let label = Font.system(size: 11, weight: .medium)
    }

    struct Shapes {
                static let small: CGFloat = 6
        static let medium: CGFloat = 10
        static let large: CGFloat = 14
    }

    struct Spacing {
                static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
    }
        }

struct MixerSlider: View {
    let label: String
    @Binding var value: Float 

    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) {
            Text("\(label) \(Int(value * 100))%")
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.onSurface)
            Slider(value: $value, in: 0...1)
                .frame(maxWidth: .infinity) 
                                        }
    }
}

struct RootScreen: View {
        @State private var bass: Float = 0.4
    @State private var mid: Float = 0.5
    @State private var treble: Float = 0.6
    @State private var master: Float = 0.7

    var body: some View {
        ZStack { 
                        AppTokens.Colors.background.ignoresSafeArea(.all)

            VStack(spacing: 0) { 
                                                                Text("Audio Mixer Terminal")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.primary)
                    .frame(maxWidth: .infinity) 
                    .padding(.vertical, (64 - 26) / 2) 
                    .frame(height: 64) 
                    .background(AppTokens.Colors.background) 

                                VStack(spacing: AppTokens.Spacing.lg) { 
                    MixerSlider(label: "Bass", value: $bass)
                    MixerSlider(label: "Mid", value: $mid)
                    MixerSlider(label: "Treble", value: $treble)

                                        Spacer().frame(height: AppTokens.Spacing.lg)

                                        ProgressView(value: master)
                        .tint(AppTokens.Colors.primary) 
                        .frame(maxWidth: .infinity) 
                        .frame(height: 6) 

                    Text("Master Volume \(Int(master * 100))%")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)
                        .frame(maxWidth: .infinity, alignment: .leading) 

                                        Slider(value: $master, in: 0...1)
                        .frame(maxWidth: .infinity) 
                        
                                        Button(action: {}) {
                        Text("Apply Settings")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .frame(maxWidth: .infinity) 
                            .padding(.vertical, (48 - 16) / 2) 
                    }
                    .background(AppTokens.Colors.primary) 
                    .cornerRadius(AppTokens.Shapes.medium) 
                    .frame(height: 48) 
                }
                .padding(AppTokens.Spacing.lg) 
                .frame(maxWidth: .infinity, maxHeight: .infinity) 
                .background(AppTokens.Colors.background) 
            }
        }
        .statusBarHidden(true) 
    }
}

@main
struct AudioMixerApp: App {
                    init() {
                UISlider.appearance().minimumTrackTintColor = UIColor(AppTokens.Colors.primary) 
        UISlider.appearance().maximumTrackTintColor = UIColor(AppTokens.Colors.surfaceVariant) 
        UISlider.appearance().thumbTintColor = UIColor(AppTokens.Colors.primary) 

                UIProgressView.appearance().progressTintColor = UIColor(AppTokens.Colors.primary) 
        UIProgressView.appearance().trackTintColor = UIColor(AppTokens.Colors.surfaceVariant) 
    }

    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}

