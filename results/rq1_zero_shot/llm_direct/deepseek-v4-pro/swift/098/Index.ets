@Entry
@Component
struct ZenBrewAppView {
  // Color constants
  private static readonly primaryBlack: string = '#121212';
  private static readonly textGrey: string = '#757575';
  private static readonly backgroundWhite: string = '#FFFFFF';
  private static readonly cardBackground: string = '#F9F9F9';
  private static readonly promoCardBackground: string = '#F0F0F0';
  private static readonly lightGreyBorder: string = '#EEEEEE';
  private static readonly veryLightGreyBorder: string = '#E0E0E0';

  // Tea data model
  class TeaGuide {
    id: number;
    name: string;
    origin: string;
    temp: string;
    time: string;
    colorCode: string;

    constructor(id: number, name: string, origin: string, temp: string, time: string, colorCode: string) {
      this.id = id;
      this.name = name;
      this.origin = origin;
      this.temp = temp;
      this.time = time;
      this.colorCode = colorCode;
    }
  }

  private sampleTeas: TeaGuide[] = [
    new TeaGuide(1, 'Sencha Green', 'Japan', '70°C / 158°F', '1-2 min', '#8BC34A'),
    new TeaGuide(2, 'Earl Grey', 'Blend', '95°C / 203°F', '3-5 min', '#795548'),
    new TeaGuide(3, 'Silver Needle', 'China', '80°C / 176°F', '3-4 min', '#E0E0E0'),
    new TeaGuide(4, 'Darjeeling', 'India', '90°C / 194°F', '3 min', '#D7CCC8'),
    new TeaGuide(5, 'Chamomile', 'Egypt', '100°C / 212°F', '5-7 min', '#FFEB3B'),
    new TeaGuide(6, 'Matcha', 'Japan', '80°C / 176°F', 'Whisk', '#4CAF50'),
    new TeaGuide(7, 'Oolong', 'Taiwan', '85°C / 185°F', '3-5 min', '#FF9800')
  ];

  @Builder
  PromoCard() {
    Row() {
      Column() {
        Text('Tip of the day')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#9E9E9E')
          .margin({ bottom: 4 })
        Text('Use filtered water for a purer taste profile.')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(ZenBrewAppView.primaryBlack)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Blank()
        .width(16)

      Stack() {
        Circle()
          .fill('#FFFFFF')
          .width(48)
          .height(48)
        Text('ⓘ')
          .fontSize(24)
          .fontColor('#9E9E9E')
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .padding(24)
    .backgroundColor(ZenBrewAppView.promoCardBackground)
    .borderRadius(20)
  }

  @Builder
  InfoBadge(label: string) {
    Text(label)
      .fontSize(11)
      .fontColor('#000000')
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor('#FFFFFF')
      .borderRadius(6)
      .border({ width: 1, color: ZenBrewAppView.veryLightGreyBorder })
  }

  @Builder
  TeaItemCard(tea: TeaGuide) {
    Row() {
      Stack() {
        Circle()
          .fill('#FFFFFF')
          .width(50)
          .height(50)
          .border({ width: 2, color: tea.colorCode + '4D' })
        Text(tea.name.substring(0, 1))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(tea.colorCode)
      }
      .width(50)
      .height(50)

      Blank()
        .width(16)

      Column() {
        Text(tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(ZenBrewAppView.primaryBlack)
        Text(tea.origin)
          .fontSize(12)
          .fontColor(ZenBrewAppView.textGrey)
        Blank()
          .height(6)
        Row() {
          this.InfoBadge(tea.temp)
          Blank()
            .width(8)
          this.InfoBadge(tea.time)
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button() {
        console.info(`Play for ${tea.name} tapped`)
      }
      .width(40)
      .height(40)
      .backgroundColor('#FFFFFF')
      .borderRadius(20)
      .border({ width: 1, color: ZenBrewAppView.veryLightGreyBorder })
      .type(ButtonType.Circle)
      .stateEffect(false)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .child(
        Text('▶')
          .fontSize(20)
          .fontColor(ZenBrewAppView.primaryBlack)
      )
    }
    .width('100%')
    .padding(16)
    .backgroundColor(ZenBrewAppView.cardBackground)
    .borderRadius(16)
    .border({ width: 1, color: ZenBrewAppView.lightGreyBorder })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Scroll() {
        Column({ space: 16 }) {
          // Top bar
          Row() {
            Column() {
              Text('ZenBrew')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(ZenBrewAppView.primaryBlack)
                .letterSpacing(-0.5)
              Text('Mindful Steeping Guide')
                .fontSize(14)
                .fontWeight(FontWeight.Regular)
                .fontColor(ZenBrewAppView.textGrey)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button() {
              console.info('Settings tapped')
            }
            .width(44)
            .height(44)
            .type(ButtonType.Normal)
            .stateEffect(false)
            .backgroundColor('#00000000')
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
            .child(
              Text('⚙')
                .fontSize(24)
                .fontColor(ZenBrewAppView.primaryBlack)
            )
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 10 })

          // Promo card
          this.PromoCard()
            .margin({ left: 20, right: 20 })

          // Collections title
          Text('Collections')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(ZenBrewAppView.primaryBlack)
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: 20, right: 20, top: 8, bottom: 8 })

          // Tea list
          ForEach(this.sampleTeas, (tea: TeaGuide) => {
            this.TeaItemCard(tea)
              .margin({ left: 20, right: 20 })
          }, (tea: TeaGuide) => tea.id.toString())

          // Bottom spacer for FAB
          Blank()
            .height(80)
        }
        .width('100%')
        .padding({ top: 10, bottom: 10 })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .backgroundColor(ZenBrewAppView.backgroundWhite)
      .align(Alignment.TopStart)

      // FAB
      Button() {
        console.info('Custom Brew tapped')
      }
      .height(56)
      .padding({ left: 24, right: 24 })
      .backgroundColor(ZenBrewAppView.primaryBlack)
      .borderRadius(16)
      .type(ButtonType.Normal)
      .stateEffect(false)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .margin({ right: 20, bottom: 20 })
      .child(
        Row({ space: 8 }) {
          Text('+')
            .fontSize(20)
            .fontColor('#FFFFFF')
          Text('Custom Brew')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
      )
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ZenBrewAppView.backgroundWhite)
  }
}