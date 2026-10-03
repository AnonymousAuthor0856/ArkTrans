// BotanyApp.ets
// Translated from SwiftUI to ArkTS

// Color Palette
const botanyWhite: string = '#FFFFFFFF';
const botanySurface: string = '#FFFAFAFA';
const botanyTextPrimary: string = '#FF1A1C19';
const botanyTextSecondary: string = '#FF757575';
const botanyAccent: string = '#FF2E5E4E';
const botanyAccentLight: string = '#FFE8F5E9';
const botanyBorder: string = '#FFEEEEEE';
const botanyChipBg: string = '#FFE0E0E0';
const botanyIconGray: string = '#FFCCCCCC';

// Data Models
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
  iconName: string;
  urgency: string;
}

// Mock Data
const tasks: Task[] = [
  { id: 1, title: 'Watering', plantName: 'Monstera Deliciosa', iconName: '💧', urgency: 'Today' },
  { id: 2, title: 'Fertilize', plantName: 'Fiddle Leaf Fig', iconName: '🔔', urgency: 'Tomorrow' },
  { id: 3, title: 'Pruning', plantName: 'Snake Plant', iconName: '⚙️', urgency: 'Next Week' }
];

const plants: Plant[] = [
  { id: 1, name: 'Monstera', scientificName: 'Monstera deliciosa', location: 'Living Room', daysUntilWater: 0, isHealthy: true },
  { id: 2, name: 'Fiddle Leaf', scientificName: 'Ficus lyrata', location: 'Bedroom', daysUntilWater: 2, isHealthy: true },
  { id: 3, name: 'Snakey', scientificName: 'Sansevieria', location: 'Hallway', daysUntilWater: 5, isHealthy: true },
  { id: 4, name: 'Spider Plant', scientificName: 'Chlorophytum', location: 'Kitchen', daysUntilWater: 1, isHealthy: true },
  { id: 5, name: 'Peace Lily', scientificName: 'Spathiphyllum', location: 'Bathroom', daysUntilWater: 3, isHealthy: true }
];

// Section Header Component
@Component
struct SectionHeader {
  title: string;

  build() {
    Text(this.title)
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .fontColor(botanyTextPrimary)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .width('100%')
  }
}

// Task Card Component
@Component
struct TaskCard {
  task: Task;
  @State isChecked: boolean = false;

  build() {
    Column({ space: 0 }) {
      Row() {
        Stack() {
          Circle()
            .fill(this.isChecked ? botanyAccent : botanyWhite)
            .width(40)
            .height(40)
          Text(this.task.iconName)
            .fontSize(20)
            .fontColor(this.isChecked ? '#FFFFFF' : botanyTextPrimary)
        }
        .width(40)
        .height(40)

        Blank()
      }
      .width('100%')

      Blank()
        .layoutWeight(1)

      Column({ space: 0 }) {
        Text(this.task.title)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(botanyTextPrimary)
        Text(this.task.plantName)
          .fontSize(12)
          .fontColor(botanyTextSecondary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Blank()
          .height(8)

        Text(this.isChecked ? 'DONE' : this.task.urgency)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? '#FFFFFF' : botanyTextPrimary)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.isChecked ? botanyAccent : botanyChipBg)
          .borderRadius(4)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .padding(16)
    .width(160)
    .height(180)
    .backgroundColor(botanySurface)
    .borderRadius(24)
    .border({
      width: this.isChecked ? 2 : 1,
      color: this.isChecked ? botanyAccent : botanyBorder
    })
    .onClick(() => {
      this.isChecked = !this.isChecked;
    })
    .animation({ duration: 200, curve: Curve.EaseInOut })
  }
}

// Plant List Item Component
@Component
struct PlantListItem {
  plant: Plant;
  @State expanded: boolean = false;

  build() {
    Row({ space: 16 }) {
      // Image placeholder
      Stack() {
        Rect()
          .fill(botanyBorder)
          .width(56)
          .height(56)
          .borderRadius(12)
        Text('❤️')
          .fontSize(20)
          .fontColor(this.plant.daysUntilWater === 0 ? botanyAccent : botanyIconGray)
      }
      .width(56)
      .height(56)

      Column({ space: 0 }) {
        Text(this.plant.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(botanyTextPrimary)
        Text(this.plant.scientificName)
          .fontSize(12)
          .fontColor(botanyTextSecondary)
          .fontStyle(FontStyle.Italic)

        if (this.expanded) {
          Blank()
            .height(8)
          Row({ space: 4 }) {
            Text('📍')
              .fontSize(12)
              .fontColor(botanyTextSecondary)
            Text(this.plant.location)
              .fontSize(10)
              .fontColor(botanyTextSecondary)
          }
          .alignItems(VerticalAlign.Center)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column({ space: 0 }) {
        if (this.plant.daysUntilWater === 0) {
          Text('✅')
            .fontSize(24)
            .fontColor(botanyAccent)
          Text('Water')
            .fontSize(10)
            .fontColor(botanyAccent)
            .fontWeight(FontWeight.Bold)
        } else {
          Text(`${this.plant.daysUntilWater} days`)
            .fontSize(10)
            .fontColor(botanyTextSecondary)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .padding(16)
    .backgroundColor(botanySurface)
    .borderRadius(16)
    .padding({ left: 24, right: 24, top: 8, bottom: 8 })
    .onClick(() => {
      this.expanded = !this.expanded;
    })
    .animation({ duration: 200, curve: Curve.EaseInOut })
  }
}

// Top Bar Component
@Component
struct BotanyTopBar {
  build() {
    Row() {
      Button() {
        Text('☰')
          .fontSize(20)
          .fontColor(botanyTextPrimary)
          .width(40)
          .height(40)
          .textAlign(TextAlign.Center)
          .backgroundColor(botanySurface)
          .borderRadius(20)
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
          .width(40)
          .height(40)
          .textAlign(TextAlign.Center)
          .backgroundColor(botanySurface)
          .borderRadius(20)
      }
      .width(40)
      .height(40)
      .backgroundColor(botanySurface)
      .borderRadius(20)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

// Bottom Nav Item Component
@Component
struct BotanyNavItem {
  iconName: string;
  isSelected: boolean;

  build() {
    Button() {
      Text(this.iconName)
        .fontSize(22)
        .fontColor(botanyTextPrimary)
        .opacity(this.isSelected ? 1.0 : 0.4)
    }
    .layoutWeight(1)
    .backgroundColor(Color.Transparent)
  }
}

// Bottom Bar Component
@Component
struct BotanyBottomBar {
  @State selectedTab: number = 0;

  build() {
    Row({ space: 0 }) {
      BotanyNavItem({ iconName: '🏠', isSelected: this.selectedTab === 0 })
        .onClick(() => { this.selectedTab = 0; })
      BotanyNavItem({ iconName: '📅', isSelected: this.selectedTab === 1 })
        .onClick(() => { this.selectedTab = 1; })
      Blank()
        .width(32)
      BotanyNavItem({ iconName: '🔔', isSelected: this.selectedTab === 2 })
        .onClick(() => { this.selectedTab = 2; })
      BotanyNavItem({ iconName: '⚙️', isSelected: this.selectedTab === 3 })
        .onClick(() => { this.selectedTab = 3; })
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .backgroundColor(botanyWhite)
    .shadow({ radius: 5, color: '#0D000000', offsetX: 0, offsetY: -2 })
  }
}

// Main Content View
@Component
struct BotanyContentView {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column() {
        // Top Bar
        BotanyTopBar()
          .padding({ top: 24, left: 24, right: 24, bottom: 8 })
          .backgroundColor(botanyWhite)

        // Scrollable Content
        Scroll() {
          Column({ space: 0 }) {
            // Header
            Column({ space: 0 }) {
              Text('Good Morning,')
                .fontSize(14)
                .fontColor(botanyTextSecondary)
              Text('My Jungle')
                .fontSize(34)
                .fontWeight(FontWeight.Bold)
                .fontColor(botanyTextPrimary)
                .letterSpacing(-1)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })

            // Pending Tasks Section
            SectionHeader({ title: 'Pending Tasks' })

            Scroll() {
              Row({ space: 16 }) {
                ForEach(tasks, (task: Task) => {
                  TaskCard({ task: task })
                })
              }
              .padding({ left: 24, right: 24 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)

            Blank()
              .height(32)

            // Your Collection Section
            SectionHeader({ title: 'Your Collection' })

            ForEach(plants, (plant: Plant) => {
              PlantListItem({ plant: plant })
            })
          }
          .width('100%')
          .padding({ bottom: 80 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .align(Alignment.Top)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(botanyWhite)

      // Floating Action Button
      Column() {
        Blank()
          .layoutWeight(1)
        Row() {
          Blank()
            .layoutWeight(1)
          Button() {
            Text('+')
              .fontSize(24)
              .fontColor('#FFFFFF')
              .width(56)
              .height(56)
              .textAlign(TextAlign.Center)
              .backgroundColor(botanyTextPrimary)
              .borderRadius(28)
          }
          .width(56)
          .height(56)
          .backgroundColor(botanyTextPrimary)
          .borderRadius(28)
          .margin({ right: 24, bottom: 96 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .zIndex(1)

      // Bottom Bar
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

// Entry Point
@Entry
@Component
struct BotanyApp {
  build() {
    BotanyContentView()
  }
}