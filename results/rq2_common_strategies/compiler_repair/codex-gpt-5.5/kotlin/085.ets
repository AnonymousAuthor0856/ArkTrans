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
struct Index {
  @State taskOneDone: boolean = false
  @State taskTwoDone: boolean = false
  @State taskThreeDone: boolean = false
  @State expandedPlant: number = 0

  private tasks: PlantTask[] = [
    new PlantTask(1, 'Watering', 'Monstera Deliciosa', '□', 'Today'),
    new PlantTask(2, 'Fertilize', 'Fiddle Leaf Fig', '!', 'Tomorrow'),
    new PlantTask(3, 'Pruning', 'Snake Plant', '⚙', 'Next Week')
  ]

  private plants: Plant[] = [
    new Plant(1, 'Monstera', 'Monstera deliciosa', 'Living Room', 0),
    new Plant(2, 'Fiddle Leaf', 'Ficus lyrata', 'Bedroom', 2),
    new Plant(3, 'Snakey', 'Sansevieria', 'Hallway', 5),
    new Plant(4, 'Spider Plant', 'Chlorophytum', 'Kitchen', 1),
    new Plant(5, 'Peace Lily', 'Spathiphyllum', 'Bathroom', 3)
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.BotanyTopBar()
        Scroll() {
          Column() {
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontColor('#757575')
              Text('My Jungle')
                .fontSize(44)
                .fontWeight(FontWeight.Bold)
                .fontColor('#1A1C19')
                .margin({ top: 4 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })

            this.SectionHeader('Pending Tasks')
            Scroll() {
              Row() {
                ForEach(this.tasks, (task: PlantTask) => {
                  this.TaskCard(task)
                })
              }
              .padding({ left: 24, right: 8 })
            }
            .width('100%')
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .margin({ bottom: 32 })

            this.SectionHeader('Your Collection')
            ForEach(this.plants, (plant: Plant) => {
              this.PlantListItem(plant)
            })
          }
          .width('100%')
          .padding({ bottom: 112 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      this.BotanyBottomBar()
      Button('+')
        .fontSize(30)
        .fontColor(Color.White)
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor('#1A1C19')
        .padding(0)
        .margin({ bottom: 56 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  SectionHeader(title: string) {
    Text(title)
      .width('100%')
      .fontSize(18)
      .fontWeight(FontWeight.Bold)
      .fontColor('#1A1C19')
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
            .fill(this.isTaskDone(task.id) ? '#2E5E4E' : Color.White)
          Text(task.icon)
            .fontSize(20)
            .fontColor(this.isTaskDone(task.id) ? Color.White : '#1A1C19')
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      Column() {
        Text(task.title)
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1C19')
        Text(task.plantName)
          .fontSize(13)
          .fontColor('#757575')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(this.isTaskDone(task.id) ? 'DONE' : task.urgency)
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isTaskDone(task.id) ? Color.White : '#1A1C19')
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .borderRadius(4)
          .backgroundColor(this.isTaskDone(task.id) ? '#2E5E4E' : '#E0E0E0')
          .margin({ top: 8 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width(160)
    .height(180)
    .padding(16)
    .border({ width: this.isTaskDone(task.id) ? 2 : 1, color: this.isTaskDone(task.id) ? '#2E5E4E' : '#EEEEEE', radius: 24 })
    .backgroundColor('#FAFAFA')
    .justifyContent(FlexAlign.SpaceBetween)
    .margin({ right: 16 })
    .onClick(() => {
      this.toggleTask(task.id)
    })
  }

  @Builder
  PlantListItem(plant: Plant) {
    Row() {
      Stack() {
        Rect()
          .width(56)
          .height(56)
          .radius(12)
          .fill('#EEEEEE')
        Text('♥')
          .fontSize(24)
          .fontColor(plant.daysUntilWater === 0 ? '#2E5E4E' : '#CCCCCC')
      }
      .width(56)
      .height(56)

      Column() {
        Text(plant.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1C19')
        Text(plant.scientificName)
          .fontSize(13)
          .fontStyle(FontStyle.Italic)
          .fontColor('#757575')
        if (this.expandedPlant === plant.id) {
          Row() {
            Text('⌖')
              .fontSize(12)
              .fontColor('#757575')
            Text(plant.location)
              .fontSize(12)
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
        if (plant.daysUntilWater === 0) {
          Text('✓')
            .fontSize(24)
            .fontColor('#2E5E4E')
            .fontWeight(FontWeight.Bold)
          Text('Water')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E5E4E')
        } else {
          Text(plant.daysUntilWater.toString() + ' days')
            .fontSize(12)
            .fontColor('#757575')
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(16)
    .borderRadius(16)
    .backgroundColor('#FAFAFA')
    .alignItems(VerticalAlign.Center)
    .margin({ left: 24, right: 24, top: 8, bottom: 8 })
    .onClick(() => {
      this.expandedPlant = this.expandedPlant === plant.id ? 0 : plant.id
    })
  }

  @Builder
  BotanyTopBar() {
    Row() {
      Button('☰')
        .fontSize(20)
        .fontColor('#1A1C19')
        .backgroundColor('#FAFAFA')
        .width(40)
        .height(40)
        .borderRadius(20)
        .padding(0)
      Button('⌕')
        .fontSize(20)
        .fontColor('#1A1C19')
        .backgroundColor('#FAFAFA')
        .width(40)
        .height(40)
        .borderRadius(20)
        .padding(0)
    }
    .width('100%')
    .padding({ top: 24, left: 24, right: 24, bottom: 8 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BotanyBottomBar() {
    Row() {
      this.BotanyNavItem('⌂', true)
      this.BotanyNavItem('□', false)
      Blank().width(32)
      this.BotanyNavItem('!', false)
      this.BotanyNavItem('⚙', false)
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
  }

  @Builder
  BotanyNavItem(icon: string, selected: boolean) {
    Text(icon)
      .fontSize(24)
      .fontColor('#1A1C19')
      .opacity(selected ? 1 : 0.4)
  }

  isTaskDone(id: number): boolean {
    if (id === 1) {
      return this.taskOneDone
    }
    if (id === 2) {
      return this.taskTwoDone
    }
    return this.taskThreeDone
  }

  toggleTask(id: number): void {
    if (id === 1) {
      this.taskOneDone = !this.taskOneDone
    } else if (id === 2) {
      this.taskTwoDone = !this.taskTwoDone
    } else {
      this.taskThreeDone = !this.taskThreeDone
    }
  }
}
