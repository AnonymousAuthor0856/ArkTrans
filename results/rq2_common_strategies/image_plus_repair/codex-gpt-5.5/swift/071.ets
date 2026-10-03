interface Tracker {
  label: string
  value: string
}

const BACKGROUND: ResourceColor = '#FFFCF9'
const CARD_BACKGROUND: ResourceColor = '#FFF5F0'
const TEXT_DARK: ResourceColor = '#291E17'
const TEXT_SUBTLE: ResourceColor = '#6E6661'
const GOLD: ResourceColor = '#FCD462'
const HEADER_CIRCLE: ResourceColor = '#FCE4D1'
const PROGRESS_ORANGE: ResourceColor = '#FF9642'
const PROGRESS_TRACK: ResourceColor = '#EBE6F5'
const OPTION_BACKGROUND: ResourceColor = '#FDE4CC'
const OPTION_BORDER: ResourceColor = '#E0AA80'
const HINT_BACKGROUND: ResourceColor = '#FCECCF'
const TRACKER_BACKGROUND: ResourceColor = '#FFE4CE'

@Entry
@Component
struct QuizForgePage {
  @State private selectedOption: number = -1

  private readonly options: string[] = [
    'Dried peel sachet',
    'Twist garnish',
    'Zester microplane',
    'Candied strip'
  ]

  private readonly trackers: Tracker[] = [
    { label: 'Current\nstreak', value: '5 days' },
    { label: 'Accuracy', value: '84%' },
    { label: 'Rank', value: 'Top 12%' }
  ]

  @Builder
  Header() {
    Stack() {
      Row() {
        Blank()
          .width(96)
          .height(96)
          .borderRadius(48)
          .backgroundColor(HEADER_CIRCLE)

        Blank()

        Blank()
          .width(96)
          .height(96)
          .borderRadius(48)
          .backgroundColor(HEADER_CIRCLE)
      }
      .width('100%')
      .padding({ left: 48, right: 48 })

      Column({ space: 2 }) {
        Text('QuizForge')
          .fontSize(40)
          .lineHeight(48)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Text('Aroma sprint')
          .fontSize(28)
          .lineHeight(34)
          .fontColor(TEXT_SUBTLE)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height(116)
    .padding({ top: 20 })
  }

  @Builder
  ProgressBar() {
    Stack({ alignContent: Alignment.Start }) {
      Row({ space: 8 }) {
        Blank()
          .width(200)
          .height(10)
          .borderRadius(5)
          .backgroundColor(PROGRESS_ORANGE)

        Blank()
          .layoutWeight(1)
          .height(10)
          .borderRadius(5)
          .backgroundColor(PROGRESS_TRACK)
      }
      .width('100%')
      .height(10)

      Circle()
        .width(8)
        .height(8)
        .fill(PROGRESS_ORANGE)
        .position({ right: 0, top: 1 })
    }
    .width('100%')
    .height(10)
    .margin({ top: 20 })
  }

  @Builder
  OptionButton(option: string, index: number) {
    Row() {
      Text(option)
        .fontSize(21)
        .lineHeight(28)
        .fontWeight(FontWeight.Medium)
        .fontColor(TEXT_DARK)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width('100%')
    .height(82)
    .alignItems(VerticalAlign.Center)
    .padding({ left: 36, right: 24 })
    .backgroundColor(this.selectedOption === index ? '#FFD3AE' : OPTION_BACKGROUND)
    .border({
      width: 2,
      color: this.selectedOption === index ? PROGRESS_ORANGE : OPTION_BORDER,
      radius: 32
    })
    .onClick(() => {
      this.selectedOption = index
    })
  }

  @Builder
  QuestionCard() {
    Column() {
      Row() {
        Text('Citrus crafts')
          .fontSize(36)
          .lineHeight(44)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_DARK)

        Blank()

        Text('45%')
          .fontSize(32)
          .lineHeight(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(GOLD)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      this.ProgressBar()

      Text('Which zest carrier gives the brightest aroma when infused cold?')
        .width('100%')
        .fontSize(44)
        .lineHeight(63)
        .fontWeight(FontWeight.Bold)
        .fontColor(TEXT_DARK)
        .margin({ top: 22 })

      Column({ space: 22 }) {
        ForEach(this.options, (option: string, index: number) => {
          this.OptionButton(option, index)
        }, (option: string) => option)
      }
      .width('100%')
      .margin({ top: 38 })

      Row() {
        Text('Hint: Think surface area')
          .fontSize(27)
          .lineHeight(34)
          .fontWeight(FontWeight.Medium)
          .fontColor(TEXT_DARK)
      }
      .height(72)
      .padding({ left: 32, right: 32 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor(HINT_BACKGROUND)
      .borderRadius(22)
      .margin({ top: 48 })
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 48, bottom: 48 })
    .backgroundColor(CARD_BACKGROUND)
    .borderRadius(72)
  }

  @Builder
  TrackerCard(tracker: Tracker) {
    Column() {
      Text(tracker.label)
        .fontSize(25)
        .lineHeight(33)
        .fontColor(TEXT_SUBTLE)
        .textAlign(TextAlign.LEFT)
        .width('100%')

      Blank()
        .layoutWeight(1)

      Text(tracker.value)
        .fontSize(29)
        .lineHeight(36)
        .fontWeight(FontWeight.Bold)
        .fontColor(TEXT_DARK)
        .width('100%')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .layoutWeight(1)
    .height(150)
    .padding({ left: 32, right: 24, top: 36, bottom: 28 })
    .backgroundColor(TRACKER_BACKGROUND)
    .borderRadius(44)
  }

  @Builder
  TrackersSection() {
    Column() {
      Text('Trackers')
        .fontSize(46)
        .lineHeight(58)
        .fontWeight(FontWeight.Bold)
        .fontColor(TEXT_DARK)
        .width('100%')

      Row({ space: 24 }) {
        ForEach(this.trackers, (tracker: Tracker) => {
          this.TrackerCard(tracker)
        }, (tracker: Tracker) => tracker.label)
      }
      .width('100%')
      .margin({ top: 30 })
    }
    .width('100%')
  }

  build() {
    Column() {
      this.Header()

      Scroll() {
        Column({ space: 68 }) {
          this.QuestionCard()
          this.TrackersSection()
        }
        .width('100%')
        .padding({ left: 32, right: 32, top: 20, bottom: 60 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}
