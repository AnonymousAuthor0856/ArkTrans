
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

    static let botanyWhite = Color(hex: 0xFFFFFFFF)
    static let botanySurface = Color(hex: 0xFFFAFAFA) 
    static let botanyTextPrimary = Color(hex: 0xFF1A1C19)
    static let botanyTextSecondary = Color(hex: 0xFF757575)
    static let botanyAccent = Color(hex: 0xFF2E5E4E) 
    static let botanyAccentLight = Color(hex: 0xFFE8F5E9)
}


struct Plant: Identifiable {
    let id: Int
    let name: String
    let scientificName: String
    let location: String
    let daysUntilWater: Int
    let isHealthy: Bool = true
}

struct Task: Identifiable {
    let id: Int
    let title: String
    let plantName: String
    let iconName: String 
    let urgency: String
}


@main
struct BotanyApp: App {
    var body: some Scene {
        WindowGroup {
            BotanyContentView()
                .statusBarHidden(true) 
        }
    }
}


struct BotanyContentView: View {
        let tasks = [
        Task(id: 1, title: "Watering", plantName: "Monstera Deliciosa", iconName: "calendar", urgency: "Today"),
        Task(id: 2, title: "Fertilize", plantName: "Fiddle Leaf Fig", iconName: "bell.fill", urgency: "Tomorrow"),
        Task(id: 3, title: "Pruning", plantName: "Snake Plant", iconName: "gearshape.fill", urgency: "Next Week")
    ]

    let plants = [
        Plant(id: 1, name: "Monstera", scientificName: "Monstera deliciosa", location: "Living Room", daysUntilWater: 0),
        Plant(id: 2, name: "Fiddle Leaf", scientificName: "Ficus lyrata", location: "Bedroom", daysUntilWater: 2),
        Plant(id: 3, name: "Snakey", scientificName: "Sansevieria", location: "Hallway", daysUntilWater: 5),
        Plant(id: 4, name: "Spider Plant", scientificName: "Chlorophytum", location: "Kitchen", daysUntilWater: 1),
        Plant(id: 5, name: "Peace Lily", scientificName: "Spathiphyllum", location: "Bathroom", daysUntilWater: 3)
    ]

    var body: some View {
        ZStack(alignment: .bottom) { 
            Color.botanyWhite.ignoresSafeArea(.all, edges: .all) 

            VStack(spacing: 0) { 
                                BotanyTopBar()
                    .padding(.top, 24) 
                    .padding(.horizontal, 24)
                    .padding(.bottom, 8)
                    .background(Color.botanyWhite) 

                                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) { 
                                                VStack(alignment: .leading) {
                            Text("Good Morning,")
                                .font(.body) 
                                .foregroundColor(.botanyTextSecondary)
                            Text("My Jungle")
                                .font(.largeTitle) 
                                .fontWeight(.bold)
                                .kerning(-1) 
                                .foregroundColor(.botanyTextPrimary)
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 16)

                                                SectionHeader(title: "Pending Tasks")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) { 
                                ForEach(tasks) { task in
                                    TaskCard(task: task)
                                }
                            }
                            .padding(.horizontal, 24)
                        }
                        .padding(.bottom, 32) 

                                                SectionHeader(title: "Your Collection")

                        ForEach(plants) { plant in
                            PlantListItem(plant: plant)
                        }
                    }
                    .padding(.bottom, 80) 
                    .frame(maxWidth: .infinity) 
                }
            }

                        VStack {
                Spacer() 
                HStack {
                    Spacer() 
                    Button(action: {
                                            }) {
                        Image(systemName: "plus") 
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 56, height: 56) 
                            .background(Color.botanyTextPrimary)
                            .clipShape(Circle()) 
                    }
                    .padding(.trailing, 24) 
                                                                                .padding(.bottom, 96)
                }
            }
            .zIndex(1) 

                        BotanyBottomBar()
                .frame(maxWidth: .infinity) 
                .background(Color.botanyWhite)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: -2) 
                .zIndex(2) 
        }
    }
}


struct SectionHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.title2) 
            .fontWeight(.bold)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .foregroundColor(.botanyTextPrimary)
    }
}


struct TaskCard: View {
    let task: Task
    @State private var isChecked: Bool = false 

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ZStack { 
                    Circle()
                        .fill(isChecked ? Color.botanyAccent : Color.white)
                        .frame(width: 40, height: 40) 
                    Image(systemName: task.iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20) 
                        .foregroundColor(isChecked ? .white : .botanyTextPrimary)
                }
                Spacer()
            }

            Spacer() 

            VStack(alignment: .leading, spacing: 0) {
                Text(task.title)
                    .font(.body) 
                    .fontWeight(.bold)
                    .foregroundColor(.botanyTextPrimary)
                Text(task.plantName)
                    .font(.caption) 
                    .foregroundColor(.botanyTextSecondary)
                    .lineLimit(1)
                    .truncationMode(.tail) 
                Spacer()
                    .frame(height: 8) 

                                Text(isChecked ? "DONE" : task.urgency)
                    .font(.caption2) 
                    .fontWeight(.bold)
                    .foregroundColor(isChecked ? .white : .botanyTextPrimary)
                    .padding(.horizontal, 6) 
                    .padding(.vertical, 2) 
                    .background(isChecked ? Color.botanyAccent : Color(hex: 0xFFE0E0E0))
                    .cornerRadius(4) 
            }
        }
        .padding(16) 
        .frame(width: 160, height: 180) 
        .background(Color.botanySurface)
        .cornerRadius(24) 
        .overlay( 
            RoundedRectangle(cornerRadius: 24)
                .stroke(isChecked ? Color.botanyAccent : Color(hex: 0xFFEEEEEE),
                        lineWidth: isChecked ? 2 : 1)
        )
        .onTapGesture { 
            withAnimation(.easeInOut(duration: 0.2)) { 
                isChecked.toggle()
            }
        }
    }
}


struct PlantListItem: View {
    let plant: Plant
    @State private var expanded: Bool = false 

    var body: some View {
        HStack(alignment: .center) { 
                        ZStack { 
                RoundedRectangle(cornerRadius: 12) 
                    .fill(Color(hex: 0xFFEEEEEE))
                    .frame(width: 56, height: 56) 
                Image(systemName: "heart.fill") 
                    .foregroundColor(plant.daysUntilWater == 0 ? .botanyAccent : Color(hex: 0xFFCCCCCC))
            }

            Spacer()
                .frame(width: 16) 

            VStack(alignment: .leading) {
                Text(plant.name)
                    .font(.headline) 
                    .fontWeight(.bold)
                    .foregroundColor(.botanyTextPrimary)
                Text(plant.scientificName)
                    .font(.caption) 
                    .foregroundColor(.botanyTextSecondary)
                    .italic() 

                if expanded {
                    Spacer()
                        .frame(height: 8) 
                    HStack(alignment: .center) {
                        Image(systemName: "location.fill") 
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12) 
                            .foregroundColor(.botanyTextSecondary)
                        Spacer()
                            .frame(width: 4) 
                        Text(plant.location)
                            .font(.caption2) 
                            .foregroundColor(.botanyTextSecondary)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading) 

            VStack(alignment: .trailing) { 
                if plant.daysUntilWater == 0 {
                    Image(systemName: "checkmark.circle.fill") 
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24) 
                        .foregroundColor(.botanyAccent)
                    Text("Water")
                        .font(.caption2) 
                        .foregroundColor(.botanyAccent)
                        .fontWeight(.bold)
                } else {
                    Text("\(plant.daysUntilWater) days")
                        .font(.caption2) 
                        .foregroundColor(.botanyTextSecondary)
                }
            }
        }
        .padding(16) 
        .background(Color.botanySurface)
        .cornerRadius(16) 
        .padding(.horizontal, 24) 
        .padding(.vertical, 8) 
        .onTapGesture { 
            withAnimation(.easeInOut(duration: 0.2)) {
                expanded.toggle()
            }
        }
    }
}


struct BotanyTopBar: View {
    var body: some View {
        HStack { 
            Button(action: { }) {
                Image(systemName: "line.horizontal.3") 
                    .foregroundColor(.botanyTextPrimary)
                    .frame(width: 40, height: 40) 
                    .background(Color.botanySurface)
                    .clipShape(Circle()) 
            }

            Spacer() 

            Button(action: { }) {
                Image(systemName: "magnifyingglass") 
                    .foregroundColor(.botanyTextPrimary)
                    .frame(width: 40, height: 40) 
                    .background(Color.botanySurface)
                    .clipShape(Circle()) 
            }
        }
    }
}


struct BotanyBottomBar: View {
    @State private var selectedTab: Int = 0 

    var body: some View {
        HStack(spacing: 0) { 
            BotanyNavItem(iconName: "house.fill", isSelected: selectedTab == 0)
                .onTapGesture { selectedTab = 0 }
            BotanyNavItem(iconName: "calendar", isSelected: selectedTab == 1)
                .onTapGesture { selectedTab = 1 }
            Spacer()
                .frame(width: 32) 
            BotanyNavItem(iconName: "bell.fill", isSelected: selectedTab == 2)
                .onTapGesture { selectedTab = 2 }
            BotanyNavItem(iconName: "gearshape.fill", isSelected: selectedTab == 3)
                .onTapGesture { selectedTab = 3 }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 48) 
        .padding(.vertical, 24) 
        .background(Color.botanyWhite)
    }
}


struct BotanyNavItem: View {
    let iconName: String
    let isSelected: Bool

    var body: some View {
        Button(action: {}) { 
            Image(systemName: iconName)
                .font(.title2) 
                .foregroundColor(.botanyTextPrimary)
                .opacity(isSelected ? 1.0 : 0.4) 
        }
        .frame(maxWidth: .infinity) 
    }
}


struct BotanyApp_Previews: PreviewProvider {
    static var previews: some View {
        BotanyContentView()
    }
}