interface TeaPreset {
  name: string
  temp: string
  time: string
  description: string
}

@Entry
@Component
struct TeaMasterPage {
  @State selectedIndex: number = 0

  private presets: TeaPreset[] = [
    { name: 'Sencha', temp: '70°C', time: '1-2 min', description: 'Japanese green tea, grassy and fresh.' },
    { name: 'Earl Grey', temp: '98°C', time: '3-4 min', description: 'Black tea flavored with bergamot oil.' },
    { name: 'Oolong', temp: '85°C', time: '3-5 min', description: 'Traditional semi-oxidized Chinese tea.' },
    { name: 'Chamomile', temp: '100°C', time: '5 min', description: 'Herbal infusion, calming and caffeine-free.' },
    { name: 'Matcha', temp: '80°C', time: 'Whisk', description: 'Finely ground powder of green tea leaves.' }
  ]

  @Builder
  Metric(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor('#888888')
        .letterSpacing(1)
      Text(value)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor('#080808')
        .margin({ top: 8 })
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    Column() {
      Row() {
        Column() {
          Text('Tea Master')
            .fontSize(38)
            .fontWeight(FontWeight.Bold)
            .fontColor('#080808')
          Text('Perfect brew, every time')
            .fontSize(16)
            .fontColor('#888888')
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)

        Text('⚙')
          .fontSize(29)
          .fontColor('#080808')
          .onClick(() => {})
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Stack() {
        Column() {
          Text('♥')
            .fontSize(52)
            .fontColor('#8D6E63')
          Text(this.presets[this.selectedIndex].name)
            .fontSize(29)
            .fontWeight(FontWeight.Medium)
            .fontColor('#080808')
            .margin({ top: 12 })
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(240)
      .height(240)
      .backgroundColor('#F5F5F5')
      .borderRadius(120)
      .alignContent(Alignment.Center)
      .margin({ top: 68, bottom: 80 })

      Row() {
        this.Metric('TEMP', this.presets[this.selectedIndex].temp)
        Divider()
          .vertical(true)
          .height(54)
          .strokeWidth(1)
          .color('#E0E0E0')
        this.Metric('TIME', this.presets[this.selectedIndex].time)
        Divider()
          .vertical(true)
          .height(54)
          .strokeWidth(1)
          .color('#E0E0E0')
        this.Metric('AMOUNT', '250ml')
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Column() {
        Text('Select Variety')
          .fontSize(19)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
          .margin({ left: 4, bottom: 18 })

        Scroll() {
          Row({ space: 16 }) {
            ForEach(this.presets, (preset: TeaPreset, index: number) => {
              Text(preset.name)
                .fontSize(18)
                .fontWeight(this.selectedIndex === index ? FontWeight.Bold : FontWeight.Normal)
                .fontColor(this.selectedIndex === index ? '#FFFFFF' : '#111111')
                .textAlign(TextAlign.Center)
                .height(54)
                .padding({ left: 27, right: 27 })
                .borderRadius(30)
                .backgroundColor(this.selectedIndex === index ? '#050505' : '#FFFFFF')
                .border({
                  width: 1,
                  color: this.selectedIndex === index ? '#050505' : '#E0E0E0',
                  radius: 30
                })
                .onClick(() => {
                  this.selectedIndex = index
                })
            }, (preset: TeaPreset) => preset.name)
          }
          .padding({ left: 4, right: 4 })
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 76 })
      .layoutWeight(1)

      Button() {
        Row({ space: 16 }) {
          Text('▶')
            .fontSize(18)
            .fontColor('#FFFFFF')
          Text('START TIMER')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height(74)
      .backgroundColor('#050505')
      .borderRadius(22)
      .margin({ bottom: 0 })
      .onClick(() => {})
    }
    .width('100%')
    .height('100%')
    .padding({ left: 32, right: 32, top: 36, bottom: 32 })
    .backgroundColor('#FFFFFF')
  }
}
