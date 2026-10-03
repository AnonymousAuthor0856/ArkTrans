interface TeaGuide {
  id: number;
  name: string;
  origin: string;
  temp: string;
  time: string;
  colorCode: string;
  borderColor: string;
}

const PRIMARY_BLACK: string = '#121212';
const TEXT_GREY: string = '#757575';
const CARD_BACKGROUND: string = '#F9F9F9';

const SAMPLE_TEAS: TeaGuide[] = [
  {
    id: 1,
    name: 'Sencha Green',
    origin: 'Japan',
    temp: '70°C / 158°F',
    time: '1-2 min',
    colorCode: '#8BC34A',
    borderColor: '#4D8BC34A'
  },
  {
    id: 2,
    name: 'Earl Grey',
    origin: 'Blend',
    temp: '95°C / 203°F',
    time: '3-5 min',
    colorCode: '#795548',
    borderColor: '#4D795548'
  },
  {
    id: 3,
    name: 'Silver Needle',
    origin: 'China',
    temp: '80°C / 176°F',
    time: '3-4 min',
    colorCode: '#E0E0E0',
    borderColor: '#4DE0E0E0'
  },
  {
    id: 4,
    name: 'Darjeeling',
    origin: 'India',
    temp: '90°C / 194°F',
    time: '3 min',
    colorCode: '#D7CCC8',
    borderColor: '#4DD7CCC8'
  },
  {
    id: 5,
    name: 'Chamomile',
    origin: 'Egypt',
    temp: '100°C / 212°F',
    time: '5-7 min',
    colorCode: '#FFEB3B',
    borderColor: '#4DFFEB3B'
  },
  {
    id: 6,
    name: 'Matcha',
    origin: 'Japan',
    temp: '80°C / 176°F',
    time: 'Whisk',
    colorCode: '#4CAF50',
    borderColor: '#4D4CAF50'
  },
  {
    id: 7,
    name: 'Oolong',
    origin: 'Taiwan',
    temp: '85°C / 185°F',
    time: '3-5 min',
    colorCode: '#FF9800',
    borderColor: '#4DFF9800'
  }
];

@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        this.TopBar()

        Scroll() {
          Column() {
            this.PromoCard()

            Text('Collections')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(PRIMARY_BLACK)
              .width('100%')
              .margin({ top: 28, bottom: 18 })

            ForEach(SAMPLE_TEAS, (tea: TeaGuide) => {
              this.TeaItemCard(tea)
            }, (tea: TeaGuide) => tea.id.toString())

            Blank()
              .height(96)
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 10 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)

      Column() {
        Blank()
          .layoutWeight(1)

        Row() {
          Blank()
            .layoutWeight(1)

          this.CustomBrewButton()
        }
        .width('100%')
        .padding({ right: 16, bottom: 32 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  TopBar() {
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
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Text('⚙')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY_BLACK)
          .textAlign(TextAlign.Center)
      }
      .width(48)
      .height(48)
      .backgroundColor('#00000000')
      .onClick(() => {
      })
    }
    .width('100%')
    .height(64)
    .padding({ left: 16, right: 16 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
  }

  @Builder
  PromoCard() {
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
          .lineHeight(24)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Blank()
        .width(16)

      Stack() {
        Text('i')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .textAlign(TextAlign.Center)
          .width(20)
          .height(20)
          .backgroundColor('#888888')
          .borderRadius(10)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.White)
      .borderRadius(24)
    }
    .width('100%')
    .padding(24)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#F0F0F0')
    .borderRadius(20)
  }

  @Builder
  TeaItemCard(tea: TeaGuide) {
    Row() {
      Stack() {
        Text(tea.name.substring(0, 1))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(tea.colorCode)
          .textAlign(TextAlign.Center)
      }
      .width(50)
      .height(50)
      .backgroundColor(Color.White)
      .borderRadius(25)
      .border({ width: 2, color: tea.borderColor })

      Blank()
        .width(16)

      Column() {
        Text(tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY_BLACK)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(tea.origin)
          .fontSize(12)
          .fontColor(TEXT_GREY)
          .margin({ top: 2 })

        Row() {
          this.InfoBadge(tea.temp)

          Blank()
            .width(8)

          this.InfoBadge(tea.time)
        }
        .margin({ top: 6 })
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Text('▶')
          .fontSize(20)
          .fontColor(PRIMARY_BLACK)
          .textAlign(TextAlign.Center)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#E0E0E0' })
      .onClick(() => {
      })
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(CARD_BACKGROUND)
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
    .margin({ bottom: 16 })
  }

  @Builder
  InfoBadge(label: string) {
    Text(label)
      .fontSize(11)
      .fontColor(PRIMARY_BLACK)
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#E0E0E0' })
      .borderRadius(6)
  }

  @Builder
  CustomBrewButton() {
    Button({ type: ButtonType.Normal, stateEffect: true }) {
      Row() {
        Text('+')
          .fontSize(26)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)

        Blank()
          .width(8)

        Text('Custom Brew')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
      }
      .alignItems(VerticalAlign.Center)
    }
    .height(56)
    .padding({ left: 18, right: 22 })
    .backgroundColor(PRIMARY_BLACK)
    .borderRadius(16)
    .onClick(() => {
    })
  }
}