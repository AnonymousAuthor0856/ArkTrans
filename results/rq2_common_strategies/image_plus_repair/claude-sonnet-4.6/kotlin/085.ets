// Index.ets

// --- Data Models ---
class Plant {
  id: number
  name: string
  scientificName: string
  location: string
  daysUntilWater: number
  isHealthy: boolean

  constructor(id: number, name: string, scientificName: string, location: string, daysUntilWater: number, isHealthy: boolean = true) {
    this.id = id
    this.name = name
    this.scientificName = scientificName
    this.location = location
    this.daysUntilWater = daysUntilWater
    this.isHealthy = isHealthy
  }
}

class Task {
  id: number
  title: string
  plantName: string
  iconType: string
  urgency: string

  constructor(id: number, title: string, plantName: string, iconType: string, urgency: string) {
    this.id = id
    this.title = title
    this.plantName = plantName
    this.iconType = iconType
    this.urgency = urgency
  }
}

// --- Color Palette ---
const BotanyWhite: string = '#FFFFFF'
const BotanySurface: string = '#FAFAFA'
const BotanyTextPrimary: string = '#1A1C19'
const BotanyTextSecondary: string = '#757575'
const BotanyAccent: string = '#2E5E4E'
const BotanyAccentLight: string = '#E8F5E9'

@Component
struct TaskCard {
  task: Task = new Task(0, '', '', '', '')
  @State isChecked: boolean = false

  build() {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Circle({ width: 40, height: 40 })
            .fill(this.isChecked ? BotanyAccent : '#FFFFFF')

          if (this.task.iconType === 'calendar') {
            Text('📅')
              .fontSize(16)
          } else if (this.task.iconType === 'bell') {
            Text('🔔')
              .fontSize(16)
          } else {
            Text('⚙️')
              .fontSize(16)
          }
        }
        .width(40)
        .height(40)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      Blank()

      Column() {
        Text(this.task.title)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyTextPrimary)

        Text(this.task.plantName)
          .fontSize(12)
          .fontColor(BotanyTextSecondary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Blank().height(8)

        Text(this.isChecked ? 'DONE' : this.task.urgency)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? '#FFFFFF' : BotanyTextPrimary)
          .backgroundColor(this.isChecked ? BotanyAccent : '#E0E0E0')
          .borderRadius(4)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .width(160)
    .height(180)
    .padding(16)
    .backgroundColor(BotanySurface)
    .borderRadius(24)
    .border({
      width: this.isChecked ? 2 : 1,
      color: this.isChecked ? BotanyAccent : '#EEEEEE'
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .onClick(() => {
      this.isChecked = !this.isChecked
    })
  }
}

@Component
struct PlantListItem {
  plant: Plant = new Plant(0, '', '', '', 0)
  @State expanded: boolean = false

  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width(56)
          .height(56)
          .borderRadius(12)
          .backgroundColor('#EEEEEE')

        Text('♥')
          .fontSize(20)
          .fontColor(this.plant.daysUntilWater === 0 ? BotanyAccent : '#CCCCCC')
      }
      .width(56)
      .height(56)

      Blank().width(16)

      Column() {
        Text(this.plant.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyTextPrimary)

        Text(this.plant.scientificName)
          .fontSize(12)
          .fontColor(BotanyTextSecondary)
          .fontStyle(FontStyle.Italic)

        if (this.expanded) {
          Blank().height(8)
          Row() {
            Text('📍')
              .fontSize(10)
            Blank().width(4)
            Text(this.plant.location)
              .fontSize(10)
              .fontColor(BotanyTextSecondary)
          }
          .alignItems(VerticalAlign.Center)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column() {
        if (this.plant.daysUntilWater === 0) {
          Text('✓')
            .fontSize(18)
            .fontColor(BotanyAccent)
            .fontWeight(FontWeight.Bold)
          Text('Water')
            .fontSize(10)
            .fontColor(BotanyAccent)
            .fontWeight(FontWeight.Bold)
        } else {
          Text(`${this.plant.daysUntilWater} days`)
            .fontSize(10)
            .fontColor(BotanyTextSecondary)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(BotanySurface)
    .borderRadius(16)
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.expanded = !this.expanded
    })
  }
}

@Component
struct BotanyTopBar {
  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 40, height: 40 })
          .fill(BotanySurface)
        Text('☰')
          .fontSize(18)
          .fontColor(BotanyTextPrimary)
      }
      .width(40)
      .height(40)

      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 40, height: 40 })
          .fill(BotanySurface)
        Text('🔍')
          .fontSize(18)
          .fontColor(BotanyTextPrimary)
      }
      .width(40)
      .height(40)
    }
    .width('100%')
    .padding({ top: 24, left: 24, right: 24, bottom: 8 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BotanyNavItem {
  iconText: string = ''
  isSelected: boolean = false

  build() {
    Text(this.iconText)
      .fontSize(22)
      .opacity(this.isSelected ? 1.0 : 0.4)
      .fontColor(BotanyTextPrimary)
      .width(40)
      .height(40)
      .textAlign(TextAlign.Center)
  }
}

@Component
struct BotanyBottomBar {
  build() {
    Row() {
      BotanyNavItem({ iconText: '🏠', isSelected: true })
      BotanyNavItem({ iconText: '📅', isSelected: false })
      Blank().width(32)
      BotanyNavItem({ iconText: '🔔', isSelected: false })
      BotanyNavItem({ iconText: '⚙️', isSelected: false })
    }
    .width('100%')
    .backgroundColor(BotanyWhite)
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Entry
@Component
struct Index {
  private tasks: Task[] = [
    new Task(1, 'Watering', 'Monstera Deliciosa', 'calendar', 'Today'),
    new Task(2, 'Fertilize', 'Fiddle Leaf Fig', 'bell', 'Tomorrow'),
    new Task(3, 'Pruning', 'Snake Plant', 'settings', 'Next Week')
  ]

  private plants: Plant[] = [
    new Plant(1, 'Monstera', 'Monstera deliciosa', 'Living Room', 0),
    new Plant(2, 'Fiddle Leaf', 'Ficus lyrata', 'Bedroom', 2),
    new Plant(3, 'Snakey', 'Sansevieria', 'Hallway', 5),
    new Plant(4, 'Spider Plant', 'Chlorophytum', 'Kitchen', 1),
    new Plant(5, 'Peace Lily', 'Spathiphyllum', 'Bathroom', 3)
  ]

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        BotanyTopBar()

        Scroll() {
          Column() {
            // Header
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontColor(BotanyTextSecondary)
              Text('My Jungle')
                .fontSize(40)
                .fontWeight(FontWeight.Bold)
                .fontColor(BotanyTextPrimary)
                .letterSpacing(-1)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })

            // Pending Tasks Section
            Text('Pending Tasks')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(BotanyTextPrimary)
              .width('100%')
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })

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
            .width('100%')

            Blank().height(32)

            // Your Collection Section
            Text('Your Collection')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(BotanyTextPrimary)
              .width('100%')
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })

            Column({ space: 0 }) {
              ForEach(this.plants, (plant: Plant) => {
                PlantListItem({ plant: plant })
                  .margin({ left: 24, right: 24, top: 8, bottom: 8 })
              })
            }
            .width('100%')

            Blank().height(120)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .backgroundColor(BotanyWhite)

        BotanyBottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BotanyWhite)

      // FAB
      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 56, height: 56 })
          .fill(BotanyTextPrimary)
        Text('+')
          .fontSize(28)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 2 })
      }
      .width(56)
      .height(56)
      .margin({ right: 24, bottom: 90 })
    }
    .width('100%')
    .height('100%')
  }
}