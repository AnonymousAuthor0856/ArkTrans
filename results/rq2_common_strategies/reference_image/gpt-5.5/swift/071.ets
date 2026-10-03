class QFColor {
  static readonly background: string = '#FFFCF9'
  static readonly cardBg: string = '#FFF3E8'

  static readonly textDark: string = '#291E17'
  static readonly textSub: string = '#6E6661'
  static readonly textGold: string = '#FCD462'

  static readonly headerCircle: string = '#FCE4D1'

  static readonly progressOrange: string = '#FF9642'
  static readonly progressTrack: string = '#EBE6F5'

  static readonly optionBg: string = '#FFE4CC'
  static readonly optionBorder: string = '#DFAA80'

  static readonly hintBg: string = '#FCECCF'
  static readonly trackerBg: string = '#FFE4CE'
}

@Entry
@Component
struct QuizForgeApp {
  build() {
    Stack() {
      Column() {
        this.HeaderView()

        Scroll() {
          Column({ space: 30 }) {
            this.QuizCard()

            Column({ space: 16 }) {
              Text('Trackers')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(QFColor.textDark)
                .margin({ left: 4 })

              Row({ space: 12 }) {
                this.TrackerCard('Current\nstreak', '5 days')
                this.TrackerCard('Accuracy', '84%')
                this.TrackerCard('Rank', 'Top 12%')
              }
              .width('100%')
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(QFColor.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(QFColor.background)
  }

  @Builder
  HeaderView() {
    Row() {
      Row() {}
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor(QFColor.headerCircle)

      Blank()

      Column({ space: 2 }) {
        Text('QuizForge')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Text('Aroma sprint')
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(QFColor.textSub)
      }

      Blank()

      Row() {}
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor(QFColor.headerCircle)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 10, bottom: 10 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  QuizCard() {
    Column() {
      Row() {
        Text('Citrus crafts')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(QFColor.textDark)

        Blank()

        Text('45%')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(QFColor.textGold)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 24 })

      Row({ space: 4 }) {
        Row() {}
        .width(100)
        .height(5)
        .borderRadius(3)
        .backgroundColor(QFColor.progressOrange)

        Stack({ alignContent: Alignment.End }) {
          Row() {}
          .width('100%')
          .height(5)
          .borderRadius(3)
          .backgroundColor(QFColor.progressTrack)

          Row() {}
          .width(4)
          .height(4)
          .borderRadius(2)
          .backgroundColor(QFColor.progressOrange)
          .translate({ x: 2 })
        }
        .layoutWeight(1)
        .height(5)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 10, bottom: 12 })

      Text('Which zest carrier gives the brightest aroma when infused cold?')
        .width('100%')
        .fontSize(23)
        .fontWeight(FontWeight.Bold)
        .fontColor(QFColor.textDark)
        .lineHeight(32)
        .padding({ left: 24, right: 24, bottom: 24 })

      Column({ space: 12 }) {
        this.OptionButton('Dried peel sachet')
        this.OptionButton('Twist garnish')
        this.OptionButton('Zester microplane')
        this.OptionButton('Candied strip')
      }
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 24 })

      Row() {
        Text('Hint: Think surface area')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(QFColor.textDark)
      }
      .padding({ left: 16, right: 16, top: 10, bottom: 10 })
      .borderRadius(12)
      .backgroundColor(QFColor.hintBg)
      .margin({ left: 24, bottom: 24 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(QFColor.cardBg)
    .borderRadius(36)
  }

  @Builder
  OptionButton(text: string) {
    Row() {
      Text(text)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(QFColor.textDark)

      Blank()
    }
    .width('100%')
    .padding({ left: 18, right: 18, top: 14, bottom: 14 })
    .backgroundColor(QFColor.optionBg)
    .borderRadius(16)
    .border({
      width: 1,
      color: QFColor.optionBorder
    })
  }

  @Builder
  TrackerCard(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(13)
        .fontWeight(FontWeight.Regular)
        .fontColor(QFColor.textSub)

      Blank()

      Text(value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(QFColor.textDark)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .layoutWeight(1)
    .height(100)
    .padding({ left: 16, right: 16, top: 20, bottom: 20 })
    .backgroundColor(QFColor.trackerBg)
    .borderRadius(24)
  }
}