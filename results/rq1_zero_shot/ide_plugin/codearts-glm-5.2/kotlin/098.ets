class TeaGuide {
  id: number
  name: string
  origin: string
  temp: string
  time: string
  colorCode: string
  colorCode30: string

  constructor(id: number, name: string, origin: string, temp: string, time: string, colorCode: string,
    colorCode30: string) {
    this.id = id
    this.name = name
    this.origin = origin
    this.temp = temp
    this.time = time
    this.colorCode = colorCode
    this.colorCode30 = colorCode30
  }
}

class AppTokens {
  static readonly Colors = {
    primaryBlack: '#FF121212',
    textGrey: '#FF757575',
    backgroundWhite: '#FFFFFFFF',
    cardBackground: '#FFF9F9F9',
    gray: '#FF888888',
    promoBg: '#FFF0F0F0',
    cardBorder: '#FFEEEEEE',
    badgeBorder: '#FFE0E0E0'
  }
}

@Entry
@Component
struct ZenBrewApp {
  private sampleTeas: TeaGuide[] = [
    new TeaGuide(1, 'Sencha Green', 'Japan', '70°C / 158°F', '1-2 min', '#FF8BC34A', '#4D8BC34A'),
    new TeaGuide(2, 'Earl Grey', 'Blend', '95°C / 203°F', '3-5 min', '#FF795548', '#4D795548'),
    new TeaGuide(3, 'Silver Needle', 'China', '80°C / 176°F', '3-4 min', '#FFE0E0E0', '#4DE0E0E0'),
    new TeaGuide(4, 'Darjeeling', 'India', '90°C / 194°F', '3 min', '#FFD7CCC8', '#4DD7CCC8'),
    new TeaGuide(5, 'Chamomile', 'Egypt', '100°C / 212°F', '5-7 min', '#FFFFEB3B', '#4DFFEB3B'),
    new TeaGuide(6, 'Matcha', 'Japan', '80°C / 176°F', 'Whisk', '#FF4CAF50', '#4D4CAF50'),
    new TeaGuide(7, 'Oolong', 'Taiwan', '85°C / 185°F', '3-5 min', '#FFFF9800', '#4DFF9800')
  ]

  build() {
    Stack() {
      Column() {
        Row() {
          Column() {
            Text('ZenBrew')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.Colors.primaryBlack)
              .letterSpacing(-0.5)
            Text('Mindful Steeping Guide')
              .fontSize(14)
              .fontColor(AppTokens.Colors.textGrey)
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Text('⚙')
            .fontSize(24)
            .fontColor(AppTokens.Colors.primaryBlack)
        }
        .width('100%')
        .padding({ top: 16, bottom: 16, left: 20, right: 20 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Scroll() {
          Column() {
            Row() {
              Column() {
                Text('Tip of the day')
                  .fontSize(12)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(AppTokens.Colors.gray)
                  .margin({ bottom: 4 })
                Text('Use filtered water for a purer taste profile.')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.primaryBlack)
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Row() {
                Text('ℹ')
                  .fontSize(24)
                  .fontColor(AppTokens.Colors.gray)
              }
              .width(48)
              .height(48)
              .borderRadius(24)
              .backgroundColor(AppTokens.Colors.backgroundWhite)
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .padding(24)
            .borderRadius(20)
            .backgroundColor(AppTokens.Colors.promoBg)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            Text('Collections')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.primaryBlack)
              .margin({ top: 24, bottom: 8 })

            ForEach(this.sampleTeas, (tea: TeaGuide) => {
              TeaItemCard({
                teaName: tea.name,
                teaOrigin: tea.origin,
                teaTemp: tea.temp,
                teaTime: tea.time,
                teaColorCode: tea.colorCode,
                teaColorCode30: tea.colorCode30,
                teaFirstLetter: tea.name.charAt(0)
              })
                .margin({ bottom: 16 })
            })

            Column()
              .height(80)
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 10, bottom: 10 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      Row() {
        Text('+')
          .fontSize(20)
          .fontColor(AppTokens.Colors.backgroundWhite)
        Text('Custom Brew')
          .fontSize(14)
          .fontColor(AppTokens.Colors.backgroundWhite)
          .margin({ left: 8 })
      }
      .height(56)
      .padding({ left: 20, right: 20 })
      .borderRadius(16)
      .backgroundColor(AppTokens.Colors.primaryBlack)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .margin({ right: 20, bottom: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.backgroundWhite)
    .alignContent(Alignment.BottomEnd)
  }
}

@Component
struct TeaItemCard {
  @Prop teaName: string
  @Prop teaOrigin: string
  @Prop teaTemp: string
  @Prop teaTime: string
  @Prop teaColorCode: string
  @Prop teaColorCode30: string
  @Prop teaFirstLetter: string

  build() {
    Row() {
      Row() {
        Text(this.teaFirstLetter)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.teaColorCode)
      }
      .width(50)
      .height(50)
      .borderRadius(25)
      .backgroundColor(AppTokens.Colors.backgroundWhite)
      .border({ width: 2, color: this.teaColorCode30 })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text(this.teaName)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primaryBlack)
        Text(this.teaOrigin)
          .fontSize(12)
          .fontColor(AppTokens.Colors.textGrey)
        Row() {
          InfoBadge({ label: this.teaTemp })
          InfoBadge({ label: this.teaTime })
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)
        .margin({ top: 6 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })

      Row() {
        Text('▶')
          .fontSize(20)
          .fontColor(AppTokens.Colors.primaryBlack)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(AppTokens.Colors.backgroundWhite)
      .border({ width: 1, color: AppTokens.Colors.badgeBorder })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(16)
    .borderRadius(16)
    .backgroundColor(AppTokens.Colors.cardBackground)
    .border({ width: 1, color: AppTokens.Colors.cardBorder })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct InfoBadge {
  @Prop label: string

  build() {
    Text(this.label)
      .fontSize(11)
      .fontColor(AppTokens.Colors.primaryBlack)
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .borderRadius(6)
      .backgroundColor(AppTokens.Colors.backgroundWhite)
      .border({ width: 1, color: AppTokens.Colors.badgeBorder })
  }
}