interface PlantItem {
  name: string
  scientific: string
  location: string
  days: number
}

@Entry
@Component
struct BotanyApp {
  @State wateringDone: boolean = false
  @State fertilizeDone: boolean = false
  @State expandedPlants: boolean[] = [false, false, false, false, false]

  private readonly primary: string = '#1A1C19'
  private readonly secondary: string = '#757575'
  private readonly surface: string = '#FAFAFA'
  private readonly borderTone: string = '#EEEEEE'
  private readonly accent: string = '#2E5E4E'
  private readonly plants: PlantItem[] = [
    { name: 'Monstera', scientific: 'Monstera deliciosa', location: 'Living Room', days: 0 },
    { name: 'Fiddle Leaf', scientific: 'Ficus lyrata', location: 'Bedroom', days: 2 },
    { name: 'Snakey', scientific: 'Sansevieria', location: 'Hallway', days: 5 },
    { name: 'Spider Plant', scientific: 'Chlorophytum', location: 'Kitchen', days: 1 },
    { name: 'Peace Lily', scientific: 'Spathiphyllum', location: 'Bathroom', days: 3 }
  ]

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.topBar()

        Scroll() {
          Column() {
            Column() {
              Text('Good Morning,')
                .fontSize(32)
                .fontColor(this.secondary)
                .fontWeight(FontWeight.Normal)
                .width('100%')

              Text('My Jungle')
                .fontSize(62)
                .fontColor(this.primary)
                .fontWeight(FontWeight.Bold)
                .margin({ top: 4 })
                .width('100%')
            }
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 48, right: 48, top: 20, bottom: 34 })

            this.sectionTitle('Pending Tasks')

            Row({ space: 16 }) {
              this.taskCard('▣', 'Watering', 'Monstera Deliciosa', 'Today', this.wateringDone, () => {
                this.wateringDone = !this.wateringDone
              })
              this.taskCard('♟', 'Fertilize', 'Fiddle Leaf Fig', 'Tomorrow', this.fertilizeDone, () => {
                this.fertilizeDone = !this.fertilizeDone
              })
            }
            .width('100%')
            .padding({ left: 48, right: 48 })

            Blank()
              .height(54)

            this.sectionTitle('Your Collection')

            ForEach(this.plants, (plant: PlantItem, index: number) => {
              this.plantRow(plant.name, plant.scientific, plant.location, plant.days, index)
            })

            Blank()
              .height(110)
          }
          .width('100%')
        }
        .layoutWeight(1)

        this.bottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      Button('+')
        .width(112)
        .height(112)
        .fontSize(48)
        .fontColor('#FFFFFF')
        .backgroundColor(this.primary)
        .borderRadius(56)
        .shadow({ radius: 18, color: '#40000000', offsetX: 0, offsetY: 8 })
        .margin({ right: 32, bottom: 126 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  topBar() {
    Row() {
      Button('☰')
        .width(96)
        .height(96)
        .fontSize(38)
        .fontColor(this.primary)
        .backgroundColor(this.surface)
        .borderRadius(48)
        .onClick(() => {})

      Blank()
        .layoutWeight(1)

      Button('⌕')
        .width(96)
        .height(96)
        .fontSize(48)
        .fontColor(this.primary)
        .backgroundColor(this.surface)
        .borderRadius(48)
        .onClick(() => {})
    }
    .width('100%')
    .padding({ left: 40, right: 40, top: 40, bottom: 14 })
  }

  @Builder
  sectionTitle(title: string) {
    Text(title)
      .fontSize(32)
      .fontColor(this.primary)
      .fontWeight(FontWeight.Bold)
      .width('100%')
      .padding({ left: 48, right: 48, top: 12, bottom: 24 })
  }

  @Builder
  taskCard(icon: string, title: string, plant: string, urgency: string, checked: boolean, toggle: () => void) {
    Column() {
      Row() {
        Stack() {
          Circle()
            .width(80)
            .height(80)
            .fill(checked ? this.accent : '#FFFFFF')

          Text(icon)
            .fontSize(30)
            .fontColor(checked ? '#FFFFFF' : this.primary)
        }
        .width(80)
        .height(80)
      }
      .width('100%')

      Blank()
        .layoutWeight(1)

      Column() {
        Text(title)
          .fontSize(28)
          .fontColor(this.primary)
          .fontWeight(FontWeight.Bold)
          .width('100%')

        Text(plant)
          .fontSize(24)
          .fontColor(this.secondary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')
          .margin({ top: 4 })

        Text(checked ? 'DONE' : urgency)
          .fontSize(22)
          .fontColor(checked ? '#FFFFFF' : this.primary)
          .fontWeight(FontWeight.Bold)
          .backgroundColor(checked ? this.accent : '#E0E0E0')
          .borderRadius(8)
          .padding({ left: 12, right: 12, top: 7, bottom: 7 })
          .margin({ top: 16 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('50%')
    .height(360)
    .padding(32)
    .backgroundColor(this.surface)
    .border({
      width: checked ? 3 : 2,
      color: checked ? this.accent : this.borderTone
    })
    .borderRadius(40)
    .onClick(toggle)
  }

  @Builder
  plantRow(name: string, scientific: string, location: string, days: number, index: number) {
    Column() {
      Row() {
        Stack() {
          Rect()
            .width(112)
            .height(112)
            .fill('#EEEEEE')
            .radius(22)

          Text('♥')
            .fontSize(40)
            .fontColor(days === 0 ? this.accent : '#AAAAAA')
        }
        .width(112)
        .height(112)

        Column() {
          Text(name)
            .fontSize(28)
            .fontColor(this.primary)
            .fontWeight(FontWeight.Bold)
            .width('100%')

          Text(scientific)
            .fontSize(22)
            .fontColor(this.secondary)
            .fontStyle(FontStyle.Italic)
            .width('100%')

          if (this.expandedPlants[index]) {
            Text('⌖  ' + location)
              .fontSize(18)
              .fontColor(this.secondary)
              .margin({ top: 12 })
          }
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 24 })

        Column() {
          if (days === 0) {
            Text('✓')
              .fontSize(36)
              .fontColor(this.accent)
              .fontWeight(FontWeight.Bold)

            Text('Water')
              .fontSize(18)
              .fontColor(this.accent)
              .fontWeight(FontWeight.Bold)
          } else {
            Text(days + ' days')
              .fontSize(18)
              .fontColor(this.secondary)
          }
        }
        .alignItems(HorizontalAlign.End)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('calc(100% - 96vp)')
    .margin({ left: 48, right: 48, bottom: 16 })
    .padding(16)
    .backgroundColor(this.surface)
    .borderRadius(28)
    .onClick(() => {
      this.expandedPlants[index] = !this.expandedPlants[index]
    })
  }

  @Builder
  bottomBar() {
    Row() {
      this.navItem('⌂', true)
      this.navItem('▣', false)
      Blank()
        .width(96)
      this.navItem('♟', false)
      this.navItem('⚙', false)
    }
    .width('100%')
    .height(112)
    .padding({ left: 56, right: 56, top: 16, bottom: 20 })
    .backgroundColor('#FFFFFF')
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  navItem(icon: string, selected: boolean) {
    Text(icon)
      .fontSize(38)
      .fontColor(selected ? this.primary : '#AAAAAA')
      .fontWeight(FontWeight.Bold)
      .width(56)
      .height(56)
      .textAlign(TextAlign.Center)
  }
}
