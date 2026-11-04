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
  @State selectedTeaIndex: number = 0

  private readonly teaPresets: TeaPreset[] = [
    new TeaPreset('Sencha', '70°C', '1-2 min', 'Japanese green tea, grassy and fresh.'),
    new TeaPreset('Earl Grey', '98°C', '3-4 min', 'Black tea flavored with bergamot oil.'),
    new TeaPreset('Oolong', '85°C', '3-5 min', 'Traditional semi-oxidized Chinese tea.'),
    new TeaPreset('Chamomile', '100°C', '5 min', 'Herbal infusion, calming and caffeine-free.'),
    new TeaPreset('Matcha', '80°C', 'Whisk', 'Finely ground powder of green tea leaves.')
  ]

  private currentTea(): TeaPreset {
    return this.teaPresets[this.selectedTeaIndex]
  }

  build() {
    Stack() {
      Column() {
        this.HeaderSection()
        Blank().height(32)
        this.BrewingVisualizer(this.currentTea())
        Blank().height(40)
        this.BrewStatsRow(this.currentTea())
        Blank().height(40)
        this.TeaSelector()
        Blank()
        this.StartBrewButton()
      }
      .width('100%')
      .height('100%')
      .padding({ top: 24, bottom: 32 })
    }
    .width('100%')
    .height('100%')
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
          .fontSize(12)
          .fontColor(Color.Gray)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
  }

  @Builder
  BrewingVisualizer(tea: TeaPreset) {
    Stack() {
      Circle()
        .width(220)
        .height(220)
        .fill('#F5F5F5')
      Column() {
        Text('♥')
          .fontSize(48)
          .fontColor('#8D6E63')
        Text(tea.name)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(220)
    .height(220)
  }

  @Builder
  BrewStatsRow(tea: TeaPreset) {
    Row() {
      this.InfoItem('TEMP', tea.temp)
      Blank()
      this.VerticalDivider()
      Blank()
      this.InfoItem('TIME', tea.time)
      Blank()
      this.VerticalDivider()
      Blank()
      this.InfoItem('AMOUNT', '250ml')
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
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
        .letterSpacing(1)
      Text(value)
        .fontSize(16)
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
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ left: 4, bottom: 12 })
      Scroll() {
        Row() {
          ForEach(this.teaPresets, (preset: TeaPreset, index?: number) => {
            this.TeaChip(preset.name, index === undefined ? 0 : index)
          }, (preset: TeaPreset) => preset.name)
        }
        .padding({ left: 4, right: 4 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  TeaChip(name: string, index: number) {
    Button() {
      Text(name)
        .fontSize(14)
        .fontWeight(index === this.selectedTeaIndex ? FontWeight.Bold : FontWeight.Regular)
        .fontColor(index === this.selectedTeaIndex ? Color.White : Color.Black)
    }
    .padding({ left: 20, right: 20, top: 10, bottom: 10 })
    .borderRadius(50)
    .backgroundColor(index === this.selectedTeaIndex ? Color.Black : Color.White)
    .border({ width: 1, color: index === this.selectedTeaIndex ? Color.Black : '#E0E0E0' })
    .margin({ right: 12 })
    .onClick(() => {
      this.selectedTeaIndex = index
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
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ left: 8 })
      }
      .justifyContent(FlexAlign.Center)
    }
    .height(56)
    .width('100%')
    .margin({ left: 24, right: 24 })
    .borderRadius(16)
    .backgroundColor(Color.Black)
  }
}