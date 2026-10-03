import SwiftUI

@main
struct ZenBreatherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        MainScreen()
            .preferredColorScheme(.light)
            .statusBarHidden(true)
    }
}

struct Theme {
    static let pureWhite = Color.white
    static let textDark = Color(red: 0.18, green: 0.18, blue: 0.18) 
    static let accentTeal = Color(red: 0.00, green: 0.54, blue: 0.48) 
    static let lightGray = Color(red: 0.96, green: 0.96, blue: 0.96) 
    static let textGray = Color.gray
}

struct BreathingPattern: Identifiable {
    let id = UUID()
    let name: String
    let inhale: Int
    let exhale: Int
    
    var totalDuration: Double {
        Double(inhale + exhale)
    }
}

struct MainScreen: View {
    @State private var selectedPatternIndex = 0
    @State private var isPlaying = false
    @State private var scale: CGFloat = 0.8
    @State private var rotation: Double = 0.0
    
    let patterns = [
        BreathingPattern(name: "Relax", inhale: 4, exhale: 6),
        BreathingPattern(name: "Balance", inhale: 5, exhale: 5),
        BreathingPattern(name: "Focus", inhale: 4, exhale: 4)
    ]
    
    var currentPattern: BreathingPattern {
        patterns[selectedPatternIndex]
    }
    
        let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Theme.pureWhite.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer().frame(height: 48)
                
                                HStack {
                    Text("ZenBreather")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Theme.textDark)
                    Spacer()
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 24)
                
                Spacer().frame(height: 60)
                
                                ZStack {
                    BreathVisualizer(scale: scale, rotation: rotation)
                        .frame(width: 280, height: 280)
                    
                    VStack {
                        Text(isPlaying ? "Breathe" : "Ready")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(Theme.accentTeal)
                        
                        Text("\(currentPattern.inhale)s In / \(currentPattern.exhale)s Out")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                                VStack(alignment: .leading, spacing: 16) {
                    Text("Select Rhythm")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Theme.textDark)
                    
                    HStack(spacing: 0) {
                        ForEach(0..<patterns.count, id: \.self) { index in
                            PatternCard(
                                pattern: patterns[index],
                                isSelected: index == selectedPatternIndex,
                                onClick: {
                                    selectedPatternIndex = index
                                    stopBreathing()
                                }
                            )
                            if index < patterns.count - 1 {
                                Spacer()
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
                
                Spacer().frame(height: 32)
                
                                Button(action: {
                    toggleBreathing()
                }) {
                    HStack(spacing: 8) {
                        Text(isPlaying ? "STOP SESSION" : "START BREATHING")
                            .font(.system(size: 16, weight: .bold))
                            .tracking(1)
                        
                        if !isPlaying {
                            Image(systemName: "play.fill")
                                .font(.system(size: 20))
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 64)
                    .background(Theme.textDark)
                    .cornerRadius(32)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 32)
            }
        }
        .onReceive(timer) { _ in
            if isPlaying {
                withAnimation(.easeInOut(duration: currentPattern.totalDuration)) {
                                        rotation += 1
                    
                                                                                                                    }
            }
        }
    }
    
    func toggleBreathing() {
        if isPlaying {
            stopBreathing()
        } else {
            startBreathing()
        }
    }
    
    func startBreathing() {
        isPlaying = true
        withAnimation(.easeInOut(duration: Double(currentPattern.inhale)).repeatForever(autoreverses: true)) {
            scale = 1.2
        }
        withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
            rotation = 360
        }
    }
    
    func stopBreathing() {
        isPlaying = false
        withAnimation(.default) {
            scale = 0.8
            rotation = 0
        }
    }
}


struct BreathVisualizer: View {
    var scale: CGFloat
    var rotation: Double
    
    var body: some View {
        ZStack {
                        Circle()
                .fill(Theme.accentTeal.opacity(0.1))
                .scaleEffect(scale)
            
                        Circle()
                .stroke(Theme.accentTeal, lineWidth: 2) 
                .scaleEffect(scale)
            
                        ForEach(0..<8) { i in
                Rectangle()
                    .fill(Theme.accentTeal.opacity(0.4))
                    .frame(width: 140, height: 2) 
                    .offset(x: 70) 
                    .rotationEffect(.degrees(Double(i) * 45))
                    .scaleEffect(scale)
                
                                Circle()
                    .fill(Theme.accentTeal)
                    .frame(width: 6, height: 6)
                    .offset(x: 135) 
                    .rotationEffect(.degrees(Double(i) * 45))
                    .scaleEffect(scale)
            }
        }
        .rotationEffect(.degrees(rotation))
    }
}

struct PatternCard: View {
    let pattern: BreathingPattern
    let isSelected: Bool
    let onClick: () -> Void
    
    var body: some View {
        Button(action: onClick) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? Theme.accentTeal.opacity(0.05) : Theme.lightGray)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(isSelected ? Theme.accentTeal : Color.clear, lineWidth: 2)
                    )
                
                VStack(spacing: 4) {
                    if isSelected {
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Theme.accentTeal)
                    }
                    
                    Text(pattern.name)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(isSelected ? Theme.accentTeal : Theme.textDark)
                    
                                                                                if !isSelected {
                       Text(" ") 
                           .font(.system(size: 16))
                    }
                }
            }
            .frame(width: 100, height: 90)
        }
    }
}