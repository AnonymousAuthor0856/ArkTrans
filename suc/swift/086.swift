import SwiftUI

@main
struct BeatMakerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        BeatMakerScreen()
            .preferredColorScheme(.light)
            .statusBarHidden(true)
    }
}

// MARK: - Main Screen
struct BeatMakerScreen: View {
    // Pure UI State
    @State private var bpm: Float = 120
    @State private var isPlaying = false
    @State private var volume: Float = 0.8
    @State private var pads: [Bool] = Array(repeating: false, count: 16)
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Header
                HeaderSection()
                    .padding(.top, 24)
                    .padding(.horizontal, 24)
                
                Spacer().frame(height: 20)
                
                // LCD Display / Info Panel
                InfoDisplay(bpm: bpm, isPlaying: isPlaying)
                    .padding(.horizontal, 24)
                
                Spacer().frame(height: 24)
                
                // The Grid (Drum Pads)
                PadGrid(pads: $pads)
                    .padding(.horizontal, 24)
                
                Spacer().frame(height: 24)
                
                // Bottom Controls
                ControlSection(
                    bpm: $bpm,
                    volume: $volume,
                    isPlaying: $isPlaying,
                    onClear: { pads = Array(repeating: false, count: 16) }
                )
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
        }
    }
}

// MARK: - Components

struct HeaderSection: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("POCKET")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
                    .tracking(2)
                
                Text("BEATS-909")
                    .font(.system(size: 28, weight: .black))
                    .tracking(-1)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.black)
            }
        }
    }
}

struct InfoDisplay: View {
    let bpm: Float
    let isPlaying: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.black, lineWidth: 2)
                .background(Color(red: 0.96, green: 0.96, blue: 0.96)) // #F5F5F5
            
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("TEMPO")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.gray)
                    
                    Text("\(Int(bpm))")
                        .font(.system(size: 32, design: .monospaced))
                        .fontWeight(.medium)
                }
                
                Spacer()
                
                Circle()
                    .fill(isPlaying ? Color(red: 1.0, green: 0.34, blue: 0.13) : Color.gray.opacity(0.5)) // Orange #FF5722
                    .frame(width: 12, height: 12)
            }
            .padding(16)
        }
        .frame(height: 80)
    }
}

struct PadGrid: View {
    @Binding var pads: [Bool]
    
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(0..<16, id: \.self) { index in
                DrumPad(
                    isActive: pads[index],
                    onClick: { pads[index].toggle() },
                    label: getPadLabel(index)
                )
            }
        }
    }
}

struct DrumPad: View {
    let isActive: Bool
    let onClick: () -> Void
    let label: String
    
    var body: some View {
        Button(action: onClick) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(isActive ? Color.black : Color(red: 0.93, green: 0.93, blue: 0.93)) // #EEEEEE
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isActive ? Color.black : Color(red: 0.88, green: 0.88, blue: 0.88), lineWidth: 1) // #E0E0E0
                    )
                
                VStack(spacing: 4) {
                    if isActive {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 6, height: 6)
                    }
                    
                    Text(label)
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(isActive ? .white : .gray)
                }
            }
            .aspectRatio(1, contentMode: .fit)
        }
    }
}

struct ControlSection: View {
    @Binding var bpm: Float
    @Binding var volume: Float
    @Binding var isPlaying: Bool
    let onClear: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            // Sliders Row
            HStack(spacing: 16) {
                // BPM Slider Column
                VStack(alignment: .leading, spacing: 0) {
                    Text("BPM")
                        .font(.system(size: 10, weight: .bold))
                    
                    Slider(value: $bpm, in: 60...200)
                        .accentColor(.black)
                }
                
                // VOL Slider Column
                VStack(alignment: .leading, spacing: 0) {
                    Text("VOL")
                        .font(.system(size: 10, weight: .bold))
                    
                    Slider(value: $volume, in: 0...1)
                        .accentColor(.black)
                }
            }
            
            // Transport Buttons Row
            HStack {
                // Clear Button
                Button(action: onClear) {
                    HStack(spacing: 8) {
                        Image(systemName: "trash")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                        Text("CLEAR")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 24)
                    .frame(height: 48)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color(red: 0.88, green: 0.88, blue: 0.88), lineWidth: 1) // #E0E0E0
                    )
                }
                
                Spacer()
                
                // Play Button
                Button(action: { isPlaying.toggle() }) {
                    HStack(spacing: 12) {
                        if isPlaying {
                            Image(systemName: "pause.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        } else {
                            Image(systemName: "play.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        }
                        
                        Text(isPlaying ? "STOP" : "PLAY")
                            .font(.system(size: 12, weight: .bold))
                            .tracking(1)
                            .foregroundColor(.white)
                    }
                    .frame(width: 140, height: 64)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                }
            }
        }
    }
}

// MARK: - Helpers

func getPadLabel(_ index: Int) -> String {
    switch index {
    case 0: return "KICK"
    case 1: return "SNARE"
    case 2: return "CLAP"
    case 3: return "HI-HAT"
    case 4: return "TOM 1"
    case 5: return "TOM 2"
    case 6: return "CRASH"
    case 7: return "RIDE"
    case 8: return "PERC 1"
    case 9: return "PERC 2"
    case 10: return "FX 1"
    case 11: return "FX 2"
    default: return "SMP \(index + 1)"
    }
}