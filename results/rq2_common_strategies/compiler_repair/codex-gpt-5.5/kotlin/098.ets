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
  private teas: TeaGuide[] = [
    new TeaGuide(1, 'Sencha Green', 'Japan', '70°C / 158°F', '1-2 min', '#8BC34A'),
    new TeaGuide(2, 'Earl Grey', 'Blend', '95°C / 203°F', '3-5 min', '#795548'),
    new TeaGuide(3, 'Silver Needle', 'China', '80°C / 176°F', '3-4 min', '#E0E0E0'),
    new TeaGuide(4, 'Darjeeling', 'India', '90°C / 194°F', '3 min', '#D7CCC8'),
    new TeaGuide(5, 'Chamomile', 'Egypt', '100°C / 212°F', '5-7 min', '#FFEB3B'),
    new TeaGuide(6, 'Matcha', 'Japan', '80°C / 176°F', 'Whisk', '#4CAF50'),
    new TeaGuide(7, 'Oolong', 'Taiwan', '85°C / 185°F', '3-5 min', '#FF9800')
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()
        Scroll() {
          Column() {
            this.PromoCard()
            Text('Collections')
              .width('100%')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#121212')
              .padding({ top: 8, bottom: 8 })
            ForEach(this.teas, (tea: TeaGuide) => {
              this.TeaItemCard(tea)
            })
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 10, bottom: 88 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      Button() {
        Row() {
          Text('+')
            .fontSize(20)
            .fontColor(Color.White)
          Text('Custom Brew')
            .fontSize(14)
            .fontColor(Color.White)
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)
      }
      .height(56)
      .borderRadius(16)
      .backgroundColor('#121212')
      .padding({ left: 20, right: 20 })
      .margin({ right: 20, bottom: 20 })
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
          .fontColor('#121212')
        Text('Mindful Steeping Guide')
          .fontSize(14)
          .fontColor('#757575')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      Button('⚙')
        .fontSize(24)
        .fontColor('#121212')
        .backgroundColor(Color.Transparent)
        .width(48)
        .height(48)
        .padding(0)
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 16, bottom: 12 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  PromoCard() {
    Row() {
      Column() {
        Text('Tip of the day')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
        Text('Use filtered water for a purer taste profile.')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#121212')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill(Color.White)
        Text('i')
          .fontSize(22)
          .fontColor(Color.Gray)
      }
      .margin({ left: 16 })
    }
    .width('100%')
    .padding(24)
    .borderRadius(20)
    .backgroundColor('#F0F0F0')
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 16 })
  }

  @Builder
  TeaItemCard(tea: TeaGuide) {
    Row() {
      Stack() {
        Circle()
          .width(50)
          .height(50)
          .fill(Color.White)
          .stroke(this.softColor(tea.colorCode))
          .strokeWidth(2)
        Text(tea.name.substring(0, 1))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(tea.colorCode)
      }
      .width(50)
      .height(50)

      Column() {
        Text(tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor('#121212')
        Text(tea.origin)
          .fontSize(12)
          .fontColor('#757575')
          .margin({ top: 2 })
        Row() {
          this.InfoBadge(tea.temp)
          this.InfoBadge(tea.time)
        }
        .margin({ top: 6 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      Button('▶')
        .fontSize(20)
        .fontColor('#121212')
        .width(40)
        .height(40)
        .border({ width: 1, color: '#E0E0E0', radius: 20 })
        .backgroundColor(Color.White)
        .padding(0)
    }
    .width('100%')
    .padding(16)
    .border({ width: 1, color: '#EEEEEE', radius: 16 })
    .backgroundColor('#F9F9F9')
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 16 })
  }

  @Builder
  InfoBadge(label: string) {
    Text(label)
      .fontSize(11)
      .fontColor(Color.Black)
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .border({ width: 1, color: '#E0E0E0', radius: 6 })
      .backgroundColor(Color.White)
      .margin({ right: 8 })
  }

  softColor(color: string): string {
    if (color === '#8BC34A') { return 'rgba(139,195,74,0.3)' }
    if (color === '#795548') { return 'rgba(121,85,72,0.3)' }
    if (color === '#E0E0E0') { return 'rgba(224,224,224,0.6)' }
    if (color === '#D7CCC8') { return 'rgba(215,204,200,0.6)' }
    if (color === '#FFEB3B') { return 'rgba(255,235,59,0.4)' }
    if (color === '#4CAF50') { return 'rgba(76,175,80,0.3)' }
    return 'rgba(255,152,0,0.3)'
  }
}
