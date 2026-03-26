//
//  VideoLibraryApp.swift
//  iOS 16 compatible – full screen – Grid card layout
//

import SwiftUI

@main
struct VideoLibraryApp: App {
    var body: some Scene {
        WindowGroup {
            VideoLibraryRoot()
                .ignoresSafeArea()
                .statusBar(hidden: true)
        }
    }
}

// MARK: - Tokens
private enum VL {
    enum C {
        static let primary = Color(hex: 0x38BDF8)
        static let secondary = Color(hex: 0x0EA5E9)
        static let tertiary = Color(hex: 0x0369A1)
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

struct VideoItem: Identifiable { 
    let id = UUID()
    let title: String
    let duration: String
}

struct VideoLibraryRoot: View {
    @State private var showDialog = false
    @State private var selectedVideo = ""
    
    private let videos: [VideoItem] = [
        .init(title: "Nature Documentary", duration: "24:18"),
        .init(title: "AI Explained", duration: "18:52"),
        .init(title: "Space Travel", duration: "31:09"),
        .init(title: "Modern Art Review", duration: "15:45"),
        .init(title: "Retro Music Visuals", duration: "22:10"),
        .init(title: "Daily News Recap", duration: "12:34")
    ]

    var body: some View {
        GeometryReader { geo in
            let scale = min(geo.size.width / 360.0, geo.size.height / 640.0)
            let columns = [
                GridItem(.flexible(), spacing: 12 * scale),
                GridItem(.flexible(), spacing: 12 * scale)
            ]
            
            VStack(spacing: 0) {
                // ===== Top Spacer =====
                Spacer()
                    .frame(height: 30 * scale) // 调整到30sp
                
                // ===== Top App Bar =====
                ZStack {
                    // 使用与整体背景相同的渐变
                    LinearGradient(
                        colors: [VL.C.surfaceVariant, VL.C.background],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 70 * scale)
                    
                    Text("Video Library")
                        .font(.system(size: 26 * scale, weight: .semibold))
                        .foregroundColor(VL.C.onSurface)
                }
                .frame(height: 70 * scale)
                
                // ===== Main Content Area =====
                VStack(spacing: 0) {
                    // ===== Subtitle =====
                    Text("Explore the latest videos")
                        .font(.system(size: 16 * scale, weight: .medium))
                        .foregroundColor(VL.C.onSurface)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16 * scale)
                        .padding(.vertical, 12 * scale)
                    
                    // ===== Video Grid =====
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 12 * scale) {
                            ForEach(videos) { video in
                                VStack(alignment: .leading, spacing: 8 * scale) {
                                    // Thumbnail
                                    RoundedRectangle(cornerRadius: 8 * scale)
                                        .fill(VL.C.surfaceVariant)
                                        .frame(height: 120 * scale)
                                        .overlay(
                                            Text("Thumbnail")
                                                .font(.system(size: 11 * scale, weight: .medium))
                                                .foregroundColor(VL.C.onSurface.opacity(0.6))
                                        )
                                    
                                    // Video Title
                                    Text(video.title)
                                        .font(.system(size: 16 * scale, weight: .medium))
                                        .foregroundColor(VL.C.onSurface)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .lineLimit(2)
                                    
                                    // Duration
                                    Text(video.duration)
                                        .font(.system(size: 13 * scale))
                                        .foregroundColor(VL.C.onSurface.opacity(0.7))
                                    
                                    // Play Button
                                    Button(action: {
                                        selectedVideo = video.title
                                        showDialog = true
                                    }) {
                                        Text("Play")
                                            .font(.system(size: 11 * scale, weight: .medium))
                                            .foregroundColor(VL.C.onPrimary)
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 32 * scale)
                                            .background(
                                                RoundedRectangle(cornerRadius: 8 * scale)
                                                    .fill(VL.C.primary)
                                            )
                                    }
                                }
                                .padding(12 * scale)
                                .background(
                                    RoundedRectangle(cornerRadius: 12 * scale)
                                        .fill(VL.C.surface)
                                        .shadow(
                                            color: Color.black.opacity(0.1),
                                            radius: 2 * scale,
                                            x: 0,
                                            y: 1 * scale
                                        )
                                )
                                .frame(maxHeight: .infinity, alignment: .top)
                            }
                        }
                        .padding(.horizontal, 16 * scale)
                        .padding(.vertical, 12 * scale)
                    }
                }
                .background(
                    LinearGradient(
                        colors: [VL.C.surfaceVariant, VL.C.background],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .background(
                LinearGradient(
                    colors: [VL.C.surfaceVariant, VL.C.background],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
            .alert(isPresented: $showDialog) {
                Alert(
                    title: Text("Playing Video"),
                    message: Text("Now playing: \(selectedVideo)"),
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
struct VideoLibraryRoot_Previews: PreviewProvider {
    static var previews: some View {
        VideoLibraryRoot()
            .previewDevice("iPhone SE (3rd generation)")
    }
}