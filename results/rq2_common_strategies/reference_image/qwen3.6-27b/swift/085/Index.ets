// entry/src/main/ets/viewpages/BotanyApp.ets

/**
 * Botany App - ArkTS Implementation
 * Converted from SwiftUI source.
 */

// MARK: - 1. Color Palette & Constants
const Colors = {
  botanyWhite: '#FFFFFF',
  botanySurface: '#FAFAFA', // Very slight grey for contrast
  botanyTextPrimary: '#1A1C19',
  botanyTextSecondary: '#757575',
  botanyAccent: '#2E5E4E', // Dark Green
  botanyAccentLight: '#E8F5E9',
  botanyBorder: '#EEEEEE',
  botanyChipBg: '#E0E0E0'
}

// MARK: - 2. Data Models
interface Plant {
  id: number;
  name: string;
  scientificName: string;
  location: string;
  daysUntilWater: number;
}

interface Task {
  id: number;
  title: string;
  plantName: string;
  iconName: string; // Using standard media names or local assets
  urgency: string;
}

// Mock Data
const MOCK_TASKS: Task[] = [
  { id: 1, title: "Watering", plantName: "Monstera Deliciosa", iconName: "calendar", urgency: "Today" },
  { id: 2, title: "Fertilize", plantName: "Fiddle Leaf Fig", iconName: "bell", urgency: "Tomorrow" },
  { id: 3, title: "Pruning", plantName: "Snake Plant", iconName: "settings", urgency: "Next Week" }
];

const MOCK_PLANTS: Plant[] = [
  { id: 1, name: "Monstera", scientificName: "Monstera deliciosa", location: "Living Room", daysUntilWater: 0 },
  { id: 2, name: "Fiddle Leaf", scientificName: "Ficus lyrata", location: "Bedroom", daysUntilWater: 2 },
  { id: 3, name: "Snakey", scientificName: "Sansevieria", location: "Hallway", daysUntilWater: 5 },
  { id: 4, name: "Spider Plant", scientificName: "Chlorophytum", location: "Kitchen", daysUntilWater: 1 },
  { id: 5, name: "Peace Lily", scientificName: "Spathiphyllum", location: "Bathroom", daysUntilWater: 3 }
];

@Entry
@Component
struct BotanyContentView {
  @State selectedTab: number = 0;

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(Colors.botanyWhite)

      // Main Scrollable Content
      Column() {
        // Top Bar
        BotanyTopBar()
          .padding({ top: 24, left: 24, right: 24, bottom: 8 })

        ScrollView({ scrollable: ScrollDirection.Vertical, barState: BarState.Off }) {
          Column({ space: 0 }) {
            // Header Text
            Column({ space: 0 }) {
              Text("Good Morning,")
                .font-size(16)
                .fontColor(Colors.botanyTextSecondary)
              
              Text("My Jungle")
                .font-size(40)
                .fontWeight(FontWeight.Bold)
                .letterSpacing(-1)
                .fontColor(Colors.botanyTextPrimary)
            }
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })

            // Pending Tasks Section
            SectionHeader(title: "Pending Tasks")
            
            Row() {
              ForEach(MOCK_TASKS, (task: Task) => {
                TaskCard(task: task)
              }, (item: Task) => item.id.toString())
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
            .alignItems(VerticalAlign.Top)
            .columnGap(16)
            .padding({ left: 24, right: 24, bottom: 32 })
            .layoutWeight(1)

            // Collection Section
            SectionHeader(title: "Your Collection")

            ForEach(MOCK_PLANTS, (plant: Plant) => {
              PlantListItem(plant: plant)
            }, (item: Plant) => item.id.toString())

            // Bottom padding to clear nav bar
            Blank().height(80)
          }
        }
      }
      .width('100%')
      .height('100%')

      // Floating Action Button (FAB)
      Column() {
        Row() {
          Blank()
          Button() {
            Image($r('app.media.ic_add')) // Assuming a plus icon exists, otherwise use text '+'
              .width(24)
              .height(24)
              .fillColor(Color.White)
          }
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor(Colors.botanyTextPrimary)
          .margin({ right: 24, bottom: 96 })
        }
        .width('100%')
        .justifyContent(FlexAlign.End)
      }
      .width('100%')
      .zIndex(1)

      // Bottom Navigation Bar
      BotanyBottomBar(selectedTab: this.selectedTab, onTabChange: (index: number) => {
        this.selectedTab = index;
      })
      .zIndex(2)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.botanyWhite)
  }
}

// MARK: - Components

@Component
struct BotanyTopBar {
  build() {
    Row() {
      // Menu Icon
      Button() {
        Image($r('app.media.ic_menu')) // Placeholder for menu icon
          .width(24)
          .height(24)
          .fillColor(Colors.botanyTextPrimary)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(Colors.botanySurface)

      Blank()

      // Search Icon
      Button() {
        Image($r('app.media.ic_search')) // Placeholder for search icon
          .width(24)
          .height(24)
          .fillColor(Colors.botanyTextPrimary)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(Colors.botanySurface)
    }
    .width('100%')
  }
}

@Component
struct SectionHeader {
  controller: string = "";
  title: string = "";

  build() {
    Text(this.title)
      .font-size(20)
      .fontWeight(FontWeight.Bold)
      .fontColor(Colors.botanyTextPrimary)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }
}

@Component
struct TaskCard {
  @State isChecked: boolean = false;
  task: Task = { id: 0, title: "", plantName: "", iconName: "", urgency: "" };

  build() {
    Column({ space: 0 }) {
      Row() {
        // Icon Circle
        Row() {
          if (this.task.iconName === 'calendar') {
             Image($r('app.media.ic_calendar'))
          } else if (this.task.iconName === 'bell') {
             Image($r('app.media.ic_bell'))
          } else {
             Image($r('app.media.ic_settings'))
          }
          .width(20)
          .height(20)
          .fillColor(this.isChecked ? Color.White : Colors.botanyTextPrimary)
        }
        .width(40)
        .height(40)
        .borderRadius(20)
        .backgroundColor(this.isChecked ? Colors.botanyAccent : Color.White)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        Blank()
      }

      Blank()

      Column({ space: 0 }) {
        Text(this.task.title)
          .font-size(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.botanyTextPrimary)
        
        Text(this.task.plantName)
          .font-size(12)
          .fontColor(Colors.botanyTextSecondary)
          .maxLines(1)
          .textOverflow({ overflowType: OverflowType.Ellipsis })
        
        Blank().height(8)

        // Status Chip
        Text(this.isChecked ? "DONE" : this.task.urgency)
          .font-size(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? Color.White : Colors.botanyTextPrimary)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.isChecked ? Colors.botanyAccent : Colors.botanyChipBg)
          .borderRadius(4)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width(160)
    .height(180)
    .padding(16)
    .backgroundColor(Colors.botanySurface)
    .borderRadius(24)
    .border({ width: this.isChecked ? 2 : 1, color: this.isChecked ? Colors.botanyAccent : Colors.botanyBorder, radius: 24 })
    .onClick(() => {
      this.isChecked = !this.isChecked;
    })
  }
}

@Component
struct PlantListItem {
  @State expanded: boolean = false;
  plant: Plant = { id: 0, name: "", scientificName: "", location: "", daysUntilWater: 0 };

  build() {
    Row() {
      // Image Placeholder / Heart Icon
      Row() {
        Image($r('app.media.ic_heart')) // Placeholder for heart icon
          .width(24)
          .height(24)
          .fillColor(this.plant.daysUntilWater == 0 ? Colors.botanyAccent : '#CCCCCC')
      }
      .width(56)
      .height(56)
      .borderRadius(12)
      .backgroundColor('#EEEEEE')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Blank().width(16)

      // Text Info
      Column({ space: 0 }) {
        Text(this.plant.name)
          .font-size(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.botanyTextPrimary)
        
        Text(this.plant.scientificName)
          .font-size(12)
          .fontColor(Colors.botanyTextSecondary)
          .fontStyle(FontStyle.Italic)

        if (this.expanded) {
          Blank().height(8)
          Row() {
            Image($r('app.media.ic_location')) // Placeholder for location pin
              .width(12)
              .height(12)
              .fillColor(Colors.botanyTextSecondary)
            
            Blank().width(4)
            
            Text(this.plant.location)
              .font-size(10)
              .fontColor(Colors.botanyTextSecondary)
          }
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Right Side Status
      Column({ space: 0 }) {
        if (this.plant.daysUntilWater == 0) {
          Image($r('app.media.ic_check')) // Placeholder for checkmark
            .width(24)
            .height(24)
            .fillColor(Colors.botanyAccent)
          
          Text("Water")
            .font-size(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.botanyAccent)
        } else {
          Text(`${this.plant.daysUntilWater} days`)
            .font-size(10)
            .fontColor(Colors.botanyTextSecondary)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Colors.botanySurface)
    .borderRadius(16)
    .margin({ left: 24, right: 24, top: 8, bottom: 8 })
    .onClick(() => {
      this.expanded = !this.expanded;
    })
  }
}

@Component
struct BotanyBottomBar {
  selectedTab: number = 0;
  onTabChange: (index: number) => void = () => {};

  build() {
    Row() {
      BotanyNavItem(iconName: $r('app.media.ic_home'), isSelected: this.selectedTab == 0)
        .onClick(() => this.onTabChange(0))
      
      BotanyNavItem(iconName: $r('app.media.ic_calendar'), isSelected: this.selectedTab == 1)
        .onClick(() => this.onTabChange(1))
      
      Blank().width(32) // Space for FAB
      
      BotanyNavItem(iconName: $r('app.media.ic_bell'), isSelected: this.selectedTab == 2)
        .onClick(() => this.onTabChange(2))
      
      BotanyNavItem(iconName: $r('app.media.ic_settings'), isSelected: this.selectedTab == 3)
        .onClick(() => this.onTabChange(3))
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .backgroundColor(Colors.botanyWhite)
    .shadow({ radius: 10, color: '#0000000D', offsetY: -2 })
  }
}

@Component
struct BotanyNavItem {
  iconName: Resource = $r('app.media.ic_home');
  isSelected: boolean = false;

  build() {
    Button() {
      Image(this.iconName)
        .width(24)
        .height(24)
        .fillColor(Colors.botanyTextPrimary)
        .opacity(this.isSelected ? 1.0 : 0.4)
    }
    .width(40)
    .height(40)
  }
}