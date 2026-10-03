@Entry
@Component
struct BotanyApp {
  @State tasks: Task[] = [
    { id: 1, title: 'Watering', plantName: 'Monstera Deliciosa', icon: $r('sys.media.ohos_ic_public_date'), urgency: 'Today', isChecked: false },
    { id: 2, title: 'Fertilize', plantName: 'Fiddle Leaf Fig', icon: $r('sys.media.ohos_ic_public_notification'), urgency: 'Tomorrow', isChecked: false },
    { id: 3, title: 'Pruning', plantName: 'Snake Plant', icon: $r('sys.media.ohos_ic_public_settings'), urgency: 'Next Week', isChecked: false }
  ]

  @State plants: Plant[] = [
    { id: 1, name: 'Monstera', scientificName: 'Monstera deliciosa', location: 'Living Room', daysUntilWater: 0, expanded: false },
    { id: 2, name: 'Fiddle Leaf', scientificName: 'Ficus lyrata', location: 'Bedroom', daysUntilWater: 2, expanded: false },
    { id: 3, name: 'Snakey', scientificName: 'Sansevieria', location: 'Hallway', daysUntilWater: 5, expanded: false },
    { id: 4, name: 'Spider Plant', scientificName: 'Chlorophytum', location: 'Kitchen', daysUntilWater: 1, expanded: false },
    { id: 5, name: 'Peace Lily', scientificName: 'Spathiphyllum', location: 'Bathroom', daysUntilWater: 3, expanded: false }
  ]

  private readonly BotanyWhite: Color = Color.White
  private readonly BotanySurface: Color = 0xFFFAFAFA
  private readonly BotanyTextPrimary: Color = 0xFF1A1C19
  private readonly BotanyTextSecondary: Color = 0xFF757575
  private readonly BotanyAccent: Color = 0xFF2E5E4E
  private readonly BotanyAccentLight: Color = 0xFFE8F5E9

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // Top Bar
        Row() {
          this.TopBarIcon($r('sys.media.ohos_ic_public_menu'))
          this.TopBarIcon($r('sys.media.ohos_ic_public_search'))
        }
        .width('100%')
        .padding({ top: 24, left: 24, right: 24, bottom: 8 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(this.BotanyWhite)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.BotanyWhite)

      Scroll() {
        Column() {
          Blank()
            .height(72)

          // Header
          Column() {
            Text('Good Morning,')
              .fontSize(16)
              .fontColor(this.BotanyTextSecondary)

            Text('My Jungle')
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.BotanyTextPrimary)
          }
          .width('100%')
          .padding({ left: 24, right: 24, top: 16, bottom: 16 })
          .alignItems(HorizontalAlign.Start)

          // Pending Tasks Section
          this.SectionHeader('Pending Tasks')

          // Horizontal scroll task cards
          Scroll() {
            Row({ space: 16 }) {
              ForEach(this.tasks, (task: Task, index: number) => {
                this.TaskCard(task, index)
              }, (task: Task) => task.id.toString())
            }
            .padding({ left: 24, right: 24 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .margin({ bottom: 32 })

          // Your Collection Section
          this.SectionHeader('Your Collection')

          // Plant list
          Column({ space: 8 }) {
            ForEach(this.plants, (plant: Plant, index: number) => {
              this.PlantListItem(plant, index)
            }, (plant: Plant) => plant.id.toString())
          }
          .padding({ left: 24, right: 24, bottom: 100 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)

      // Floating Action Button
      Column() {
        Blank()
        Row() {
          Blank()
          Stack({ alignContent: Alignment.Center }) {
            Circle()
              .width(56)
              .height(56)
              .fill(this.BotanyTextPrimary)
            Image($r('sys.media.ohos_ic_public_add'))
              .width(24)
              .height(24)
              .fillColor(Color.White)
          }
          .width(56)
          .height(56)
          .margin({ right: 24, bottom: 24 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)

      // Bottom Bar
      Column() {
        Blank()
        Row() {
          this.NavItem($r('sys.media.ohos_ic_public_home'), true)
          this.NavItem($r('sys.media.ohos_ic_public_date'), false)
          Blank().width(64)
          this.NavItem($r('sys.media.ohos_ic_public_notification'), false)
          this.NavItem($r('sys.media.ohos_ic_public_settings'), false)
        }
        .width('100%')
        .padding({ left: 48, right: 48, top: 24, bottom: 24 })
        .backgroundColor(this.BotanyWhite)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.BotanyWhite)
  }

  @Builder
  TopBarIcon(icon: Resource) {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(40)
        .height(40)
        .fill(this.BotanySurface)
      Image(icon)
        .width(20)
        .height(20)
        .fillColor(this.BotanyTextPrimary)
    }
    .width(40)
    .height(40)
  }

  @Builder
  SectionHeader(title: string) {
    Text(title)
      .fontSize(18)
      .fontWeight(FontWeight.Bold)
      .fontColor(this.BotanyTextPrimary)
      .width('100%')
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }

  @Builder
  TaskCard(task: Task, index: number) {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(40)
            .height(40)
            .fill(task.isChecked ? this.BotanyAccent : Color.White)
          Image(task.icon)
            .width(20)
            .height(20)
            .fillColor(task.isChecked ? Color.White : this.BotanyTextPrimary)
        }
        .width(40)
        .height(40)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      Blank()

      Column() {
        Text(task.title)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.BotanyTextPrimary)

        Text(task.plantName)
          .fontSize(12)
          .fontColor(this.BotanyTextSecondary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ top: 2 })

        // Status Chip
        Row() {
          Text(task.isChecked ? 'DONE' : task.urgency)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(task.isChecked ? Color.White : this.BotanyTextPrimary)
        }
        .padding({ left: 6, right: 6, top: 2, bottom: 2 })
        .backgroundColor(task.isChecked ? this.BotanyAccent : 0xFFE0E0E0)
        .borderRadius(4)
        .margin({ top: 8 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width(160)
    .height(180)
    .padding(16)
    .backgroundColor(this.BotanySurface)
    .borderRadius(24)
    .border({
      width: task.isChecked ? 2 : 1,
      color: task.isChecked ? this.BotanyAccent : 0xFFEEEEEE
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .onClick(() => {
      this.tasks[index].isChecked = !this.tasks[index].isChecked
    })
  }

  @Builder
  PlantListItem(plant: Plant, index: number) {
    Row() {
      // Image Placeholder
      Stack({ alignContent: Alignment.Center }) {
        Rect()
          .width(56)
          .height(56)
          .fill(0xFFEEEEEE)
          .radius(12)
        Image($r('sys.media.ohos_ic_public_favorite'))
          .width(24)
          .height(24)
          .fillColor(plant.daysUntilWater === 0 ? this.BotanyAccent : 0xFFCCCCCC)
      }
      .width(56)
      .height(56)

      // Plant info
      Column() {
        Text(plant.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.BotanyTextPrimary)

        Text(plant.scientificName)
          .fontSize(12)
          .fontColor(this.BotanyTextSecondary)
          .fontStyle(FontStyle.Italic)
          .margin({ top: 2 })

        if (plant.expanded) {
          Row() {
            Image($r('sys.media.ohos_ic_public_location'))
              .width(12)
              .height(12)
              .fillColor(this.BotanyTextSecondary)

            Text(plant.location)
              .fontSize(11)
              .fontColor(this.BotanyTextSecondary)
              .margin({ left: 4 })
          }
          .alignItems(VerticalAlign.Center)
          .margin({ top: 8 })
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      // Right side - water status
      Column() {
        if (plant.daysUntilWater === 0) {
          Image($r('sys.media.ohos_ic_public_selected'))
            .width(24)
            .height(24)
            .fillColor(this.BotanyAccent)

          Text('Water')
            .fontSize(11)
            .fontColor(this.BotanyAccent)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 2 })
        } else {
          Text(plant.daysUntilWater + ' days')
            .fontSize(11)
            .fontColor(this.BotanyTextSecondary)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(this.BotanySurface)
    .borderRadius(16)
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.plants[index].expanded = !this.plants[index].expanded
    })
  }

  @Builder
  NavItem(icon: Resource, isSelected: boolean) {
    Image(icon)
      .width(24)
      .height(24)
      .fillColor(this.BotanyTextPrimary)
      .opacity(isSelected ? 1 : 0.4)
      .padding(8)
      .onClick(() => {})
  }
}

interface Task {
  id: number
  title: string
  plantName: string
  icon: Resource
  urgency: string
  isChecked: boolean
}

interface Plant {
  id: number
  name: string
  scientificName: string
  location: string
  daysUntilWater: number
  expanded: boolean
}
