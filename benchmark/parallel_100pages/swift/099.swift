import SwiftUI

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

struct MatchaBrewingScreen: View {
    var body: some View {
                        Color.white
            .ignoresSafeArea() 
            .overlay( 
                VStack(alignment: .center) { 
                                        VStack(alignment: .center) {
                                                Spacer().frame(height: 48)
                        Text("MATCHA RITUAL")
                            .font(.system(size: 14)) 
                            .kerning(4) 
                            .fontWeight(.bold) 
                            .foregroundColor(.gray) 
                        Spacer().frame(height: 8)
                        Text("Ceremonial Grade")
                            .font(.system(size: 28)) 
                            .fontWeight(.light) 
                            .foregroundColor(.black) 
                    }

                                                            VStack(alignment: .center) {
                        MatchaBowlCanvas()
                            .frame(width: 160, height: 160) 

                        Spacer().frame(height: 40) 

                                                HStack(spacing: 0) { 
                            Spacer() 
                            InfoItem(label: "TEMP", value: "80°C")
                            Spacer() 
                            InfoItem(label: "WATER", value: "70ml")
                            Spacer() 
                            InfoItem(label: "BAMBOO", value: "Whisk")
                            Spacer() 
                        }
                        .frame(maxWidth: .infinity) 
                    }
                    .frame(maxHeight: .infinity) 

                                        VStack(alignment: .center) { 
                        StepCard(number: "01", text: "Sift 2g of matcha powder.")
                        Spacer().frame(height: 12) 
                        StepCard(number: "02", text: "Add hot water. Whisk in 'M' shape.")

                        Spacer().frame(height: 32) 

                        Button(action: {
                                                    }) {
                            HStack(spacing: 8) { 
                                Image(systemName: "play.fill") 
                                    .font(.system(size: 20)) 
                                Text("START TIMER")
                                    .font(.system(size: 16)) 
                                    .fontWeight(.semibold) 
                            }
                            .foregroundColor(.white) 
                            .frame(maxWidth: .infinity, maxHeight: 56) 
                            .background(Color(hex: 0xFF556B2F)) 
                            .cornerRadius(28) 
                        }
                        .buttonStyle(PlainButtonStyle()) 
                        .frame(maxWidth: .infinity) 
                        
                        Spacer().frame(height: 24) 
                    }
                    .frame(maxWidth: .infinity) 
                }
                .padding(24) 
            )
            .statusBarHidden(true) 
    }
}

struct MatchaBowlCanvas: View {
    let bowlColor = Color(hex: 0xFF333333) 
    let matchaColor = Color(hex: 0xFF8BBD52) 
    
    var body: some View {
        Canvas { context, size in 
            let w = size.width
            let h = size.height
            
                        var bowlPath = Path() 
            bowlPath.move(to: CGPoint(x: w * 0.15, y: h * 0.4)) 
            bowlPath.addLine(to: CGPoint(x: w * 0.85, y: h * 0.4)) 
            bowlPath.addQuadCurve(
                to: CGPoint(x: w * 0.5, y: h * 0.9), 
                control: CGPoint(x: w * 0.9, y: h * 0.9) 
            ) 
            bowlPath.addQuadCurve(
                to: CGPoint(x: w * 0.15, y: h * 0.4), 
                control: CGPoint(x: w * 0.1, y: h * 0.9) 
            ) 
            bowlPath.closeSubpath() 
            
            context.fill(bowlPath, with: .color(bowlColor)) 
            
                        let matchaRect = CGRect(x: w * 0.2, y: h * 0.42, width: w * 0.6, height: h * 0.15)
            context.fill(Path(ellipseIn: matchaRect), with: .color(matchaColor)) 
            
                        let steamColor = Color.gray.opacity(0.5) 
                        let strokeStyle = StrokeStyle(lineWidth: 4, lineCap: .round) 
            
            var steamPath1 = Path()
            steamPath1.move(to: CGPoint(x: w * 0.4, y: h * 0.3))
            steamPath1.addLine(to: CGPoint(x: w * 0.4, y: h * 0.15))
            context.stroke(steamPath1, with: .color(steamColor), style: strokeStyle) 
            
            var steamPath2 = Path()
            steamPath2.move(to: CGPoint(x: w * 0.5, y: h * 0.25))
            steamPath2.addLine(to: CGPoint(x: w * 0.5, y: h * 0.1))
            context.stroke(steamPath2, with: .color(steamColor), style: strokeStyle) 
            
            var steamPath3 = Path()
            steamPath3.move(to: CGPoint(x: w * 0.6, y: h * 0.3))
            steamPath3.addLine(to: CGPoint(x: w * 0.6, y: h * 0.15))
            context.stroke(steamPath3, with: .color(steamColor), style: strokeStyle) 
        }
    }
}

struct InfoItem: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .center) { 
            Text(label)
                .font(.system(size: 10)) 
                .fontWeight(.bold) 
                .foregroundColor(.gray.opacity(0.5)) 
            Spacer().frame(height: 4) 
            Text(value)
                .font(.system(size: 16)) 
                .fontWeight(.medium) 
                .foregroundColor(.black) 
        }
    }
}

struct StepCard: View {
    let number: String
    let text: String
    
    var body: some View {
        HStack(alignment: .center) { 
            ZStack { 
                Circle() 
                    .fill(Color(hex: 0xFFF5F5F5)) 
                    .frame(width: 32, height: 32) 
                Text(number)
                    .font(.system(size: 12)) 
                    .fontWeight(.bold) 
                    .foregroundColor(.black) 
            }
            Spacer().frame(width: 16) 
            Text(text)
                .font(.system(size: 14)) 
                .foregroundColor(Color(white: 0.3)) 
        }
        .frame(maxWidth: .infinity) 
        .padding(16) 
                .overlay(
            RoundedRectangle(cornerRadius: 12) 
                .stroke(Color(hex: 0xFFEEEEEE), lineWidth: 1) 
        )
                            }
}

@main
struct MatchaApp: App {
    var body: some Scene {
        WindowGroup {
            MatchaBrewingScreen()
                        }
    }
}

struct MatchaBrewingScreen_Previews: PreviewProvider {
    static var previews: some View {
        MatchaBrewingScreen()
    }
}