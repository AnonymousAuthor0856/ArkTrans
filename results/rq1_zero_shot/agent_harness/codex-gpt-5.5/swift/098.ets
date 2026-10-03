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

const ZEN_PRIMARY_BLACK: string = '#121212';
const ZEN_TEXT_GREY: string = '#757575';
const ZEN_BACKGROUND_WHITE: string = '#FFFFFF';
const ZEN_CARD_BACKGROUND: string = '#F9F9F9';
const ZEN_PROMO_BACKGROUND: string = '#F0F0F0';
const ZEN_LIGHT_BORDER: string = '#EEEEEE';
const ZEN_VERY_LIGHT_BORDER: string = '#E0E0E0';

const SAMPLE_TEAS: TeaGuide[] = [
  new TeaGuide(1, 'Sencha Green', 'Japan', '70°C / 158°F', '1-2 min', '#8BC34A'),
  new TeaGuide(2, 'Earl Grey', 'Blend', '95°C / 203°F', '3-5 min', '#795548'),
  new TeaGuide(3, 'Silver Needle', 'China', '80°C / 176°F', '3-4 min', '#E0E0E0'),
  new TeaGuide(4, 'Darjeeling', 'India', '90°C / 194°F', '3 min', '#D7CCC8'),
  new TeaGuide(5, 'Chamomile', 'Egypt', '100°C / 212°F', '5-7 min', '#FFEB3B'),
  new TeaGuide(6, 'Matcha', 'Japan', '80°C / 176°F', 'Whisk', '#4CAF50'),
  new TeaGuide(7, 'Oolong', 'Taiwan', '85°C / 185°F', '3-5 min', '#FF9800')
];

@Entry
@Component
struct ZenBrewAppView {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Scroll() {
        Column({ space: 16 }) {
          Row() {
            Column() {
              Text('ZenBrew')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(ZEN_PRIMARY_BLACK)

              Text('Mindful Steeping Guide')
                .fontSize(14)
                .fontColor(ZEN_TEXT_GREY)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button() {
              Text('⚙')
                .fontSize(24)
                .fontColor(ZEN_PRIMARY_BLACK)
            }
            .width(44)
            .height(44)
            .backgroundColor(Color.Transparent)
          }
          .alignItems(VerticalAlign.Top)
          .padding({ left: 20, right: 20, top: 10 })
          .width('100%')

          PromoCard()
            .padding({ left: 20, right: 20 })

          Text('Collections')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(ZEN_PRIMARY_BLACK)
            .width('100%')
            .padding({ left: 20, right: 20, top: 8, bottom: 8 })

          ForEach(SAMPLE_TEAS, (tea: TeaGuide) => {
            TeaItemCard({ tea: tea })
              .padding({ left: 20, right: 20 })
          }, (tea: TeaGuide) => tea.id.toString())

          Blank()
            .height(80)
        }
        .padding({ top: 10, bottom: 10 })
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .backgroundColor(ZEN_BACKGROUND_WHITE)
      .width('100%')
      .height('100%')

      Button() {
        Row({ space: 8 }) {
          Text('+')
            .fontSize(20)
            .fontColor(Color.White)
          Text('Custom Brew')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
        }
        .height(56)
        .padding({ left: 24, right: 24 })
      }
      .backgroundColor(ZEN_PRIMARY_BLACK)
      .borderRadius(16)
      .margin({ right: 20, bottom: 20 })
    }
    .backgroundColor(ZEN_BACKGROUND_WHITE)
    .width('100%')
    .height('100%')
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
          .fontColor(ZEN_PRIMARY_BLACK)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank()
        .width(16)

      Stack() {
        Circle()
          .fill(Color.White)
          .width(48)
          .height(48)

        Text('i')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
      }
      .width(48)
      .height(48)
    }
    .alignItems(VerticalAlign.Center)
    .padding(24)
    .width('100%')
    .backgroundColor(ZEN_PROMO_BACKGROUND)
    .borderRadius(20)
  }
}

@Component
struct TeaItemCard {
  @Prop tea: TeaGuide;

  build() {
    Row() {
      Stack() {
        Circle()
          .fill(Color.White)
          .stroke(this.tea.colorCode)
          .strokeWidth(2)
          .width(50)
          .height(50)
          .opacity(0.85)

        Text(this.tea.name.substring(0, 1))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.tea.colorCode)
      }
      .width(50)
      .height(50)

      Blank()
        .width(16)

      Column() {
        Text(this.tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(ZEN_PRIMARY_BLACK)

        Text(this.tea.origin)
          .fontSize(12)
          .fontColor(ZEN_TEXT_GREY)

        Blank()
          .height(6)

        Row() {
          InfoBadge({ label: this.tea.temp })
          Blank().width(8)
          InfoBadge({ label: this.tea.time })
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button() {
        Text('▶')
          .fontSize(20)
          .fontColor(ZEN_PRIMARY_BLACK)
      }
      .width(40)
      .height(40)
      .type(ButtonType.Circle)
      .backgroundColor(Color.White)
      .border({ width: 1, color: ZEN_VERY_LIGHT_BORDER })
    }
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .width('100%')
    .backgroundColor(ZEN_CARD_BACKGROUND)
    .borderRadius(16)
    .border({ width: 1, color: ZEN_LIGHT_BORDER })
  }
}

@Component
struct InfoBadge {
  @Prop label: string;

  build() {
    Text(this.label)
      .fontSize(11)
      .fontColor(Color.Black)
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor(Color.White)
      .borderRadius(6)
      .border({ width: 1, color: ZEN_VERY_LIGHT_BORDER })
  }
}
