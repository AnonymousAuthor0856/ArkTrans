class QuizColors {
  static background: string = '#FFFCF9'
  static cardBg: string = '#FFF5F0'
  static textDark: string = '#291E17'
  static textSub: string = '#6E6661'
  static textGold: string = '#FCD462'
  static headerCircle: string = '#FCE4D1'
  static progressOrange: string = '#FF9642'
  static progressTrack: string = '#EBE6F5'
  static optionBg: string = '#FFE4CC'
  static optionBorder: string = '#DFA980'
  static hintBg: string = '#FCECCF'
  static trackerBg: string = '#FFE4CE'
}

class TrackerData {
  label: string
  value: string

  constructor(label: string, value: string) {
    this.label = label
    this.value = value
  }
}

@Entry
@Component
struct Index {
  private options: string[] = ['Dried peel sachet', 'Twist garnish', 'Zester microplane', 'Candied strip']
  private trackers: TrackerData[] = [
    new TrackerData('Current\nstreak', '5 days'),
    new TrackerData('Accuracy', '84%'),
    new TrackerData('Rank', 'Top 12%')
  ]

  @Builder
  HeaderView() {
    Row() {
      Circle()
        .width(48)
        .height(48)
        .fill(QuizColors.headerCircle)

      Blank()
        .layoutWeight(1)

      Column({ space: 2 }) {
        Text('QuizForge')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text('Aroma sprint')
          .fontSize(14)
          .fontColor(QuizColors.textSub)
      }
      .alignItems(HorizontalAlign.Center)

      Blank()
        .layoutWeight(1)

      Circle()
        .width(48)
        .height(48)
        .fill(QuizColors.headerCircle)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 10, bottom: 10 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  OptionButton(text: string) {
    Row() {
      Text(text)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(QuizColors.textDark)
      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .padding({ left: 18, right: 18, top: 14, bottom: 14 })
    .backgroundColor(QuizColors.optionBg)
    .border({ width: 1, color: QuizColors.optionBorder, radius: 16 })
  }

  @Builder
  QuizCard() {
    Column() {
      Row() {
        Text('Citrus crafts')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(QuizColors.textDark)
        Blank()
          .layoutWeight(1)
        Text('45%')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(QuizColors.textGold)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 24 })

      Row({ space: 4 }) {
        Rect()
          .width(100)
          .height(5)
          .fill(QuizColors.progressOrange)
          .radius(3)
        Stack({ alignContent: Alignment.End }) {
          Rect()
            .width('100%')
            .height(5)
            .fill(QuizColors.progressTrack)
            .radius(3)
          Circle()
            .width(4)
            .height(4)
            .fill(QuizColors.progressOrange)
        }
        .layoutWeight(1)
        .height(5)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 10, bottom: 12 })

      Text('Which zest carrier gives the brightest aroma when infused cold?')
        .fontSize(23)
        .fontWeight(FontWeight.Bold)
        .fontColor(QuizColors.textDark)
        .lineHeight(32)
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 24 })

      Column({ space: 12 }) {
        ForEach(this.options, (option: string) => {
          this.OptionButton(option)
        })
      }
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 24 })

      Text('Hint: Think surface area')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(QuizColors.textDark)
        .padding({ left: 16, right: 16, top: 10, bottom: 10 })
        .backgroundColor(QuizColors.hintBg)
        .borderRadius(12)
        .margin({ left: 24, bottom: 24 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor('#FFF3E8')
    .borderRadius(36)
  }

  @Builder
  TrackerCard(item: TrackerData) {
    Column({ space: 8 }) {
      Text(item.label)
        .fontSize(13)
        .fontColor(QuizColors.textSub)
        .width('100%')
      Blank()
        .layoutWeight(1)
      Text(item.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(QuizColors.textDark)
        .width('100%')
    }
    .layoutWeight(1)
    .height(100)
    .padding({ left: 16, right: 16, top: 20, bottom: 20 })
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(QuizColors.trackerBg)
    .borderRadius(24)
  }

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
                .fontColor(QuizColors.textDark)
                .width('100%')
                .padding({ left: 4 })

              Row({ space: 12 }) {
                ForEach(this.trackers, (item: TrackerData) => {
                  this.TrackerCard(item)
                })
              }
              .width('100%')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
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
    .backgroundColor(QuizColors.background)
  }
}
