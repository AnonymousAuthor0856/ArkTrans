//
//  BotanyApp.swift
//  BotanyApp
//
//  Created by YourName on 2023/10/27.
//  Translated from Kotlin Compose UI
//

import SwiftUI

// MARK: - 1. Color Palette (Strictly minimal/white based)
// 定义颜色，方便统一管理和修改。

extension Color {
    // Helper to create Color from hex string
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
    static let botanySurface = Color(hex: 0xFFFAFAFA) // Very slight grey for contrast
    static let botanyTextPrimary = Color(hex: 0xFF1A1C19)
    static let botanyTextSecondary = Color(hex: 0xFF757575)
    static let botanyAccent = Color(hex: 0xFF2E5E4E) // Dark Green
    static let botanyAccentLight = Color(hex: 0xFFE8F5E9)
}

// MARK: - 2. Data Models
// 将 Kotlin 的 data class 转换为 Swift 的 struct，并添加 Identifiable 协议以用于 ForEach。

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
    let iconName: String // 使用 SF Symbols 的名称
    let urgency: String
}

// MARK: - 3. Main App Entry Point
// @main 入口，设置全屏显示和隐藏状态栏。

@main
struct BotanyApp: App {
    var body: some Scene {
        WindowGroup {
            BotanyContentView()
                .statusBarHidden(true) // 隐藏状态栏
        }
    }
}

// MARK: - 4. Main Content View (Equivalent to BotanyApp Composable)
// 对应 Kotlin 的 BotanyApp Composable，实现 Scaffold 的布局结构。

struct BotanyContentView: View {
    // Mock Data (为了方便示例，数据直接定义在此处)
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
        ZStack(alignment: .bottom) { // 使用 ZStack 来分层布局：背景、内容、FAB、底部导航
            Color.botanyWhite.ignoresSafeArea(.all, edges: .all) // 设置全局背景色并忽略安全区

            VStack(spacing: 0) { // 垂直堆栈，用于顶部栏和可滚动内容
                // 固定顶部栏 (BotanyTopBar)
                BotanyTopBar()
                    .padding(.top, 24) // 顶部内边距，即使状态栏隐藏，也保持视觉间距
                    .padding(.horizontal, 24)
                    .padding(.bottom, 8)
                    .background(Color.botanyWhite) // 确保顶部栏有自己的背景色

                // 可滚动内容区域 (BotanyContent)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) { // 垂直堆栈，用于内容布局
                        // 头部区域
                        VStack(alignment: .leading) {
                            Text("Good Morning,")
                                .font(.body) // 对应 MaterialTheme.typography.bodyLarge
                                .foregroundColor(.botanyTextSecondary)
                            Text("My Jungle")
                                .font(.largeTitle) // 对应 MaterialTheme.typography.displayMedium
                                .fontWeight(.bold)
                                .kerning(-1) // 对应 letterSpacing = (-1).sp
                                .foregroundColor(.botanyTextPrimary)
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 16)

                        // 任务区域
                        SectionHeader(title: "Pending Tasks")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) { // 对应 Arrangement.spacedBy(16.dp)
                                ForEach(tasks) { task in
                                    TaskCard(task: task)
                                }
                            }
                            .padding(.horizontal, 24)
                        }
                        .padding(.bottom, 32) // 对应 Spacer(modifier = Modifier.height(32.dp))

                        // 植物收藏区域
                        SectionHeader(title: "Your Collection")

                        ForEach(plants) { plant in
                            PlantListItem(plant: plant)
                        }
                    }
                    .padding(.bottom, 80) // 对应 contentPadding = PaddingValues(bottom = 80.dp)，为底部导航栏留出空间
                    .frame(maxWidth: .infinity) // 确保 VStack 在 ScrollView 中占据全部宽度
                }
            }

            // 浮动操作按钮 (FloatingActionButton)
            VStack {
                Spacer() // 将按钮推到底部
                HStack {
                    Spacer() // 将按钮推到右侧
                    Button(action: {
                        // 无逻辑
                    }) {
                        Image(systemName: "plus") // 对应 Icons.Default.Add
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 56, height: 56) // 对应 size(56.dp)
                            .background(Color.botanyTextPrimary)
                            .clipShape(Circle()) // 对应 CircleShape
                    }
                    .padding(.trailing, 24) // 对应 padding(horizontal = 24.dp)
                    // 底部内边距，确保 FAB 在底部导航栏上方且有适当间距
                    // 底部导航栏高度约 (24 + 24 + 24) = 72dp (垂直padding + icon高度)
                    // FAB 底部间距 = 底部导航栏高度 + 额外间距 (24dp) = 96dp
                    .padding(.bottom, 96)
                }
            }
            .zIndex(1) // 确保 FAB 在内容上方

            // 固定底部导航栏 (BotanyBottomBar)
            BotanyBottomBar()
                .frame(maxWidth: .infinity) // 确保底部导航栏占据全部宽度
                .background(Color.botanyWhite)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: -2) // 添加细微阴影以区分内容
                .zIndex(2) // 确保底部导航栏在最上层
        }
    }
}

// MARK: - 5. SectionHeader
// 对应 Kotlin 的 SectionHeader Composable。

struct SectionHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.title2) // 对应 MaterialTheme.typography.titleMedium
            .fontWeight(.bold)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .foregroundColor(.botanyTextPrimary)
    }
}

// MARK: - 6. TaskCard
// 对应 Kotlin 的 TaskCard Composable。

struct TaskCard: View {
    let task: Task
    @State private var isChecked: Bool = false // 对应 remember { mutableStateOf(false) }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ZStack { // 对应 Box
                    Circle()
                        .fill(isChecked ? Color.botanyAccent : Color.white)
                        .frame(width: 40, height: 40) // 对应 size(40.dp)
                    Image(systemName: task.iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20) // 对应 size(20.dp)
                        .foregroundColor(isChecked ? .white : .botanyTextPrimary)
                }
                Spacer()
            }

            Spacer() // 将下方内容推到底部

            VStack(alignment: .leading, spacing: 0) {
                Text(task.title)
                    .font(.body) // 对应 MaterialTheme.typography.bodyMedium
                    .fontWeight(.bold)
                    .foregroundColor(.botanyTextPrimary)
                Text(task.plantName)
                    .font(.caption) // 对应 MaterialTheme.typography.bodySmall
                    .foregroundColor(.botanyTextSecondary)
                    .lineLimit(1)
                    .truncationMode(.tail) // 对应 maxLines = 1, overflow = TextOverflow.Ellipsis
                Spacer()
                    .frame(height: 8) // 对应 Spacer(modifier = Modifier.height(8.dp))

                // 状态标签 (Status Chip)
                Text(isChecked ? "DONE" : task.urgency)
                    .font(.caption2) // 对应 MaterialTheme.typography.labelSmall
                    .fontWeight(.bold)
                    .foregroundColor(isChecked ? .white : .botanyTextPrimary)
                    .padding(.horizontal, 6) // 对应 padding(horizontal = 6.dp)
                    .padding(.vertical, 2) // 对应 padding(vertical = 2.dp)
                    .background(isChecked ? Color.botanyAccent : Color(hex: 0xFFE0E0E0))
                    .cornerRadius(4) // 对应 RoundedCornerShape(4.dp)
            }
        }
        .padding(16) // 对应 padding(16.dp)
        .frame(width: 160, height: 180) // 对应 width(160.dp), height(180.dp)
        .background(Color.botanySurface)
        .cornerRadius(24) // 对应 RoundedCornerShape(24.dp)
        .overlay( // 对应 BorderStroke
            RoundedRectangle(cornerRadius: 24)
                .stroke(isChecked ? Color.botanyAccent : Color(hex: 0xFFEEEEEE),
                        lineWidth: isChecked ? 2 : 1)
        )
        .onTapGesture { // 对应 clickable { isChecked = !isChecked }
            withAnimation(.easeInOut(duration: 0.2)) { // 对应 animateFloatAsState
                isChecked.toggle()
            }
        }
    }
}

// MARK: - 7. PlantListItem
// 对应 Kotlin 的 PlantListItem Composable。

struct PlantListItem: View {
    let plant: Plant
    @State private var expanded: Bool = false // 对应 remember { mutableStateOf(false) }

    var body: some View {
        HStack(alignment: .center) { // 对应 verticalAlignment = Alignment.CenterVertically
            // "图片" 占位符
            ZStack { // 对应 Box
                RoundedRectangle(cornerRadius: 12) // 对应 RoundedCornerShape(12.dp)
                    .fill(Color(hex: 0xFFEEEEEE))
                    .frame(width: 56, height: 56) // 对应 size(56.dp)
                Image(systemName: "heart.fill") // 对应 Icons.Default.Favorite
                    .foregroundColor(plant.daysUntilWater == 0 ? .botanyAccent : Color(hex: 0xFFCCCCCC))
            }

            Spacer()
                .frame(width: 16) // 对应 Spacer(modifier = Modifier.width(16.dp))

            VStack(alignment: .leading) {
                Text(plant.name)
                    .font(.headline) // 对应 MaterialTheme.typography.titleSmall
                    .fontWeight(.bold)
                    .foregroundColor(.botanyTextPrimary)
                Text(plant.scientificName)
                    .font(.caption) // 对应 MaterialTheme.typography.bodySmall
                    .foregroundColor(.botanyTextSecondary)
                    .italic() // 对应 FontStyle.Italic

                if expanded {
                    Spacer()
                        .frame(height: 8) // 对应 Spacer(modifier = Modifier.height(8.dp))
                    HStack(alignment: .center) {
                        Image(systemName: "location.fill") // 对应 Icons.Default.LocationOn
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12) // 对应 size(12.dp)
                            .foregroundColor(.botanyTextSecondary)
                        Spacer()
                            .frame(width: 4) // 对应 Spacer(modifier = Modifier.width(4.dp))
                        Text(plant.location)
                            .font(.caption2) // 对应 MaterialTheme.typography.labelSmall
                            .foregroundColor(.botanyTextSecondary)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading) // 对应 modifier = Modifier.weight(1f)

            VStack(alignment: .trailing) { // 对应 horizontalAlignment = Alignment.End
                if plant.daysUntilWater == 0 {
                    Image(systemName: "checkmark.circle.fill") // 对应 Icons.Default.Check
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24) // 对应 size(24.dp)
                        .foregroundColor(.botanyAccent)
                    Text("Water")
                        .font(.caption2) // 对应 MaterialTheme.typography.labelSmall
                        .foregroundColor(.botanyAccent)
                        .fontWeight(.bold)
                } else {
                    Text("\(plant.daysUntilWater) days")
                        .font(.caption2) // 对应 MaterialTheme.typography.labelSmall
                        .foregroundColor(.botanyTextSecondary)
                }
            }
        }
        .padding(16) // 对应 padding(16.dp)
        .background(Color.botanySurface)
        .cornerRadius(16) // 对应 RoundedCornerShape(16.dp)
        .padding(.horizontal, 24) // 对应 padding(horizontal = 24.dp)
        .padding(.vertical, 8) // 对应 padding(vertical = 8.dp)
        .onTapGesture { // 对应 clickable { expanded = !expanded }
            withAnimation(.easeInOut(duration: 0.2)) {
                expanded.toggle()
            }
        }
    }
}

// MARK: - 8. BotanyTopBar
// 对应 Kotlin 的 BotanyTopBar Composable。

struct BotanyTopBar: View {
    var body: some View {
        HStack { // 对应 horizontalArrangement = Arrangement.SpaceBetween
            Button(action: { }) {
                Image(systemName: "line.horizontal.3") // 对应 Icons.Default.Menu
                    .foregroundColor(.botanyTextPrimary)
                    .frame(width: 40, height: 40) // 对应 size(40.dp)
                    .background(Color.botanySurface)
                    .clipShape(Circle()) // 对应 CircleShape
            }

            Spacer() // 将按钮推开

            Button(action: { }) {
                Image(systemName: "magnifyingglass") // 对应 Icons.Default.Search
                    .foregroundColor(.botanyTextPrimary)
                    .frame(width: 40, height: 40) // 对应 size(40.dp)
                    .background(Color.botanySurface)
                    .clipShape(Circle()) // 对应 CircleShape
            }
        }
    }
}

// MARK: - 9. BotanyBottomBar
// 对应 Kotlin 的 BotanyBottomBar Composable。

struct BotanyBottomBar: View {
    @State private var selectedTab: Int = 0 // 模拟选中状态

    var body: some View {
        HStack(spacing: 0) { // 对应 horizontalArrangement = Arrangement.SpaceBetween
            BotanyNavItem(iconName: "house.fill", isSelected: selectedTab == 0)
                .onTapGesture { selectedTab = 0 }
            BotanyNavItem(iconName: "calendar", isSelected: selectedTab == 1)
                .onTapGesture { selectedTab = 1 }
            Spacer()
                .frame(width: 32) // 对应 Spacer(modifier = Modifier.width(32.dp))，为 FAB 留出空间
            BotanyNavItem(iconName: "bell.fill", isSelected: selectedTab == 2)
                .onTapGesture { selectedTab = 2 }
            BotanyNavItem(iconName: "gearshape.fill", isSelected: selectedTab == 3)
                .onTapGesture { selectedTab = 3 }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 48) // 对应 padding(horizontal = 48.dp)
        .padding(.vertical, 24) // 对应 padding(vertical = 24.dp)
        .background(Color.botanyWhite)
    }
}

// MARK: - 10. BotanyNavItem
// 对应 Kotlin 的 BotanyNavItem Composable。

struct BotanyNavItem: View {
    let iconName: String
    let isSelected: Bool

    var body: some View {
        Button(action: {}) { // 动作由父视图的 onTapGesture 处理
            Image(systemName: iconName)
                .font(.title2) // 调整图标大小
                .foregroundColor(.botanyTextPrimary)
                .opacity(isSelected ? 1.0 : 0.4) // 对应 animateFloatAsState
        }
        .frame(maxWidth: .infinity) // 确保项目均匀分布
    }
}

// MARK: - Preview
// SwiftUI 预览，方便在 Xcode 中查看 UI 效果。

struct BotanyApp_Previews: PreviewProvider {
    static var previews: some View {
        BotanyContentView()
    }
}