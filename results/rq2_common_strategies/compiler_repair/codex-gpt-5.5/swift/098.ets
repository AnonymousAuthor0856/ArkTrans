class TeaGuide {
  id: number
  name: string
  origin: string
  temp: string
  time: string
  colorCode: string

  constructor(id: number, name: string, origin: string, temp: string, time: string, colorCode: string) {
    this.id = id
    this.name = name
    this.origin = origin
    this.temp = temp
    this.time = time
    this.colorCode = colorCode
  }
}

@Entry
@Component
struct Index {
  private readonly primaryBlack: string = '#121212'
  private readonly textGrey: string = '#757575'
  private readonly cardBackground: string = '#F9F9F9'
  private readonly promoCardBackground: string = '#F0F0F0'
  private readonly lightGreyBorder: string = '#EEEEEE'
  private readonly veryLightGreyBorder: string = '#E0E0E0'
  private readonly sampleTeas: TeaGuide[] = [
    new TeaGuide(1, 'Sencha Green', 'Japan', '70°C / 158°F', '1-2 min', '#8BC34A'),
    new TeaGuide(2, 'Earl Grey', 'Blend', '95°C / 203°F', '3-5 min', '#795548'),
    new TeaGuide(3, 'Silver Needle', 'China', '80°C / 176°F', '3-4 min', '#E0E0E0'),
    new TeaGuide(4, 'Darjeeling', 'India', '90°C / 194°F', '3 min', '#D7CCC8'),
    new TeaGuide(5, 'Chamomile', 'Egypt', '100°C / 212°F', '5-7 min', '#FFEB3B'),
    new TeaGuide(6, 'Matcha', 'Japan', '80°C / 176°F', 'Whisk', '#4CAF50'),
    new TeaGuide(7, 'Oolong', 'Taiwan', '85°C / 185°F', '3-5 min', '#FF9800')
  ]

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Scroll() {
        Column() {
          this.TopBar()
          this.PromoCard()
          Text('Collections')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.primaryBlack)
            .width('100%')
            .padding({ left: 20, right: 20, top: 8, bottom: 8 })
          ForEach(this.sampleTeas, (tea: TeaGuide) => {
            this.TeaItemCard(tea)
          }, (tea: TeaGuide) => tea.id.toString())
          Blank().height(80)
        }
        .width('100%')
        .padding({ top: 10, bottom: 10 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
      .scrollBar(BarState.Off)
      this.CustomBrewButton()
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
          .fontColor(this.primaryBlack)
          .letterSpacing(-0.5)
        Text('Mindful Steeping Guide')
          .fontSize(14)
          .fontColor(this.textGrey)
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor(this.primaryBlack)
      }
      .width(44)
      .height(44)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 10 })
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
          .fontColor(this.primaryBlack)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      Blank().width(16)
      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill(Color.White)
        Text('i')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .padding(24)
    .margin({ left: 20, right: 20, top: 16, bottom: 16 })
    .backgroundColor(this.promoCardBackground)
    .borderRadius(20)
  }

  @Builder
  TeaItemCard(tea: TeaGuide) {
    Row() {
      Stack() {
        Circle()
          .width(50)
          .height(50)
          .fill(Color.White)
          .stroke(tea.colorCode)
          .strokeWidth(2)
        Text(tea.name.substring(0, 1))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(tea.colorCode)
      }
      .width(50)
      .height(50)
      Blank().width(16)
      Column() {
        Text(tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.primaryBlack)
        Text(tea.origin)
          .fontSize(12)
          .fontColor(this.textGrey)
        Blank().height(6)
        Row() {
          this.InfoBadge(tea.temp)
          Blank().width(8)
          this.InfoBadge(tea.time)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      Button() {
        Text('▶')
          .fontSize(20)
          .fontColor(this.primaryBlack)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(Color.White)
      .border({ width: 1, color: this.veryLightGreyBorder })
    }
    .width('100%')
    .padding(16)
    .margin({ left: 20, right: 20, bottom: 16 })
    .backgroundColor(this.cardBackground)
    .borderRadius(16)
    .border({ width: 1, color: this.lightGreyBorder })
  }

  @Builder
  InfoBadge(label: string) {
    Text(label)
      .fontSize(11)
      .fontColor(Color.Black)
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor(Color.White)
      .borderRadius(6)
      .border({ width: 1, color: this.veryLightGreyBorder })
  }

  @Builder
  CustomBrewButton() {
    Button() {
      Row() {
        Text('+')
          .fontSize(20)
          .fontColor(Color.White)
        Text('Custom Brew')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
          .margin({ left: 8 })
      }
      .justifyContent(FlexAlign.Center)
    }
    .height(56)
    .padding({ left: 24, right: 24 })
    .backgroundColor(this.primaryBlack)
    .borderRadius(16)
    .margin({ right: 20, bottom: 20 })
  }
}