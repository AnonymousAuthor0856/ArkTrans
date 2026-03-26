import SwiftUI

struct ContentView: View {
    @State private var currentLocation = "New York"
    @State private var temperature = "72°"
    @State private var condition = "Sunny"
    @State private var feelsLike = "74°"
    @State private var humidity = "45%"
    @State private var wind = "5 mph"
    
    // 定义颜色常量以匹配设计
    private let primaryBlue = Color(red: 0.13, green: 0.59, blue: 0.95) // #2196F3
    private let primaryGreen = Color(red: 0.30, green: 0.69, blue: 0.31) // #4CAF50
    private let primaryOrange = Color(red: 1.00, green: 0.60, blue: 0.00) // #FF9800
    private let backgroundColor = Color(red: 0.96, green: 0.97, blue: 0.98) // #F5F7FA
    private let surfaceColor = Color.white
    private let surfaceVariant = Color(red: 0.91, green: 0.96, blue: 0.91) // #E8F5E8
    private let textPrimary = Color(red: 0.15, green: 0.20, blue: 0.22) // #263238
    private let textSecondary = Color(red: 0.15, green: 0.20, blue: 0.22).opacity(0.7)
    
    private let hourlyForecast = [
        WeatherHour(hour: "Now", temp: "72°", condition: "Sunny", color: Color(red: 1.00, green: 0.60, blue: 0.00)),
        WeatherHour(hour: "1 PM", temp: "74°", condition: "Sunny", color: Color(red: 1.00, green: 0.60, blue: 0.00)),
        WeatherHour(hour: "2 PM", temp: "75°", condition: "Sunny", color: Color(red: 1.00, green: 0.60, blue: 0.00)),
        WeatherHour(hour: "3 PM", temp: "76°", condition: "Cloudy", color: Color(red: 0.13, green: 0.59, blue: 0.95)),
        WeatherHour(hour: "4 PM", temp: "74°", condition: "Cloudy", color: Color(red: 0.13, green: 0.59, blue: 0.95)),
        WeatherHour(hour: "5 PM", temp: "72°", condition: "Rain", color: Color(red: 0.30, green: 0.69, blue: 0.31)),
        WeatherHour(hour: "6 PM", temp: "70°", condition: "Rain", color: Color(red: 0.30, green: 0.69, blue: 0.31))
    ]
    
    private let weeklyForecast = [
        WeatherDay(day: "Today", high: "76°", low: "62°", condition: "Sunny", color: Color(red: 1.00, green: 0.60, blue: 0.00)),
        WeatherDay(day: "Mon", high: "74°", low: "60°", condition: "Cloudy", color: Color(red: 0.13, green: 0.59, blue: 0.95)),
        WeatherDay(day: "Tue", high: "72°", low: "58°", condition: "Rain", color: Color(red: 0.30, green: 0.69, blue: 0.31)),
        WeatherDay(day: "Wed", high: "70°", low: "56°", condition: "Rain", color: Color(red: 0.30, green: 0.69, blue: 0.31)),
        WeatherDay(day: "Thu", high: "73°", low: "59°", condition: "Cloudy", color: Color(red: 0.13, green: 0.59, blue: 0.95)),
        WeatherDay(day: "Fri", high: "75°", low: "61°", condition: "Sunny", color: Color(red: 1.00, green: 0.60, blue: 0.00)),
        WeatherDay(day: "Sat", high: "77°", low: "63°", condition: "Sunny", color: Color(red: 1.00, green: 0.60, blue: 0.00))
    ]
    
    var body: some View {
        ZStack {
            // Background
            backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                Text("Weather")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(textPrimary)
                    .padding(.top, 44)
                    .padding(.bottom, 18)
                
                // Main Content
                ScrollView {
                    VStack(spacing: 18) {
                        // Current Weather Card
                        VStack(spacing: 10) {
                            Text(currentLocation)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(textPrimary)
                            
                            Text(temperature)
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(textPrimary)
                            
                            Text(condition)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(textSecondary)
                            
                            HStack(spacing: 0) {
                                WeatherInfoItem(title: "Feels like", value: feelsLike, textPrimary: textPrimary)
                                Spacer()
                                WeatherInfoItem(title: "Humidity", value: humidity, textPrimary: textPrimary)
                                Spacer()
                                WeatherInfoItem(title: "Wind", value: wind, textPrimary: textPrimary)
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(18)
                        .background(surfaceColor)
                        .cornerRadius(14)
                        .shadow(color: .black.opacity(0.12), radius: 5, x: 0, y: 2)
                        
                        // Hourly Forecast
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Hourly Forecast")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(textPrimary)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 6) {
                                    ForEach(hourlyForecast, id: \.hour) { hour in
                                        VStack(spacing: 6) {
                                            Text(hour.hour)
                                                .font(.system(size: 10, weight: .medium))
                                                .foregroundColor(textPrimary)
                                            
                                            Circle()
                                                .fill(hour.color)
                                                .frame(width: 20, height: 20)
                                            
                                            Text(hour.temp)
                                                .font(.system(size: 12, weight: .regular))
                                                .foregroundColor(textPrimary)
                                        }
                                        .frame(width: 70)
                                        .padding(6)
                                        .background(surfaceColor)
                                        .cornerRadius(10)
                                        .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 1)
                                    }
                                }
                            }
                        }
                        
                        // 7-Day Forecast
                        VStack(alignment: .leading, spacing: 10) {
                            Text("7-Day Forecast")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(textPrimary)
                            
                            VStack(spacing: 6) {
                                ForEach(weeklyForecast, id: \.day) { day in
                                    HStack {
                                        Text(day.day)
                                            .font(.system(size: 12, weight: .regular))
                                            .foregroundColor(textPrimary)
                                            .frame(width: 40, alignment: .leading)
                                        
                                        Circle()
                                            .fill(day.color)
                                            .frame(width: 16, height: 16)
                                        
                                        Spacer()
                                        
                                        HStack(spacing: 6) {
                                            Text(day.high)
                                                .font(.system(size: 12, weight: .regular))
                                                .foregroundColor(textPrimary)
                                            
                                            Text(day.low)
                                                .font(.system(size: 12, weight: .regular))
                                                .foregroundColor(textSecondary)
                                        }
                                    }
                                    .padding(14)
                                    .background(surfaceColor)
                                    .cornerRadius(6)
                                    .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 1)
                                }
                            }
                        }
                        
                        // Additional Info Card
                        HStack(spacing: 0) {
                            WeatherInfoItem(title: "UV Index", value: "Moderate", textPrimary: textPrimary)
                            Spacer()
                            WeatherInfoItem(title: "Sunset", value: "7:45 PM", textPrimary: textPrimary)
                            Spacer()
                            WeatherInfoItem(title: "Visibility", value: "10 mi", textPrimary: textPrimary)
                        }
                        .padding(18)
                        .background(surfaceVariant)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 1)
                    }
                    .padding(.horizontal, 14)
                    .padding(.bottom, 80)
                }
            }
            
            // Bottom Bar
            VStack {
                Spacer()
                
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 1)
                    
                    HStack(spacing: 0) {
                        Spacer()
                        
                        LocationButton(
                            title: "NY",
                            isSelected: currentLocation == "New York",
                            textPrimary: textPrimary,
                            primaryBlue: primaryBlue,
                            surfaceVariant: surfaceVariant,
                            action: { currentLocation = "New York" }
                        )
                        
                        Spacer()
                        
                        LocationButton(
                            title: "London",
                            isSelected: currentLocation == "London",
                            textPrimary: textPrimary,
                            primaryBlue: primaryBlue,
                            surfaceVariant: surfaceVariant,
                            action: { currentLocation = "London" }
                        )
                        
                        Spacer()
                        
                        LocationButton(
                            title: "Tokyo",
                            isSelected: currentLocation == "Tokyo",
                            textPrimary: textPrimary,
                            primaryBlue: primaryBlue,
                            surfaceVariant: surfaceVariant,
                            action: { currentLocation = "Tokyo" }
                        )
                        
                        Spacer()
                    }
                    .padding(.vertical, 14)
                    .background(surfaceColor)
                    .cornerRadius(14, corners: [.topLeft, .topRight])
                    .shadow(color: .black.opacity(0.12), radius: 5, x: 0, y: -2)
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .statusBar(hidden: true)
    }
}

struct WeatherInfoItem: View {
    let title: String
    let value: String
    let textPrimary: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(textPrimary.opacity(0.7))
            Text(value)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(textPrimary)
        }
    }
}

struct LocationButton: View {
    let title: String
    let isSelected: Bool
    let textPrimary: Color
    let primaryBlue: Color
    let surfaceVariant: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(isSelected ? .white : textPrimary)
                .frame(width: 80, height: 32)
                .background(isSelected ? primaryBlue : surfaceVariant)
                .cornerRadius(10)
        }
    }
}

struct WeatherHour {
    let hour: String
    let temp: String
    let condition: String
    let color: Color
}

struct WeatherDay {
    let day: String
    let high: String
    let low: String
    let condition: String
    let color: Color
}

// Extension for rounded corners on specific sides
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCornerShape(radius: radius, corners: corners))
    }
}

struct RoundedCornerShape: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}