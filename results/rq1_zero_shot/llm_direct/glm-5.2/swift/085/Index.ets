// BotanyApp.ets
import { Length, ResourceStr } from '@ohos.arkui.UI';

// 1. Color Palette
class BotanyColors {
  static readonly botanyWhite: string = '#FFFFFF';
  static readonly botanySurface: string = '#FAFAFA';
  static readonly botanyTextPrimary: string = '#1A1C19';
  static readonly botanyTextSecondary: string = '#757575';
  static readonly botanyAccent: string = '#2E5E4E';
  static readonly botanyAccentLight: string = '#E8F5E9';
  static readonly botanyBorder: string = '#EEEEEE';
  static readonly botanyChipBg: string = '#E0E0E0';
  static readonly botanyIconTertiary: string = '#CCCCCC';
}

// 2. Data Models
class Plant {
  id: number;
  name: string;
  scientificName: string;
  location: string;
  daysUntilWater: number;
  isHealthy: boolean;

  constructor(id: number, name: string, scientificName: string, location: string, daysUntilWater: number) {
    this.id = id;
    this.name = name;
    this.scientificName = scientificName;
    this.location = location;
    this.daysUntilWater = daysUntilWater;
    this.isHealthy = true;
  }
}

class Task {
  id: number;
  title: string;
  plantName: string;
  iconName: ResourceStr;
  urgency: string;

  constructor(id: number, title: string, plantName: string, iconName: ResourceStr, urgency: string) {
    this.id = id;
    this.title = title;
    this.plantName = plantName;
    this.iconName = iconName;
    this.urgency = urgency;
  }
}

@Entry
@Component
struct BotanyContentView {
  @State tasks: Task[] = [
    new Task(1, 'Watering', 'Monstera Deliciosa', $r('sys.symbol.calendar'), 'Today'),
    new Task(2, 'Fertilize', 'Fiddle Leaf Fig', $r('sys.symbol.bell_fill'), 'Tomorrow'),
    new Task(3, 'Pruning', 'Snake Plant', $r('sys.symbol.gearshape_fill'), 'Next Week')
  ];

  @State plants: Plant[] = [
    new Plant(1, 'Monstera', 'Monstera deliciosa', 'Living Room', 0),
    new Plant(2, 'Fiddle Leaf', 'Ficus lyrata', 'Bedroom', 2),
    new Plant(3, 'Snakey', 'Sansevieria', 'Hallway', 5),
    new Plant(4, 'Spider Plant', 'Chlorophytum', 'Kitchen', 1),
    new Plant(5, 'Peace Lily', 'Spathiphyllum', 'Bathroom', 3)
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        BotanyTopBar()

        // Scrollable Content
        Scroll() {
          Column() {
            // Header
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontColor(BotanyColors.botanyTextSecondary)
              Text('My Jungle')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor(BotanyColors.botanyTextPrimary)
            }
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })

            // Pending Tasks
            SectionHeader({ title: 'Pending Tasks' })
            
            Scroll() {
              Row({ space: 16 }) {
                ForEach(this.tasks, (task: Task) => {
                  TaskCard({ task: task })
                })
              }
              .padding({ left: 24, right: 24 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .padding({ bottom: 32 })

            // Collection
            SectionHeader({ title: 'Your Collection' })

            ForEach(this.plants, (plant: Plant) => {
              PlantListItem({ plant: plant })
            })
          }
          .padding({ bottom: 80 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }

      // FAB
      Row() {
        Button() {
          Image($r('sys.symbol.plus'))
            .fontSize(20)
            .fontColor(Color.White)
        }
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor(BotanyColors.botanyTextPrimary)
        .margin({ right: 24, bottom: 96 })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)

      // Bottom Bar
      BotanyBottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BotanyColors.botanyWhite)
  }
}

@Component
struct SectionHeader {
  private title: string = '';

  build() {
    Text(this.title)
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .fontColor(BotanyColors.botanyTextPrimary)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }
}

@Component
struct TaskCard {
  private task: Task = new Task(0, '', '', $r('sys.symbol.heart'), '');
  @State isChecked: boolean = false;

  build() {
    Column() {
      Row() {
        Stack() {
          if (this.isChecked) {
            Circle({ width: 40, height: 40 }).fill(BotanyColors.botanyAccent)
          } else {
            Circle({ width: 40, height: 40 }).fill(Color.White)
          }
          Image(this.task.iconName)
            .width(20)
            .height(20)
            .fillColor(this.isChecked ? Color.White : BotanyColors.botanyTextPrimary)
        }
      }

      Blank() // Push to bottom

      Column() {
        Text(this.task.title)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyColors.botanyTextPrimary)
        Text(this.task.plantName)
          .fontSize(12)
          .fontColor(BotanyColors.botanyTextSecondary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Blank().height(8)

        Text(this.isChecked ? 'DONE' : this.task.urgency)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? Color.White : BotanyColors.botanyTextPrimary)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.isChecked ? BotanyColors.botanyAccent : BotanyColors.botanyChipBg)
          .borderRadius(4)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width(160)
    .height(180)
    .borderRadius(24)
    .backgroundColor(BotanyColors.botanySurface)
    .border({
      width: this.isChecked ? 2 : 1,
      color: this.isChecked ? BotanyColors.botanyAccent : BotanyColors.botanyBorder
    })
    .onClick(() => {
      this.isChecked = !this.isChecked;
    })
    .animation({ duration: 200, curve: Curve.EaseInOut })
  }
}

@Component
struct PlantListItem {
  private plant: Plant = new Plant(0, '', '', '', 0);
  @State expanded: boolean = false;

  build() {
    Row() {
      // Image Placeholder
      Stack() {
        Rect().width(56).height(56).borderRadius(12).fill(BotanyColors.botanyBorder)
        Image($r('sys.symbol.heart_fill'))
          .width(24)
          .height(24)
          .fillColor(this.plant.daysUntilWater === 0 ? BotanyColors.botanyAccent : BotanyColors.botanyIconTertiary)
      }

      Blank().width(16)

      Column() {
        Text(this.plant.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyColors.botanyTextPrimary)
        Text(this.plant.scientificName)
          .fontSize(12)
          .fontColor(BotanyColors.botanyTextSecondary)
          .fontStyle(FontStyle.Italic)

        if (this.expanded) {
          Blank().height(8)
          Row() {
            Image($r('sys.symbol.location_fill'))
              .width(12)
              .height(12)
              .fillColor(BotanyColors.botanyTextSecondary)
            Blank().width(4)
            Text(this.plant.location)
              .fontSize(10)
              .fontColor(BotanyColors.botanyTextSecondary)
          }
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Column() {
        if (this.plant.daysUntilWater === 0) {
          Image($r('sys.symbol.checkmark_circle_fill'))
            .width(24)
            .height(24)
            .fillColor(BotanyColors.botanyAccent)
          Text('Water')
            .fontSize(10)
            .fontColor(BotanyColors.botanyAccent)
            .fontWeight(FontWeight.Bold)
        } else {
          Text(`${this.plant.daysUntilWater} days`)
            .fontSize(10)
            .fontColor(BotanyColors.botanyTextSecondary)
        }
      }
    }
    .padding(16)
    .borderRadius(16)
    .backgroundColor(BotanyColors.botanySurface)
    .margin({ left: 24, right: 24, top: 8, bottom: 8 })
    .onClick(() => {
      this.expanded = !this.expanded;
    })
    .animation({ duration: 200, curve: Curve.EaseInOut })
  }
}

@Component
struct BotanyTopBar {
  build() {
    Row() {
      Button() {
        Image($r('sys.symbol.line_horizontal_3'))
          .fillColor(BotanyColors.botanyTextPrimary)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(BotanyColors.botanySurface)

      Blank()

      Button() {
        Image($r('sys.symbol.magnifyingglass'))
          .fillColor(BotanyColors.botanyTextPrimary)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(BotanyColors.botanySurface)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 8 })
    .backgroundColor(BotanyColors.botanyWhite)
  }
}

@Component
struct BotanyBottomBar {
  @State selectedTab: number = 0;

  build() {
    Row() {
      BotanyNavItem({ iconName: $r('sys.symbol.house_fill'), isSelected: this.selectedTab === 0 })
        .onClick(() => { this.selectedTab = 0; })
      BotanyNavItem({ iconName: $r('sys.symbol.calendar'), isSelected: this.selectedTab === 1 })
        .onClick(() => { this.selectedTab = 1; })
      
      Blank().width(32)

      BotanyNavItem({ iconName: $r('sys.symbol.bell_fill'), isSelected: this.selectedTab === 2 })
        .onClick(() => { this.selectedTab = 2; })
      BotanyNavItem({ iconName: $r('sys.symbol.gearshape_fill'), isSelected: this.selectedTab === 3 })
        .onClick(() => { this.selectedTab = 3; })
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .backgroundColor(BotanyColors.botanyWhite)
    .shadow({ radius: 5, color: '#0D000000', offsetX: 0, offsetY: -2 })
  }
}

@Component
struct BotanyNavItem {
  private iconName: ResourceStr = $r('sys.symbol.heart');
  private isSelected: boolean = false;

  build() {
    Button() {
      Image(this.iconName)
        .fontSize(20)
        .fillColor(BotanyColors.botanyTextPrimary)
        .opacity(this.isSelected ? 1.0 : 0.4)
    }
    .layoutWeight(1)
    .backgroundColor(Color.Transparent)
  }
}