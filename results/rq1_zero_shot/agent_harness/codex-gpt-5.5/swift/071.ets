class QuizColors {
  static background: string = '#FFFCF9';
  static cardBg: string = '#FFF5F0';
  static textDark: string = '#291E17';
  static textSub: string = '#6E6661';
  static textGold: string = '#FCD462';
  static headerCircle: string = '#FCE4D1';
  static progressOrange: string = '#FF9642';
  static progressTrack: string = '#EBE6F5';
  static optionBg: string = '#FDECD9';
  static optionBorder: string = '#EBCBA6';
  static hintBg: string = '#FCECCF';
  static trackerBg: string = '#FFE4CE';
}

@Entry
@Component
struct ContentView {
  @Builder
  private HeaderView() {
    Row() {
      Circle()
        .width(48)
        .height(48)
        .fill(QuizColors.headerCircle)
      Blank()
      Column({ space: 2 }) {
        Text('QuizForge')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text('Aroma sprint')
          .fontSize(14)
          .fontColor(QuizColors.textSub)
      }
      Blank()
      Circle()
        .width(48)
        .height(48)
        .fill(QuizColors.headerCircle)
    }
    .padding({ left: 24, right: 24 })
    .width('100%')
  }

  @Builder
  private OptionButton(text: string) {
    Row() {
      Text(text)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(QuizColors.textDark)
      Blank()
    }
    .padding({ left: 18, right: 18, top: 14, bottom: 14 })
    .width('100%')
    .backgroundColor('#FFE4CC')
    .borderRadius(16)
    .border({ width: 1, color: '#DFAA80' })
  }

  @Builder
  private TrackerCard(label: string, value: string) {
    Column({ space: 8 }) {
      Text(label)
        .fontSize(13)
        .fontColor(QuizColors.textSub)
        .width('100%')
        .textAlign(TextAlign.Start)
      Blank()
      Text(value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(QuizColors.textDark)
        .width('100%')
        .textAlign(TextAlign.Start)
    }
    .padding({ left: 16, right: 16, top: 20, bottom: 20 })
    .layoutWeight(1)
    .constraintSize({ minHeight: 100 })
    .backgroundColor(QuizColors.trackerBg)
    .borderRadius(24)
  }

  @Builder
  private QuizCard() {
    Column({ space: 0 }) {
      Row() {
        Text('Citrus crafts')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(QuizColors.textDark)
        Blank()
        Text('45%')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(QuizColors.textGold)
      }
      .padding({ left: 24, right: 24, top: 24 })
      .width('100%')

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
        .height(5)
        .layoutWeight(1)
      }
      .padding({ left: 24, right: 24, top: 10, bottom: 12 })
      .width('100%')

      Text('Which zest carrier gives the brightest aroma when infused cold?')
        .fontSize(23)
        .fontWeight(FontWeight.Bold)
        .fontColor(QuizColors.textDark)
        .padding({ left: 24, right: 24, bottom: 24 })
        .width('100%')

      Column({ space: 12 }) {
        this.OptionButton('Dried peel sachet')
        this.OptionButton('Twist garnish')
        this.OptionButton('Zester microplane')
        this.OptionButton('Candied strip')
      }
      .padding({ left: 24, right: 24, bottom: 24 })
      .width('100%')

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
    .backgroundColor('#FFF3E8')
    .borderRadius(36)
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        this.HeaderView()
          .padding({ top: 10, bottom: 10 })

        Scroll() {
          Column({ space: 30 }) {
            this.QuizCard()

            Column({ space: 16 }) {
              Text('Trackers')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(QuizColors.textDark)
                .width('100%')
                .textAlign(TextAlign.Start)
                .padding({ left: 4 })

              Row({ space: 12 }) {
                this.TrackerCard('Current\nstreak', '5 days')
                this.TrackerCard('Accuracy', '84%')
                this.TrackerCard('Rank', 'Top 12%')
              }
              .width('100%')
            }
            .width('100%')
          }
          .padding({ left: 16, right: 16, bottom: 40 })
          .width('100%')
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(QuizColors.background)
  }
}
