const PRIMARY_BLACK: ResourceColor = '#121212';
const TEXT_GREY: ResourceColor = '#757575';
const BACKGROUND_WHITE: ResourceColor = Color.White;
const CARD_BACKGROUND: ResourceColor = '#F9F9F9';
const PROMO_CARD_BACKGROUND: ResourceColor = '#F0F0F0';
const LIGHT_GREY_BORDER: ResourceColor = '#EEEEEE';
const VERY_LIGHT_GREY_BORDER: ResourceColor = '#E0E0E0';

interface TeaGuide {
  id: number;
  name: string;
  origin: string;
  temp: string;
  time: string;
  colorCode: ResourceColor;
  borderColor: ResourceColor;
}

const sampleTeas: TeaGuide[] = [
  {
    id: 1,
    name: 'Sencha Green',
    origin: 'Japan',
    temp: '70°C / 158°F',
    time: '1-2 min',
    colorCode: '#8BC34A',
    borderColor: 'rgba(139, 195, 74, 0.3)'
  },
  {
    id: 2,
    name: 'Earl Grey',
    origin: 'Blend',
    temp: '95°C / 203°F',
    time: '3-5 min',
    colorCode: '#795548',
    borderColor: 'rgba(121, 85, 72, 0.3)'
  },
  {
    id: 3,
    name: 'Silver Needle',
    origin: 'China',
    temp: '80°C / 176°F',
    time: '3-4 min',
    colorCode: '#E0E0E0',
    borderColor: 'rgba(224, 224, 224, 0.3)'
  },
  {
    id: 4,
    name: 'Darjeeling',
    origin: 'India',
    temp: '90°C / 194°F',
    time: '3 min',
    colorCode: '#D7CCC8',
    borderColor: 'rgba(215, 204, 200, 0.3)'
  },
  {
    id: 5,
    name: 'Chamomile',
    origin: 'Egypt',
    temp: '100°C / 212°F',
    time: '5-7 min',
    colorCode: '#FFEB3B',
    borderColor: 'rgba(255, 235, 59, 0.3)'
  },
  {
    id: 6,
    name: 'Matcha',
    origin: 'Japan',
    temp: '80°C / 176°F',
    time: 'Whisk',
    colorCode: '#4CAF50',
    borderColor: 'rgba(76, 175, 80, 0.3)'
  },
  {
    id: 7,
    name: 'Oolong',
    origin: 'Taiwan',
    temp: '85°C / 185°F',
    time: '3-5 min',
    colorCode: '#FF9800',
    borderColor: 'rgba(255, 152, 0, 0.3)'
  }
];

@Entry
@Component
struct ZenBrewApp {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Scroll() {
        Column({ space: 16 }) {
          Row() {
            Column() {
              Text('ZenBrew')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(PRIMARY_BLACK)
                .letterSpacing(-0.5)

              Text('Mindful Steeping Guide')
                .fontSize(14)
                .fontWeight(FontWeight.Regular)
                .fontColor(TEXT_GREY)
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Button({ type: ButtonType.Normal }) {
              Text('⚙')
                .fontSize(24)
                .fontColor(PRIMARY_BLACK)
            }
            .width(44)
            .height(44)
            .padding(0)
            .backgroundColor(Color.Transparent)
            .borderRadius(22)
            .onClick(() => {
              console.info('Settings tapped');
            })
          }
          .width('100%')
          .alignItems(VerticalAlign.Top)
          .padding({ top: 10 })
          .margin({ left: 20, right: 20 })

          PromoCard()
            .margin({ left: 20, right: 20 })

          Text('Collections')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(PRIMARY_BLACK)
            .width('100%')
            .padding({ top: 8, bottom: 8 })
            .margin({ left: 20, right: 20 })

          ForEach(sampleTeas, (tea: TeaGuide) => {
            TeaItemCard({ tea: tea })
              .margin({ left: 20, right: 20 })
          }, (tea: TeaGuide) => tea.id.toString())

          Blank()
            .height(80)
        }
        .width('100%')
        .padding({ top: 10, bottom: 10 })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .backgroundColor(BACKGROUND_WHITE)

      Button({ type: ButtonType.Normal }) {
        Row({ space: 8 }) {
          Text('+')
            .fontSize(24)
            .fontWeight(FontWeight.Regular)
            .fontColor(Color.White)

          Text('Custom Brew')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
        }
        .height(56)
        .padding({ left: 24, right: 24 })
        .alignItems(VerticalAlign.Center)
      }
      .height(56)
      .backgroundColor(PRIMARY_BLACK)
      .borderRadius(16)
      .padding(0)
      .margin({ right: 20, bottom: 20 })
      .onClick(() => {
        console.info('Custom Brew tapped');
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_WHITE)
  }
}

@Component
struct PromoCard {
  build() {
    Row() {
      Column() {
        Text('Tip of the day')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .margin({ bottom: 4 })

        Text('Use filtered water for a purer taste profile.')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(PRIMARY_BLACK)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank()
        .width(16)

      Stack({ alignContent: Alignment.Center }) {
        Text('ⓘ')
          .fontSize(26)
          .fontColor(Color.Gray)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.White)
      .borderRadius(24)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(24)
    .backgroundColor(PROMO_CARD_BACKGROUND)
    .borderRadius(20)
  }
}

@Component
struct TeaItemCard {
  @Prop tea: TeaGuide = sampleTeas[0];

  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Text(this.tea.name.substring(0, 1))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.tea.colorCode)
      }
      .width(50)
      .height(50)
      .backgroundColor(Color.White)
      .borderRadius(25)
      .border({
        width: 2,
        color: this.tea.borderColor
      })

      Blank()
        .width(16)

      Column() {
        Text(this.tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY_BLACK)

        Text(this.tea.origin)
          .fontSize(12)
          .fontColor(TEXT_GREY)

        Blank()
          .height(6)

        Row() {
          InfoBadge({ label: this.tea.temp })

          Blank()
            .width(8)

          InfoBadge({ label: this.tea.time })
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button({ type: ButtonType.Normal }) {
        Text('▶')
          .fontSize(18)
          .fontColor(PRIMARY_BLACK)
      }
      .width(40)
      .height(40)
      .padding(0)
      .backgroundColor(Color.White)
      .borderRadius(20)
      .border({
        width: 1,
        color: VERY_LIGHT_GREY_BORDER
      })
      .onClick(() => {
        console.info(`Play for ${this.tea.name} tapped`);
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .backgroundColor(CARD_BACKGROUND)
    .borderRadius(16)
    .border({
      width: 1,
      color: LIGHT_GREY_BORDER
    })
  }
}

@Component
struct InfoBadge {
  @Prop label: string = '';

  build() {
    Text(this.label)
      .fontSize(11)
      .fontColor(Color.Black)
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor(Color.White)
      .borderRadius(6)
      .border({
        width: 1,
        color: VERY_LIGHT_GREY_BORDER
      })
  }
}