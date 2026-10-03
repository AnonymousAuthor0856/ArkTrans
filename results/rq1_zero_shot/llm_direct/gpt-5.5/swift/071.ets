const QFColor = {
  background: '#FFFCF9',
  cardBg: '#FFF5F0',
  textDark: '#291E17',
  textSub: '#6E6661',
  textGold: '#FCD462',
  headerCircle: '#FCE4D1',
  progressOrange: '#FF9642',
  progressTrack: '#EBE6F5',
  optionBg: '#FFE4CC',
  optionBorder: '#DFAA80',
  hintBg: '#FCECCF',
  trackerBg: '#FFE4CE'
}

@Entry
@Component
struct QuizForgeApp {
  build() {
    Stack() {
      Column() {
        HeaderView()
          .padding({ top: 10, bottom: 10 })

        Scroll() {
          Column({ space: 30 }) {
            QuizCard()

            Column({ space: 16 }) {
              Text('Trackers')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(QFColor.textDark)
                .padding({ left: 4 })

              Row({ space: 12 }) {
                TrackerCard({
                  label: 'Current\nstreak',
                  value: '5 days'
                })

                TrackerCard({
                  label: 'Accuracy',
                  value: '84%'
                })

                TrackerCard({
                  label: 'Rank',
                  value: 'Top 12%'
                })
              }
              .width('100%')
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(QFColor.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

@Component
struct QuizCard {
  build() {
    Column() {
      Row() {
        Text('Citrus crafts')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
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
        Row()
          .width(100)
          .height(5)
          .backgroundColor(QFColor.progressOrange)
          .borderRadius(3)

        Stack({ alignContent: Alignment.End }) {
          Row()
            .width('100%')
            .height(5)
            .backgroundColor(QFColor.progressTrack)
            .borderRadius(3)

          Circle()
            .width(4)
            .height(4)
            .fill(QFColor.progressOrange)
            .translate({ x: 2 })
        }
        .height(5)
        .layoutWeight(1)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 10, bottom: 12 })

      Text('Which zest carrier gives the brightest aroma when infused cold?')
        .fontSize(23)
        .fontWeight(FontWeight.Bold)
        .fontColor(QFColor.textDark)
        .lineHeight(31)
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 24 })

      Column({ space: 12 }) {
        OptionButton({ text: 'Dried peel sachet' })
        OptionButton({ text: 'Twist garnish' })
        OptionButton({ text: 'Zester microplane' })
        OptionButton({ text: 'Candied strip' })
      }
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 24 })

      Row() {
        Text('Hint: Think surface area')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(QFColor.textDark)
      }
      .padding({ top: 10, bottom: 10, left: 16, right: 16 })
      .backgroundColor(QFColor.hintBg)
      .borderRadius(12)
      .margin({ left: 24, bottom: 24 })
      .alignSelf(ItemAlign.Start)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(QFColor.cardBg)
    .borderRadius(36)
  }
}

@Component
struct HeaderView {
  build() {
    Row() {
      Circle()
        .width(48)
        .height(48)
        .fill(QFColor.headerCircle)

      Blank()

      Column({ space: 2 }) {
        Text('QuizForge')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Text('Aroma sprint')
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(QFColor.textSub)
      }

      Blank()

      Circle()
        .width(48)
        .height(48)
        .fill(QFColor.headerCircle)
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
  }
}

@Component
struct OptionButton {
  @Prop text: string

  build() {
    Row() {
      Text(this.text)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(QFColor.textDark)

      Blank()
    }
    .width('100%')
    .padding({ top: 14, bottom: 14, left: 18, right: 18 })
    .backgroundColor(QFColor.optionBg)
    .borderRadius(16)
    .border({
      width: 1,
      color: QFColor.optionBorder
    })
  }
}

@Component
struct TrackerCard {
  @Prop label: string
  @Prop value: string

  build() {
    Column() {
      Text(this.label)
        .fontSize(13)
        .fontWeight(FontWeight.Regular)
        .fontColor(QFColor.textSub)

      Blank()

      Text(this.value)
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
    .padding({ top: 20, bottom: 20, left: 16, right: 16 })
    .backgroundColor(QFColor.trackerBg)
    .borderRadius(24)
  }
}