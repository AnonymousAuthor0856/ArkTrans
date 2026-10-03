class ZbColors {
  static readonly primaryBlack: string = '#FF121212'
  static readonly textGrey: string = '#FF757575'
  static readonly white: string = '#FFFFFFFF'
  static readonly cardBg: string = '#FFF9F9F9'
  static readonly promoBg: string = '#FFF0F0F0'
  static readonly lightBorder: string = '#FFEEEEEE'
  static readonly veryLightBorder: string = '#FFE0E0E0'
  static readonly gray: string = '#FF808080'
  static readonly black: string = '#FF000000'
}

class TeaGuide {
  name: string
  origin: string
  temp: string
  time: string
  colorCode: string
  colorCode30: string

  constructor(name: string, origin: string, temp: string, time: string, colorCode: string, colorCode30: string) {
    this.name = name
    this.origin = origin
    this.temp = temp
    this.time = time
    this.colorCode = colorCode
    this.colorCode30 = colorCode30
  }
}

@Entry
@Component
struct Index {
  private teas: TeaGuide[] = [
    new TeaGuide('Sencha Green', 'Japan', '70°C / 158°F', '1-2 min', '#FF8BC34A', '#4D8BC34A'),
    new TeaGuide('Earl Grey', 'Blend', '95°C / 203°F', '3-5 min', '#FF795548', '#4D795548'),
    new TeaGuide('Silver Needle', 'China', '80°C / 176°F', '3-4 min', '#FFE0E0E0', '#4DE0E0E0'),
    new TeaGuide('Darjeeling', 'India', '90°C / 194°F', '3 min', '#FFD7CCC8', '#4DD7CCC8'),
    new TeaGuide('Chamomile', 'Egypt', '100°C / 212°F', '5-7 min', '#FFFFEB3B', '#4DFFEB3B'),
    new TeaGuide('Matcha', 'Japan', '80°C / 176°F', 'Whisk', '#FF4CAF50', '#4D4CAF50'),
    new TeaGuide('Oolong', 'Taiwan', '85°C / 185°F', '3-5 min', '#FFFF9800', '#4DFF9800'),
  ]

  build() {
    Stack() {
      Scroll() {
        Column() {
          Row() {
            Column() {
              Text('ZenBrew')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(ZbColors.primaryBlack)
              Text('Mindful Steeping Guide')
                .fontSize(14)
                .fontColor(ZbColors.textGrey)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Text('⚙')
              .fontSize(24)
              .fontColor(ZbColors.primaryBlack)
              .width(44)
              .height(44)
              .textAlign(TextAlign.Center)
          }
          .padding({ left: 20, right: 20, top: 10 })
          .alignItems(VerticalAlign.Top)

          Row() {
            Column() {
              Text('Tip of the day')
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .fontColor(ZbColors.gray)
                .margin({ bottom: 4 })
              Text('Use filtered water for a purer taste profile.')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(ZbColors.primaryBlack)
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Stack() {
              Circle({ width: 48, height: 48 })
                .fill(ZbColors.white)
              Text('ⓘ')
                .fontSize(24)
                .fontColor(ZbColors.gray)
            }
            .margin({ left: 16 })
          }
          .padding(24)
          .backgroundColor(ZbColors.promoBg)
          .borderRadius(20)
          .margin({ left: 20, right: 20, top: 16 })

          Text('Collections')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(ZbColors.primaryBlack)
            .padding({ left: 20, right: 20, top: 8, bottom: 8 })

          ForEach(this.teas, (tea: TeaGuide) => {
            TeaItemCard({
              tName: tea.name, tOrigin: tea.origin, tTemp: tea.temp,
              tTime: tea.time, tColor: tea.colorCode, tColor30: tea.colorCode30
            })
              .margin({ left: 20, right: 20, top: 16 })
          })

          Blank().height(80)
        }
        .padding({ top: 10, bottom: 10 })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)

      Stack() {
        Row() {
          Text('+')
            .fontSize(20)
            .fontColor(ZbColors.white)
          Text('Custom Brew')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(ZbColors.white)
            .margin({ left: 8 })
        }
        .height(56)
        .padding({ left: 24, right: 24 })
        .backgroundColor(ZbColors.primaryBlack)
        .borderRadius(16)
        .margin({ right: 20, bottom: 20 })
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.BottomEnd)
    }
    .backgroundColor(ZbColors.white)
    .width('100%')
    .height('100%')
  }
}

@Component
struct TeaItemCard {
  @Prop tName: string = ''
  @Prop tOrigin: string = ''
  @Prop tTemp: string = ''
  @Prop tTime: string = ''
  @Prop tColor: string = '#FFFFFF'
  @Prop tColor30: string = '#4DFFFFFF'

  build() {
    Row() {
      Stack() {
        Circle({ width: 50, height: 50 })
          .fill(ZbColors.white)
          .border({ width: 2, color: this.tColor30 })
        Text(this.tName.charAt(0))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.tColor)
      }

      Column() {
        Text(this.tName)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(ZbColors.primaryBlack)
        Text(this.tOrigin)
          .fontSize(12)
          .fontColor(ZbColors.textGrey)
          .margin({ top: 2 })

        Row() {
          InfoBadge({ label: this.tTemp })
          InfoBadge({ label: this.tTime })
            .margin({ left: 8 })
        }
        .margin({ top: 6 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })

      Text('▶')
        .fontSize(20)
        .fontColor(ZbColors.primaryBlack)
        .width(40)
        .height(40)
        .textAlign(TextAlign.Center)
        .backgroundColor(ZbColors.white)
        .borderRadius(20)
        .border({ width: 1, color: ZbColors.veryLightBorder })
    }
    .padding(16)
    .backgroundColor(ZbColors.cardBg)
    .borderRadius(16)
    .border({ width: 1, color: ZbColors.lightBorder })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct InfoBadge {
  @Prop label: string = ''

  build() {
    Text(this.label)
      .fontSize(11)
      .fontColor(ZbColors.black)
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor(ZbColors.white)
      .borderRadius(6)
      .border({ width: 1, color: ZbColors.veryLightBorder })
  }
}