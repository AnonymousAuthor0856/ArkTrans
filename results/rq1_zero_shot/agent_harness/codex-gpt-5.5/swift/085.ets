class BotanyColors {
  static white: string = '#FFFFFF';
  static surface: string = '#FAFAFA';
  static textPrimary: string = '#1A1C19';
  static textSecondary: string = '#757575';
  static accent: string = '#2E5E4E';
  static accentLight: string = '#E8F5E9';
}

class Plant {
  id: number;
  name: string;
  scientificName: string;
  location: string;
  daysUntilWater: number;
  isHealthy: boolean = true;

  constructor(id: number, name: string, scientificName: string, location: string, daysUntilWater: number) {
    this.id = id;
    this.name = name;
    this.scientificName = scientificName;
    this.location = location;
    this.daysUntilWater = daysUntilWater;
  }
}

class TaskItem {
  id: number;
  title: string;
  plantName: string;
  iconName: string;
  urgency: string;

  constructor(id: number, title: string, plantName: string, iconName: string, urgency: string) {
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
  @State private checkedTasks: boolean[] = [false, false, false];
  @State private expandedPlants: boolean[] = [false, false, false, false, false];
  @State private selectedTab: number = 0;

  private tasks: TaskItem[] = [
    new TaskItem(1, 'Watering', 'Monstera Deliciosa', '□', 'Today'),
    new TaskItem(2, 'Fertilize', 'Fiddle Leaf Fig', '🔔', 'Tomorrow'),
    new TaskItem(3, 'Pruning', 'Snake Plant', '⚙', 'Next Week')
  ];

  private plants: Plant[] = [
    new Plant(1, 'Monstera', 'Monstera deliciosa', 'Living Room', 0),
    new Plant(2, 'Fiddle Leaf', 'Ficus lyrata', 'Bedroom', 2),
    new Plant(3, 'Snakey', 'Sansevieria', 'Hallway', 5),
    new Plant(4, 'Spider Plant', 'Chlorophytum', 'Kitchen', 1),
    new Plant(5, 'Peace Lily', 'Spathiphyllum', 'Bathroom', 3)
  ];

  @Builder
  private BotanyTopBar() {
    Row() {
      Button('☰')
        .width(40)
        .height(40)
        .fontColor(BotanyColors.textPrimary)
        .backgroundColor(BotanyColors.surface)
        .borderRadius(20)
      Blank()
      Button('⌕')
        .width(40)
        .height(40)
        .fontColor(BotanyColors.textPrimary)
        .backgroundColor(BotanyColors.surface)
        .borderRadius(20)
    }
    .width('100%')
  }

  @Builder
  private SectionHeader(title: string) {
    Text(title)
      .fontSize(22)
      .fontWeight(FontWeight.Bold)
      .fontColor(BotanyColors.textPrimary)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .width('100%')
      .textAlign(TextAlign.Start)
  }

  @Builder
  private TaskCard(task: TaskItem, index: number) {
    Column() {
      Row() {
        Stack() {
          Circle()
            .width(40)
            .height(40)
            .fill(this.checkedTasks[index] ? BotanyColors.accent : Color.White)
          Text(task.iconName)
            .fontSize(20)
            .fontColor(this.checkedTasks[index] ? Color.White : BotanyColors.textPrimary)
        }
        .width(40)
        .height(40)
        Blank()
      }
      .width('100%')

      Blank()

      Column({ space: 0 }) {
        Text(task.title)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyColors.textPrimary)
        Text(task.plantName)
          .fontSize(12)
          .fontColor(BotanyColors.textSecondary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Blank().height(8)
        Text(this.checkedTasks[index] ? 'DONE' : task.urgency)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.checkedTasks[index] ? Color.White : BotanyColors.textPrimary)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.checkedTasks[index] ? BotanyColors.accent : '#E0E0E0')
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
    .border({ width: this.checkedTasks[index] ? 2 : 1, color: this.checkedTasks[index] ? BotanyColors.accent : '#EEEEEE' })
    .onClick(() => {
      let next: boolean[] = this.checkedTasks.slice();
      next[index] = !next[index];
      this.checkedTasks = next;
    })
  }

  @Builder
  private PlantListItem(plant: Plant, index: number) {
    Row() {
      Stack() {
        Rect()
          .width(56)
          .height(56)
          .fill('#EEEEEE')
          .radius(12)
        Text('♥')
          .fontSize(20)
          .fontColor(plant.daysUntilWater === 0 ? BotanyColors.accent : '#CCCCCC')
      }
      .width(56)
      .height(56)

      Blank().width(16)

      Column() {
        Text(plant.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyColors.textPrimary)
        Text(plant.scientificName)
          .fontSize(12)
          .fontStyle(FontStyle.Italic)
          .fontColor(BotanyColors.textSecondary)

        if (this.expandedPlants[index]) {
          Blank().height(8)
          Row() {
            Text('⌖')
              .fontSize(12)
              .fontColor(BotanyColors.textSecondary)
            Blank().width(4)
            Text(plant.location)
              .fontSize(10)
              .fontColor(BotanyColors.textSecondary)
          }
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column() {
        if (plant.daysUntilWater === 0) {
          Text('✓')
            .fontSize(24)
            .fontColor(BotanyColors.accent)
          Text('Water')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(BotanyColors.accent)
        } else {
          Text(`${plant.daysUntilWater} days`)
            .fontSize(10)
            .fontColor(BotanyColors.textSecondary)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .padding(16)
    .width('100%')
    .backgroundColor(BotanyColors.surface)
    .borderRadius(16)
    .margin({ left: 24, right: 24, top: 8, bottom: 8 })
    .onClick(() => {
      let next: boolean[] = this.expandedPlants.slice();
      next[index] = !next[index];
      this.expandedPlants = next;
    })
  }

  @Builder
  private BotanyNavItem(iconName: string, index: number) {
    Text(iconName)
      .fontSize(22)
      .fontColor(BotanyColors.textPrimary)
      .opacity(this.selectedTab === index ? 1.0 : 0.4)
      .layoutWeight(1)
      .textAlign(TextAlign.Center)
      .onClick(() => {
        this.selectedTab = index;
      })
  }

  @Builder
  private BotanyBottomBar() {
    Row({ space: 0 }) {
      this.BotanyNavItem('⌂', 0)
      this.BotanyNavItem('□', 1)
      Blank().width(32)
      this.BotanyNavItem('🔔', 2)
      this.BotanyNavItem('⚙', 3)
    }
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .width('100%')
    .backgroundColor(BotanyColors.white)
    .shadow({ radius: 5, color: '#0000000D', offsetX: 0, offsetY: -2 })
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        this.BotanyTopBar()
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
            .width('100%')

            this.SectionHeader('Pending Tasks')
            Scroll() {
              Row({ space: 16 }) {
                ForEach(this.tasks, (task: TaskItem, index: number) => {
                  this.TaskCard(task, index)
                })
              }
              .padding({ left: 24, right: 24 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .padding({ bottom: 32 })

            this.SectionHeader('Your Collection')
            ForEach(this.plants, (plant: Plant, index: number) => {
              this.PlantListItem(plant, index)
            })
          }
          .padding({ bottom: 80 })
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
        Row() {
          Blank()
          Button('+')
            .width(56)
            .height(56)
            .fontSize(24)
            .fontColor(Color.White)
            .backgroundColor(BotanyColors.textPrimary)
            .borderRadius(28)
            .margin({ right: 24, bottom: 96 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
        this.BotanyBottomBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BotanyColors.white)
  }
}
