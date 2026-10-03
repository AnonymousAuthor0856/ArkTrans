class Plant {
  id: number = 0
  name: string = ''
  scientificName: string = ''
  location: string = ''
  daysUntilWater: number = 0
  constructor(id: number, name: string, scientificName: string, location: string, daysUntilWater: number) {
    this.id = id
    this.name = name
    this.scientificName = scientificName
    this.location = location
    this.daysUntilWater = daysUntilWater
  }
}

class TaskInfo {
  id: number = 0
  title: string = ''
  plantName: string = ''
  icon: string = ''
  urgency: string = ''
  constructor(id: number, title: string, plantName: string, icon: string, urgency: string) {
    this.id = id
    this.title = title
    this.plantName = plantName
    this.icon = icon
    this.urgency = urgency
  }
}

@Component
struct TaskCardComponent {
  @State isChecked: boolean = false
  @Prop title: string = ''
  @Prop plantName: string = ''
  @Prop icon: string = ''
  @Prop urgency: string = ''

  build() {
    Column() {
      Row() {
        Column() {
          Text(this.icon)
            .fontSize(18)
            .fontColor(this.isChecked ? '#FFFFFF' : '#1A1C19')
        }
        .width(40)
        .height(40)
        .backgroundColor(this.isChecked ? '#2E5E4E' : '#FFFFFF')
        .borderRadius(20)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

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

        Text(this.isChecked ? 'DONE' : this.urgency)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? '#FFFFFF' : '#1A1C19')
          .backgroundColor(this.isChecked ? '#2E5E4E' : '#E0E0E0')
          .borderRadius(4)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width(160)
    .height(180)
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(24)
    .borderWidth(this.isChecked ? 2 : 1)
    .borderColor(this.isChecked ? '#2E5E4E' : '#EEEEEE')
    .justifyContent(FlexAlign.SpaceBetween)
    .onClick(() => {
      this.isChecked = !this.isChecked
    })
  }
}

@Component
struct PlantListItemComponent {
  @State expanded: boolean = false
  @Prop name: string = ''
  @Prop scientificName: string = ''
  @Prop location: string = ''
  @Prop daysUntilWater: number = 0

  build() {
    Row() {
      Column() {
        Text('♥')
          .fontSize(24)
          .fontColor(this.daysUntilWater === 0 ? '#2E5E4E' : '#CCCCCC')
      }
      .width(56)
      .height(56)
      .backgroundColor('#EEEEEE')
      .borderRadius(12)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

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
          Row() {
            Text('📍')
              .fontSize(12)
              .fontColor('#757575')
            Text(this.location)
              .fontSize(11)
              .fontColor('#757575')
              .margin({ left: 4 })
          }
          .alignItems(VerticalAlign.Center)
          .margin({ top: 8 })
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      Column() {
        if (this.daysUntilWater === 0) {
          Text('✓')
            .fontSize(22)
            .fontColor('#2E5E4E')
          Text('Water')
            .fontSize(11)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E5E4E')
        } else {
          Text(`${this.daysUntilWater} days`)
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
    .onClick(() => {
      this.expanded = !this.expanded
    })
  }
}

@Entry
@Component
struct BotanyApp {
  private tasks: TaskInfo[] = [
    new TaskInfo(1, 'Watering', 'Monstera Deliciosa', '📅', 'Today'),
    new TaskInfo(2, 'Fertilize', 'Fiddle Leaf Fig', '🔔', 'Tomorrow'),
    new TaskInfo(3, 'Pruning', 'Snake Plant', '⚙', 'Next Week'),
  ]
  private plants: Plant[] = [
    new Plant(1, 'Monstera', 'Monstera deliciosa', 'Living Room', 0),
    new Plant(2, 'Fiddle Leaf', 'Ficus lyrata', 'Bedroom', 2),
    new Plant(3, 'Snakey', 'Sansevieria', 'Hallway', 5),
    new Plant(4, 'Spider Plant', 'Chlorophytum', 'Kitchen', 1),
    new Plant(5, 'Peace Lily', 'Spathiphyllum', 'Bathroom', 3),
  ]

  build() {
    Stack() {
      Column() {
        Row() {
          Column() {
            Text('☰')
              .fontSize(20)
              .fontColor('#1A1C19')
          }
          .width(40)
          .height(40)
          .backgroundColor('#FAFAFA')
          .borderRadius(20)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)

          Column() {
            Text('🔍')
              .fontSize(20)
              .fontColor('#1A1C19')
          }
          .width(40)
          .height(40)
          .backgroundColor('#FAFAFA')
          .borderRadius(20)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .padding({ top: 24, bottom: 8, left: 24, right: 24 })
        .justifyContent(FlexAlign.SpaceBetween)

        Scroll() {
          Column() {
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontColor('#757575')
              Text('My Jungle')
                .fontSize(36)
                .fontWeight(FontWeight.Bold)
                .fontColor('#1A1C19')
            }
            .width('100%')
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })
            .alignItems(HorizontalAlign.Start)

            Text('Pending Tasks')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1A1C19')
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })

            Scroll() {
              Row() {
                ForEach(this.tasks, (task: TaskInfo) => {
                  TaskCardComponent({
                    title: task.title,
                    plantName: task.plantName,
                    icon: task.icon,
                    urgency: task.urgency
                  })
                }, (task: TaskInfo) => task.id.toString())
              }
              .padding({ left: 24, right: 24 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            Text('Your Collection')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1A1C19')
              .padding({ left: 24, right: 24, top: 20, bottom: 12 })

            ForEach(this.plants, (plant: Plant) => {
              Column() {
                PlantListItemComponent({
                  name: plant.name,
                  scientificName: plant.scientificName,
                  location: plant.location,
                  daysUntilWater: plant.daysUntilWater
                })
              }
              .padding({ left: 24, right: 24, top: 4, bottom: 4 })
            }, (plant: Plant) => plant.id.toString())
          }
          .width('100%')
          .padding({ bottom: 80 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        Row() {
          Text('🏠')
            .fontSize(24)
            .fontColor('#1A1C19')
          Text('📅')
            .fontSize(24)
            .fontColor('#1A1C19')
            .opacity(0.4)
          Text('🔔')
            .fontSize(24)
            .fontColor('#1A1C19')
            .opacity(0.4)
          Text('⚙')
            .fontSize(24)
            .fontColor('#1A1C19')
            .opacity(0.4)
        }
        .width('100%')
        .padding({ left: 48, right: 48, top: 24, bottom: 24 })
        .backgroundColor('#FFFFFF')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height('100%')

      Column() {
        Text('+')
          .fontSize(28)
          .fontColor('#FFFFFF')
      }
      .width(56)
      .height(56)
      .backgroundColor('#1A1C19')
      .borderRadius(28)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .position({ x: '42%', y: '88%' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}