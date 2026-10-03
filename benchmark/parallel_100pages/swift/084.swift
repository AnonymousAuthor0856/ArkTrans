import SwiftUI

@main
struct V60GuideApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            
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
            .padding(.vertical, 30) 
            
            Spacer()
            
                        VStack(spacing: 10) {
                Text("00:45")
                    .font(.system(size: 90, weight: .regular))
                    .monospacedDigit() 
                    .foregroundColor(.black)
                    .minimumScaleFactor(0.8) 
                    .lineLimit(1)
                
                Text("Target: 300g")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color(UIColor.systemGray))
            }
            
            Spacer()
            
                        HStack(spacing: 0) {
                                ParameterItem(icon: "plus", value: "1:15", label: "Ratio")
                
                Spacer()
                
                                ParameterItem(icon: "heart.fill", value: "20g", label: "Beans")
                
                Spacer()
                
                                ParameterItem(icon: "arrow.clockwise", value: "93°C", label: "Temp")
            }
            .padding(.horizontal, 30)
            
            Spacer()
            
                        Divider()
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
            
                        VStack(alignment: .leading, spacing: 15) {
                Text("Brewing Steps")
                    .font(.system(size: 19, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                
                                HStack(spacing: 16) {
                                        Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.black)
                        .background(Color.white)
                        .clipShape(Circle())
                    
                                        RoundedRectangle(cornerRadius: 10)
                        .fill(Color(UIColor.systemGray6)) 
                        .frame(height: 52)
                        .overlay(
                                                        HStack {
                                Spacer()
                            }
                        )
                }
                .padding(.horizontal, 24)
            }
            
            Spacer()
            
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

struct ParameterItem: View {
    let icon: String
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 12) {
                        ZStack {
                Circle()
                    .stroke(Color(UIColor.systemGray5), lineWidth: 1.5)
                    .frame(width: 64, height: 64)
                
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(Color(UIColor.systemGray))
            }
            
                        VStack(spacing: 4) {
                Text(value)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                
                Text(label)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(Color(UIColor.systemGray))
            }
        }
        .frame(width: 80) 
    }
}
