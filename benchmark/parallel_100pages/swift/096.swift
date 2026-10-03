import SwiftUI

extension Color {
    static let pureWhite = Color(red: 1.0, green: 1.0, blue: 1.0)
    static let offWhite = Color(red: 0xFA / 255.0, green: 0xFA / 255.0, blue: 0xFA / 255.0)
    static let textPrimary = Color(red: 0x1A / 255.0, green: 0x1A / 255.0, blue: 0x1A / 255.0)
    static let textSecondary = Color(red: 0x75 / 255.0, green: 0x75 / 255.0, blue: 0x75 / 255.0)
    static let accentGreen = Color(red: 0x4C / 255.0, green: 0xAF / 255.0, blue: 0x50 / 255.0)
    static let accentWarning = Color(red: 0xFF / 255.0, green: 0x98 / 255.0, blue: 0x00 / 255.0)
    static let dividerColor = Color(red: 0xEE / 255.0, green: 0xEE / 255.0, blue: 0xEE / 255.0)
}

@main
struct AeroSenseApp: App {
    var body: some Scene {
        WindowGroup {
            AeroSenseContentView()
                                                                .ignoresSafeArea(.all)
                .statusBarHidden()
        }
    }
}

struct AeroSenseContentView: View {
    var body: some View {
        ZStack { 
            Color.pureWhite.ignoresSafeArea() 

            VStack(spacing: 0) { 
                TopHeader()
                    .padding(.horizontal, 24) 
                    .padding(.vertical, 24)   

                                MainContent()
                    .padding(.horizontal, 24) 
                    .padding(.bottom, 16)     
                    .frame(maxWidth: .infinity, maxHeight: .infinity) 
            }
            .background(Color.pureWhite) 

            VStack {
                Spacer() 
                BottomControlBar()
            }
        }
    }
}

struct TopHeader: View {
    var body: some View {
        HStack { 
            VStack(alignment: .leading) { 
                Text("Living Room")
                                        .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.textSecondary)
                Text("AeroSense")
                                        .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.textPrimary)
            }
            Spacer() 
            Button(action: {  }) {
                Image(systemName: "gearshape.fill") 
                    .font(.system(size: 24)) 
                    .foregroundColor(.textPrimary)
                    .frame(width: 48, height: 48) 
                    .background(Color.offWhite) 
                    .clipShape(Circle()) 
            }
        }
    }
}

struct MainContent: View {
    var body: some View {
                ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 32) { 
                                AirQualityCircle(aqi: 42)
                
                                VStack(spacing: 16) { 
                    HStack(spacing: 16) { 
                        MetricCard(
                            label: "Temp",
                            value: "23°C",
                            iconName: "info.circle.fill", 
                            statusColor: .textPrimary
                        )
                        MetricCard(
                            label: "Humidity",
                            value: "45%",
                            iconName: "checkmark.circle.fill", 
                            statusColor: .accentGreen
                        )
                    }
                    HStack(spacing: 16) { 
                        MetricCard(
                            label: "PM 2.5",
                            value: "12",
                            iconName: "checkmark.circle.fill", 
                            statusColor: .accentGreen
                        )
                        MetricCard(
                            label: "CO2",
                            value: "850",
                            iconName: "exclamationmark.triangle.fill", 
                            statusColor: .accentWarning
                        )
                    }
                }
                
                                StatusBanner()
            }
            .padding(.vertical, 16) 
        }
    }
}

struct AirQualityCircle: View {
    let aqi: Int
    
    var body: some View {
                ZStack(alignment: .center) {
                        Canvas { context, size in
                let lineWidth: CGFloat = 40.0 
                let radius = (min(size.width, size.height) - lineWidth) / 2
                let center = CGPoint(x: size.width / 2, y: size.height / 2)
                
                                var backgroundPath = Path()
                backgroundPath.addArc(
                    center: center,
                    radius: radius,
                    startAngle: .degrees(135), 
                    endAngle: .degrees(135 + 270), 
                    clockwise: false 
                )
                context.stroke(backgroundPath, with: .color(.offWhite), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                
                                var progressPath = Path()
                progressPath.addArc(
                    center: center,
                    radius: radius,
                    startAngle: .degrees(135), 
                    endAngle: .degrees(135 + 110), 
                    clockwise: false
                )
                context.stroke(progressPath, with: .color(.accentGreen), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                
                                let dotRadius: CGFloat = 12.0 
                let angleForDot: Angle = .degrees(135 + 110) 
                let xOffset = radius * cos(angleForDot.radians)
                let yOffset = radius * sin(angleForDot.radians)
                let dotCenter = CGPoint(x: center.x + xOffset, y: center.y + yOffset)
                
                context.fill(Path(ellipseIn: CGRect(x: dotCenter.x - dotRadius / 2, y: dotCenter.y - dotRadius / 2, width: dotRadius, height: dotRadius)), with: .color(.pureWhite))
            }
            .frame(width: 220, height: 220) 
            
            VStack(alignment: .center) { 
                Text("AQI")
                                        .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.textSecondary)
                    .kerning(2) 
                Text("\(aqi)")
                                        .font(.system(size: 80, weight: .medium))
                    .foregroundColor(.textPrimary)
                Text("Excellent")
                                        .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.accentGreen)
                    .padding(.horizontal, 12) 
                    .padding(.vertical, 6)   
                    .background(
                        RoundedRectangle(cornerRadius: 16) 
                            .fill(Color.accentGreen.opacity(0.1)) 
                    )
            }
        }
        .frame(maxWidth: .infinity) 
        .aspectRatio(1.2, contentMode: .fit) 
    }
}

struct MetricCard: View {
    let label: String
    let value: String
    let iconName: String
    let statusColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) { 
            HStack {
                Image(systemName: iconName)
                    .font(.system(size: 20))
                    .foregroundColor(statusColor)
                Spacer() 
            }
            Spacer() 
            VStack(alignment: .leading, spacing: 4) { 
                Text(value)
                                        .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.textPrimary)
                Text(label)
                                        .font(.system(size: 12))
                    .foregroundColor(.textSecondary)
            }
        }
        .padding(16) 
        .frame(height: 110) 
        .frame(maxWidth: .infinity) 
        .background(Color.offWhite) 
        .cornerRadius(24) 
            }
}

struct StatusBanner: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) { 
            HStack(alignment: .center) { 
                Image(systemName: "house.fill") 
                    .font(.system(size: 24))
                    .foregroundColor(.textPrimary)
                Spacer()
                    .frame(width: 12) 
                Text("Room Analysis")
                                        .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.textPrimary)
            }
            Spacer()
                .frame(height: 12) 
            Text("Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.")
                                .font(.system(size: 14))
                .foregroundColor(.textSecondary)
                                                .lineSpacing(8) 
                .fixedSize(horizontal: false, vertical: true) 
        }
        .padding(20) 
        .frame(maxWidth: .infinity) 
        .background(
            RoundedRectangle(cornerRadius: 20) 
                .stroke(Color.dividerColor, lineWidth: 1) 
        )
    }
}

struct BottomControlBar: View {
    var body: some View {
        VStack(spacing: 0) { 
            Divider() 
                .background(Color.dividerColor) 
            
            HStack(alignment: .center) { 
                ControlIcon(iconName: "line.horizontal.3", description: "Menu") 
                
                Button(action: {  }) {
                    HStack(spacing: 8) { 
                        Image(systemName: "arrow.clockwise") 
                            .font(.system(size: 18)) 
                        Text("Refresh Data")
                            .font(.system(size: 16, weight: .medium)) 
                    }
                    .padding(.horizontal, 24) 
                    .padding(.vertical, 16)   
                    .background(Color.textPrimary) 
                    .foregroundColor(.pureWhite)    
                    .cornerRadius(16) 
                }
                
                ControlIcon(iconName: "plus", description: "Add Room") 
            }
            .padding(24) 
            .frame(maxWidth: .infinity) 
            .background(Color.pureWhite) 
        }
    }
}

struct ControlIcon: View {
    let iconName: String
    let description: String
    
    var body: some View {
        Button(action: {  }) {
            Image(systemName: iconName)
                .font(.system(size: 24)) 
                .foregroundColor(.textPrimary)
                .frame(width: 48, height: 48) 
                .background(
                    Circle() 
                        .stroke(Color.dividerColor, lineWidth: 1) 
                )
        }
        .accessibilityLabel(description) 
    }
}

struct AeroSenseContentView_Previews: PreviewProvider {
    static var previews: some View {
        AeroSenseContentView()
            .previewDisplayName("AeroSense App")
    }
}