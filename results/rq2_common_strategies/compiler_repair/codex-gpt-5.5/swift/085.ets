class BotanyColors {
  static white: string = '#FFFFFF'
  static surface: string = '#FAFAFA'
  static textPrimary: string = '#1A1C19'
  static textSecondary: string = '#757575'
  static accent: string = '#2E5E4E'
  static accentLight: string = '#E8F5E9'
  static lightBorder: string = '#EEEEEE'
  static chipGray: string = '#E0E0E0'
  static iconGray: string = '#CCCCCC'
}

class Plant {
  id: number
  name: string
  scientificName: string
  location: string
  daysUntilWater: number

  constructor(id: number, name: string, scientificName: string, location: string, daysUntilWater: number) {
    this.id = id
    this.name = name
    this.scientificName = scientificName
    this.location = location
    this.daysUntilWater = daysUntilWater
  }
}

class PlantTask {
  id: number
  title: string
  plantName: string
  iconName: string
  urgency: string

  constructor(id: number, title: string, plantName: string, iconName: string, urgency: string) {
    this.id = id
    this.title = title
    this.plantName = plantName
    this.iconName = iconName
    this.urgency = urgency
  }
}

@Entry
@Component
struct Index {
  @State task1Done: boolean = false
  @State task2Done: boolean = false
  @State task3Done: boolean = false
  @State expandedPlant: number = 0
  @State selectedTab: number = 0

  private tasks: PlantTask[] = [
    new PlantTask(1, 'Watering', 'Monstera Deliciosa', 'Cal', 'Today'),
    new PlantTask(2, 'Fertilize', 'Fiddle Leaf Fig', 'Bell', 'Tomorrow'),
    new PlantTask(3, 'Pruning', 'Snake Plant', 'Gear', 'Next Week')
  ]

  private plants: Plant[] = [
    new Plant(1, 'Monstera', 'Monstera deliciosa', 'Living Room', 0),
    new Plant(2, 'Fiddle Leaf', 'Ficus lyrata', 'Bedroom', 2),
    new Plant(3, 'Snakey', 'Sansevieria', 'Hallway', 5),
    new Plant(4, 'Spider Plant', 'Chlorophytum', 'Kitchen', 1),
    new Plant(5, 'Peace Lily', 'Spathiphyllum', 'Bathroom', 3)
  ]

  private isTaskDone(id: number): boolean {
    if (id === 1) {
      return this.task1Done
    }
    if (id === 2) {
      return this.task2Done
    }
    return this.task3Done
  }

  @Builder
  BotanyTopBar() {
    Row() {
      Button('Menu')
        .fontSize(12)
        .fontColor(BotanyColors.textPrimary)
        .width(40)
        .height(40)
        .backgroundColor(BotanyColors.surface)
        .borderRadius(20)

      Blank()
        .layoutWeight(1)

      Button('Search')
        .fontSize(12)
        .fontColor(BotanyColors.textPrimary)
        .width(40)
        .height(40)
        .backgroundColor(BotanyColors.surface)
        .borderRadius(20)
    }
    .width('100%')
  }

  @Builder
  HeaderArea() {
    Column() {
      Text('Good Morning,')
        .fontSize(16)
        .fontColor(BotanyColors.textSecondary)
      Text('My Jungle')
        .fontSize(34)
        .fontWeight(FontWeight.Bold)
        .fontColor(BotanyColors.textPrimary)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 16, bottom: 16 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  SectionHeader(title: string) {
    Text(title)
      .fontSize(22)
      .fontWeight(FontWeight.Bold)
      .fontColor(BotanyColors.textPrimary)
      .width('100%')
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }

  @Builder
  TaskCard(task: PlantTask) {
    Column() {
      Row() {
        Stack() {
          Circle()
            .width(40)
            .height(40)
            .fill(this.isTaskDone(task.id) ? BotanyColors.accent : BotanyColors.white)
          Text(task.iconName)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isTaskDone(task.id) ? BotanyColors.white : BotanyColors.textPrimary)
        }
        .width(40)
        .height(40)
        Blank()
          .layoutWeight(1)
      }
      .width('100%')

      Blank()
        .layoutWeight(1)

      Column() {
        Text(task.title)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyColors.textPrimary)
        Text(task.plantName)
          .fontSize(12)
          .fontColor(BotanyColors.textSecondary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Blank()
          .height(8)
        Text(this.isTaskDone(task.id) ? 'DONE' : task.urgency)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isTaskDone(task.id) ? BotanyColors.white : BotanyColors.textPrimary)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.isTaskDone(task.id) ? BotanyColors.accent : BotanyColors.chipGray)
          .borderRadius(4)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width(160)
    .height(180)
    .padding(16)
    .backgroundColor(BotanyColors.surface)
    .border({ width: this.isTaskDone(task.id) ? 2 : 1, color: this.isTaskDone(task.id) ? BotanyColors.accent : BotanyColors.lightBorder, radius: 24 })
    .onClick(() => {
      if (task.id === 1) {
        this.task1Done = !this.task1Done
      } else if (task.id === 2) {
        this.task2Done = !this.task2Done
      } else {
        this.task3Done = !this.task3Done
      }
    })
  }

  @Builder
  PlantListItem(plant: Plant) {
    Row() {
      Stack() {
        Rect()
          .width(56)
          .height(56)
          .fill(BotanyColors.lightBorder)
          .radius(12)
        Text('♥')
          .fontSize(18)
          .fontColor(plant.daysUntilWater === 0 ? BotanyColors.accent : BotanyColors.iconGray)
      }
      .width(56)
      .height(56)

      Blank()
        .width(16)

      Column() {
        Text(plant.name)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyColors.textPrimary)
        Text(plant.scientificName)
          .fontSize(12)
          .fontStyle(FontStyle.Italic)
          .fontColor(BotanyColors.textSecondary)
        if (this.expandedPlant === plant.id) {
          Blank()
            .height(8)
          Row() {
            Text('Loc')
              .fontSize(10)
              .fontColor(BotanyColors.textSecondary)
            Blank()
              .width(4)
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
          Text('OK')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(BotanyColors.accent)
          Text('Water')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(BotanyColors.accent)
        } else {
          Text(plant.daysUntilWater.toString() + ' days')
            .fontSize(10)
            .fontColor(BotanyColors.textSecondary)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(BotanyColors.surface)
    .borderRadius(16)
    .onClick(() => {
      this.expandedPlant = this.expandedPlant === plant.id ? 0 : plant.id
    })
  }

  @Builder
  BotanyNavItem(label: string, index: number) {
    Text(label)
      .fontSize(12)
      .fontWeight(FontWeight.Bold)
      .fontColor(BotanyColors.textPrimary)
      .opacity(this.selectedTab === index ? 1.0 : 0.4)
      .layoutWeight(1)
      .textAlign(TextAlign.Center)
      .onClick(() => {
        this.selectedTab = index
      })
  }

  @Builder
  BottomBar() {
    Row() {
      this.BotanyNavItem('Home', 0)
      this.BotanyNavItem('Cal', 1)
      Blank()
        .width(32)
      this.BotanyNavItem('Bell', 2)
      this.BotanyNavItem('Gear', 3)
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .backgroundColor(BotanyColors.white)
    .shadow({ radius: 5, color: '#0D000000', offsetY: -2 })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Column() {
          this.BotanyTopBar()
        }
        .width('100%')
        .padding({ top: 24, left: 24, right: 24, bottom: 8 })
        .backgroundColor(BotanyColors.white)

        Scroll() {
          Column() {
            this.HeaderArea()
            this.SectionHeader('Pending Tasks')
            Scroll() {
              Row({ space: 16 }) {
                ForEach(this.tasks, (task: PlantTask) => {
                  this.TaskCard(task)
                })
              }
              .padding({ left: 24, right: 24 })
            }
            .width('100%')
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)

            Blank()
              .height(32)

            this.SectionHeader('Your Collection')

            ForEach(this.plants, (plant: Plant) => {
              Column() {
                this.PlantListItem(plant)
              }
              .width('100%')
              .padding({ left: 24, right: 24, top: 8, bottom: 8 })
            })

            Blank()
              .height(80)
          }
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      Button('+')
        .fontSize(24)
        .fontColor(BotanyColors.white)
        .width(56)
        .height(56)
        .backgroundColor(BotanyColors.textPrimary)
        .borderRadius(28)
        .margin({ right: 24, bottom: 96 })

      Column() {
        Blank()
          .layoutWeight(1)
        this.BottomBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BotanyColors.white)
  }
}
