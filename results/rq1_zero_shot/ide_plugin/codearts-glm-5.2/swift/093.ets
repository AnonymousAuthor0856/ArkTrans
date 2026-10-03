class TmColors {
  static readonly white: string = '#FFFFFFFF'
  static readonly black: string = '#FF000000'
  static readonly gray: string = '#FF808080'
  static readonly visualizerBg: string = '#FFF5F5F5'
  static readonly teaIcon: string = '#FF8D6E63'
  static readonly divider: string = '#FFE0E0E0'
}

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

  private teaPresets: TeaPreset[] = [
    new TeaPreset('Sencha', '70°C', '1-2 min', 'Japanese green tea, grassy and fresh.'),
    new TeaPreset('Earl Grey', '98°C', '3-4 min', 'Black tea flavored with bergamot oil.'),
    new TeaPreset('Oolong', '85°C', '3-5 min', 'Traditional semi-oxidized Chinese tea.'),
    new TeaPreset('Chamomile', '100°C', '5 min', 'Herbal infusion, calming and caffeine-free.'),
    new TeaPreset('Matcha', '80°C', 'Whisk', 'Finely ground powder of green tea leaves.'),
  ]

  build() {
    Stack() {
      Column() {
        Row() {
          Column() {
            Text('Tea Master')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(TmColors.black)
            Text('Perfect brew, every time')
              .fontSize(12)
              .fontColor(TmColors.gray)
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Text('⚙')
            .fontSize(24)
            .fontColor(TmColors.black)
        }
        .padding({ left: 24, right: 24, top: 24 })

        Blank().height(32)

        Stack() {
          Column() {
            Text('♥')
              .fontSize(48)
              .fontColor(TmColors.teaIcon)

            Text(this.teaPresets[this.selectedTeaIndex].name)
              .fontSize(22)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(TmColors.black)
              .margin({ top: 8 })
          }
        }
        .width(220)
        .height(220)
        .backgroundColor(TmColors.visualizerBg)
        .borderRadius(110)

        Blank().height(40)

        Row() {
          Column() {
            Text('TEMP')
              .fontSize(11)
              .fontWeight(FontWeight.Bold)
              .fontColor(TmColors.gray)
            Text(this.teaPresets[this.selectedTeaIndex].temp)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(TmColors.black)
              .margin({ top: 4 })
          }

          Blank()

          Column() { Blank() }
            .width(1)
            .height(40)
            .backgroundColor(TmColors.divider)

          Blank()

          Column() {
            Text('TIME')
              .fontSize(11)
              .fontWeight(FontWeight.Bold)
              .fontColor(TmColors.gray)
            Text(this.teaPresets[this.selectedTeaIndex].time)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(TmColors.black)
              .margin({ top: 4 })
          }

          Blank()

          Column() { Blank() }
            .width(1)
            .height(40)
            .backgroundColor(TmColors.divider)

          Blank()

          Column() {
            Text('AMOUNT')
              .fontSize(11)
              .fontWeight(FontWeight.Bold)
              .fontColor(TmColors.gray)
            Text('250ml')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(TmColors.black)
              .margin({ top: 4 })
          }
        }
        .padding({ left: 24, right: 24 })

        Blank().height(40)

        Column() {
          Text('Select Variety')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(TmColors.black)
            .margin({ left: 4, bottom: 12 })

          Scroll() {
            Row() {
              ForEach(this.teaPresets, (preset: TeaPreset, index: number) => {
                Text(preset.name)
                  .fontSize(14)
                  .fontWeight(this.selectedTeaIndex === index ? FontWeight.Bold : FontWeight.Normal)
                  .fontColor(this.selectedTeaIndex === index ? TmColors.white : TmColors.black)
                  .padding({ left: 20, right: 20, top: 10, bottom: 10 })
                  .backgroundColor(this.selectedTeaIndex === index ? TmColors.black : TmColors.white)
                  .borderRadius(20)
                  .border({ width: 1, color: this.selectedTeaIndex === index ? TmColors.black : TmColors.divider })
                  .margin({ right: 12 })
                  .onClick(() => {
                    this.selectedTeaIndex = index
                  })
              })
            }
            .padding({ left: 4, right: 4 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
        }
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 24, right: 24 })

        Blank()

        Row() {
          Text('▶')
            .fontSize(20)
            .fontColor(TmColors.white)
          Text('START TIMER')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(TmColors.white)
            .margin({ left: 8 })
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(TmColors.black)
        .borderRadius(16)
        .padding({ left: 24, right: 24, bottom: 32 })
      }
    }
    .backgroundColor(TmColors.white)
    .width('100%')
    .height('100%')
  }
}