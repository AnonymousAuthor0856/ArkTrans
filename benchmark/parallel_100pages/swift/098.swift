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

        static let primaryBlack = Color(hex: 0xFF121212)
    static let textGrey = Color(hex: 0xFF757575)
    static let backgroundWhite = Color.white
    static let cardBackground = Color(hex: 0xFFF9F9F9)
    static let promoCardBackground = Color(hex: 0xFFF0F0F0)
    static let lightGreyBorder = Color(hex: 0xFFEEEEEE)
    static let veryLightGreyBorder = Color(hex: 0xFFE0E0E0)
}

struct TeaGuide: Identifiable {
    let id: Int
    let name: String
    let origin: String
    let temp: String
    let time: String
    let colorCode: Color
}

let sampleTeas = [
    TeaGuide(id: 1, name: "Sencha Green", origin: "Japan", temp: "70°C / 158°F", time: "1-2 min", colorCode: Color(hex: 0xFF8BC34A)),
    TeaGuide(id: 2, name: "Earl Grey", origin: "Blend", temp: "95°C / 203°F", time: "3-5 min", colorCode: Color(hex: 0xFF795548)),
    TeaGuide(id: 3, name: "Silver Needle", origin: "China", temp: "80°C / 176°F", time: "3-4 min", colorCode: Color(hex: 0xFFE0E0E0)),
    TeaGuide(id: 4, name: "Darjeeling", origin: "India", temp: "90°C / 194°F", time: "3 min", colorCode: Color(hex: 0xFFD7CCC8)),
    TeaGuide(id: 5, name: "Chamomile", origin: "Egypt", temp: "100°C / 212°F", time: "5-7 min", colorCode: Color(hex: 0xFFFFEB3B)),
    TeaGuide(id: 6, name: "Matcha", origin: "Japan", temp: "80°C / 176°F", time: "Whisk", colorCode: Color(hex: 0xFF4CAF50)),
    TeaGuide(id: 7, name: "Oolong", origin: "Taiwan", temp: "85°C / 185°F", time: "3-5 min", colorCode: Color(hex: 0xFFFF9800))
]


struct ZenBrewAppView: View {
    var body: some View {
                ZStack(alignment: .bottomTrailing) {
                        ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) { 
                                        HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text("ZenBrew")
                                .font(.system(size: 24, weight: .bold)) 
                                .foregroundColor(.primaryBlack)
                                .kerning(-0.5) 
                            Text("Mindful Steeping Guide")
                                .font(.system(size: 14, weight: .regular)) 
                                .foregroundColor(.textGrey)
                        }
                        Spacer()
                        Button(action: {
                                                        print("Settings tapped")
                        }) {
                            Image(systemName: "gear") 
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24) 
                                .foregroundColor(.primaryBlack)
                        }
                        .frame(width: 44, height: 44) 
                    }
                    .padding(.horizontal, 20) 
                    .padding(.top, 10) 

                                        PromoCard()
                        .padding(.horizontal, 20) 

                                        Text("Collections")
                        .font(.system(size: 18, weight: .semibold)) 
                        .foregroundColor(.primaryBlack)
                        .frame(maxWidth: .infinity, alignment: .leading) 
                        .padding(.vertical, 8) 
                        .padding(.horizontal, 20) 

                                        ForEach(sampleTeas) { tea in
                        TeaItemCard(tea: tea)
                            .padding(.horizontal, 20) 
                    }

                                        Spacer()
                        .frame(height: 80) 
                }
                .padding(.vertical, 10) 
            }
            .background(Color.backgroundWhite.ignoresSafeArea()) 
            .edgesIgnoringSafeArea(.all) 

                        Button(action: {
                                print("Custom Brew tapped")
            }) {
                HStack(spacing: 8) { 
                    Image(systemName: "plus") 
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20) 
                    Text("Custom Brew")
                        .font(.system(size: 16, weight: .medium)) 
                }
                .frame(height: 56) 
                .padding(.horizontal, 24) 
                .background(Color.primaryBlack) 
                .foregroundColor(.white) 
                .cornerRadius(16) 
            }
            .padding(.trailing, 20) 
            .padding(.bottom, 20) 
        }
        .background(Color.backgroundWhite.ignoresSafeArea()) 
        .statusBarHidden(true) 
    }
}

struct PromoCard: View {
    var body: some View {
        HStack(alignment: .center) { 
            VStack(alignment: .leading) { 
                Text("Tip of the day")
                    .font(.system(size: 12, weight: .bold)) 
                    .foregroundColor(.gray)
                    .padding(.bottom, 4) 
                Text("Use filtered water for a purer taste profile.")
                    .font(.system(size: 16, weight: .medium)) 
                    .foregroundColor(.primaryBlack)
            }
            .frame(maxWidth: .infinity, alignment: .leading) 
            Spacer()
                .frame(width: 16) 

                        ZStack { 
                Circle()
                    .fill(Color.white) 
                    .frame(width: 48, height: 48) 
                Image(systemName: "info.circle.fill") 
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24) 
                    .foregroundColor(.gray)
            }
        }
        .padding(24) 
        .background(Color.promoCardBackground) 
        .cornerRadius(20) 
            }
}

struct TeaItemCard: View {
    let tea: TeaGuide
    
    var body: some View {
        HStack(alignment: .center) { 
                        ZStack { 
                Circle()
                    .fill(Color.white) 
                    .frame(width: 50, height: 50) 
                    .overlay(
                        Circle()
                            .stroke(tea.colorCode.opacity(0.3), lineWidth: 2) 
                    )
                Text(String(tea.name.prefix(1))) 
                    .font(.system(size: 20, weight: .bold)) 
                    .foregroundColor(tea.colorCode)
            }
            .clipShape(Circle()) 

            Spacer()
                .frame(width: 16) 

            VStack(alignment: .leading) { 
                Text(tea.name)
                    .font(.system(size: 17, weight: .bold)) 
                    .foregroundColor(.primaryBlack)
                Text(tea.origin)
                    .font(.system(size: 12)) 
                    .foregroundColor(.textGrey)
                Spacer()
                    .frame(height: 6) 
                HStack(alignment: .center) { 
                    InfoBadge(label: tea.temp)
                    Spacer()
                        .frame(width: 8) 
                    InfoBadge(label: tea.time)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading) 

                        Button(action: {
                                print("Play for \(tea.name) tapped")
            }) {
                Image(systemName: "play.fill") 
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20) 
                    .foregroundColor(.primaryBlack)
            }
            .frame(width: 40, height: 40) 
            .background(Color.white) 
            .clipShape(Circle()) 
            .overlay(
                Circle()
                    .stroke(Color.veryLightGreyBorder, lineWidth: 1) 
            )
        }
        .padding(16) 
        .background(Color.cardBackground) 
        .cornerRadius(16) 
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.lightGreyBorder, lineWidth: 1) 
        )
            }
}

struct InfoBadge: View {
    let label: String
    
    var body: some View {
        Text(label)
            .font(.system(size: 11)) 
            .foregroundColor(.black)
            .padding(.horizontal, 6) 
            .padding(.vertical, 2)
            .background(Color.white) 
            .cornerRadius(6) 
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.veryLightGreyBorder, lineWidth: 1) 
            )
    }
}

@main
struct ZenBrewApp: App {
    var body: some Scene {
        WindowGroup {
            ZenBrewAppView()
        }
    }
}

struct ZenBrewApp_Previews: PreviewProvider {
    static var previews: some View {
        ZenBrewAppView()
    }
}