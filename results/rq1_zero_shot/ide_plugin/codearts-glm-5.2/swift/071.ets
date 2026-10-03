class QfColors {
  static readonly background: string = '#FFFFFCF9'
  static readonly cardBg: string = '#FFFFF5F0'
  static readonly textDark: string = '#FF291E17'
  static readonly textSub: string = '#FF6E6661'
  static readonly textGold: string = '#FFFCD462'
  static readonly headerCircle: string = '#FFFCE4D1'
  static readonly progressOrange: string = '#FFFF9642'
  static readonly progressTrack: string = '#FFEBE6F5'
  static readonly optionBg: string = '#FFFDECD9'
  static readonly optionBorder: string = '#FFEBCBA6'
  static readonly hintBg: string = '#FFFCECCF'
  static readonly trackerBg: string = '#FFFFE4CE'
  static readonly quizCardBg: string = '#FFFFF3E8'
  static readonly optionFill: string = '#FFFFE4CC'
  static readonly optionStroke: string ='#FFDFAA80'
}

@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        HeaderView()

        Scroll() {
          Column() {
            Column() {
              Row() {
                Text('Citrus crafts')
                  .fontSize(18)
                  .fontWeight(FontWeight.SemiBold)
                  .fontColor(QfColors.textDark)
                Blank()
                Text('45%')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(QfColors.textGold)
              }
              .padding({ left: 24, right: 24 })
              .margin({ top: 24 })

              Row() {
                Column() {
                  Blank()
                }
                .width(100)
                .height(5)
                .backgroundColor(QfColors.progressOrange)
                .borderRadius(2.5)

                Stack() {
                  Column() {
                    Blank()
                  }
                  .height(5)
                  .backgroundColor(QfColors.progressTrack)
                  .borderRadius(2.5)
                  .layoutWeight(1)

                  Circle({ width: 4, height: 4 })
                    .fill(QfColors.progressOrange)
                    .margin({ right: -2 })
                }
                .layoutWeight(1)
                .alignContent(Alignment.End)
              }
              .padding({ left: 24, right: 24 })
              .margin({ top: 10, bottom: 12 })

              Text('Which zest carrier gives the brightest aroma when infused cold?')
                .fontSize(23)
                .fontWeight(FontWeight.Bold)
                .fontColor(QfColors.textDark)
                .lineHeight(27)
                .padding({ left: 24, right: 24 })
                .margin({ bottom: 24 })

              Column() {
                OptionButton({ text: 'Dried peel sachet' })
                OptionButton({ text: 'Twist garnish' })
                OptionButton({ text: 'Zester microplane' })
                OptionButton({ text: 'Candied strip' })
              }
              .padding({ left: 24, right: 24 })
              .margin({ bottom: 24 })

              Text('Hint: Think surface area')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(QfColors.textDark)
                .padding({ top: 10, bottom: 10, left: 16, right: 16 })
                .backgroundColor(QfColors.hintBg)
                .borderRadius(12)
                .margin({ left: 24, right: 24, bottom: 24 })
            }
            .backgroundColor(QfColors.quizCardBg)
            .borderRadius(36)
            .alignItems(HorizontalAlign.Start)
            .margin({ bottom: 30 })

            Column() {
              Text('Trackers')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(QfColors.textDark)
                .margin({ left: 4, bottom: 16 })

              Row() {
                TrackerCard({ label: 'Current\nstreak', value: '5 days' })
                TrackerCard({ label: 'Accuracy', value: '84%' })
                TrackerCard({ label: 'Rank', value: 'Top 12%' })
              }
            }
            .alignItems(HorizontalAlign.Start)
          }
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
    }
    .backgroundColor(QfColors.background)
    .width('100%')
    .height('100%')
  }
}

@Component
struct HeaderView {
  build() {
    Row() {
      Circle({ width: 48, height: 48 })
        .fill(QfColors.headerCircle)

      Blank()

      Column() {
        Text('QuizForge')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF000000')
        Text('Aroma sprint')
          .fontSize(14)
          .fontColor(QfColors.textSub)
      }
      .margin({ top: 2, bottom: 2 })

      Blank()

      Circle({ width: 48, height: 48 })
        .fill(QfColors.headerCircle)
    }
    .padding({ left: 24, right: 24 })
    .margin({ top: 10, bottom: 10 })
  }
}

@Component
struct OptionButton {
  @Prop text: string = ''

  build() {
    Row() {
      Text(this.text)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(QfColors.textDark)
      Blank()
    }
    .padding({ top: 14, bottom: 14, left: 18, right: 18 })
    .backgroundColor(QfColors.optionFill)
    .borderRadius(16)
    .border({ width: 1, color: QfColors.optionStroke })
  }
}

@Component
struct TrackerCard {
  @Prop label: string = ''
  @Prop value: string = ''

  build() {
    Column() {
      Text(this.label)
        .fontSize(13)
        .fontColor(QfColors.textSub)

      Blank()

      Text(this.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(QfColors.textDark)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .padding({ top: 20, bottom: 20, left: 16, right: 16 })
    .layoutWeight(1)
    .height(100)
    .backgroundColor(QfColors.trackerBg)
    .borderRadius(24)
    .alignItems(HorizontalAlign.Start)
  }
}