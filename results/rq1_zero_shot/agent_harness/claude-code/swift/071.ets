// MARK: - Color Palette
class QfColors {
  static readonly qfBackground: ResourceStr = '#FFFCF9'
  static readonly qfCardBg: ResourceStr = '#FFF5F0'
  static readonly qfTextDark: ResourceStr = '#291E17'
  static readonly qfTextSub: ResourceStr = '#6E6661'
  static readonly qfTextGold: ResourceStr = '#FCD462'
  static readonly qfHeaderCircle: ResourceStr = '#FCE4D1'
  static readonly qfProgressOrange: ResourceStr = '#FF9642'
  static readonly qfProgressTrack: ResourceStr = '#EBE6F5'
  static readonly qfOptionBg: ResourceStr = '#FDECD9'
  static readonly qfOptionBorder: ResourceStr = '#EBCBA6'
  static readonly qfHintBg: ResourceStr = '#FCECCF'
  static readonly qfTrackerBg: ResourceStr = '#FFE4CE'
  static readonly quizCardBg: ResourceStr = '#FFF3E8'
  static readonly optionFill: ResourceStr = '#FFE4CC'
  static readonly optionBorder: ResourceStr = '#DFAA80'
}

// MARK: - Header Component
@Component
struct HeaderView {
  build() {
    Row() {
      Circle()
        .fill(QfColors.qfHeaderCircle)
        .width(48)
        .height(48)

      Blank()

      Column() {
        Text('QuizForge')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text('Aroma sprint')
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(QfColors.qfTextSub)
      }
      .space(2)

      Blank()

      Circle()
        .fill(QfColors.qfHeaderCircle)
        .width(48)
        .height(48)
    }
    .padding({ left: 24, right: 24 })
  }
}

// MARK: - Option Button Component
@Component
struct OptionButton {
  text: string = ''

  build() {
    Row() {
      Text(this.text)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(QfColors.qfTextDark)
      Blank()
    }
    .padding({ top: 14, bottom: 14, left: 18, right: 18 })
    .backgroundColor(QfColors.optionFill)
    .borderRadius(16)
    .border({
      width: 1,
      color: QfColors.optionBorder,
      radius: 16
    })
  }
}

// MARK: - Tracker Card Component
@Component
struct TrackerCard {
  label: string = ''
  value: string = ''

  build() {
    Column() {
      Text(this.label)
        .fontSize(13)
        .fontWeight(FontWeight.Regular)
        .fontColor(QfColors.qfTextSub)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Clip })
        .width('100%')

      Blank()

      Text(this.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(QfColors.qfTextDark)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
    }
    .width('100%')
    .height(100)
    .padding({ top: 20, bottom: 20, left: 16, right: 16 })
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(QfColors.qfTrackerBg)
    .borderRadius(24)
  }
}

// MARK: - Main Content View
@Entry
@Component
struct ContentView {
  build() {
    Stack() {
      // Global Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(QfColors.qfBackground)

      Column() {
        // Header
        HeaderView()
          .padding({ top: 10, bottom: 10 })

        Scroll() {
          Column() {
            // Quiz Card Section
            Column() {
              // Card Header: Title + Progress
              Row() {
                Text('Citrus crafts')
                  .fontSize(18)
                  .fontWeight(FontWeight.SemiBold)
                  .fontColor(QfColors.qfTextDark)
                Blank()
                Text('45%')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(QfColors.qfTextGold)
              }
              .padding({ left: 24, right: 24, top: 24 })

              // Progress Bar
              Row() {
                // Orange progress portion
                Row() {
                  Capsule()
                    .fill(QfColors.qfProgressOrange)
                    .width(100)
                    .height(5)
                }

                // Track portion with dot
                Stack({ alignContent: Alignment.End }) {
                  Capsule()
                    .fill(QfColors.qfProgressTrack)
                    .width('100%')
                    .height(5)

                  Circle()
                    .fill(QfColors.qfProgressOrange)
                    .width(4)
                    .height(4)
                    .margin({ right: -2 })
                }
                .layoutWeight(1)
              }
              .padding({ left: 24, right: 24, top: 10, bottom: 12 })
              .space(4)

              // Question
              Text('Which zest carrier gives the brightest aroma when infused cold?')
                .fontSize(23)
                .fontWeight(FontWeight.Bold)
                .fontColor(QfColors.qfTextDark)
                .lineHeight(27)
                .padding({ left: 24, right: 24, bottom: 24 })

              // Options
              Column() {
                OptionButton({ text: 'Dried peel sachet' })
                OptionButton({ text: 'Twist garnish' })
                OptionButton({ text: 'Zester microplane' })
                OptionButton({ text: 'Candied strip' })
              }
              .space(12)
              .padding({ left: 24, right: 24, bottom: 24 })

              // Hint Tag
              Text('Hint: Think surface area')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(QfColors.qfTextDark)
                .padding({ top: 10, bottom: 10, left: 16, right: 16 })
                .backgroundColor(QfColors.qfHintBg)
                .borderRadius(12)
                .padding({ left: 24, right: 24, bottom: 24 })
            }
            .backgroundColor(QfColors.quizCardBg)
            .borderRadius(36)
            .alignItems(HorizontalAlign.Start)

            // Trackers Section
            Column() {
              Text('Trackers')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(QfColors.qfTextDark)
                .padding({ left: 4 })

              Row() {
                TrackerCard({ label: 'Current\nstreak', value: '5 days' })
                  .layoutWeight(1)
                TrackerCard({ label: 'Accuracy', value: '84%' })
                  .layoutWeight(1)
                TrackerCard({ label: 'Rank', value: 'Top 12%' })
                  .layoutWeight(1)
              }
              .space(12)
              .width('100%')
            }
            .space(16)
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .space(30)
          .padding({ left: 16, right: 16, bottom: 40 })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}
