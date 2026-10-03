const BOTANY_WHITE: string = '#FFFFFF'
const BOTANY_SURFACE: string = '#FAFAFA'
const BOTANY_TEXT_PRIMARY: string = '#1A1C19'
const BOTANY_TEXT_SECONDARY: string = '#757575'
const BOTANY_ACCENT: string = '#2E5E4E'
const BOTANY_BORDER: string = '#EEEEEE'
const BOTANY_CHIP: string = '#E0E0E0'

class PlantModel {
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

class TaskModel {
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

@Entry
@Component
struct BotanyApp {
  build() {
    Stack() {
      Column() {
        BotanyTopBar()

        Scroll() {
          BotanyContent()
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BOTANY_WHITE)

      Column() {
        Blank().layoutWeight(1)
        BotanyBottomBar()
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank().layoutWeight(1)

        Row() {
          Blank().layoutWeight(1)
          FloatingAddButton()
            .margin({ right: 32, bottom: 84 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BOTANY_WHITE)
  }
}

@Component
struct BotanyContent {
  private tasks: TaskModel[] = [
    new TaskModel(1, 'Watering', 'Monstera Deliciosa', '▣', 'Today'),
    new TaskModel(2, 'Fertilize', 'Fiddle Leaf Fig', '♟', 'Tomorrow'),
    new TaskModel(3, 'Pruning', 'Snake Plant', '⚙', 'Next Week')
  ]

  private plants: PlantModel[] = [
    new PlantModel(1, 'Monstera', 'Monstera deliciosa', 'Living Room', 0),
    new PlantModel(2, 'Fiddle Leaf', 'Ficus lyrata', 'Bedroom', 2),
    new PlantModel(3, 'Snakey', 'Sansevieria', 'Hallway', 5),
    new PlantModel(4, 'Spider Plant', 'Chlorophytum', 'Kitchen', 1),
    new PlantModel(5, 'Peace Lily', 'Spathiphyllum', 'Bathroom', 3)
  ]

  build() {
    Column() {
      Column() {
        Text('Good Morning,')
          .fontSize(16)
          .fontColor(BOTANY_TEXT_SECONDARY)

        Text('My Jungle')
          .fontSize(44)
          .fontWeight(FontWeight.Bold)
          .fontColor(BOTANY_TEXT_PRIMARY)
          .letterSpacing(-1)
          .lineHeight(54)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding({ left: 24, right: 24, top: 16, bottom: 20 })

      SectionHeader({ title: 'Pending Tasks' })

      Scroll() {
        Row({ space: 16 }) {
          ForEach(this.tasks, (task: TaskModel) => {
            TaskCard({ task: task })
          }, (task: TaskModel) => task.id.toString())
        }
        .padding({ left: 24, right: 24 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
      .height(184)

      Blank().height(32)

      SectionHeader({ title: 'Your Collection' })

      ForEach(this.plants, (plant: PlantModel) => {
        PlantListItem({ plant: plant })
      }, (plant: PlantModel) => plant.id.toString())

      Blank().height(112)
    }
    .width('100%')
    .backgroundColor(BOTANY_WHITE)
  }
}

@Component
struct SectionHeader {
  title: string = ''

  build() {
    Text(this.title)
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .fontColor(BOTANY_TEXT_PRIMARY)
      .width('100%')
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }
}

@Component
struct TaskCard {
  task: TaskModel = new TaskModel(0, '', '', '', '')
  @State isChecked: boolean = false

  build() {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Text(this.task.icon)
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isChecked ? BOTANY_WHITE : BOTANY_TEXT_PRIMARY)
        }
        .width(40)
        .height(40)
        .borderRadius(20)
        .backgroundColor(this.isChecked ? BOTANY_ACCENT : BOTANY_WHITE)

        Blank().layoutWeight(1)
      }
      .width('100%')

      Column() {
        Text(this.task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(BOTANY_TEXT_PRIMARY)

        Text(this.task.plantName)
          .fontSize(14)
          .fontColor(BOTANY_TEXT_SECONDARY)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Blank().height(8)

        Text(this.isChecked ? 'DONE' : this.task.urgency)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? BOTANY_WHITE : BOTANY_TEXT_PRIMARY)
          .padding({ left: 8, right: 8, top: 3, bottom: 3 })
          .backgroundColor(this.isChecked ? BOTANY_ACCENT : BOTANY_CHIP)
          .borderRadius(4)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width(160)
    .height(180)
    .padding(16)
    .backgroundColor(BOTANY_SURFACE)
    .borderRadius(24)
    .border({
      width: this.isChecked ? 2 : 1,
      color: this.isChecked ? BOTANY_ACCENT : BOTANY_BORDER
    })
    .onClick(() => {
      this.isChecked = !this.isChecked
    })
  }
}

@Component
struct PlantListItem {
  plant: PlantModel = new PlantModel(0, '', '', '', 0)
  @State expanded: boolean = false

  build() {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Text('♥')
            .fontSize(26)
            .fontColor(this.plant.daysUntilWater === 0 ? BOTANY_ACCENT : '#CCCCCC')
        }
        .width(56)
        .height(56)
        .borderRadius(12)
        .backgroundColor(BOTANY_BORDER)

        Blank().width(16)

        Column() {
          Text(this.plant.name)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(BOTANY_TEXT_PRIMARY)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Text(this.plant.scientificName)
            .fontSize(12)
            .fontStyle(FontStyle.Italic)
            .fontColor(BOTANY_TEXT_SECONDARY)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          if (this.expanded) {
            Blank().height(8)

            Row() {
              Text('⌖')
                .fontSize(12)
                .fontColor(BOTANY_TEXT_SECONDARY)

              Blank().width(4)

              Text(this.plant.location)
                .fontSize(11)
                .fontColor(BOTANY_TEXT_SECONDARY)
            }
            .alignItems(VerticalAlign.Center)
          }
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Column() {
          if (this.plant.daysUntilWater === 0) {
            Text('✓')
              .fontSize(30)
              .fontWeight(FontWeight.Bold)
              .fontColor(BOTANY_ACCENT)
              .lineHeight(26)

            Text('Water')
              .fontSize(11)
              .fontWeight(FontWeight.Bold)
              .fontColor(BOTANY_ACCENT)
          } else {
            Text(`${this.plant.daysUntilWater} days`)
              .fontSize(11)
              .fontColor(BOTANY_TEXT_SECONDARY)
          }
        }
        .alignItems(HorizontalAlign.End)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .padding(16)
      .borderRadius(16)
      .backgroundColor(BOTANY_SURFACE)
      .alignItems(VerticalAlign.Center)
      .onClick(() => {
        this.expanded = !this.expanded
      })
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 8, bottom: 8 })
  }
}

@Component
struct BotanyTopBar {
  build() {
    Row() {
      RoundIconButton({ icon: '☰', fontSize: 26 })
      RoundIconButton({ icon: '⌕', fontSize: 31 })
    }
    .width('100%')
    .padding({ top: 40, left: 24, right: 24, bottom: 8 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct RoundIconButton {
  icon: string = ''
  fontSize: number = 24

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text(this.icon)
        .fontSize(this.fontSize)
        .fontWeight(FontWeight.Bold)
        .fontColor(BOTANY_TEXT_PRIMARY)
    }
    .width(48)
    .height(48)
    .borderRadius(24)
    .backgroundColor(BOTANY_SURFACE)
    .onClick(() => {
    })
  }
}

@Component
struct BotanyBottomBar {
  build() {
    Row() {
      BotanyNavItem({ icon: '⌂', isSelected: true })
      BotanyNavItem({ icon: '▣', isSelected: false })

      Blank().width(32)

      BotanyNavItem({ icon: '♟', isSelected: false })
      BotanyNavItem({ icon: '⚙', isSelected: false })
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 18, bottom: 22 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(BOTANY_WHITE)
  }
}

@Component
struct BotanyNavItem {
  icon: string = ''
  isSelected: boolean = false

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text(this.icon)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(BOTANY_TEXT_PRIMARY)
        .opacity(this.isSelected ? 1 : 0.4)
    }
    .width(40)
    .height(40)
    .onClick(() => {
    })
  }
}

@Component
struct FloatingAddButton {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text('+')
        .fontSize(34)
        .fontWeight(FontWeight.Regular)
        .fontColor(BOTANY_WHITE)
        .lineHeight(36)
    }
    .width(56)
    .height(56)
    .borderRadius(28)
    .backgroundColor(BOTANY_TEXT_PRIMARY)
    .shadow({
      radius: 20,
      color: '#33000000',
      offsetX: 0,
      offsetY: 8
    })
    .onClick(() => {
    })
  }
}