class BtColors {
  static readonly white: string = '#FFFFFFFF'
  static readonly surface: string = '#FFFAFAFA'
  static readonly textPrimary: string = '#FF1A1C19'
  static readonly textSecondary: string = '#FF757575'
  static readonly accent: string = '#FF2E5E4E'
  static readonly accentLight: string = '#FFE8F5E9'
  static readonly chipBg: string = '#FFE0E0E0'
  static readonly imgPlaceholder: string = '#FFEEEEEE'
  static readonly imgDisabled: string = '#FFCCCCCC'
}

class Plant {
  name: string
  scientificName: string
  location: string
  daysUntilWater: number

  constructor(name: string, scientificName: string, location: string, daysUntilWater: number) {
    this.name = name
    this.scientificName = scientificName
    this.location = location
    this.daysUntilWater = daysUntilWater
  }
}

class TaskItem {
  title: string
  plantName: string
  iconName: string
  urgency: string

  constructor(title: string, plantName: string, iconName: string, urgency: string) {
    this.title = title
    this.plantName = plantName
    this.iconName = iconName
    this.urgency = urgency
  }
}

@Entry
@Component
struct Index {
  @State selectedTab: number = 0

  private tasks: TaskItem[] = [
    new TaskItem('Watering', 'Monstera Deliciosa', '📅', 'Today'),
    new TaskItem('Fertilize', 'Fiddle Leaf Fig', '🔔', 'Tomorrow'),
    new TaskItem('Pruning', 'Snake Plant', '⚙', 'Next Week'),
  ]
  private plants: Plant[] = [
    new Plant('Monstera', 'Monstera deliciosa', 'Living Room', 0),
    new Plant('Fiddle Leaf', 'Ficus lyrata', 'Bedroom', 2),
    new Plant('Snakey', 'Sansevieria', 'Hallway', 5),
    new Plant('Spider Plant', 'Chlorophytum', 'Kitchen', 1),
    new Plant('Peace Lily', 'Spathiphyllum', 'Bathroom', 3),
  ]

  build() {
    Stack() {
      Column() {
        Row() {
          Text('☰')
            .fontSize(24)
            .fontColor(BtColors.textPrimary)
            .width(40)
            .height(40)
            .textAlign(TextAlign.Center)
            .backgroundColor(BtColors.surface)
            .borderRadius(20)

          Blank()

          Text('🔍')
            .fontSize(24)
            .fontColor(BtColors.textPrimary)
            .width(40)
            .height(40)
            .textAlign(TextAlign.Center)
            .backgroundColor(BtColors.surface)
            .borderRadius(20)
        }
        .padding({ left: 24, right: 24, top: 24, bottom: 8 })
        .backgroundColor(BtColors.white)

        Scroll() {
          Column() {
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontColor(BtColors.textSecondary)
              Text('My Jungle')
                .fontSize(34)
                .fontWeight(FontWeight.Bold)
                .fontColor(BtColors.textPrimary)
            }
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })
            .alignItems(HorizontalAlign.Start)

            Text('Pending Tasks')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(BtColors.textPrimary)
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })

            Scroll() {
              Row() {
                ForEach(this.tasks, (task: TaskItem) => {
                  TaskCard({
                    title: task.title, plantName: task.plantName,
                    iconName: task.iconName, urgency: task.urgency
                  })
                })
              }
              .padding({ left: 24, right: 24 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .margin({ bottom: 32 })

            Text('Your Collection')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(BtColors.textPrimary)
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })

            ForEach(this.plants, (plant: Plant) => {
              PlantListItem({
                pName: plant.name, pSciName: plant.scientificName,
                pLocation: plant.location, pDays: plant.daysUntilWater
              })
            })
          }
          .padding({ bottom: 80 })
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }

      Stack() {
        Row() {
          Blank()
          Text('+')
            .fontSize(24)
            .fontColor(BtColors.white)
            .width(56)
            .height(56)
            .textAlign(TextAlign.Center)
            .backgroundColor(BtColors.textPrimary)
            .borderRadius(28)
        }
        .padding({ right: 24, bottom: 96 })
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.Bottom)

      Stack() {
        Row() {
          NavItem({ iconName: '⌂', isSelected: this.selectedTab === 0 })
            .layoutWeight(1)
            .onClick(() => { this.selectedTab = 0 })
          NavItem({ iconName: '📅', isSelected: this.selectedTab === 1 })
            .layoutWeight(1)
            .onClick(() => { this.selectedTab = 1 })
          Blank().width(32)
          NavItem({ iconName: '🔔', isSelected: this.selectedTab === 2 })
            .layoutWeight(1)
            .onClick(() => { this.selectedTab = 2 })
          NavItem({ iconName: '⚙', isSelected: this.selectedTab === 3 })
            .layoutWeight(1)
            .onClick(() => { this.selectedTab = 3 })
        }
        .padding({ left: 48, right: 48, top: 24, bottom: 24 })
        .backgroundColor(BtColors.white)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.Bottom)
    }
    .backgroundColor(BtColors.white)
    .width('100%')
    .height('100%')
  }
}

@Component
struct TaskCard {
  @Prop title: string = ''
  @Prop plantName: string = ''
  @Prop iconName: string = ''
  @Prop urgency: string = ''
  @State isChecked: boolean = false

  build() {
    Column() {
      Row() {
        Stack() {
          Circle({ width: 40, height: 40 })
            .fill(this.isChecked ? BtColors.accent : BtColors.white)
          Text(this.iconName)
            .fontSize(20)
            .fontColor(this.isChecked ? BtColors.white : BtColors.textPrimary)
        }
        Blank()
      }

      Blank()

      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(BtColors.textPrimary)
        Text(this.plantName)
          .fontSize(12)
          .fontColor(BtColors.textSecondary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.isChecked ? 'DONE' : this.urgency)
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? BtColors.white : BtColors.textPrimary)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.isChecked ? BtColors.accent : BtColors.chipBg)
          .borderRadius(4)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
    .width(160)
    .height(180)
    .backgroundColor(BtColors.surface)
    .borderRadius(24)
    .border({ width: this.isChecked ? 2 : 1, color: this.isChecked ? BtColors.accent : BtColors.imgPlaceholder })
    .alignItems(HorizontalAlign.Start)
    .margin({ right: 16 })
    .onClick(() => {
      this.isChecked = !this.isChecked
    })
  }
}

@Component
struct PlantListItem {
  @Prop pName: string = ''
  @Prop pSciName: string = ''
  @Prop pLocation: string = ''
  @Prop pDays: number = 0
  @State expanded: boolean = false

  build() {
    Row() {
      Stack() {
        Column() {
          Blank()
        }
        .width(56)
        .height(56)
        .backgroundColor(BtColors.imgPlaceholder)
        .borderRadius(12)
        Text('♥')
          .fontSize(24)
          .fontColor(this.pDays === 0 ? BtColors.accent : BtColors.imgDisabled)
      }

      Column() {
        Text(this.pName)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(BtColors.textPrimary)
        Text(this.pSciName)
          .fontSize(12)
          .fontColor(BtColors.textSecondary)
          .fontStyle(FontStyle.Italic)

        if (this.expanded) {
          Row() {
            Text('📍')
              .fontSize(12)
              .fontColor(BtColors.textSecondary)
            Text(this.pLocation)
              .fontSize(11)
              .fontColor(BtColors.textSecondary)
              .margin({ left: 4 })
          }
          .margin({ top: 8 })
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      Column() {
        if (this.pDays === 0) {
          Text('☑')
            .fontSize(24)
            .fontColor(BtColors.accent)
          Text('Water')
            .fontSize(11)
            .fontWeight(FontWeight.Bold)
            .fontColor(BtColors.accent)
        } else {
          Text(`${this.pDays} days`)
            .fontSize(11)
            .fontColor(BtColors.textSecondary)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .padding(16)
    .backgroundColor(BtColors.surface)
    .borderRadius(16)
    .margin({ left: 24, right: 24, top: 8, bottom: 8 })
    .onClick(() => {
      this.expanded = !this.expanded
    })
  }
}

@Component
struct NavItem {
  @Prop iconName: string = ''
  @Prop isSelected: boolean = false

  build() {
    Text(this.iconName)
      .fontSize(24)
      .fontColor(BtColors.textPrimary)
      .opacity(this.isSelected ? 1.0 : 0.4)
      .textAlign(TextAlign.Center)
  }
}