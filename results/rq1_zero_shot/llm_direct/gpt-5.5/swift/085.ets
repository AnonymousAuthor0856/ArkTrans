class BotanyColors {
  static readonly WHITE: string = '#FFFFFF'
  static readonly SURFACE: string = '#FAFAFA'
  static readonly TEXT_PRIMARY: string = '#1A1C19'
  static readonly TEXT_SECONDARY: string = '#757575'
  static readonly ACCENT: string = '#2E5E4E'
  static readonly ACCENT_LIGHT: string = '#E8F5E9'
  static readonly LIGHT_GREY: string = '#EEEEEE'
  static readonly MID_GREY: string = '#E0E0E0'
  static readonly ICON_GREY: string = '#CCCCCC'
}

interface Plant {
  id: number
  name: string
  scientificName: string
  location: string
  daysUntilWater: number
  isHealthy: boolean
}

interface PlantTask {
  id: number
  title: string
  plantName: string
  iconName: string
  urgency: string
}

function iconGlyph(iconName: string): string {
  switch (iconName) {
    case 'line.horizontal.3':
      return '☰'
    case 'magnifyingglass':
      return '⌕'
    case 'plus':
      return '+'
    case 'calendar':
      return '□'
    case 'bell.fill':
      return '●'
    case 'gearshape.fill':
      return '⚙'
    case 'heart.fill':
      return '♥'
    case 'location.fill':
      return '◆'
    case 'checkmark.circle.fill':
      return '✓'
    case 'house.fill':
      return '⌂'
    default:
      return '•'
  }
}

@Entry
@Component
struct BotanyApp {
  private tasks: PlantTask[] = [
    { id: 1, title: 'Watering', plantName: 'Monstera Deliciosa', iconName: 'calendar', urgency: 'Today' },
    { id: 2, title: 'Fertilize', plantName: 'Fiddle Leaf Fig', iconName: 'bell.fill', urgency: 'Tomorrow' },
    { id: 3, title: 'Pruning', plantName: 'Snake Plant', iconName: 'gearshape.fill', urgency: 'Next Week' }
  ]

  private plants: Plant[] = [
    {
      id: 1,
      name: 'Monstera',
      scientificName: 'Monstera deliciosa',
      location: 'Living Room',
      daysUntilWater: 0,
      isHealthy: true
    },
    {
      id: 2,
      name: 'Fiddle Leaf',
      scientificName: 'Ficus lyrata',
      location: 'Bedroom',
      daysUntilWater: 2,
      isHealthy: true
    },
    {
      id: 3,
      name: 'Snakey',
      scientificName: 'Sansevieria',
      location: 'Hallway',
      daysUntilWater: 5,
      isHealthy: true
    },
    {
      id: 4,
      name: 'Spider Plant',
      scientificName: 'Chlorophytum',
      location: 'Kitchen',
      daysUntilWater: 1,
      isHealthy: true
    },
    {
      id: 5,
      name: 'Peace Lily',
      scientificName: 'Spathiphyllum',
      location: 'Bathroom',
      daysUntilWater: 3,
      isHealthy: true
    }
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        BotanyTopBar()
          .padding({ top: 24, left: 24, right: 24, bottom: 8 })
          .backgroundColor(BotanyColors.WHITE)

        Scroll() {
          Column() {
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontColor(BotanyColors.TEXT_SECONDARY)

              Text('My Jungle')
                .fontSize(34)
                .fontWeight(FontWeight.Bold)
                .letterSpacing(-1)
                .fontColor(BotanyColors.TEXT_PRIMARY)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })

            SectionHeader({ title: 'Pending Tasks' })

            Scroll() {
              Row() {
                ForEach(this.tasks, (task: PlantTask) => {
                  TaskCard({ task: task })
                }, (task: PlantTask) => task.id.toString())
              }
              .padding({ left: 24, right: 24 })
              .gap(16)
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .padding({ bottom: 32 })

            SectionHeader({ title: 'Your Collection' })

            ForEach(this.plants, (plant: Plant) => {
              PlantListItem({ plant: plant })
            }, (plant: Plant) => plant.id.toString())
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({ bottom: 80 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BotanyColors.WHITE)

      Column() {
        Blank()
          .layoutWeight(1)

        Row() {
          Blank()
            .layoutWeight(1)

          Stack() {
            Text(iconGlyph('plus'))
              .fontSize(30)
              .fontWeight(FontWeight.Normal)
              .fontColor(BotanyColors.WHITE)
          }
          .width(56)
          .height(56)
          .backgroundColor(BotanyColors.TEXT_PRIMARY)
          .borderRadius(28)
          .onClick(() => {
          })
        }
        .width('100%')
        .padding({ right: 24, bottom: 96 })
      }
      .width('100%')
      .height('100%')

      BotanyBottomBar()
        .width('100%')
        .backgroundColor(BotanyColors.WHITE)
        .shadow({
          radius: 5,
          color: '#0D000000',
          offsetX: 0,
          offsetY: -2
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BotanyColors.WHITE)
  }
}

@Component
struct SectionHeader {
  title: string = ''

  build() {
    Text(this.title)
      .fontSize(22)
      .fontWeight(FontWeight.Bold)
      .fontColor(BotanyColors.TEXT_PRIMARY)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }
}

@Component
struct TaskCard {
  task: PlantTask = {
    id: 0,
    title: '',
    plantName: '',
    iconName: '',
    urgency: ''
  }

  @State private isChecked: boolean = false

  build() {
    Column() {
      Row() {
        Stack() {
          Text(iconGlyph(this.task.iconName))
            .fontSize(20)
            .fontColor(this.isChecked ? BotanyColors.WHITE : BotanyColors.TEXT_PRIMARY)
        }
        .width(40)
        .height(40)
        .backgroundColor(this.isChecked ? BotanyColors.ACCENT : BotanyColors.WHITE)
        .borderRadius(20)

        Blank()
          .layoutWeight(1)
      }
      .width('100%')

      Blank()
        .layoutWeight(1)

      Column() {
        Text(this.task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyColors.TEXT_PRIMARY)

        Text(this.task.plantName)
          .fontSize(12)
          .fontColor(BotanyColors.TEXT_SECONDARY)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Blank()
          .height(8)

        Text(this.isChecked ? 'DONE' : this.task.urgency)
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? BotanyColors.WHITE : BotanyColors.TEXT_PRIMARY)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.isChecked ? BotanyColors.ACCENT : BotanyColors.MID_GREY)
          .borderRadius(4)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width(160)
    .height(180)
    .padding(16)
    .backgroundColor(BotanyColors.SURFACE)
    .borderRadius(24)
    .border({
      width: this.isChecked ? 2 : 1,
      color: this.isChecked ? BotanyColors.ACCENT : BotanyColors.LIGHT_GREY
    })
    .onClick(() => {
      animateTo({ duration: 200, curve: Curve.EaseInOut }, () => {
        this.isChecked = !this.isChecked
      })
    })
  }
}

@Component
struct PlantListItem {
  plant: Plant = {
    id: 0,
    name: '',
    scientificName: '',
    location: '',
    daysUntilWater: 0,
    isHealthy: true
  }

  @State private expanded: boolean = false

  build() {
    Row() {
      Stack() {
        Text(iconGlyph('heart.fill'))
          .fontSize(20)
          .fontColor(this.plant.daysUntilWater === 0 ? BotanyColors.ACCENT : BotanyColors.ICON_GREY)
      }
      .width(56)
      .height(56)
      .backgroundColor(BotanyColors.LIGHT_GREY)
      .borderRadius(12)

      Blank()
        .width(16)

      Column() {
        Text(this.plant.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyColors.TEXT_PRIMARY)

        Text(this.plant.scientificName)
          .fontSize(12)
          .fontColor(BotanyColors.TEXT_SECONDARY)
          .fontStyle(FontStyle.Italic)

        if (this.expanded) {
          Blank()
            .height(8)

          Row() {
            Text(iconGlyph('location.fill'))
              .fontSize(12)
              .fontColor(BotanyColors.TEXT_SECONDARY)

            Blank()
              .width(4)

            Text(this.plant.location)
              .fontSize(11)
              .fontColor(BotanyColors.TEXT_SECONDARY)
          }
          .alignItems(VerticalAlign.Center)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column() {
        if (this.plant.daysUntilWater === 0) {
          Text(iconGlyph('checkmark.circle.fill'))
            .fontSize(24)
            .fontColor(BotanyColors.ACCENT)

          Text('Water')
            .fontSize(11)
            .fontWeight(FontWeight.Bold)
            .fontColor(BotanyColors.ACCENT)
        } else {
          Text(`${this.plant.daysUntilWater} days`)
            .fontSize(11)
            .fontColor(BotanyColors.TEXT_SECONDARY)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .alignItems(VerticalAlign.Center)
    .width('calc(100% - 48vp)')
    .padding(16)
    .margin({ left: 24, right: 24, top: 8, bottom: 8 })
    .backgroundColor(BotanyColors.SURFACE)
    .borderRadius(16)
    .onClick(() => {
      animateTo({ duration: 200, curve: Curve.EaseInOut }, () => {
        this.expanded = !this.expanded
      })
    })
  }
}

@Component
struct BotanyTopBar {
  build() {
    Row() {
      Stack() {
        Text(iconGlyph('line.horizontal.3'))
          .fontSize(22)
          .fontColor(BotanyColors.TEXT_PRIMARY)
      }
      .width(40)
      .height(40)
      .backgroundColor(BotanyColors.SURFACE)
      .borderRadius(20)
      .onClick(() => {
      })

      Blank()
        .layoutWeight(1)

      Stack() {
        Text(iconGlyph('magnifyingglass'))
          .fontSize(22)
          .fontColor(BotanyColors.TEXT_PRIMARY)
      }
      .width(40)
      .height(40)
      .backgroundColor(BotanyColors.SURFACE)
      .borderRadius(20)
      .onClick(() => {
      })
    }
    .width('100%')
  }
}

@Component
struct BotanyBottomBar {
  @State private selectedTab: number = 0

  build() {
    Row() {
      BotanyNavItem({ iconName: 'house.fill', isSelected: this.selectedTab === 0 })
        .onClick(() => {
          this.selectedTab = 0
        })

      BotanyNavItem({ iconName: 'calendar', isSelected: this.selectedTab === 1 })
        .onClick(() => {
          this.selectedTab = 1
        })

      Blank()
        .width(32)

      BotanyNavItem({ iconName: 'bell.fill', isSelected: this.selectedTab === 2 })
        .onClick(() => {
          this.selectedTab = 2
        })

      BotanyNavItem({ iconName: 'gearshape.fill', isSelected: this.selectedTab === 3 })
        .onClick(() => {
          this.selectedTab = 3
        })
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .backgroundColor(BotanyColors.WHITE)
  }
}

@Component
struct BotanyNavItem {
  iconName: string = ''
  isSelected: boolean = false

  build() {
    Stack() {
      Text(iconGlyph(this.iconName))
        .fontSize(24)
        .fontColor(BotanyColors.TEXT_PRIMARY)
        .opacity(this.isSelected ? 1.0 : 0.4)
    }
    .layoutWeight(1)
  }
}