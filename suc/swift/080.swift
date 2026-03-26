import SwiftUI

@main
struct FurnitureApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        FurnitureDetailScreen()
            .preferredColorScheme(.light)
            .statusBarHidden(true)
    }
}

struct FurnitureDetailScreen: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HeaderBar()
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                
                // Content
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        Spacer().frame(height: 24)
                        
                        ProductImagePlaceholder()
                        
                        Spacer().frame(height: 32)
                        
                        ProductInfoSection()
                        
                        // Spacer to push content up if needed, but in scrollview it just adds padding
                        Spacer().frame(height: 24)
                    }
                    .padding(.horizontal, 24)
                }
                
                // Bottom Actions (Sticky at bottom)
                BottomActionSection()
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
            }
        }
    }
}

struct HeaderBar: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "arrow.backward")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .frame(width: 48, height: 48)
                    .background(
                        Circle()
                            .stroke(Color(red: 0.88, green: 0.88, blue: 0.88), lineWidth: 1) // #E0E0E0
                    )
            }
            
            Spacer()
            
            Text("Details")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "heart")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .frame(width: 48, height: 48)
                    .background(
                        Circle()
                            .stroke(Color(red: 0.88, green: 0.88, blue: 0.88), lineWidth: 1) // #E0E0E0
                    )
            }
        }
    }
}

struct ProductImagePlaceholder: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32)
                .fill(Color(red: 0.96, green: 0.96, blue: 0.96)) // #F5F5F5
            
            Image(systemName: "cart")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .foregroundColor(Color(red: 0.74, green: 0.74, blue: 0.74)) // #BDBDBD
        }
        .frame(height: 300)
        .frame(maxWidth: .infinity)
    }
}

struct ProductInfoSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Modern Lounge\nChair")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.black)
                        .lineSpacing(4) // Adjusting line spacing to approx 32.sp line height
                    
                    Text("Minimalist Series")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Text("$1299")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
            }
            
            Spacer().frame(height: 24)
            
            HStack(spacing: 0) {
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(red: 1.0, green: 0.76, blue: 0.03)) // #FFC107
                
                Spacer().frame(width: 4)
                
                Text("4.8")
                    .font(.system(size: 16, weight: .bold)) // Default usually matches body
                    .foregroundColor(.black)
                
                Spacer().frame(width: 8)
                
                Text("(238 Reviews)")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Spacer().frame(height: 24)
            
            Text("Colors")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
            
            Spacer().frame(height: 12)
            
            HStack(spacing: 12) {
                ColorSelector(color: Color(red: 0.13, green: 0.13, blue: 0.13), isSelected: true) // #212121
                ColorSelector(color: Color(red: 0.47, green: 0.33, blue: 0.28), isSelected: false) // #795548
                ColorSelector(color: Color(red: 0.62, green: 0.62, blue: 0.62), isSelected: false) // #9E9E9E
            }
        }
    }
}

struct ColorSelector: View {
    let color: Color
    let isSelected: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .fill(color)
                .frame(width: 32, height: 32)
            
            if isSelected {
                Circle()
                    .stroke(Color.gray.opacity(0.5), lineWidth: 2) // LightGray approx
                    .frame(width: 32, height: 32)
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 10, height: 10)
            }
        }
    }
}

struct BottomActionSection: View {
    var body: some View {
        HStack(spacing: 16) {
            Button(action: {}) {
                Text("Add to Cart")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.black)
                    .cornerRadius(16)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(red: 0.96, green: 0.96, blue: 0.96)) // #F5F5F5
                    .frame(width: 56, height: 56)
                
                Image(systemName: "heart.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.black)
            }
        }
    }
}