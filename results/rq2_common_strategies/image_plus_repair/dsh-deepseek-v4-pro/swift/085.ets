//
//  BotanyApp.ets
//  BotanyApp
//
//  Created by YourName on 2023/10/27.
//  Translated from SwiftUI (originally Kotlin Compose UI)
//

// MARK: - 1. Color Palette (Strictly minimal/white based)
// 定义颜色，方便统一管理和修改。

const botanyWhite: string = '#FFFFFF';
const botanySurface: string = '#FAFAFA'; // Very slight grey for contrast
const botanyTextPrimary: string = '#1A1C19';
const botanyTextSecondary: string = '#757575';
const botanyAccent: string = '#2E5E4E'; // Dark Green
const botanyAccentLight: string = '#E8F5E9';

// Helper: map SF Symbols name to a display glyph (HarmonyOS has no SF Symbols).
function iconGlyph(name: string): string {
  switch (name) {
    case 'calendar':
      return '📅';
    case 'bell.fill':
      return '🔔';
    case 'gearshape.fill':
      return '⚙️';
    case 'plus':
      return '+';
    case 'house.fill':
      return '🏠';
    case 'heart.fill':
      return '❤️';
    case 'location.fill':
      return '📍';
    case 'checkmark.circle.fill':
      return '✅';
    case 'magnifyingglass':
      return '🔍';
    case 'line.horizontal.3':
      return '☰';
    default:
      return '•';
  }
}

// MARK: - 2. Data Models
// 将 Swift 的 struct 转换为 ArkTS 的 interface，并保留 id 作为 ForEach 的 key。

interface Plant {
  id: number;
  name: string;
  scientificName: string;
  location: string;
  daysUntilWater: number;
  isHealthy: boolean;
}

interface Task {
  id: number;
  title: string;
  plantName: string;
  iconName: string; // 图标名称（原 SF Symbols 名称）
  urgency: string;
}

// MARK: - 3. Main App Entry Point
// @Entry 入口，对应 SwiftUI 的 @main / App。

// MARK: - 3. Main App Entry Point
// @Entry 入口，对应 SwiftUI 的 @main / App。
// （ArkTS 中 @Entry 的 build 只能有一个容器组件作为根节点，故将入口直接放在主内容视图上。）

// MARK: - 4. Main Content View (Equivalent to BotanyApp Composable)
// 对应 SwiftUI 的 BotanyContentView，实现 Scaffold 的布局结构。

@Entry
@Component
struct BotanyContentView {
  // Mock Data (为了方便示例，数据直接定义在此处)
  tasks: Task[] = [
    { id: 1, title: 'Watering', plantName: 'Monstera Deliciosa', iconName: 'calendar', urgency: 'Today' },
    { id: 2, title: 'Fertilize', plantName: 'Fiddle Leaf Fig', iconName: 'bell.fill', urgency: 'Tomorrow' },
    { id: 3, title: 'Pruning', plantName: 'Snake Plant', iconName: 'gearshape.fill', urgency: 'Next Week' }
  ];

  plants: Plant[] = [
    { id: 1, name: 'Monstera', scientificName: 'Monstera deliciosa', location: 'Living Room', daysUntilWater: 0, isHealthy: true },
    { id: 2, name: 'Fiddle Leaf', scientificName: 'Ficus lyrata', location: 'Bedroom', daysUntilWater: 2, isHealthy: true },
    { id: 3, name: 'Snakey', scientificName: 'Sansevieria', location: 'Hallway', daysUntilWater: 5, isHealthy: true },
    { id: 4, name: 'Spider Plant', scientificName: 'Chlorophytum', location: 'Kitchen', daysUntilWater: 1, isHealthy: true },
    { id: 5, name: 'Peace Lily', scientificName: 'Spathiphyllum', location: 'Bathroom', daysUntilWater: 3, isHealthy: true }
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // 固定顶部栏 (BotanyTopBar)
        BotanyTopBar()
          .padding({ top: 24, left: 24, right: 24, bottom: 8 })
          .backgroundColor(botanyWhite)

        // 可滚动内容区域 (BotanyContent)
        Scroll() {
          Column() {
            // 头部区域
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontColor(botanyTextSecondary)
              Text('My Jungle')
                .fontSize(34)
                .fontWeight(FontWeight.Bold)
                .letterSpacing(-1)
                .fontColor(botanyTextPrimary)
            }
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })

            // 任务区域
            SectionHeader({ title: 'Pending Tasks' })
            Scroll() {
              Row({ space: 16 }) {
                ForEach(this.tasks, (task: Task) => {
                  TaskCard({ task: task })
                }, (task: Task) => task.id.toString())
              }
              .padding({ left: 24, right: 24 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .padding({ bottom: 32 })

            // 植物收藏区域
            SectionHeader({ title: 'Your Collection' })

            ForEach(this.plants, (plant: Plant) => {
              PlantListItem({ plant: plant })
            }, (plant: Plant) => plant.id.toString())
          }
          .alignItems(HorizontalAlign.Start)
          .padding({ bottom: 80 })
          .width('100%')
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      // 浮动操作按钮 (FloatingActionButton)
      Row() {
        Blank()
        Button() {
          Text('+')
            .fontSize(22)
            .fontColor(Color.White)
        }
        .width(56)
        .height(56)
        .backgroundColor(botanyTextPrimary)
        .borderRadius(28)
        .margin({ right: 24 })
      }
      .width('100%')
      .margin({ bottom: 96 })
      .zIndex(1)

      // 固定底部导航栏 (BotanyBottomBar)
      BotanyBottomBar()
        .width('100%')
        .backgroundColor(botanyWhite)
        .shadow({ radius: 5, color: '#0D000000', offsetX: 0, offsetY: -2 })
        .zIndex(2)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(botanyWhite)
  }
}

// MARK: - 5. SectionHeader
// 对应 SwiftUI 的 SectionHeader。

@Component
struct SectionHeader {
  title: string = '';

  build() {
    Text(this.title)
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .fontColor(botanyTextPrimary)
  }
}

// MARK: - 6. TaskCard
// 对应 SwiftUI 的 TaskCard。

@Component
struct TaskCard {
  task: Task = { id: 0, title: '', plantName: '', iconName: '', urgency: '' };
  @State isChecked: boolean = false; // 对应 remember { mutableStateOf(false) }

  build() {
    Column() {
      Row() {
        Stack() {
          Text(iconGlyph(this.task.iconName))
            .fontSize(18)
            .fontColor(this.isChecked ? Color.White : botanyTextPrimary)
        }
        .width(40)
        .height(40)
        .borderRadius(20)
        .backgroundColor(this.isChecked ? botanyAccent : Color.White)

        Blank()
      }
      .width('100%')

      Blank()

      Column() {
        Text(this.task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(botanyTextPrimary)
        Text(this.task.plantName)
          .fontSize(12)
          .fontColor(botanyTextSecondary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        // 状态标签 (Status Chip)
        Text(this.isChecked ? 'DONE' : this.task.urgency)
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? Color.White : botanyTextPrimary)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.isChecked ? botanyAccent : '#E0E0E0')
          .borderRadius(4)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .width(160)
    .height(180)
    .padding(16)
    .backgroundColor(botanySurface)
    .borderRadius(24)
    .border({ width: this.isChecked ? 2 : 1, color: this.isChecked ? botanyAccent : '#EEEEEE' })
    .onClick(() => {
      animateTo({ duration: 200, curve: Curve.EaseInOut }, () => {
        this.isChecked = !this.isChecked;
      });
    })
  }
}

// MARK: - 7. PlantListItem
// 对应 SwiftUI 的 PlantListItem。

@Component
struct PlantListItem {
  plant: Plant = { id: 0, name: '', scientificName: '', location: '', daysUntilWater: 0, isHealthy: true };
  @State expanded: boolean = false; // 对应 remember { mutableStateOf(false) }

  build() {
    Row() {
      // "图片" 占位符
      Stack() {
        Text('❤️')
          .fontSize(20)
          .fontColor(this.plant.daysUntilWater === 0 ? botanyAccent : '#CCCCCC')
      }
      .width(56)
      .height(56)
      .borderRadius(12)
      .backgroundColor('#EEEEEE')

      Column() {
        Text(this.plant.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(botanyTextPrimary)
        Text(this.plant.scientificName)
          .fontSize(12)
          .fontColor(botanyTextSecondary)
          .fontStyle(FontStyle.Italic)

        if (this.expanded) {
          Row() {
            Text('📍')
              .fontSize(12)
              .fontColor(botanyTextSecondary)
            Text(this.plant.location)
              .fontSize(11)
              .fontColor(botanyTextSecondary)
              .margin({ left: 4 })
          }
          .margin({ top: 8 })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })

      Column() {
        if (this.plant.daysUntilWater === 0) {
          Text('✅')
            .fontSize(24)
            .fontColor(botanyAccent)
          Text('Water')
            .fontSize(11)
            .fontColor(botanyAccent)
            .fontWeight(FontWeight.Bold)
        } else {
          Text(this.plant.daysUntilWater.toString() + ' days')
            .fontSize(11)
            .fontColor(botanyTextSecondary)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .backgroundColor(botanySurface)
    .borderRadius(16)
    .margin({ left: 24, right: 24, top: 8, bottom: 8 })
    .onClick(() => {
      animateTo({ duration: 200, curve: Curve.EaseInOut }, () => {
        this.expanded = !this.expanded;
      });
    })
  }
}

// MARK: - 8. BotanyTopBar
// 对应 SwiftUI 的 BotanyTopBar。

@Component
struct BotanyTopBar {
  build() {
    Row() {
      Button() {
        Text('☰')
          .fontSize(20)
          .fontColor(botanyTextPrimary)
      }
      .width(40)
      .height(40)
      .backgroundColor(botanySurface)
      .borderRadius(20)

      Blank()

      Button() {
        Text('🔍')
          .fontSize(20)
          .fontColor(botanyTextPrimary)
      }
      .width(40)
      .height(40)
      .backgroundColor(botanySurface)
      .borderRadius(20)
    }
  }
}

// MARK: - 9. BotanyBottomBar
// 对应 SwiftUI 的 BotanyBottomBar。

@Component
struct BotanyBottomBar {
  @State selectedTab: number = 0; // 模拟选中状态

  build() {
    Row() {
      BotanyNavItem({ iconName: 'house.fill', isSelected: this.selectedTab === 0 })
        .onClick(() => {
          this.selectedTab = 0;
        })
      BotanyNavItem({ iconName: 'calendar', isSelected: this.selectedTab === 1 })
        .onClick(() => {
          this.selectedTab = 1;
        })
      Blank()
        .width(32) // 为 FAB 留出空间
      BotanyNavItem({ iconName: 'bell.fill', isSelected: this.selectedTab === 2 })
        .onClick(() => {
          this.selectedTab = 2;
        })
      BotanyNavItem({ iconName: 'gearshape.fill', isSelected: this.selectedTab === 3 })
        .onClick(() => {
          this.selectedTab = 3;
        })
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .backgroundColor(botanyWhite)
  }
}

// MARK: - 10. BotanyNavItem
// 对应 SwiftUI 的 BotanyNavItem。

@Component
struct BotanyNavItem {
  iconName: string = '';
  isSelected: boolean = false;

  build() {
    // SwiftUI 中该视图为 Button（空动作），选中状态由父视图的 onTapGesture 处理，
    // 此处直接渲染图标，点击由父视图的 onClick 处理。
    Text(iconGlyph(this.iconName))
      .fontSize(20)
      .fontColor(botanyTextPrimary)
      .opacity(this.isSelected ? 1.0 : 0.4)
      .layoutWeight(1)
  }
}

// MARK: - Preview
// SwiftUI 预览（PreviewProvider）在 ArkTS 中无对应机制，此处以注释保留说明。
// struct BotanyApp_Previews: PreviewProvider {
//     static var previews: some View {
//         BotanyContentView()
//     }
// }
