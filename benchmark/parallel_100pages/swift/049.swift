import SwiftUI


struct AppTokens {
    struct Colors {
                static let primary = Color(red: 0xFF / 255.0, green: 0x70 / 255.0, blue: 0x43 / 255.0)
        static let secondary = Color(red: 0xFF / 255.0, green: 0xB7 / 255.0, blue: 0x4D / 255.0)
        static let tertiary = Color(red: 0xFF / 255.0, green: 0xD1 / 255.0, blue: 0x80 / 255.0)
        static let background = Color(red: 0xFF / 255.0, green: 0xF8 / 255.0, blue: 0xF2 / 255.0)
        static let surface = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let surfaceVariant = Color(red: 0xFF / 255.0, green: 0xE0 / 255.0, blue: 0xB2 / 255.0)
        static let outline = Color(red: 0xD7 / 255.0, green: 0xCC / 255.0, blue: 0xC8 / 255.0)
        static let success = Color(red: 0x43 / 255.0, green: 0xA0 / 255.0, blue: 0x47 / 255.0)
        static let warning = Color(red: 0xFF / 255.0, green: 0xB3 / 255.0, blue: 0x00 / 255.0)
        static let error = Color(red: 0xE5 / 255.0, green: 0x39 / 255.0, blue: 0x35 / 255.0)
        static let onPrimary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onSecondary = Color(red: 0x3E / 255.0, green: 0x27 / 255.0, blue: 0x23 / 255.0)
        static let onTertiary = Color(red: 0x3E / 255.0, green: 0x27 / 255.0, blue: 0x23 / 255.0)
        static let onBackground = Color(red: 0x3E / 255.0, green: 0x27 / 255.0, blue: 0x23 / 255.0)
        static let onSurface = Color(red: 0x3E / 255.0, green: 0x27 / 255.0, blue: 0x23 / 255.0)
    }

    struct TypographyTokens {
                static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) 
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
                static let small: CGFloat = 8
        static let medium: CGFloat = 14
        static let large: CGFloat = 20
    }

    struct Spacing {
                static let sm: CGFloat = 6
        static let md: CGFloat = 10
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 36
    }

        struct ShadowSpec {
        let elevation: CGFloat 
        let radius: CGFloat    
        let dy: CGFloat        
        let opacity: Double    

        var shadowColor: Color {
            Color.black.opacity(opacity)
        }
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.1)
        static let level2 = ShadowSpec(elevation: 6, radius: 8, dy: 4, opacity: 0.15)
        static let level3 = ShadowSpec(elevation: 10, radius: 12, dy: 6, opacity: 0.18)
    }
    
        static let gridItemMinSize: CGFloat = 160
}


struct TripCard: Identifiable {
    let id: Int
    let title: String
    let days: Int
    let price: String
}


struct TripCardView: View {
    let trip: TripCard

    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
                        RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                .fill(AppTokens.Colors.surfaceVariant)
                .frame(maxWidth: .infinity) 
                .frame(height: 100)          

            Text(trip.title)
                .font(AppTokens.TypographyTokens.title)
                .foregroundColor(AppTokens.Colors.onSurface)

            Text("\(trip.days) days")
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.onSurface.opacity(0.7)) 

            HStack { 
                Text(trip.price)
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.primary)

                Spacer() 

                Button(action: {
                                        print("Details for \(trip.title)")
                }) {
                    Text("Details")
                        .font(AppTokens.TypographyTokens.label)
                        .foregroundColor(AppTokens.Colors.onPrimary)
                                                .padding(.horizontal, AppTokens.Spacing.md)
                        .padding(.vertical, AppTokens.Spacing.sm / 2) 
                }
                .background(AppTokens.Colors.primary) 
                .cornerRadius(AppTokens.Shapes.medium) 
                .frame(height: 36) 
            }
        }
        .padding(AppTokens.Spacing.md) 
        .background(AppTokens.Colors.surface) 
        .cornerRadius(AppTokens.Shapes.large) 
        .shadow(color: AppTokens.ElevationMapping.level2.shadowColor, 
                radius: AppTokens.ElevationMapping.level2.radius,
                x: 0, 
                y: AppTokens.ElevationMapping.level2.dy)
    }
}


struct RootScreen: View {
        let trips: [TripCard] = [
        TripCard(id: 1, title: "Kyoto Cherry Trail", days: 4, price: "$460"),
        TripCard(id: 2, title: "Tokyo City Break", days: 3, price: "$390"),
        TripCard(id: 3, title: "Osaka Gourmet Tour", days: 5, price: "$520"),
        TripCard(id: 4, title: "Mount Fuji Escape", days: 2, price: "$280"),
        TripCard(id: 5, title: "Okinawa Beach Week", days: 6, price: "$740"),
        TripCard(id: 6, title: "Hokkaido Winter Lights", days: 5, price: "$680")
    ]

    var body: some View {
                VStack(alignment: .leading, spacing: AppTokens.Spacing.md) { 
            Text("Itinerary Planner")
                .font(AppTokens.TypographyTokens.display)
                .foregroundColor(AppTokens.Colors.primary)
                .padding(.horizontal, AppTokens.Spacing.lg) 

            ScrollView { 
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: AppTokens.gridItemMinSize), spacing: AppTokens.Spacing.lg)], 
                    spacing: AppTokens.Spacing.lg 
                ) {
                    ForEach(trips) { trip in 
                        TripCardView(trip: trip)
                    }
                }
                .padding(.horizontal, AppTokens.Spacing.lg) 
                .padding(.bottom, AppTokens.Spacing.xxl)    
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) 
        .background(
            LinearGradient( 
                gradient: Gradient(colors: [
                    AppTokens.Colors.secondary.opacity(0.3), 
                    AppTokens.Colors.background,
                    AppTokens.Colors.primary.opacity(0.3)    
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
                            }
}


@main
struct ItineraryPlannerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        RootScreen()
            .ignoresSafeArea() 
            .statusBarHidden(true) 
    }
}


struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}