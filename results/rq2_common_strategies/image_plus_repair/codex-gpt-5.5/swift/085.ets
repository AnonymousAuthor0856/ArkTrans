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

  constructor(id: number, name: string, scientificName: string, location: string, daysUntilWater: number) {
    this.id = id
    this.name = name
    this.scientificName = scientificName
    this.location = location
    this.daysUntilWater = daysUntilWater
  }
}

class TaskModel {
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
struct BotanyContentView {
  private tasks: TaskModel[] = [
    new TaskModel(1, 'Watering', 'Monstera Deliciosa', 'calendar', 'Today'),
    new TaskModel(2, 'Fertilize', 'Fiddle Leaf Fig', 'bell', 'Tomorrow'),
    new TaskModel(3, 'Pruning', 'Snake Plant', 'gear', 'Next Week')
  ]

  private plants: PlantModel[] = [
    new PlantModel(1, 'Monstera', 'Monstera deliciosa', 'Living Room', 0),
    new PlantModel(2, 'Fiddle Leaf', 'Ficus lyrata', 'Bedroom', 2),
    new PlantModel(3, 'Snakey', 'Sansevieria', 'Hallway', 5),
    new PlantModel(4, 'Spider Plant', 'Chlorophytum', 'Kitchen', 1),
    new PlantModel(5, 'Peace Lily', 'Spathiphyllum', 'Bathroom', 3)
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        BotanyTopBar()
          .padding({ top: 24, left: 24, right: 24, bottom: 8 })
          .backgroundColor(BOTANY_WHITE)

        Scroll() {
          Column() {
            Column({ space: 0 }) {
              Text('Good Morning,')
                .fontSize(17)
                .fontWeight(FontWeight.Regular)
                .fontColor(BOTANY_TEXT_SECONDARY)
                .lineHeight(26)

              Text('My Jungle')
                .fontSize(34)
                .fontWeight(FontWeight.Bold)
                .fontColor(BOTANY_TEXT_PRIMARY)
                .lineHeight(42)
                .margin({ top: 1 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })

            SectionHeader({ title: 'Pending Tasks' })

            Scroll() {
              Row({ space: 16 }) {
                ForEach(this.tasks, (task: TaskModel) => {
                  TaskCard({ task: task })
                }, (task: TaskModel) => task.id.toString())
              }
              .padding({ left: 24, right: 24 })
            }
            .width('100%')
            .height(184)
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .margin({ bottom: 32 })

            SectionHeader({ title: 'Your Collection' })

            ForEach(this.plants, (plant: PlantModel) => {
              PlantListItem({ plant: plant })
            }, (plant: PlantModel) => plant.id.toString())
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ bottom: 80 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BOTANY_WHITE)

      Button({ type: ButtonType.Circle }) {
        Text('+')
          .fontSize(42)
          .fontWeight(FontWeight.Regular)
          .fontColor(BOTANY_WHITE)
          .lineHeight(54)
          .translate({ y: -3 })
      }
      .width(56)
      .height(56)
      .padding(0)
      .backgroundColor(BOTANY_TEXT_PRIMARY)
      .stateEffect(false)
      .position({ x: 295, y: 515 })
      .zIndex(2)

      BotanyBottomBar()
        .width('100%')
        .height(74)
        .backgroundColor(BOTANY_WHITE)
        .shadow({ radius: 10, color: '#0D000000', offsetX: 0, offsetY: -2 })
        .zIndex(3)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BOTANY_WHITE)
  }
}

@Component
struct SectionHeader {
  title: string = ''

  build() {
    Text(this.title)
      .fontSize(22)
      .fontWeight(FontWeight.Bold)
      .fontColor(BOTANY_TEXT_PRIMARY)
      .lineHeight(31)
      .width('100%')
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }
}

@Component
struct TaskCard {
  task: TaskModel = new TaskModel(0, '', '', 'calendar', '')
  @State isChecked: boolean = false

  build() {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(40)
            .height(40)
            .fill(this.isChecked ? BOTANY_ACCENT : BOTANY_WHITE)

          TaskIcon({ iconName: this.task.iconName, color: this.isChecked ? BOTANY_WHITE : BOTANY_TEXT_PRIMARY })
        }
        .width(40)
        .height(40)

        Blank()
      }
      .width('100%')

      Blank()

      Column({ space: 0 }) {
        Text(this.task.title)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(BOTANY_TEXT_PRIMARY)
          .lineHeight(24)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.task.plantName)
          .fontSize(13)
          .fontColor(BOTANY_TEXT_SECONDARY)
          .lineHeight(18)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.isChecked ? 'DONE' : this.task.urgency)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? BOTANY_WHITE : BOTANY_TEXT_PRIMARY)
          .lineHeight(16)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.isChecked ? BOTANY_ACCENT : BOTANY_CHIP)
          .borderRadius(4)
          .margin({ top: 8 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width(160)
    .height(180)
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(BOTANY_SURFACE)
    .borderRadius(24)
    .border({
      width: this.isChecked ? 2 : 1,
      color: this.isChecked ? BOTANY_ACCENT : BOTANY_BORDER,
      radius: 24
    })
    .onClick(() => {
      this.isChecked = !this.isChecked
    })
  }
}

@Component
struct TaskIcon {
  iconName: string = 'calendar'
  color: string = BOTANY_TEXT_PRIMARY

  build() {
    if (this.iconName === 'calendar') {
      CalendarIcon({ color: this.color })
    } else if (this.iconName === 'bell') {
      BellIcon({ color: this.color })
    } else {
      Text('⚙')
        .fontSize(21)
        .fontColor(this.color)
        .fontWeight(FontWeight.Bold)
        .lineHeight(22)
    }
  }
}

@Component
struct PlantListItem {
  plant: PlantModel = new PlantModel(0, '', '', '', 0)
  @State expanded: boolean = false

  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Rect()
          .width(56)
          .height(56)
          .fill('#EEEEEE')
          .radius(12)

        Text('♥')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.plant.daysUntilWater === 0 ? BOTANY_ACCENT : '#CCCCCC')
          .lineHeight(28)
      }
      .width(56)
      .height(56)

      Column({ space: 0 }) {
        Text(this.plant.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(BOTANY_TEXT_PRIMARY)
          .lineHeight(23)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.plant.scientificName)
          .fontSize(13)
          .fontColor(BOTANY_TEXT_SECONDARY)
          .fontStyle(FontStyle.Italic)
          .lineHeight(18)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        if (this.expanded) {
          Row({ space: 4 }) {
            Text('●')
              .fontSize(8)
              .fontColor(BOTANY_TEXT_SECONDARY)
              .lineHeight(12)

            Text(this.plant.location)
              .fontSize(11)
              .fontColor(BOTANY_TEXT_SECONDARY)
              .lineHeight(14)
          }
          .margin({ top: 8 })
          .alignItems(VerticalAlign.Center)
        }
      }
      .layoutWeight(1)
      .margin({ left: 16 })
      .alignItems(HorizontalAlign.Start)

      Column({ space: 2 }) {
        if (this.plant.daysUntilWater === 0) {
          Text('✓')
            .fontSize(23)
            .fontWeight(FontWeight.Bold)
            .fontColor(BOTANY_ACCENT)
            .lineHeight(24)

          Text('Water')
            .fontSize(11)
            .fontWeight(FontWeight.Bold)
            .fontColor(BOTANY_ACCENT)
            .lineHeight(14)
        } else {
          Text(this.plant.daysUntilWater.toString() + ' days')
            .fontSize(11)
            .fontColor(BOTANY_TEXT_SECONDARY)
            .lineHeight(14)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .width(327)
    .height(this.expanded ? 108 : 88)
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(BOTANY_SURFACE)
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
      RoundIconButton({ iconType: 'menu' })

      Blank()

      RoundIconButton({ iconType: 'search' })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct RoundIconButton {
  iconType: string = 'menu'

  build() {
    Button({ type: ButtonType.Circle }) {
      Stack({ alignContent: Alignment.Center }) {
        if (this.iconType === 'menu') {
          MenuIcon()
        } else {
          SearchIcon()
        }
      }
      .width(40)
      .height(40)
    }
    .width(40)
    .height(40)
    .padding(0)
    .backgroundColor(BOTANY_SURFACE)
    .stateEffect(false)
  }
}

@Component
struct BotanyBottomBar {
  @State selectedTab: number = 0

  build() {
    Row() {
      NavItem({ iconType: 'home', isSelected: this.selectedTab === 0 })
        .onClick(() => {
          this.selectedTab = 0
        })

      NavItem({ iconType: 'calendar', isSelected: this.selectedTab === 1 })
        .onClick(() => {
          this.selectedTab = 1
        })

      Blank()
        .width(32)

      NavItem({ iconType: 'bell', isSelected: this.selectedTab === 2 })
        .onClick(() => {
          this.selectedTab = 2
        })

      NavItem({ iconType: 'gear', isSelected: this.selectedTab === 3 })
        .onClick(() => {
          this.selectedTab = 3
        })
    }
    .width('100%')
    .height(74)
    .padding({ left: 48, right: 48, top: 18, bottom: 18 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(BOTANY_WHITE)
  }
}

@Component
struct NavItem {
  iconType: string = 'home'
  isSelected: boolean = false

  build() {
    Stack({ alignContent: Alignment.Center }) {
      if (this.iconType === 'home') {
        Text('⌂')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(BOTANY_TEXT_PRIMARY)
          .opacity(this.isSelected ? 1 : 0.4)
          .lineHeight(34)
      } else if (this.iconType === 'calendar') {
        CalendarIcon({ color: BOTANY_TEXT_PRIMARY, opacityValue: this.isSelected ? 1 : 0.4 })
      } else if (this.iconType === 'bell') {
        BellIcon({ color: BOTANY_TEXT_PRIMARY, opacityValue: this.isSelected ? 1 : 0.4 })
      } else {
        Text('⚙')
          .fontSize(29)
          .fontWeight(FontWeight.Bold)
          .fontColor(BOTANY_TEXT_PRIMARY)
          .opacity(this.isSelected ? 1 : 0.4)
          .lineHeight(30)
      }
    }
    .layoutWeight(1)
    .height(38)
  }
}

@Component
struct MenuIcon {
  build() {
    Column({ space: 4 }) {
      Rect().width(18).height(2.5).radius(2).fill(BOTANY_TEXT_PRIMARY)
      Rect().width(18).height(2.5).radius(2).fill(BOTANY_TEXT_PRIMARY)
      Rect().width(18).height(2.5).radius(2).fill(BOTANY_TEXT_PRIMARY)
    }
    .width(24)
    .height(18)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct SearchIcon {
  build() {
    Stack() {
      Circle()
        .width(20)
        .height(20)
        .fill(Color.Transparent)
        .stroke(BOTANY_TEXT_PRIMARY)
        .strokeWidth(2.6)
        .position({ x: 1, y: 1 })

      Rect()
        .width(12)
        .height(3)
        .radius(2)
        .fill(BOTANY_TEXT_PRIMARY)
        .rotate({ angle: 45 })
        .position({ x: 18, y: 19 })
    }
    .width(32)
    .height(32)
  }
}

@Component
struct CalendarIcon {
  color: string = BOTANY_TEXT_PRIMARY
  opacityValue: number = 1

  build() {
    Stack() {
      Rect()
        .width(22)
        .height(19)
        .fill(Color.Transparent)
        .stroke(this.color)
        .strokeWidth(2.2)
        .radius(3)
        .opacity(this.opacityValue)
        .position({ x: 1, y: 3 })

      Row({ space: 3 }) {
        Column({ space: 3 }) {
          Rect().width(3).height(3).radius(1).fill(this.color).opacity(this.opacityValue)
          Rect().width(3).height(3).radius(1).fill(this.color).opacity(this.opacityValue)
          Rect().width(3).height(3).radius(1).fill(this.color).opacity(this.opacityValue)
        }

        Column({ space: 3 }) {
          Rect().width(3).height(3).radius(1).fill(this.color).opacity(this.opacityValue)
          Rect().width(3).height(3).radius(1).fill(this.color).opacity(this.opacityValue)
          Rect().width(3).height(3).radius(1).fill(this.color).opacity(this.opacityValue)
        }

        Column({ space: 3 }) {
          Rect().width(3).height(3).radius(1).fill(this.color).opacity(this.opacityValue)
          Rect().width(3).height(3).radius(1).fill(this.color).opacity(this.opacityValue)
          Rect().width(3).height(3).radius(1).fill(this.color).opacity(this.opacityValue)
        }
      }
      .position({ x: 6, y: 8 })
    }
    .width(24)
    .height(24)
  }
}

@Component
struct BellIcon {
  color: string = BOTANY_TEXT_PRIMARY
  opacityValue: number = 1

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text('♟')
        .fontSize(28)
        .fontColor(this.color)
        .opacity(this.opacityValue)
        .rotate({ angle: 180 })
        .lineHeight(28)
        .translate({ y: -1 })

      Circle()
        .width(4)
        .height(4)
        .fill(this.color)
        .opacity(this.opacityValue)
        .translate({ y: 11 })
    }
    .width(24)
    .height(24)
  }
}
