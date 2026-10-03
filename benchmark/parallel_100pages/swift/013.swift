
import SwiftUI

@main
struct RetroMusicPlayerApp: App {
    var body: some Scene {
        WindowGroup {
            RetroMusicPlayerRoot()
                .ignoresSafeArea()
                .statusBar(hidden: true)
        }
    }
}

private enum RM {
    enum C {
        static let primary    = Color(hex: 0xEF476F)  
        static let secondary  = Color(hex: 0xFFD166)  
        static let tertiary   = Color(hex: 0x06D6A0)  
        static let background = Color(hex: 0xFFFCF2)  
        static let surface    = Color(hex: 0xFFF8E1)  
        static let surfaceVariant = Color(hex: 0xFCE7E7) 
        static let outline    = Color(hex: 0xBDBDBD)  
        static let success    = Color(hex: 0x06D6A0)  
        static let warning    = Color(hex: 0xFFA600)  
        static let error      = Color(hex: 0xD62828)  
        static let onPrimary  = Color(hex: 0xFFFFFF)  
        static let onSecondary = Color(hex: 0x1F1F1F) 
        static let onTertiary = Color(hex: 0x1F1F1F)  
        static let onBackground = Color(hex: 0x1F1F1F) 
        static let onSurface  = Color(hex: 0x1F1F1F)  
    }
}

struct RetroMusicPlayerRoot: View {
    @State private var knobPosition = CGPoint(x: 140, y: 140)
    @State private var isDragging = false
    
    var body: some View {
        GeometryReader { geo in
            let scale = max(geo.size.width / 360.0, geo.size.height / 640.0)
            
            VStack(spacing: 0) {
                                ZStack {
                    Rectangle()
                        .fill(RM.C.background)
                        .frame(height: 80 * scale)
                    
                    Text("Retro Music Player")
                        .font(.system(size: 34 * scale, weight: .bold))
                        .foregroundColor(RM.C.onSurface)
                }
                .frame(height: 80 * scale)
                
                Spacer()
                
                                VStack(spacing: 32 * scale) {
                                        ZStack {
                                                RoundedRectangle(cornerRadius: 16 * scale)
                            .fill(RM.C.surface)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16 * scale)
                                    .stroke(RM.C.outline, lineWidth: 3 * scale)
                            )
                        
                                                Circle()
                            .stroke(RM.C.secondary, lineWidth: 8 * scale)
                            .padding(20 * scale) 
                        
                                                Circle()
                            .fill(RM.C.primary)
                            .frame(width: 24 * scale, height: 24 * scale)
                            .position(knobPosition)
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { value in
                                        isDragging = true
                                                                                let center = CGPoint(x: 140 * scale, y: 140 * scale)
                                        let radius = 120 * scale 
                                        
                                        let vector = CGVector(
                                            dx: value.location.x - center.x,
                                            dy: value.location.y - center.y
                                        )
                                        let distance = sqrt(vector.dx * vector.dx + vector.dy * vector.dy)
                                        
                                        if distance <= radius {
                                            knobPosition = value.location
                                        } else {
                                            let angle = atan2(vector.dy, vector.dx)
                                            knobPosition = CGPoint(
                                                x: center.x + cos(angle) * radius,
                                                y: center.y + sin(angle) * radius
                                            )
                                        }
                                    }
                                    .onEnded { _ in
                                        isDragging = false
                                    }
                            )
                            .animation(isDragging ? nil : .easeOut(duration: 0.2), value: knobPosition)
                    }
                    .frame(width: 280 * scale, height: 280 * scale)
                    
                                        Text("Track: Summer Nights")
                        .font(.system(size: 22 * scale, weight: .medium))
                        .foregroundColor(RM.C.onSurface)
                    
                                        HStack(spacing: 32 * scale) {
                        Button(action: {
                                                    }) {
                            Text("Play")
                                .font(.system(size: 22 * scale, weight: .medium))
                                .foregroundColor(RM.C.onPrimary)
                                .frame(width: 140 * scale, height: 56 * scale)
                                .background(
                                    RoundedRectangle(cornerRadius: 12 * scale)
                                        .fill(RM.C.primary)
                                )
                        }
                        
                        Button(action: {
                                                    }) {
                            Text("Pause")
                                .font(.system(size: 22 * scale, weight: .medium))
                                .foregroundColor(RM.C.onSecondary)
                                .frame(width: 140 * scale, height: 56 * scale)
                                .background(
                                    RoundedRectangle(cornerRadius: 12 * scale)
                                        .fill(RM.C.secondary)
                                )
                        }
                    }
                    
                                        Text("Knob X:268 Y:303") 
                        .font(.system(size: 16 * scale, weight: .medium))
                        .foregroundColor(RM.C.tertiary)
                }
                .padding(.horizontal, 32 * scale)
                
                Spacer()
                
                                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 60 * scale)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(RM.C.background)
            .onAppear {
                                knobPosition = CGPoint(x: 140 * scale, y: 140 * scale)
            }
        }
    }
}

private extension Color {
    init(hex: UInt32) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0
        )
    }
}

struct RetroMusicPlayerRoot_Previews: PreviewProvider {
    static var previews: some View {
        RetroMusicPlayerRoot()
            .previewDevice("iPhone 14 Pro")
    }
}