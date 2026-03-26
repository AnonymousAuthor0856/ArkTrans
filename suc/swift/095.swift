import SwiftUI

@main
struct ReceiptApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        ReceiptScreen()
            .preferredColorScheme(.light)
            .statusBarHidden(true)
    }
}

struct ReceiptScreen: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 0) {
                // Header
                Spacer().frame(height: 20)
                
                SuccessIcon()
                
                Spacer().frame(height: 16)
                
                Text("Payment Success")
                    .font(.system(size: 16, weight: .medium)) // TitleMedium approx
                    .foregroundColor(.gray)
                
                Spacer().frame(height: 8)
                
                Text("$1,249.00")
                    .font(.system(size: 45, weight: .bold)) // DisplayMedium approx
                    .foregroundColor(.black)
                
                Spacer().frame(height: 32)
                
                // Receipt Card
                ReceiptDetailsCard()
                
                Spacer()
                
                // Action Buttons
                ActionButtons()
                
                Spacer().frame(height: 16)
            }
            .padding(24)
        }
    }
}

struct SuccessIcon: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(red: 0.91, green: 0.96, blue: 0.91)) // #E8F5E9 (Light Green)
                .frame(width: 72, height: 72)
            
            Image(systemName: "checkmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 36, height: 36)
                .foregroundColor(Color(red: 0.18, green: 0.49, blue: 0.20)) // #2E7D32 (Darker Green)
                .font(Font.system(size: 36, weight: .bold)) // Make checkmark thicker
        }
    }
}

struct ReceiptDetailsCard: View {
    var body: some View {
        VStack(spacing: 16) {
            // Recipient
            RowDetail(
                label: "To Merchant",
                value: "TechSpace Solutions",
                iconName: "info.circle.fill"
            )
            
            Divider()
                .background(Color(red: 0.88, green: 0.88, blue: 0.88)) // #E0E0E0
            
            // Date
            RowDetail(
                label: "Date",
                value: "Dec 02, 2025 - 11:30 PM",
                iconName: "calendar"
            )
            
            Divider()
                .background(Color(red: 0.88, green: 0.88, blue: 0.88)) // #E0E0E0
            
            // Transaction ID
            HStack {
                Text("Ref Number")
                    .font(.system(size: 14)) // BodyMedium approx
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("009281-XX-99")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
            }
            
            // Payment Method
            HStack {
                Text("Payment Method")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("Credit Card •••• 4242")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
            }
        }
        .padding(20)
        .background(Color(red: 0.97, green: 0.98, blue: 0.98)) // #F8F9FA
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(red: 0.93, green: 0.93, blue: 0.93), lineWidth: 1) // #EEEEEE
        )
    }
}

struct RowDetail: View {
    let label: String
    let value: String
    let iconName: String
    
    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Image(systemName: iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
                    .foregroundColor(.gray)
                
                Text(label)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(value)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
        }
    }
}

struct ActionButtons: View {
    var body: some View {
        VStack(spacing: 12) {
            Button(action: {}) {
                Text("Done")
                    .font(.system(size: 16, weight: .bold)) // BodyLarge + Bold
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.black)
                    .cornerRadius(8)
            }
            
            Button(action: {}) {
                HStack(spacing: 8) {
                    Image(systemName: "square.and.arrow.up") // Share icon approximation
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18)
                        .foregroundColor(.black)
                    
                    Text("Share Receipt")
                        .font(.system(size: 16)) // BodyLarge
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(red: 0.87, green: 0.87, blue: 0.87), lineWidth: 1) // #DDDDDD
                )
            }
        }
    }
}