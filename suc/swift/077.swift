import SwiftUI

@main
struct FurnitureShopApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        FurnitureDetailScreen()
            .statusBarHidden(true)
    }
}

struct FurnitureDetailScreen: View {
    @State private var isFavorite: Bool = false
    @State private var selectedColorIndex: Int = 0
    @State private var quantity: Int = 1

    let colors: [Color] = [
        Color(red: 0.94, green: 0.71, blue: 0.58), // #EFB495
        Color(red: 0.55, green: 0.43, blue: 0.39), // #8D6E63
        Color(red: 0.36, green: 0.25, blue: 0.22)  // #5D4037
    ]

    var body: some View {
        ZStack {
            // Main Background
            Color(red: 0.96, green: 0.96, blue: 0.97) // #F5F5F7
                .ignoresSafeArea()

            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        
                        // Top Image Section
                        ZStack {
                            // Background shape
                            Color(red: 0.91, green: 0.91, blue: 0.91) // #E8E8E8
                                .frame(height: 400)
                                .clipShape(CustomCornerShape(radius: 40, corners: [.bottomLeft, .bottomRight]))
                            
                            // Centered Icon Container
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 200, height: 200)
                                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                                
                                Image(systemName: "house.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(Color(red: 0.94, green: 0.71, blue: 0.58)) // #EFB495
                            }
                            
                            // Top Buttons
                            VStack {
                                HStack {
                                    // Back Button
                                    Button(action: {}) {
                                        Image(systemName: "arrow.backward")
                                            .font(.system(size: 20, weight: .medium))
                                            .foregroundColor(.black)
                                            .frame(width: 42, height: 42)
                                            .background(Color.white)
                                            .clipShape(Circle())
                                    }
                                    
                                    Spacer()
                                    
                                    // Favorite Button
                                    Button(action: { isFavorite.toggle() }) {
                                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                                            .font(.system(size: 20, weight: .medium))
                                            .foregroundColor(isFavorite ? .red : .black)
                                            .frame(width: 42, height: 42)
                                            .background(Color.white)
                                            .clipShape(Circle())
                                    }
                                }
                                .padding(24)
                                Spacer()
                            }
                            .frame(height: 400)
                        }

                        // Content Section
                        VStack(alignment: .leading, spacing: 0) {
                            
                            // Title and Rating
                            HStack(alignment: .center) {
                                Text("Modern Lounge")
                                    .font(.system(size: 26, weight: .bold))
                                    .foregroundColor(Color(red: 0.20, green: 0.20, blue: 0.20)) // #333333
                                
                                Spacer()
                                
                                HStack(spacing: 4) {
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(Color(red: 1.0, green: 0.76, blue: 0.03)) // #FFC107
                                    
                                    Text("4.8")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.black)
                                }
                            }
                            
                            // Subtitle
                            Text("Armchair")
                                .font(.system(size: 20, weight: .light))
                                .foregroundColor(.gray)
                                .padding(.top, -4) // Offset to match visual layout
                            
                            Spacer().frame(height: 24)
                            
                            // Description Title
                            Text("Description")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                            
                            Spacer().frame(height: 8)
                            
                            // Description Body
                            Text("Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .lineSpacing(6) // Approx lineHeight 22sp
                            
                            Spacer().frame(height: 24)
                            
                            // Color and Quantity Row
                            HStack(alignment: .top) {
                                // Color Selection
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Color")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.black)
                                    
                                    HStack(spacing: 12) {
                                        ForEach(0..<colors.count, id: \.self) { index in
                                            ZStack {
                                                Circle()
                                                    .fill(colors[index])
                                                    .frame(width: 30, height: 30)
                                                
                                                if selectedColorIndex == index {
                                                    Circle()
                                                        .stroke(Color.black, lineWidth: 2)
                                                        .frame(width: 30, height: 30)
                                                }
                                            }
                                            .onTapGesture {
                                                selectedColorIndex = index
                                            }
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                                // Quantity Selection
                                VStack(alignment: .trailing, spacing: 8) {
                                    Text("Quantity")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.black)
                                    
                                    HStack(alignment: .center, spacing: 0) {
                                        Text("-")
                                            .font(.system(size: 20))
                                            .foregroundColor(.black)
                                            .frame(width: 40, height: 32)
                                            .contentShape(Rectangle())
                                            .onTapGesture {
                                                if quantity > 1 { quantity -= 1 }
                                            }
                                        
                                        Text("\(quantity)")
                                            .font(.system(size: 18, weight: .bold))
                                            .foregroundColor(.black)
                                            .frame(minWidth: 20)
                                        
                                        Image(systemName: "plus")
                                            .font(.system(size: 16))
                                            .foregroundColor(.black)
                                            .frame(width: 40, height: 32)
                                            .contentShape(Rectangle())
                                            .onTapGesture {
                                                quantity += 1
                                            }
                                    }
                                    .background(Color.white)
                                    .cornerRadius(12)
                                }
                            }
                            
                            // Extra padding at bottom of scrollable content to avoid overlap with bottom bar
                            Spacer().frame(height: 100)
                        }
                        .padding(24)
                    }
                }
            }
            
            // Bottom Surface
            VStack {
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Total Price")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        
                        Text("$\(245 * quantity)")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        HStack(spacing: 8) {
                            Image(systemName: "cart.fill")
                                .font(.system(size: 20))
                            Text("Add to Cart")
                                .font(.system(size: 16, weight: .medium))
                        }
                        .foregroundColor(.white)
                        .frame(width: 160, height: 50)
                        .background(Color(red: 0.20, green: 0.20, blue: 0.20)) // #333333
                        .cornerRadius(16)
                    }
                }
                .padding(24)
                .background(Color.white)
                .cornerRadius(24, corners: [.topLeft, .topRight])
                .shadow(color: Color.black.opacity(0.1), radius: 16, x: 0, y: -4)
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

// MARK: - Helper Components

struct CustomCornerShape: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// Helper extension to apply custom corners easily via .cornerRadius modifier wrapper if needed, 
// but strictly keeping it compatible with standard SwiftUI View modifier approach.
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(CustomCornerShape(radius: radius, corners: corners))
    }
}