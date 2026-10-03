import { create, AnimatorResult } from '@ohos.arkui.UIContext';

// Data Models
class Plant {
  id: number;
  name: string;
  scientificName: string;
  location: string;
  daysUntilWater: number;
  isHealthy: boolean;

  constructor(id: number, name: string, scientificName: string, location: string, daysUntilWater: number, isHealthy: boolean = true) {
    this.id = id;
    this.name = name;
    this.scientificName = scientificName;
    this.location = location;
    this.daysUntilWater = daysUntilWater;
    this.isHealthy = isHealthy;
  }
}

class Task {
  id: number;
  title: string;
  plantName: string;
  icon: string;
  urgency: string;

  constructor(id: number, title: string, plantName: string, icon: string, urgency: string) {
    this.id = id;
    this.title = title;
    this.plantName = plantName;
    this.icon = icon;
    this.urgency = urgency;
  }
}

// Color Palette
const BotanyWhite: string = '#FFFFFFFF';
const BotanySurface: string = '#FFFAFAFA';
const BotanyTextPrimary: string = '#FF1A1C19';
const BotanyTextSecondary: string = '#FF757575';
const BotanyAccent: string = '#FF2E5E4E';
const BotanyAccentLight: string = '#FFE8F5E9';
const BorderLight: string = '#FFEEEEEE';
const PlaceholderBg: string = '#FFEEEEEE';
const PlaceholderIcon: string = '#FFCCCCCC';
const ChipBg: string = '#FFE0E0E0';

// Icon paths (SVG-like paths for ArkUI)
const ICON_MENU = 'M3,6H21V8H3V6M3,11H21V13H3V11M3,16H21V18H3V16Z';
const ICON_SEARCH = 'M9.5,3A6.5,6.5 0 0,1 16,9.5C16,11.11 15.41,12.59 14.44,13.73L14.71,14H15.5L20.5,19L19,20.5L14,15.5V14.71L13.73,14.44C12.59,15.41 11.11,16 9.5,16A6.5,6.5 0 0,1 3,9.5A6.5,6.5 0 0,1 9.5,3M9.5,5C7,5 5,7 5,9.5C5,12 7,14 9.5,14C12,14 14,12 14,9.5C14,7 12,5 9.5,5Z';
const ICON_HOME = 'M10,20V14H14V20H19V12H22L12,3L2,12H5V20H10Z';
const ICON_DATE = 'M19,19H5V8H19M16,1V3H8V1H6V3H5C3.89,3 3,3.89 3,5V19A2,2 0 0,0 5,21H19A2,2 0 0,0 21,19V5C21,3.89 20.1,3 19,3H18V1M17,12H12V17H17V12Z';
const ICON_NOTIFICATIONS = 'M12,22A2,2 0 0,0 14,20H10A2,2 0 0,0 12,22M18,16V11C18,7.93 16.36,5.36 13.5,4.68V4A1.5,1.5 0 0,0 12,2.5A1.5,1.5 0 0,0 10.5,4V4.68C7.63,5.36 6,7.92 6,11V16L4,18V19H20V18L18,16Z';
const ICON_SETTINGS = 'M12,15.5A3.5,3.5 0 0,1 8.5,12A3.5,3.5 0 0,1 12,8.5A3.5,3.5 0 0,1 15.5,12A3.5,3.5 0 0,1 12,15.5M19.43,12.97C19.47,12.65 19.5,12.33 19.5,12C19.5,11.67 19.47,11.34 19.43,11L21.54,9.37C21.73,9.22 21.78,8.95 21.66,8.73L19.66,5.27C19.54,5.05 19.27,4.96 19.05,5.05L16.56,6.05C16.04,5.66 15.5,5.32 14.87,5.07L14.5,2.42C14.46,2.18 14.25,2 14,2H10C9.75,2 9.54,2.18 9.5,2.42L9.13,5.07C8.5,5.32 7.96,5.66 7.44,6.05L4.95,5.05C4.73,4.96 4.46,5.05 4.34,5.27L2.34,8.73C2.21,8.95 2.27,9.22 2.46,9.37L4.57,11C4.53,11.34 4.5,11.67 4.5,12C4.5,12.33 4.53,12.65 4.57,12.97L2.46,14.63C2.27,14.78 2.21,15.05 2.34,15.27L4.34,18.73C4.46,18.95 4.73,19.03 4.95,18.95L7.44,17.94C7.96,18.34 8.5,18.68 9.13,18.93L9.5,21.58C9.54,21.82 9.75,22 10,22H14C14.25,22 14.46,21.82 14.5,21.58L14.87,18.93C15.5,18.67 16.04,18.34 16.56,17.94L19.05,18.95C19.27,19.03 19.54,18.95 19.66,18.73L21.66,15.27C21.78,15.05 21.73,14.78 21.54,14.63L19.43,12.97Z';
const ICON_ADD = 'M19,13H13V19H11V13H5V11H11V5H13V11H19V13Z';
const ICON_CHECK = 'M21,7L9,19L3.5,13.5L4.91,12.09L9,16.17L19.59,5.59L21,7Z';
const ICON_FAVORITE = 'M12,21.35L10.55,20.03C5.4,15.36 2,12.28 2,8.5C2,5.42 4.42,3 7.5,3C9.24,3 10.91,3.81 12,5.09C13.09,3.81 14.76,3 16.5,3C19.58,3 22,5.42 22,8.5C22,12.28 18.6,15.36 13.45,20.04L12,21.35Z';
const ICON_LOCATION = 'M12,11.5A2.5,2.5 0 0,1 9.5,9A2.5,2.5 0 0,1 12,6.5A2.5,2.5 0 0,1 14.5,9A2.5,2.5 0 0,1 12,11.5M12,2A7,7 0 0,0 5,9C5,14.25 12,22 12,22C12,22 19,14.25 19,9A7,7 0 0,0 12,2Z';

// Mock Data
const tasks: Task[] = [
  new Task(1, 'Watering', 'Monstera Deliciosa', ICON_DATE, 'Today'),
  new Task(2, 'Fertilize', 'Fiddle Leaf Fig', ICON_NOTIFICATIONS, 'Tomorrow'),
  new Task(3, 'Pruning', 'Snake Plant', ICON_SETTINGS, 'Next Week')
];

const plants: Plant[] = [
  new Plant(1, 'Monstera', 'Monstera deliciosa', 'Living Room', 0),
  new Plant(2, 'Fiddle Leaf', 'Ficus lyrata', 'Bedroom', 2),
  new Plant(3, 'Snakey', 'Sansevieria', 'Hallway', 5),
  new Plant(4, 'Spider Plant', 'Chlorophytum', 'Kitchen', 1),
  new Plant(5, 'Peace Lily', 'Spathiphyllum', 'Bathroom', 3)
];

// Helper function to create icon path
function iconPath(pathData: string, color: string, size: number = 24): string {
  return `data:image/svg+xml;charset=utf-8,<svg xmlns="http://www.w3.org/2000/svg" width="${size}" height="${size}" viewBox="0 0 24 24"><path d="${pathData}" fill="${color.replace('#', '%23')}"/></svg>`;
}

@Entry
@Component
struct BotanyApp {
  @State selectedNavIndex: number = 0;
  @State taskCheckedStates: boolean[] = [false, false, false];
  @State expandedPlantIds: Set<number> = new Set();

  build() {
    Stack() {
      // Main background
      Column() {
        // Top Bar
        this.BotanyTopBar()

        // Content
        Scroll() {
          Column() {
            // Header
            Column({ space: 4 }) {
              Text('Good Morning,')
                .fontSize(16)
                .fontColor(BotanyTextSecondary)
                .margin({ left: 24, right: 24, top: 16 })

              Text('My Jungle')
                .fontSize(36)
                .fontWeight(FontWeight.Bold)
                .fontColor(BotanyTextPrimary)
                .letterSpacing(-1)
                .margin({ left: 24, right: 24 })
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')

            // Pending Tasks Section
            Column() {
              this.SectionHeader('Pending Tasks')

              Scroll() {
                Row({ space: 16 }) {
                  ForEach(tasks, (task: Task, index: number) => {
                    this.TaskCard(task, index)
                  })
                }
                .padding({ left: 24, right: 24 })
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
              .width('100%')
            }
            .margin({ top: 8 })

            // Spacer
            Row().height(32)

            // Collection Section
            Column() {
              this.SectionHeader('Your Collection')

              ForEach(plants, (plant: Plant) => {
                this.PlantListItem(plant)
              })
            }
          }
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.Top)
        .width('100%')

        // Bottom Bar
        this.BotanyBottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BotanyWhite)

      // Floating Action Button
      Button() {
        Image(iconPath(ICON_ADD, '#FFFFFF', 24))
          .width(24)
          .height(24)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor(BotanyTextPrimary)
      .position({ x: '50%', y: '85%' })
      .translate({ x: -28, y: -28 })
      .onClick(() => {
        // No logic
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BotanyWhite)
  }

  @Builder
  SectionHeader(title: string) {
    Text(title)
      .fontSize(16)
      .fontWeight(FontWeight.Bold)
      .fontColor(BotanyTextPrimary)
      .margin({ left: 24, right: 24, top: 12, bottom: 12 })
      .alignSelf(ItemAlign.Start)
  }

  @Builder
  BotanyTopBar() {
    Row() {
      Button() {
        Image(iconPath(ICON_MENU, BotanyTextPrimary, 20))
          .width(20)
          .height(20)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(BotanySurface)
      .padding(0)
      .onClick(() => {})

      Blank()

      Button() {
        Image(iconPath(ICON_SEARCH, BotanyTextPrimary, 20))
          .width(20)
          .height(20)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(BotanySurface)
      .padding(0)
      .onClick(() => {})
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 8 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BotanyBottomBar() {
    Row() {
      this.NavItem(ICON_HOME, 0)
      this.NavItem(ICON_DATE, 1)
      Blank().width(32)
      this.NavItem(ICON_NOTIFICATIONS, 2)
      this.NavItem(ICON_SETTINGS, 3)
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(BotanyWhite)
  }

  @Builder
  NavItem(icon: string, index: number) {
    Button() {
      Image(iconPath(icon, BotanyTextPrimary, 24))
        .width(24)
        .height(24)
        .opacity(this.selectedNavIndex === index ? 1.0 : 0.4)
    }
    .width(40)
    .height(40)
    .padding(0)
    .backgroundColor(Color.Transparent)
    .onClick(() => {
      this.selectedNavIndex = index;
    })
  }

  @Builder
  TaskCard(task: Task, index: number) {
    Column() {
      // Top row with icon
      Row() {
        Column() {
          Image(iconPath(task.icon, this.taskCheckedStates[index] ? '#FFFFFF' : BotanyTextPrimary, 20))
            .width(20)
            .height(20)
        }
        .width(40)
        .height(40)
        .borderRadius(20)
        .backgroundColor(this.taskCheckedStates[index] ? BotanyAccent : BotanyWhite)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Blank().layoutWeight(1)

      // Bottom content
      Column({ space: 4 }) {
        Text(task.title)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyTextPrimary)

        Text(task.plantName)
          .fontSize(12)
          .fontColor(BotanyTextSecondary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row().height(8)

        // Status chip
        Text(this.taskCheckedStates[index] ? 'DONE' : task.urgency)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.taskCheckedStates[index] ? '#FFFFFF' : BotanyTextPrimary)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .borderRadius(4)
          .backgroundColor(this.taskCheckedStates[index] ? BotanyAccent : ChipBg)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width(160)
    .height(180)
    .padding(16)
    .borderRadius(24)
    .backgroundColor(BotanySurface)
    .border({
      width: this.taskCheckedStates[index] ? 2 : 1,
      color: this.taskCheckedStates[index] ? BotanyAccent : BorderLight
    })
    .onClick(() => {
      this.taskCheckedStates[index] = !this.taskCheckedStates[index];
    })
  }

  @Builder
  PlantListItem(plant: Plant) {
    Row() {
      // Image placeholder
      Column() {
        Image(iconPath(ICON_FAVORITE, plant.daysUntilWater === 0 ? BotanyAccent : PlaceholderIcon, 24))
          .width(24)
          .height(24)
      }
      .width(56)
      .height(56)
      .borderRadius(12)
      .backgroundColor(PlaceholderBg)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Row().width(16)

      // Plant info
      Column({ space: 2 }) {
        Text(plant.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyTextPrimary)

        Text(plant.scientificName)
          .fontSize(12)
          .fontColor(BotanyTextSecondary)
          .fontStyle(FontStyle.Italic)

        if (this.expandedPlantIds.has(plant.id)) {
          Row({ space: 4 }) {
            Image(iconPath(ICON_LOCATION, BotanyTextSecondary, 12))
              .width(12)
              .height(12)

            Text(plant.location)
              .fontSize(10)
              .fontColor(BotanyTextSecondary)
          }
          .alignItems(VerticalAlign.Center)
          .margin({ top: 8 })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Right side status
      Column({ space: 2 }) {
        if (plant.daysUntilWater === 0) {
          Image(iconPath(ICON_CHECK, BotanyAccent, 24))
            .width(24)
            .height(24)

          Text('Water')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(BotanyAccent)
        } else {
          Text(`${plant.daysUntilWater} days`)
            .fontSize(10)
            .fontColor(BotanyTextSecondary)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(16)
    .margin({ left: 24, right: 24, top: 8, bottom: 8 })
    .borderRadius(16)
    .backgroundColor(BotanySurface)
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      if (this.expandedPlantIds.has(plant.id)) {
        this.expandedPlantIds.delete(plant.id);
      } else {
        this.expandedPlantIds.add(plant.id);
      }
    })
  }
}