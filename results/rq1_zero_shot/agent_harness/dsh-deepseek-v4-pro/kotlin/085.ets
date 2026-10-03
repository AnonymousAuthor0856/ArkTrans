interface Plant {
  id: number
  name: string
  scientificName: string
  location: string
  daysUntilWater: number
  isHealthy: boolean
}

interface Task {
  id: number
  title: string
  plantName: string
  icon: string
  urgency: string
}

const tasks: Task[] = [
  { id: 1, title: 'Watering', plantName: 'Monstera Deliciosa', icon: '🗓', urgency: 'Today' },
  { id: 2, title: 'Fertilize', plantName: 'Fiddle Leaf Fig', icon: '🔔', urgency: 'Tomorrow' },
  { id: 3, title: 'Pruning', plantName: 'Snake Plant', icon: '⚙', urgency: 'Next Week' }
]

const plants: Plant[] = [
  { id: 1, name: 'Monstera', scientificName: 'Monstera deliciosa', location: 'Living Room', daysUntilWater: 0, isHealthy: true },
  { id: 2, name: 'Fiddle Leaf', scientificName: 'Ficus lyrata', location: 'Bedroom', daysUntilWater: 2, isHealthy: true },
  { id: 3, name: 'Snakey', scientificName: 'Sansevieria', location: 'Hallway', daysUntilWater: 5, isHealthy: true },
  { id: 4, name: 'Spider Plant', scientificName: 'Chlorophytum', location: 'Kitchen', daysUntilWater: 1, isHealthy: true },
  { id: 5, name: 'Peace Lily', scientificName: 'Spathiphyllum', location: 'Bathroom', daysUntilWater: 3, isHealthy: true }
]

@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        BotanyTopBar()
        BotanyContent()
        BotanyBottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      Button({ type: ButtonType.Circle }) {
        Text('+').fontSize(24).fontColor('#FFFFFF')
      }
      .width(56).height(56)
      .backgroundColor('#1A1C19')
      .margin({ right: 24, bottom: 96 })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct BotanyContent {
  build() {
    Scroll() {
      Column() {
        Column() {
          Text('Good Morning,')
            .fontSize(16)
            .fontColor('#757575')
          Text('My Jungle')
            .fontSize(45)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(-1)
            .fontColor('#1A1C19')
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        .alignItems(HorizontalAlign.Start)

        SectionHeader({ title: 'Pending Tasks' })

        Scroll() {
          Row() {
            ForEach(tasks, (task: Task) => {
              TaskCard({ title: task.title, plantName: task.plantName, urgency: task.urgency, icon: task.icon })
            }, (task: Task) => task.id.toString())
          }
          .space(16)
          .padding({ left: 24, right: 24 })
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)

        Blank().height(32)

        SectionHeader({ title: 'Your Collection' })

        ForEach(plants, (plant: Plant) => {
          PlantListItem({
            name: plant.name,
            scientificName: plant.scientificName,
            location: plant.location,
            daysUntilWater: plant.daysUntilWater
          })
        }, (plant: Plant) => plant.id.toString())
      }
      .padding({ bottom: 80 })
    }
    .layoutWeight(1)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .scrollBar(BarState.Off)
  }
}

@Component
struct SectionHeader {
  @Prop title: string = ''

  build() {
    Text(this.title)
      .fontSize(16)
      .fontWeight(FontWeight.Bold)
      .fontColor('#1A1C19')
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }
}

@Component
struct TaskCard {
  @Prop title: string = ''
  @Prop plantName: string = ''
  @Prop urgency: string = ''
  @Prop icon: string = ''
  @State isChecked: boolean = false

  build() {
    Column() {
      Row() {
        Stack() {
          Text(this.icon)
            .fontSize(20)
            .fontColor(this.isChecked ? '#FFFFFF' : '#1A1C19')
        }
        .width(40).height(40)
        .borderRadius(20)
        .backgroundColor(this.isChecked ? '#2E5E4E' : '#FFFFFF')
        .alignContent(Alignment.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        Text(this.title)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1C19')
        Text(this.plantName)
          .fontSize(12)
          .fontColor('#757575')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Blank().height(8)

        Text(this.isChecked ? 'DONE' : this.urgency)
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? '#FFFFFF' : '#1A1C19')
          .backgroundColor(this.isChecked ? '#2E5E4E' : '#E0E0E0')
          .borderRadius(4)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      }
    }
    .width(160).height(180)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#FAFAFA')
    .borderRadius(24)
    .border({ width: this.isChecked ? 2 : 1, color: this.isChecked ? '#2E5E4E' : '#EEEEEE' })
    .onClick(() => { this.isChecked = !this.isChecked })
  }
}

@Component
struct PlantListItem {
  @Prop name: string = ''
  @Prop scientificName: string = ''
  @Prop location: string = ''
  @Prop daysUntilWater: number = 0
  @State expanded: boolean = false

  build() {
    Row() {
      Row() {
        Stack() {
          Text('♥')
            .fontSize(28)
            .fontColor(this.daysUntilWater == 0 ? '#2E5E4E' : '#CCCCCC')
        }
        .width(56).height(56)
        .borderRadius(12)
        .backgroundColor('#EEEEEE')
        .alignContent(Alignment.Center)

        Blank().width(16)

        Column() {
          Text(this.name)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1A1C19')
          Text(this.scientificName)
            .fontSize(12)
            .fontColor('#757575')
            .fontStyle(FontStyle.Italic)

          if (this.expanded) {
            Blank().height(8)
            Row() {
              Text('📍').fontSize(12).fontColor('#757575')
              Blank().width(4)
              Text(this.location).fontSize(11).fontColor('#757575')
            }
            .alignItems(VerticalAlign.Center)
          }
        }
        .layoutWeight(1)

        Column() {
          if (this.daysUntilWater == 0) {
            Text('✓').fontSize(24).fontColor('#2E5E4E')
            Text('Water')
              .fontSize(11)
              .fontColor('#2E5E4E')
              .fontWeight(FontWeight.Bold)
          } else {
            Text(this.daysUntilWater + ' days')
              .fontSize(11)
              .fontColor('#757575')
          }
        }
        .alignItems(HorizontalAlign.End)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FAFAFA')
      .borderRadius(16)
      .alignItems(VerticalAlign.Center)
      .onClick(() => { this.expanded = !this.expanded })
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 8, bottom: 8 })
  }
}

@Component
struct BotanyTopBar {
  build() {
    Row() {
      Button({ type: ButtonType.Circle }) {
        Text('≡').fontSize(20).fontColor('#1A1C19')
      }
      .width(40).height(40)
      .backgroundColor('#FAFAFA')

      Button({ type: ButtonType.Circle }) {
        Text('🔍').fontSize(20).fontColor('#1A1C19')
      }
      .width(40).height(40)
      .backgroundColor('#FAFAFA')
    }
    .width('100%')
    .padding({ top: 24, left: 24, right: 24, bottom: 8 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BotanyBottomBar {
  build() {
    Row() {
      BotanyNavItem({ icon: '⌂', isSelected: true })
      BotanyNavItem({ icon: '🗓', isSelected: false })
      Blank().width(32)
      BotanyNavItem({ icon: '🔔', isSelected: false })
      BotanyNavItem({ icon: '⚙', isSelected: false })
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct BotanyNavItem {
  @Prop icon: string = ''
  @Prop isSelected: boolean = false

  build() {
    Button({ type: ButtonType.Circle }) {
      Text(this.icon).fontSize(24).fontColor('#1A1C19')
    }
    .width(48).height(48)
    .backgroundColor('#00000000')
    .opacity(this.isSelected ? 1 : 0.4)
  }
}
