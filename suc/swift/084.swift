import SwiftUI

// MARK: - App Entry Point
@main
struct V60GuideApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// MARK: - Main Content View
struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: Header Section
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("V60 Guide")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("Ethiopia Yirgacheffe")
                        .font(.system(size: 16))
                        .foregroundColor(Color(UIColor.systemGray))
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 30) // Top margin since status bar is hidden
            
            Spacer()
            
            // MARK: Timer Section
            VStack(spacing: 10) {
                Text("00:45")
                    .font(.system(size: 90, weight: .regular))
                    .monospacedDigit() // Ensures fixed width for numbers
                    .foregroundColor(.black)
                    .minimumScaleFactor(0.8) // Adjusts for smaller SE screens if needed
                    .lineLimit(1)
                
                Text("Target: 300g")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color(UIColor.systemGray))
            }
            
            Spacer()
            
            // MARK: Parameters Grid
            HStack(spacing: 0) {
                // Left: Ratio
                ParameterItem(icon: "plus", value: "1:15", label: "Ratio")
                
                Spacer()
                
                // Center: Beans
                ParameterItem(icon: "heart.fill", value: "20g", label: "Beans")
                
                Spacer()
                
                // Right: Temperature
                ParameterItem(icon: "arrow.clockwise", value: "93°C", label: "Temp")
            }
            .padding(.horizontal, 30)
            
            Spacer()
            
            // Divider Line
            Divider()
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
            
            // MARK: Brewing Steps Section
            VStack(alignment: .leading, spacing: 15) {
                Text("Brewing Steps")
                    .font(.system(size: 19, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                
                // Step Item Row
                HStack(spacing: 16) {
                    // Checkmark Icon
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.black)
                        .background(Color.white)
                        .clipShape(Circle())
                    
                    // Step Content Background
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(UIColor.systemGray6)) // Very light gray
                        .frame(height: 52)
                        .overlay(
                            // Placeholder for step content (e.g., "Pour water")
                            HStack {
                                Spacer()
                            }
                        )
                }
                .padding(.horizontal, 24)
            }
            
            Spacer()
            
            // MARK: Start Button
            Button(action: {}) {
                HStack(spacing: 8) {
                    Image(systemName: "play.fill")
                        .font(.system(size: 18))
                    Text("Start Brewing")
                        .font(.system(size: 18, weight: .bold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Color.black)
                .cornerRadius(18)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 30)
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .statusBar(hidden: true)
    }
}

// MARK: - Component: Parameter Item
struct ParameterItem: View {
    let icon: String
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 12) {
            // Circular Icon Button
            ZStack {
                Circle()
                    .stroke(Color(UIColor.systemGray5), lineWidth: 1.5)
                    .frame(width: 64, height: 64)
                
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(Color(UIColor.systemGray))
            }
            
            // Text Values
            VStack(spacing: 4) {
                Text(value)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                
                Text(label)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(Color(UIColor.systemGray))
            }
        }
        .frame(width: 80) // Fixed width to ensure alignment
    }
}
