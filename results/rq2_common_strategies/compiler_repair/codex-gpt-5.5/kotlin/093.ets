class TeaPreset {
  name: string
  temp: string
  time: string
  description: string

  constructor(name: string, temp: string, time: string, description: string) {
    this.name = name
    this.temp = temp
    this.time = time
    this.description = description
  }
}

@Entry
@Component
struct Index {
  @State selectedIndex: number = 0

  private presets: TeaPreset[] = [
    new TeaPreset('Sencha', '70°C', '1-2 min', 'Japanese green tea, grassy and fresh.'),
    new TeaPreset('Earl Grey', '98°C', '3-4 min', 'Black tea flavored with bergamot oil.'),
    new TeaPreset('Oolong', '85°C', '3-5 min', 'Traditional semi-oxidized Chinese tea.'),
    new TeaPreset('Chamomile', '100°C', '5 min', 'Herbal infusion, calming and caffeine-free.'),
    new TeaPreset('Matcha', '80°C', 'Whisk', 'Finely ground powder of green tea leaves.')
  ]

  build() {
    Column() {
      this.HeaderSection()
      this.BrewingVisualizer()
      this.BrewStatsRow()
      this.TeaSelector()
      Blank()
      this.StartBrewButton()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Color.White)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Tea Master')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text('Perfect brew, every time')
          .fontSize(13)
          .fontColor(Color.Gray)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Button('⚙')
        .fontSize(24)
        .fontColor(Color.Black)
        .backgroundColor(Color.Transparent)
        .width(48)
        .height(48)
        .padding(0)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BrewingVisualizer() {
    Stack() {
      Circle()
        .width(180)
        .height(180)
        .fill('#F5F5F5')
      Column() {
        Text('♥')
          .fontSize(48)
          .fontColor('#8D6E63')
        Text(this.presets[this.selectedIndex].name)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(220)
    .height(220)
    .margin({ top: 32 })
  }

  @Builder
  BrewStatsRow() {
    Row() {
      this.InfoItem('TEMP', this.presets[this.selectedIndex].temp)
      this.VerticalDivider()
      this.InfoItem('TIME', this.presets[this.selectedIndex].time)
      this.VerticalDivider()
      this.InfoItem('AMOUNT', '250ml')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
    .margin({ top: 40 })
  }

  @Builder
  VerticalDivider() {
    Rect()
      .width(1)
      .height(40)
      .fill('#E0E0E0')
  }

  @Builder
  InfoItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)
      Text(value)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  TeaSelector() {
    Column() {
      Text('Select Variety')
        .width('100%')
        .fontSize(16)
        .fontColor(Color.Black)
        .margin({ left: 4, bottom: 12 })
      Scroll() {
        Row() {
          ForEach(this.presets, (preset: TeaPreset, index: number) => {
            this.TeaChip(preset, index)
          })
        }
        .padding({ left: 4, right: 4 })
      }
      .width('100%')
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .margin({ top: 40 })
  }

  @Builder
  TeaChip(preset: TeaPreset, index: number) {
    Text(preset.name)
      .fontSize(14)
      .fontWeight(this.selectedIndex === index ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.selectedIndex === index ? Color.White : Color.Black)
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      .border({ width: 1, color: this.selectedIndex === index ? Color.Black : '#E0E0E0', radius: 50 })
      .backgroundColor(this.selectedIndex === index ? Color.Black : Color.White)
      .margin({ right: 12 })
      .onClick(() => {
        this.selectedIndex = index
      })
  }

  @Builder
  StartBrewButton() {
    Button() {
      Row() {
        Text('▶')
          .fontSize(20)
          .fontColor(Color.White)
        Text('START TIMER')
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ left: 8 })
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(56)
    .borderRadius(16)
    .backgroundColor(Color.Black)
  }
}
