// BotanyApp.ets
// Translated from SwiftUI to ArkTS

import promptAction from '@ohos.promptAction';

// MARK: - Color Palette
class BotanyColors {
  static readonly white: string = '#FFFFFFFF';
  static readonly surface: string = '#FFFAFAFA';
  static readonly textPrimary: string = '#FF1A1C19';
  static readonly textSecondary: string = '#FF757575';
  static readonly accent: string = '#FF2E5E4E';
  static readonly accentLight: string = '#FFE8F5E9';
  static readonly divider: string = '#FFEEEEEE';
  static readonly placeholder: string = '#FFE0E0E0';
  static readonly iconGray: string = '#FFCCCCCC';
}

// MARK: - Data Models
class Plant {
  id: number;
  name: string;
  scientificName: string;
  location: string;
  daysUntilWater: number;
  isHealthy: boolean = true;

  constructor(id: number, name: string, scientificName: string,
              location: string, daysUntilWater: number) {
    this.id = id;
    this.name = name;
    this.scientificName = scientificName;
    this.location = location;
    this.daysUntilWater = daysUntilWater;
  }
}

class Task {
  id: number;
  title: string;
  plantName: string;
  iconName: string;
  urgency: string;

  constructor(id: number, title: string, plantName: string,
              iconName: string, urgency: string) {
    this.id = id;
    this.title = title;
    this.plantName = plantName;
    this.iconName = iconName;
    this.urgency = urgency;
  }
}

// MARK: - SectionHeader Component
@Component
struct SectionHeader {
  title: string = '';

  build() {
    Text(this.title)
      .fontSize(22)
      .fontWeight(FontWeight.Bold)
      .fontColor(BotanyColors.textPrimary)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }
}

// MARK: - TaskCard Component
@Component
struct TaskCard {
  task: Task = new Task(0, '', '', '', '');
  @State isChecked: boolean = false;

  build() {
    Column() {
      Row() {
        Stack() {
          Circle()
            .fill(this.isChecked ? BotanyColors.accent : Color.White)
            .width(40)
            .height(40)
          Text(this.task.iconName)
            .fontSize(20)
            .fontColor(this.isChecked ? Color.White : BotanyColors.textPrimary)
        }
        .width(40)
        .height(40)

        Blank()
      }
      .width('100%')

      Blank()

      Column({ space: 0 }) {
        Text(this.task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyColors.textPrimary)

        Text(this.task.plantName)
          .fontSize(12)
          .fontColor(BotanyColors.textSecondary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Blank()
          .height(8)

        Text(this.isChecked ? 'DONE' : this.task.urgency)
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? Color.White : BotanyColors.textPrimary)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.isChecked ? BotanyColors.accent : BotanyColors.placeholder)
          .borderRadius(4)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width(160)
    .height(180)
    .backgroundColor(BotanyColors.surface)
    .borderRadius(24)
    .border({
      width: this.isChecked ? 2 : 1,
      color: this.isChecked ? BotanyColors.accent : BotanyColors.divider
    })
    .onClick(() => {
      this.isChecked = !this.isChecked;
    })
  }
}

// MARK: - PlantListItem Component
@Component
struct PlantListItem {
  plant: Plant = new Plant(0, '', '', '', 0);
  @State expanded: boolean = false;

  build() {
    Row() {
      Stack() {
        RoundedRect()
          .fill(BotanyColors.divider)
          .width(56)
          .height(56)
          .radius(12)
        Text('♥')
          .fontSize(24)
          .fontColor(this.plant.daysUntilWater === 0 ? BotanyColors.accent : BotanyColors.iconGray)
      }
      .width(56)
      .height(56)

      Blank()
        .width(16)

      Column() {
        Text(this.plant.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyColors.textPrimary)

        Text(this.plant.scientificName)
          .fontSize(12)
          .fontColor(BotanyColors.textSecondary)
          .fontStyle(FontStyle.Italic)

        if (this.expanded) {
          Blank()
            .height(8)
          Row() {
            Text('\u{1F4CD}')
              .fontSize(12)
              .fontColor(BotanyColors.textSecondary)
            Blank()
              .width(4)
            Text(this.plant.location)
              .fontSize(11)
              .fontColor(BotanyColors.textSecondary)
          }
          .alignItems(VerticalAlign.Center)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column() {
        if (this.plant.daysUntilWater === 0) {
          Text('✓')
            .fontSize(24)
            .fontColor(BotanyColors.accent)
          Text('Water')
            .fontSize(11)
            .fontColor(BotanyColors.accent)
            .fontWeight(FontWeight.Bold)
        } else {
          Text(`${this.plant.daysUntilWater} days`)
            .fontSize(11)
            .fontColor(BotanyColors.textSecondary)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .backgroundColor(BotanyColors.surface)
    .borderRadius(16)
    .padding({ left: 24, right: 24, top: 8, bottom: 8 })
    .onClick(() => {
      this.expanded = !this.expanded;
    })
  }
}

// MARK: - BotanyTopBar Component
@Component
struct BotanyTopBar {
  build() {
    Row() {
      Button() {
        Text('☰')
          .fontSize(20)
          .fontColor(BotanyColors.textPrimary)
      }
      .width(40)
      .height(40)
      .backgroundColor(BotanyColors.surface)
      .borderRadius(20)
      .onClick(() => {
        promptAction.showToast({ message: 'Menu', duration: 1000 });
      })

      Blank()

      Button() {
        Text('\u{1F50D}')
          .fontSize(20)
          .fontColor(BotanyColors.textPrimary)
      }
      .width(40)
      .height(40)
      .backgroundColor(BotanyColors.surface)
      .borderRadius(20)
      .onClick(() => {
        promptAction.showToast({ message: 'Search', duration: 1000 });
      })
    }
    .width('100%')
  }
}

// MARK: - BotanyNavItem Component
@Component
struct BotanyNavItem {
  iconName: string = '';
  isSelected: boolean = false;
  onItemClick?: () => void;

  build() {
    Button() {
      Text(this.iconName)
        .fontSize(22)
        .fontColor(BotanyColors.textPrimary)
        .opacity(this.isSelected ? 1.0 : 0.4)
    }
    .layoutWeight(1)
    .backgroundColor(Color.Transparent)
    .onClick(() => {
      if (this.onItemClick) {
        this.onItemClick();
      }
    })
  }
}

// MARK: - BotanyBottomBar Component
@Component
struct BotanyBottomBar {
  @State selectedTab: number = 0;

  build() {
    Row() {
      BotanyNavItem({
        iconName: '\u{1F3E0}',
        isSelected: this.selectedTab === 0,
        onItemClick: () => { this.selectedTab = 0; }
      })

      BotanyNavItem({
        iconName: '\u{1F4C5}',
        isSelected: this.selectedTab === 1,
        onItemClick: () => { this.selectedTab = 1; }
      })

      Blank()
        .width(32)

      BotanyNavItem({
        iconName: '\u{1F514}',
        isSelected: this.selectedTab === 2,
        onItemClick: () => { this.selectedTab = 2; }
      })

      BotanyNavItem({
        iconName: '⚙',
        isSelected: this.selectedTab === 3,
        onItemClick: () => { this.selectedTab = 3; }
      })
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .backgroundColor(BotanyColors.white)
  }
}

// MARK: - Main Content View
@Entry
@Component
struct BotanyContentView {
  private tasks: Task[] = [
    new Task(1, 'Watering', 'Monstera Deliciosa', '\u{1F4C5}', 'Today'),
    new Task(2, 'Fertilize', 'Fiddle Leaf Fig', '\u{1F514}', 'Tomorrow'),
    new Task(3, 'Pruning', 'Snake Plant', '⚙', 'Next Week')
  ];

  private plants: Plant[] = [
    new Plant(1, 'Monstera', 'Monstera deliciosa', 'Living Room', 0),
    new Plant(2, 'Fiddle Leaf', 'Ficus lyrata', 'Bedroom', 2),
    new Plant(3, 'Snakey', 'Sansevieria', 'Hallway', 5),
    new Plant(4, 'Spider Plant', 'Chlorophytum', 'Kitchen', 1),
    new Plant(5, 'Peace Lily', 'Spathiphyllum', 'Bathroom', 3)
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        BotanyTopBar()
          .padding({ top: 24, left: 24, right: 24, bottom: 8 })
          .backgroundColor(BotanyColors.white)

        Scroll() {
          Column({ space: 0 }) {
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontColor(BotanyColors.textSecondary)
              Text('My Jungle')
                .fontSize(34)
                .fontWeight(FontWeight.Bold)
                .fontColor(BotanyColors.textPrimary)
            }
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })

            SectionHeader({ title: 'Pending Tasks' })

            Scroll() {
              Row({ space: 16 }) {
                ForEach(this.tasks, (item: Task) => {
                  TaskCard({ task: item })
                }, (item: Task) => item.id.toString())
              }
              .padding({ left: 24, right: 24 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .padding({ bottom: 32 })

            SectionHeader({ title: 'Your Collection' })

            ForEach(this.plants, (item: Plant) => {
              PlantListItem({ plant: item })
            }, (item: Plant) => item.id.toString())
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({ bottom: 80 })
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BotanyColors.white)

      // FAB
      Column() {
        Blank()
        Row() {
          Blank()
          Button() {
            Text('+')
              .fontSize(28)
              .fontColor(Color.White)
          }
          .width(56)
          .height(56)
          .backgroundColor(BotanyColors.textPrimary)
          .borderRadius(28)
          .padding({ right: 24, bottom: 96 })
          .onClick(() => {
            promptAction.showToast({ message: 'Add plant', duration: 1000 });
          })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')

      // Bottom Bar
      BotanyBottomBar()
        .width('100%')
        .shadow({
          radius: 5,
          color: 'rgba(0, 0, 0, 0.05)',
          offsetY: -2
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BotanyColors.white)
  }
}
