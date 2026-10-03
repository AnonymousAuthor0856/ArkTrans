interface QuizQuestion {
  category: string
  prompt: string
  options: string[]
  hint: string
}

interface StreakCard {
  label: string
  value: string
}

class CitrusColors {
  static readonly primary: ResourceColor = '#FF8A2A'
  static readonly secondary: ResourceColor = '#FFC857'
  static readonly background: ResourceColor = '#FFF9F2'
  static readonly surfaceSoft: ResourceColor = '#FFF2E7'
  static readonly surfaceVariant: ResourceColor = '#FFE4CC'
  static readonly outline: ResourceColor = '#E2B088'
  static readonly onSurface: ResourceColor = '#311F10'
  static readonly mutedText: ResourceColor = '#6F5D4F'
  static readonly paleTrack: ResourceColor = '#EEE4F5'
  static readonly hint: ResourceColor = '#FFEABF'
}

@Entry
@Component
struct QuizForgePage {
  @State selectedIndex: number = -1

  question: QuizQuestion = {
    category: 'Citrus crafts',
    prompt: 'Which zest carrier gives the brightest aroma when infused cold?',
    options: ['Dried peel sachet', 'Twist garnish', 'Zester microplane', 'Candied strip'],
    hint: 'Think surface area'
  }

  streaks: StreakCard[] = [
    { label: 'Current\nstreak', value: '5 days' },
    { label: 'Accuracy', value: '84%' },
    { label: 'Rank', value: 'Top 12%' }
  ]

  @Builder
  Header() {
    Stack() {
      Row() {
        Blank()
          .width(60)
          .height(60)
          .borderRadius(30)
          .backgroundColor('#FFDDBD')

        Blank()

        Blank()
          .width(60)
          .height(60)
          .borderRadius(30)
          .backgroundColor('#FFD0A6')
      }
      .width('100%')
      .padding({ left: 26, right: 26 })

      Column() {
        Text('QuizForge')
          .fontSize(31)
          .lineHeight(36)
          .fontWeight(FontWeight.Bold)
          .fontColor(CitrusColors.onSurface)

        Text('Aroma sprint')
          .fontSize(25)
          .lineHeight(30)
          .fontWeight(FontWeight.Medium)
          .fontColor(CitrusColors.mutedText)
          .margin({ top: -2 })
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
    }
    .width('100%')
    .height(112)
    .padding({ top: 34 })
  }

  @Builder
  ProgressBar() {
    Stack({ alignContent: Alignment.Start }) {
      Row({ space: 8 }) {
        Blank()
          .width(220)
          .height(8)
          .borderRadius(4)
          .backgroundColor(CitrusColors.primary)

        Blank()
          .width(246)
          .height(8)
          .borderRadius(4)
          .backgroundColor(CitrusColors.paleTrack)
      }
      .width(478)
      .height(12)

      Circle()
        .width(8)
        .height(8)
        .fill(CitrusColors.primary)
        .margin({ left: 472 })
    }
    .width('100%')
    .height(18)
  }

  @Builder
  OptionChip(option: string, index: number) {
    Row() {
      Text(option)
        .fontSize(30)
        .lineHeight(38)
        .fontWeight(FontWeight.Bold)
        .fontColor(CitrusColors.onSurface)
    }
    .width('100%')
    .height(84)
    .alignItems(VerticalAlign.Center)
    .padding({ left: 24, right: 24 })
    .backgroundColor(this.selectedIndex === index ? '#FFD1AB' : CitrusColors.surfaceVariant)
    .border({
      width: 2,
      color: this.selectedIndex === index ? CitrusColors.primary : CitrusColors.outline,
      radius: 34
    })
    .onClick(() => {
      this.selectedIndex = index
    })
  }

  @Builder
  QuestionCard() {
    Column() {
      Row() {
        Text(this.question.category)
          .fontSize(30)
          .lineHeight(38)
          .fontWeight(FontWeight.Bold)
          .fontColor(CitrusColors.onSurface)

        Blank()

        Text('45%')
          .fontSize(27)
          .lineHeight(34)
          .fontColor(CitrusColors.secondary)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      this.ProgressBar()

      Text(this.question.prompt)
        .fontSize(42)
        .lineHeight(56)
        .fontWeight(FontWeight.Bold)
        .fontColor(CitrusColors.onSurface)
        .width('100%')
        .margin({ top: 4 })

      Column({ space: 16 }) {
        ForEach(this.question.options, (option: string, index: number) => {
          this.OptionChip(option, index)
        }, (option: string) => option)
      }
      .width('100%')
      .margin({ top: 16 })

      Row() {
        Text(`Hint: ${this.question.hint}`)
          .fontSize(24)
          .lineHeight(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(CitrusColors.onSurface)
      }
      .height(62)
      .padding({ left: 24, right: 24 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor(CitrusColors.hint)
      .borderRadius(18)
      .margin({ top: 24 })
    }
    .width('100%')
    .padding({ left: 32, right: 32, top: 32, bottom: 32 })
    .backgroundColor(CitrusColors.surfaceSoft)
    .borderRadius(54)
  }

  @Builder
  TrackerCard(streak: StreakCard) {
    Column() {
      Text(streak.label)
        .fontSize(23)
        .lineHeight(30)
        .fontWeight(FontWeight.Medium)
        .fontColor(CitrusColors.mutedText)
        .textAlign(TextAlign.Center)

      Text(streak.value)
        .fontSize(30)
        .lineHeight(38)
        .fontWeight(FontWeight.Bold)
        .fontColor(CitrusColors.onSurface)
        .textAlign(TextAlign.Center)
        .margin({ top: 6 })
    }
    .layoutWeight(1)
    .height(123)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(CitrusColors.surfaceVariant)
    .borderRadius(33)
    .padding({ left: 10, right: 10 })
  }

  @Builder
  TrackersPanel() {
    Column() {
      Text('Trackers')
        .fontSize(44)
        .lineHeight(56)
        .fontWeight(FontWeight.Bold)
        .fontColor(CitrusColors.onSurface)
        .width('100%')

      Row({ space: 24 }) {
        ForEach(this.streaks, (streak: StreakCard) => {
          this.TrackerCard(streak)
        }, (streak: StreakCard) => streak.label)
      }
      .width('100%')
      .margin({ top: 16 })

      Button('Submit answer')
        .width('100%')
        .height(68)
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2C0D00')
        .backgroundColor(CitrusColors.primary)
        .borderRadius(30)
        .margin({ top: 22 })
    }
    .width('100%')
    .padding({ left: 32, right: 32, top: 26, bottom: 28 })
    .backgroundColor('#FFF8F1')
    .borderRadius(44)
  }

  build() {
    Column() {
      this.Header()

      Scroll() {
        Column({ space: 34 }) {
          this.QuestionCard()
          this.TrackersPanel()
        }
        .width('100%')
        .padding({ left: 40, right: 40, top: 40, bottom: 40 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(CitrusColors.background)
  }
}
