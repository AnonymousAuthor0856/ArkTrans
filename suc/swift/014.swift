//
//  PodcastListenColdGradientApp.swift
//  iOS 16 compatible – full screen – Cold Gradient
//

import SwiftUI

@main
struct PodcastListenColdGradientApp: App {
    var body: some Scene {
        WindowGroup {
            PodcastColdRoot()
                .ignoresSafeArea()
                .statusBar(hidden: true)
        }
    }
}

// MARK: - Tokens
private enum PC {
    enum C {
        static let primary = Color(hex: 0x38BDF8)
        static let secondary = Color(hex: 0x0EA5E9)
        static let tertiary = Color(hex: 0x0284C7)
        static let background = Color(hex: 0xF0F9FF)
        static let surface = Color.white
        static let surfaceVariant = Color(hex: 0xE0F2FE)
        static let outline = Color(hex: 0xBFE0F4)
        static let success = Color(hex: 0x16A34A)
        static let warning = Color(hex: 0xF59E0B)
        static let error = Color(hex: 0xDC2626)
        static let onPrimary = Color(hex: 0x001F2F)
        static let onSecondary = Color.white
        static let onTertiary = Color.white
        static let onBackground = Color(hex: 0x082F49)
        static let onSurface = Color(hex: 0x082F49)
    }
}

struct PodcastColdRoot: View {
    @State private var selectedTab = 0
    @State private var showDialog = false
    @State private var selectedPodcast = ""
    
    private let tabs = ["Trending", "Following", "Recent"]
    private let podcasts = [
        "AI Insights",
        "Mindful Moments", 
        "History Flash",
        "Tech Hour",
        "Design Flow"
    ]

    var body: some View {
        GeometryReader { geo in
            let scale = min(geo.size.width / 360.0, geo.size.height / 640.0)
            
            VStack(spacing: 0) {
                // ===== Top Spacer =====
                Spacer()
                    .frame(height: 0 * scale) // 增加顶部空白
                    .padding(.bottom, 25)
                    
                // ===== Top App Bar =====
                ZStack {
                    Rectangle()
                        .fill(PC.C.background)
                        .frame(height: 790 * scale)
                    
                    Text("Podcasts")
                        .font(.system(size: 28 * scale, weight: .semibold))
                        .foregroundColor(PC.C.onSurface)
                }
                .frame(height: 60 * scale)


            
                // ===== Tab Selection =====
                HStack(spacing: 10 * scale) {
                    ForEach(0..<tabs.count, id: \.self) { index in
                        Button(action: {
                            selectedTab = index
                        }) {
                            HStack(spacing: 1 * scale) {
                                if selectedTab == index {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 13 * scale, weight: .bold))
                                }
                                Text(tabs[index])
                                    .font(.system(size: 14 * scale, weight: .medium))
                            }
                            .foregroundColor(selectedTab == index ? PC.C.onPrimary : PC.C.onSurface)
                            .frame(maxWidth: .infinity)
                            .frame(width:112)
                            .frame(height: 39 * scale)
                            .background(
                                RoundedRectangle(cornerRadius: 8 * scale)
                                    .fill(selectedTab == index ? PC.C.primary : PC.C.surface)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8 * scale)
                                            .stroke(PC.C.outline, lineWidth: 1 * scale)
                                    )
                            )
                        }
                    }
                }
                .padding(.horizontal, 16 * scale)
                .padding(.vertical, 15 * scale)
                .background(
                    LinearGradient(
                        colors: [PC.C.surfaceVariant, PC.C.background],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                
                // ===== Podcast List =====
                ScrollView {
                    LazyVStack(spacing: 15 * scale) {
                        ForEach(podcasts, id: \.self) { podcast in
                            HStack {
                                VStack(alignment: .leading, spacing: 5 * scale) {
                                    Text(podcast)
                                        .font(.system(size: 20 * scale, weight: .medium))
                                        .foregroundColor(PC.C.onSurface)
                                    Text("30 min episode")
                                        .font(.system(size: 14 * scale))
                                        .foregroundColor(PC.C.onSurface.opacity(0.7))
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    selectedPodcast = podcast
                                    showDialog = true
                                }) {
                                    Text("Play")
                                        .font(.system(size: 14 * scale, weight: .medium))
                                        .foregroundColor(PC.C.onSecondary)
                                        .frame(width: 84 * scale, height: 39 * scale)
                                        .background(
                                            RoundedRectangle(cornerRadius: 8 * scale)
                                                .fill(PC.C.secondary)
                                        )
                                }
                            }
                            .padding(16 * scale)
                            .background(
                                RoundedRectangle(cornerRadius: 12 * scale)
                                    .fill(PC.C.surface)
                            )
                            .padding(.horizontal, 16 * scale)
                        }
                    }
                    .padding(.vertical, 12 * scale)
                }
                .background(PC.C.background)
                
                // ===== Bottom Spacer =====
                Spacer()
                    .frame(height: 20 * scale) // 增加底部空白
            }
            .background(
                LinearGradient(
                    colors: [PC.C.surfaceVariant, PC.C.background],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
            .alert(isPresented: $showDialog) {
                Alert(
                    title: Text("Playing Podcast"),
                    message: Text("Streaming audio..."),
                    dismissButton: .default(Text("OK")) {
                        showDialog = false
                    }
                )
            }
        }
    }
}

// MARK: - Hex Color Extension
private extension Color {
    init(hex: UInt32) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0
        )
    }
}

// MARK: - Preview
struct PodcastColdRoot_Previews: PreviewProvider {
    static var previews: some View {
        PodcastColdRoot()
            .previewDevice("iPhone SE (3rd generation)")
    }
}
