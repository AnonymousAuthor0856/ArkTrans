class Plant {
  id: number
  name: string
  scientificName: string
  location: string
  daysUntilWater: number
  isHealthy: boolean

  constructor(
    id: number,
    name: string,
    scientificName: string,
    location: string,
    daysUntilWater: number,
    isHealthy: boolean = true
  ) {
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
  icon: string
  urgency: string

  constructor(id: number, title: string, plantName: string, icon: string, urgency: string) {
    this.id = id
    this.title = title
    this.plantName = plantName
    this.icon = icon
    this.urgency = urgency
  }
}

const BotanyWhite: string = '#FFFFFFFF'
const BotanySurface: string = '#FFFAFAFA'
const BotanyTextPrimary: string = '#FF1A1C19'
const BotanyTextSecondary: string = '#FF757575'
const BotanyAccent: string = '#FF2E5E4E'
const BotanyAccentLight: string = '#FFE8F5E9'

@Component
struct SectionHeader {
  title: string = ''

  build() {
    Text(this.title)
      .fontSize(18)
      .fontWeight(FontWeight.Bold)
      .fontColor(BotanyTextPrimary)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }
}

@Component
struct TaskCard {
  task: Task = new Task(0, '', '', '', '')
  @State isChecked: boolean = false

  build() {
    Column() {
      Row() {
        Stack() {
          Text(this.task.icon)
            .fontSize(20)
            .fontColor(this.isChecked ? BotanyWhite : BotanyTextPrimary)
        }
        .width(40)
        .height(40)
        .borderRadius(20)
        .backgroundColor(this.isChecked ? BotanyAccent : BotanyWhite)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

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
          .margin({ top: 2 })

        Blank()
          .height(8)

        Stack() {
          Text(this.isChecked ? 'DONE' : this.task.urgency)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isChecked ? BotanyWhite : BotanyTextPrimary)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
        }
        .borderRadius(4)
        .backgroundColor(this.isChecked ? BotanyAccent : '#FFE0E0E0')
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .width(160)
    .height(180)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(BotanySurface)
    .borderRadius(24)
    .border({
      width: this.isChecked ? 2 : 1,
      color: this.isChecked ? BotanyAccent : '#FFEEEEEE'
    })
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
      Stack() {
        Text('♥')
          .fontSize(24)
          .fontColor(this.plant.daysUntilWater === 0 ? BotanyAccent : '#FFCCCCCC')
      }
      .width(56)
      .height(56)
      .borderRadius(12)
      .backgroundColor('#FFEEEEEE')

      Blank()
        .width(16)

      Column() {
        Text(this.plant.name)
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyTextPrimary)

        Text(this.plant.scientificName)
          .fontSize(12)
          .fontColor(BotanyTextSecondary)
          .fontStyle(FontStyle.Italic)
          .margin({ top: 2 })

        if (this.expanded) {
          Blank()
            .height(8)

          Row() {
            Text('📍')
              .fontSize(12)
              .fontColor(BotanyTextSecondary)

            Blank()
              .width(4)

            Text(this.plant.location)
              .fontSize(11)
              .fontColor(BotanyTextSecondary)
          }
          .alignItems(VerticalAlign.Center)
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Column() {
        if (this.plant.daysUntilWater === 0) {
          Text('✓')
            .fontSize(24)
            .fontColor(BotanyAccent)

          Text('Water')
            .fontSize(11)
            .fontWeight(FontWeight.Bold)
            .fontColor(BotanyAccent)
        } else {
          Text(`${this.plant.daysUntilWater} days`)
            .fontSize(11)
            .fontColor(BotanyTextSecondary)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(BotanySurface)
    .borderRadius(16)
    .margin({ left: 24, right: 24, top: 8, bottom: 8 })
    .onClick(() => {
      this.expanded = !this.expanded
    })
  }
}

@Component
struct BotanyTopBar {
  build() {
    Row() {
      Button({ type: ButtonType.Circle }) {
        Text('☰')
          .fontSize(22)
          .fontColor(BotanyTextPrimary)
      }
      .width(40)
      .height(40)
      .backgroundColor(BotanySurface)

      Button({ type: ButtonType.Circle }) {
        Text('⌕')
          .fontSize(24)
          .fontColor(BotanyTextPrimary)
      }
      .width(40)
      .height(40)
      .backgroundColor(BotanySurface)
    }
    .width('100%')
    .padding({ top: 24, left: 24, right: 24, bottom: 8 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(BotanyWhite)
  }
}

@Component
struct BotanyNavItem {
  icon: string = ''
  isSelected: boolean = false

  build() {
    Button({ type: ButtonType.Circle }) {
      Text(this.icon)
        .fontSize(22)
        .fontColor(BotanyTextPrimary)
        .opacity(this.isSelected ? 1.0 : 0.4)
    }
    .width(48)
    .height(48)
    .backgroundColor(Color.Transparent)
  }
}

@Component
struct BotanyBottomBar {
  build() {
    Row() {
      BotanyNavItem({ icon: '⌂', isSelected: true })
      BotanyNavItem({ icon: '◷', isSelected: false })

      Blank()
        .width(32)

      BotanyNavItem({ icon: '🔔', isSelected: false })
      BotanyNavItem({ icon: '⚙', isSelected: false })
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(BotanyWhite)
  }
}

@Component
struct BotanyContent {
  private tasks: Task[] = [
    new Task(1, 'Watering', 'Monstera Deliciosa', '◷', 'Today'),
    new Task(2, 'Fertilize', 'Fiddle Leaf Fig', '🔔', 'Tomorrow'),
    new Task(3, 'Pruning', 'Snake Plant', '⚙', 'Next Week')
  ]

  private plants: Plant[] = [
    new Plant(1, 'Monstera', 'Monstera deliciosa', 'Living Room', 0),
    new Plant(2, 'Fiddle Leaf', 'Ficus lyrata', 'Bedroom', 2),
    new Plant(3, 'Snakey', 'Sansevieria', 'Hallway', 5),
    new Plant(4, 'Spider Plant', 'Chlorophytum', 'Kitchen', 1),
    new Plant(5, 'Peace Lily', 'Spathiphyllum', 'Bathroom', 3)
  ]

  build() {
    List() {
      ListItem() {
        Column() {
          Text('Good Morning,')
            .fontSize(16)
            .fontColor(BotanyTextSecondary)

          Text('My Jungle')
            .fontSize(44)
            .fontWeight(FontWeight.Bold)
            .fontColor(BotanyTextPrimary)
            .letterSpacing(-1)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
      }

      ListItem() {
        Column() {
          SectionHeader({ title: 'Pending Tasks' })

          Scroll() {
            Row() {
              ForEach(this.tasks, (task: Task) => {
                TaskCard({ task: task })
                  .margin({ right: 16 })
              }, (task: Task) => task.id.toString())
            }
            .padding({ left: 24, right: 8 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Blank()
            .height(32)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }

      ListItem() {
        SectionHeader({ title: 'Your Collection' })
      }

      ForEach(this.plants, (plant: Plant) => {
        ListItem() {
          PlantListItem({ plant: plant })
        }
      }, (plant: Plant) => plant.id.toString())

      ListItem() {
        Blank()
          .height(80)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BotanyWhite)
    .edgeEffect(EdgeEffect.None)
    .scrollBar(BarState.Off)
  }
}

@Entry
@Component
struct BotanyApp {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        BotanyTopBar()

        BotanyContent()
          .layoutWeight(1)

        BotanyBottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BotanyWhite)

      Button({ type: ButtonType.Circle }) {
        Text('+')
          .fontSize(30)
          .fontWeight(FontWeight.Normal)
          .fontColor(BotanyWhite)
      }
      .width(56)
      .height(56)
      .backgroundColor(BotanyTextPrimary)
      .margin({ right: 24, bottom: 78 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BotanyWhite)
  }
}