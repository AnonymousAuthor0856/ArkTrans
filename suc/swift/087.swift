import SwiftUI

@main
struct TeaMasterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        TeaBrewingScreen()
            .preferredColorScheme(.light)
            .statusBarHidden(true)
    }
}

// MARK: - App Colors
struct TeaColors {
    static let primary = Color(red: 0.43, green: 0.30, blue: 0.25) // #6D4C41
    static let secondary = Color(red: 0.63, green: 0.53, blue: 0.50) // #A1887F
    static let surfaceVariant = Color(red: 0.98, green: 0.98, blue: 0.98) // #FAFAFA
    static let outline = Color(red: 0.93, green: 0.93, blue: 0.93) // #EEEEEE
    static let backgroundTint = Color(red: 0.96, green: 0.96, blue: 0.96) // #F5F5F5
    static let teaLeafDetail = Color(red: 0.55, green: 0.43, blue: 0.39) // #8D6E63
    static let favoriteTint = Color(red: 1.0, green: 0.80, blue: 0.82) // #FFCDD2
    static let textSecondary = Color.gray
    static let textPrimary = Color.black
}

// MARK: - Main Screen
struct TeaBrewingScreen: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Header
                HeaderSection()
                    .padding(.top, 24)
                    .padding(.bottom, 32)
                
                // Main Card
                TeaSelectionCard()
                    .padding(.bottom, 32)
                
                // Timer
                TimerDisplay(time: "02:00")
                    .padding(.bottom, 40)
                
                // Action Buttons
                ControlButtons()
                
                Spacer()
                
                // Steps
                PreparationSteps()
                    .padding(.bottom, 24)
            }
            .padding(.horizontal, 24)
        }
    }
}

// MARK: - Components

struct HeaderSection: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Good Morning,")
                    .font(.system(size: 14)) // BodyMedium approx
                    .foregroundColor(TeaColors.textSecondary)
                Text("Tea Master")
                    .font(.system(size: 22, weight: .bold)) // TitleLarge approx
                    .foregroundColor(TeaColors.textPrimary)
            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 24))
                    .foregroundColor(TeaColors.textPrimary)
                    .frame(width: 48, height: 48)
                    .background(TeaColors.backgroundTint)
                    .clipShape(Circle())
            }
        }
    }
}

struct TeaSelectionCard: View {
    var body: some View {
        HStack(spacing: 16) {
            // Icon Box
            ZStack {
                Circle()
                    .fill(Color(red: 0.94, green: 0.92, blue: 0.91)) // #EFEBE9
                    .frame(width: 60, height: 60)
                
                // Custom drawn leaf-like shape using SF Symbol or Path
                // Approximating the canvas drawing with a symbol + styling
                Image(systemName: "leaf") // Simple fallback for leaf concept
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(TeaColors.primary)
                    // Or custom drawing to match exactly:
                    // But requirement says "maintain component styles".
                    // Let's use a custom shape to mimic the Kotlin Canvas drawing.
                    .opacity(0) // Hiding SF Symbol to draw custom
                    .overlay(
                        CustomLeafIcon()
                            .frame(width: 30, height: 30)
                    )
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Earl Grey Reserve")
                    .font(.system(size: 16, weight: .bold)) // TitleMedium approx
                    .foregroundColor(TeaColors.textPrimary)
                Text("Black Tea • 95°C")
                    .font(.system(size: 12)) // BodySmall approx
                    .foregroundColor(TeaColors.teaLeafDetail)
            }
            
            Spacer()
            
            Image(systemName: "heart.fill")
                .font(.system(size: 24))
                .foregroundColor(TeaColors.favoriteTint)
        }
        .padding(20)
        .background(TeaColors.surfaceVariant)
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(TeaColors.outline, lineWidth: 1)
        )
    }
}

struct CustomLeafIcon: View {
    var body: some View {
        GeometryReader { geometry in
            let w = geometry.size.width
            let h = geometry.size.height
            
            ZStack {
                // Circle outline
                Circle()
                    .stroke(TeaColors.primary, lineWidth: 2)
                    .frame(width: min(w, h), height: min(w, h))
                
                // Vertical Line
                Path { path in
                    path.move(to: CGPoint(x: w / 2, y: h / 4))
                    path.addLine(to: CGPoint(x: w / 2, y: h * 0.75))
                }
                .stroke(TeaColors.primary, style: StrokeStyle(lineWidth: 2, lineCap: .round))
            }
        }
    }
}

struct TimerDisplay: View {
    let time: String
    
    var body: some View {
        ZStack {
            // Background Circle
            Circle()
                .stroke(TeaColors.backgroundTint, lineWidth: 12)
                .frame(width: 220, height: 220)
            
            // Progress Arc
            Circle()
                .trim(from: 0.0, to: 0.66) // 240 degrees / 360
                .stroke(TeaColors.primary, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                .rotationEffect(.degrees(-210)) // Start from bottom left-ish to match visual
                .frame(width: 220, height: 220)
            
            VStack(spacing: 4) {
                Text("Steeping")
                    .font(.system(size: 12, weight: .medium)) // LabelMedium
                    .tracking(2)
                    .foregroundColor(TeaColors.textSecondary)
                
                Text(time)
                    .font(.system(size: 45, weight: .light)) // DisplayMedium approx
                    .foregroundColor(TeaColors.textPrimary)
            }
        }
    }
}

struct ControlButtons: View {
    var body: some View {
        HStack(spacing: 24) {
            // Reset
            Button(action: {}) {
                Image(systemName: "arrow.counterclockwise")
                    .font(.system(size: 24))
                    .foregroundColor(.gray)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color(red: 0.88, green: 0.88, blue: 0.88), lineWidth: 1)
                    )
            }
            
            // Start
            Button(action: {}) {
                HStack(spacing: 8) {
                    Image(systemName: "play.fill")
                        .font(.system(size: 18))
                    Text("Start")
                        .font(.system(size: 16, weight: .medium))
                }
                .foregroundColor(.white)
                .frame(width: 120, height: 60)
                .background(TeaColors.primary)
                .cornerRadius(24)
            }
            
            // Add Note
            Button(action: {}) {
                Image(systemName: "plus")
                    .font(.system(size: 24))
                    .foregroundColor(.gray)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color(red: 0.88, green: 0.88, blue: 0.88), lineWidth: 1)
                    )
            }
        }
    }
}

struct PreparationSteps: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("PREPARATION")
                .font(.system(size: 11, weight: .bold)) // LabelSmall
                .foregroundColor(.gray.opacity(0.8))
                .padding(.bottom, 12)
            
            StepItem(step: "1", text: "Boil fresh water to 95°C")
            Divider().background(TeaColors.backgroundTint)
            StepItem(step: "2", text: "Add 1 tsp of loose leaf per cup")
            Divider().background(TeaColors.backgroundTint)
            StepItem(step: "3", text: "Pour water and wait for timer")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct StepItem: View {
    let step: String
    let text: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Text(step)
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(TeaColors.textPrimary)
                .frame(width: 24, height: 24)
                .background(TeaColors.backgroundTint)
                .clipShape(Circle())
            
            Text(text)
                .font(.system(size: 14)) // BodyMedium
                .foregroundColor(Color.gray)
            
            Spacer()
            
            Image(systemName: "checkmark")
                .font(.system(size: 12))
                .foregroundColor(TeaColors.outline)
        }
        .padding(.vertical, 8)
    }
}