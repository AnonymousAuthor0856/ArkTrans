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

@Entry
@Component
struct MainActivity {
  private teas: TeaGuide[] = [
    new TeaGuide(1, 'Sencha Green', 'Japan', '70°C / 158°F', '1-2 min', '#8BC34A'),
    new TeaGuide(2, 'Earl Grey', 'Blend', '95°C / 203°F', '3-5 min', '#795548'),
    new TeaGuide(3, 'Silver Needle', 'China', '80°C / 176°F', '3-4 min', '#E0E0E0'),
    new TeaGuide(4, 'Darjeeling', 'India', '90°C / 194°F', '3 min', '#D7CCC8'),
    new TeaGuide(5, 'Chamomile', 'Egypt', '100°C / 212°F', '5-7 min', '#FFEB3B'),
    new TeaGuide(6, 'Matcha', 'Japan', '80°C / 176°F', 'Whisk', '#4CAF50'),
    new TeaGuide(7, 'Oolong', 'Taiwan', '85°C / 185°F', '3-5 min', '#FF9800')
  ];

  @Builder
  TopBar() {
    Row() {
      Column() {
        Text('ZenBrew')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1F1F1F')
        Text('Mindful Steeping Guide')
          .fontSize(14)
          .fontColor('#777777')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('⚙')
        .fontSize(22)
        .fontColor('#333333')
        .backgroundColor('#F1F1F1')
        .width(46)
        .height(46)
        .borderRadius(23)
    }
    .width('100%')
    .padding({ left: 22, right: 22, top: 24, bottom: 14 })
  }

  @Builder
  PromoCard() {
    Column() {
      Text('Tip of the day')
        .fontSize(15)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E4A22')
      Text('Use filtered water for a purer taste profile.')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1F1F1F')
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(20)
    .backgroundColor('#EAF5E2')
    .borderRadius(24)
    .margin({ top: 4, bottom: 26 })
  }

  @Builder
  InfoBadge(label: string) {
    Text(label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor('#4A4A4A')
      .padding({ left: 10, right: 10, top: 6, bottom: 6 })
      .backgroundColor('#F1F1F1')
      .borderRadius(14)
  }

  @Builder
  TeaItemCard(tea: TeaGuide) {
    Row() {
      Stack() {
        Circle()
          .width(54)
          .height(54)
          .fill(tea.colorCode)
        Text(tea.name.substring(0, 1))
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
      }
      .width(54)
      .height(54)
      .margin({ right: 16 })

      Column() {
        Text(tea.name)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#222222')
        Text(tea.origin)
          .fontSize(13)
          .fontColor('#888888')
          .margin({ top: 2, bottom: 10 })
        Row() {
          this.InfoBadge(tea.temp)
          this.InfoBadge(tea.time)
            .margin({ left: 8 })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('▶')
        .fontSize(16)
        .fontColor('#FFFFFF')
        .backgroundColor('#222222')
        .width(42)
        .height(42)
        .borderRadius(21)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F9F9F9')
    .borderRadius(24)
    .margin({ bottom: 14 })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopBar()
        Scroll() {
          Column() {
            this.PromoCard()
            Text('Collections')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1F1F1F')
              .width('100%')
              .margin({ bottom: 16 })

            ForEach(this.teas, (tea: TeaGuide) => {
              this.TeaItemCard(tea)
            }, (tea: TeaGuide) => tea.id.toString())
          }
          .width('100%')
          .padding({ left: 22, right: 22, bottom: 100 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      Button('+  Custom Brew')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .backgroundColor('#1F1F1F')
        .height(54)
        .padding({ left: 22, right: 22 })
        .borderRadius(27)
        .margin({ right: 22, bottom: 26 })
    }
    .width('100%')
    .height('100%')
  }
}
