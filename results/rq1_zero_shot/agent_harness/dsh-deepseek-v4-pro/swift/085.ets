// Translated from SwiftUI (Swift) to ArkTS (ArkUI)
// Source: BotanyApp
// Color(hex:) helper and static color palette replaced with inline hex strings.

@Entry
@Component
struct Index {
  build() {
    BotanyContentView()
  }
}

// MARK: - 2. Data Models
class Plant {
  id: number
  name: string
  scientificName: string
  location: string
  daysUntilWater: number
  isHealthy: boolean = true

  constructor(id: number, name: string, scientificName: string, location: string, daysUntilWater: number) {
    this.id = id
    this.name = name
    this.scientificName = scientificName
    this.location = location
    this.daysUntilWater = daysUntilWater
  }
}

class Task {
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

// MARK: - 4. Main Content View
@Component
struct BotanyContentView {
  tasks: Task[] = [
    new Task(1, 'Watering', 'Monstera Deliciosa', '📅', 'Today'),
    new Task(2, 'Fertilize', 'Fiddle Leaf Fig', '🔔', 'Tomorrow'),
    new Task(3, 'Pruning', 'Snake Plant', '⚙', 'Next Week')
  ]

  plants: Plant[] = [
    new Plant(1, 'Monstera', 'Monstera deliciosa', 'Living Room', 0),
    new Plant(2, 'Fiddle Leaf', 'Ficus lyrata', 'Bedroom', 2),
    new Plant(3, 'Snakey', 'Sansevieria', 'Hallway', 5),
    new Plant(4, 'Spider Plant', 'Chlorophytum', 'Kitchen', 1),
    new Plant(5, 'Peace Lily', 'Spathiphyllum', 'Bathroom', 3)
  ]

  build() {
    Stack() {
      Column() {
        BotanyTopBar()
          .padding({ top: 24, left: 24, right: 24, bottom: 8 })
          .backgroundColor('#FFFFFF')

        Scroll() {
          Column() {
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontColor('#757575')
              Text('My Jungle')
                .fontSize(34)
                .fontWeight(FontWeight.Bold)
                .letterSpacing(-1)
                .fontColor('#1A1C19')
            }
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })

            SectionHeader({ title: 'Pending Tasks' })

            Scroll() {
              Row({ space: 16 }) {
                ForEach(this.tasks, (task: Task) => {
                  TaskCard({ task: task })
                }, (task: Task) => task.id.toString())
              }
              .padding({ left: 24, right: 24 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .padding({ bottom: 32 })

            SectionHeader({ title: 'Your Collection' })

            ForEach(this.plants, (plant: Plant) => {
              PlantListItem({ plant: plant })
            }, (plant: Plant) => plant.id.toString())
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ bottom: 80 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      // Floating Action Button
      Button() {
        Text('+')
          .fontSize(24)
          .fontColor('#FFFFFF')
          .width(56)
          .height(56)
          .backgroundColor('#1A1C19')
          .borderRadius(28)
      }
      .onClick(() => {})
      .align(Alignment.BottomEnd)
      .margin({ right: 24, bottom: 96 })

      // Bottom Navigation Bar
      BotanyBottomBar()
        .align(Alignment.Bottom)
        .width('100%')
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 5, color: '#0D000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

// MARK: - 5. SectionHeader
@Component
struct SectionHeader {
  title: string = ''

  build() {
    Text(this.title)
      .fontSize(22)
      .fontWeight(FontWeight.Bold)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .fontColor('#1A1C19')
  }
}

// MARK: - 6. TaskCard
@Component
struct TaskCard {
  task: Task = new Task(0, '', '', '', '')
  @State isChecked: boolean = false

  build() {
    Column() {
      Row() {
        Stack() {
          Circle()
            .fill(this.isChecked ? '#2E5E4E' : '#FFFFFF')
            .width(40)
            .height(40)

          Text(this.task.iconName)
            .fontSize(20)
            .fontColor(this.isChecked ? '#FFFFFF' : '#1A1C19')
            .width(20)
            .height(20)
        }
        .width(40)
        .height(40)

        Blank()
      }
      .width('100%')

      Blank()

      Column() {
        Text(this.task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1C19')

        Text(this.task.plantName)
          .fontSize(12)
          .fontColor('#757575')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Blank().height(8)

        Text(this.isChecked ? 'DONE' : this.task.urgency)
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? '#FFFFFF' : '#1A1C19')
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.isChecked ? '#2E5E4E' : '#E0E0E0')
          .borderRadius(4)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width(160)
    .height(180)
    .backgroundColor('#FAFAFA')
    .borderRadius(24)
    .border({ width: this.isChecked ? 2 : 1, color: this.isChecked ? '#2E5E4E' : '#EEEEEE' })
    .onClick(() => { this.isChecked = !this.isChecked })
  }
}

// MARK: - 7. PlantListItem
@Component
struct PlantListItem {
  plant: Plant = new Plant(0, '', '', '', 0)
  @State expanded: boolean = false

  build() {
    Row() {
      Stack() {
        Column()
          .width(56)
          .height(56)
          .backgroundColor('#EEEEEE')
          .borderRadius(12)

        Text('❤')
          .fontColor(this.plant.daysUntilWater === 0 ? '#2E5E4E' : '#CCCCCC')
      }
      .width(56)
      .height(56)

      Blank().width(16)

      Column() {
        Text(this.plant.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1C19')

        Text(this.plant.scientificName)
          .fontSize(12)
          .fontColor('#757575')
          .fontStyle(FontStyle.Italic)

        if (this.expanded) {
          Blank().height(8)
          Row() {
            Text('📍')
              .fontSize(12)
              .fontColor('#757575')
            Blank().width(4)
            Text(this.plant.location)
              .fontSize(11)
              .fontColor('#757575')
          }
          .alignItems(VerticalAlign.Center)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column() {
        if (this.plant.daysUntilWater === 0) {
          Text('✅')
            .fontSize(24)
            .fontColor('#2E5E4E')
          Text('Water')
            .fontSize(11)
            .fontColor('#2E5E4E')
            .fontWeight(FontWeight.Bold)
        } else {
          Text(this.plant.daysUntilWater.toString() + ' days')
            .fontSize(11)
            .fontColor('#757575')
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(16)
    .margin({ left: 24, right: 24, top: 8, bottom: 8 })
    .onClick(() => { this.expanded = !this.expanded })
  }
}

// MARK: - 8. BotanyTopBar
@Component
struct BotanyTopBar {
  build() {
    Row() {
      Button() {
        Text('☰')
          .fontColor('#1A1C19')
          .width(40)
          .height(40)
          .backgroundColor('#FAFAFA')
          .borderRadius(20)
      }
      .onClick(() => {})

      Blank()

      Button() {
        Text('🔍')
          .fontColor('#1A1C19')
          .width(40)
          .height(40)
          .backgroundColor('#FAFAFA')
          .borderRadius(20)
      }
      .onClick(() => {})
    }
    .width('100%')
  }
}

// MARK: - 9. BotanyBottomBar
@Component
struct BotanyBottomBar {
  @State selectedTab: number = 0

  build() {
    Row() {
      BotanyNavItem({ iconName: '🏠', isSelected: this.selectedTab === 0 })
        .onClick(() => { this.selectedTab = 0 })
      BotanyNavItem({ iconName: '📅', isSelected: this.selectedTab === 1 })
        .onClick(() => { this.selectedTab = 1 })
      Blank().width(32)
      BotanyNavItem({ iconName: '🔔', isSelected: this.selectedTab === 2 })
        .onClick(() => { this.selectedTab = 2 })
      BotanyNavItem({ iconName: '⚙', isSelected: this.selectedTab === 3 })
        .onClick(() => { this.selectedTab = 3 })
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .backgroundColor('#FFFFFF')
  }
}

// MARK: - 10. BotanyNavItem
@Component
struct BotanyNavItem {
  iconName: string = ''
  isSelected: boolean = false

  build() {
    Button() {
      Text(this.iconName)
        .fontSize(22)
        .fontColor('#1A1C19')
        .opacity(this.isSelected ? 1.0 : 0.4)
    }
    .onClick(() => {})
    .layoutWeight(1)
  }
}
