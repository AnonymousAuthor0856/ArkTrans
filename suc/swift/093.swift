import SwiftUI

@main
struct TeaMasterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        TeaBrewingScreen()
            .preferredColorScheme(.light)
            .statusBarHidden(true)
    }
}

// MARK: - Models
struct TeaPreset: Identifiable {
    let id = UUID()
    let name: String
    let temp: String
    let time: String
    let description: String
}

// MARK: - Main Screen
struct TeaBrewingScreen: View {
    
    // Sample Data
    let teaPresets = [
        TeaPreset(name: "Sencha", temp: "70°C", time: "1-2 min", description: "Japanese green tea, grassy and fresh."),
        TeaPreset(name: "Earl Grey", temp: "98°C", time: "3-4 min", description: "Black tea flavored with bergamot oil."),
        TeaPreset(name: "Oolong", temp: "85°C", time: "3-5 min", description: "Traditional semi-oxidized Chinese tea."),
        TeaPreset(name: "Chamomile", temp: "100°C", time: "5 min", description: "Herbal infusion, calming and caffeine-free."),
        TeaPreset(name: "Matcha", temp: "80°C", time: "Whisk", description: "Finely ground powder of green tea leaves.")
    ]
    
    @State private var selectedTeaIndex = 0
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HeaderSection()
                    .padding(.top, 24)
                    .padding(.horizontal, 24)
                
                Spacer().frame(height: 32)
                
                // Visualization
                BrewingVisualizer(tea: teaPresets[selectedTeaIndex])
                
                Spacer().frame(height: 40)
                
                // Stats Row
                BrewStatsRow(tea: teaPresets[selectedTeaIndex])
                    .padding(.horizontal, 24)
                
                Spacer().frame(height: 40)
                
                // Selection List
                TeaSelector(
                    presets: teaPresets,
                    selectedIndex: $selectedTeaIndex
                )
                .padding(.horizontal, 24)
                
                Spacer()
                
                // Action Button
                StartBrewButton()
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
            }
        }
    }
}

// MARK: - Components

struct HeaderSection: View {
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Tea Master")
                    .font(.system(size: 28, weight: .bold)) // HeadlineMedium approx
                    .foregroundColor(.black)
                Text("Perfect brew, every time")
                    .font(.system(size: 12)) // BodySmall approx
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.black)
            }
        }
    }
}

struct BrewingVisualizer: View {
    let tea: TeaPreset
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(red: 0.96, green: 0.96, blue: 0.96)) // #F5F5F5
                .frame(width: 220, height: 220)
            
            // Inner Circle Content
            VStack(spacing: 8) {
                Image(systemName: "heart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 48, height: 48)
                    .foregroundColor(Color(red: 0.55, green: 0.43, blue: 0.39)) // #8D6E63
                
                Text(tea.name)
                    .font(.system(size: 22, weight: .semibold)) // TitleLarge approx
                    .foregroundColor(.black)
            }
        }
    }
}

struct BrewStatsRow: View {
    let tea: TeaPreset
    
    var body: some View {
        HStack {
            InfoItem(label: "TEMP", value: tea.temp)
            Spacer()
            VerticalDivider()
            Spacer()
            InfoItem(label: "TIME", value: tea.time)
            Spacer()
            VerticalDivider()
            Spacer()
            InfoItem(label: "AMOUNT", value: "250ml")
        }
    }
}

struct VerticalDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color(red: 0.88, green: 0.88, blue: 0.88)) // #E0E0E0
            .frame(width: 1, height: 40)
    }
}

struct InfoItem: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.system(size: 11, weight: .bold)) // LabelSmall + bold
                .foregroundColor(.gray)
                .tracking(1)
            
            Text(value)
                .font(.system(size: 16, weight: .medium)) // TitleMedium
                .foregroundColor(.black)
        }
    }
}

struct TeaSelector: View {
    let presets: [TeaPreset]
    @Binding var selectedIndex: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Select Variety")
                .font(.system(size: 14, weight: .medium)) // TitleSmall approx
                .foregroundColor(.black)
                .padding(.leading, 4)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(0..<presets.count, id: \.self) { index in
                        TeaChip(
                            name: presets[index].name,
                            isSelected: index == selectedIndex,
                            onClick: { selectedIndex = index }
                        )
                    }
                }
                .padding(.horizontal, 4) // Align start with header
            }
        }
    }
}

struct TeaChip: View {
    let name: String
    let isSelected: Bool
    let onClick: () -> Void
    
    var body: some View {
        Button(action: onClick) {
            Text(name)
                .font(.system(size: 14, weight: isSelected ? .bold : .regular))
                .foregroundColor(isSelected ? .white : .black)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .fill(isSelected ? Color.black : Color.white)
                        .overlay(
                            Capsule()
                                .stroke(isSelected ? Color.black : Color(red: 0.88, green: 0.88, blue: 0.88), lineWidth: 1)
                        )
                )
        }
    }
}

struct StartBrewButton: View {
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 8) {
                Image(systemName: "play.fill")
                    .font(.system(size: 20))
                Text("START TIMER")
                    .font(.system(size: 14, weight: .bold))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.black)
            .cornerRadius(16)
        }
    }
}