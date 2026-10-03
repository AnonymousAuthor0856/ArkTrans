// ============================================================
// QuizForge — ArkTS / ArkUI translation
// File: entry/src/main/ets/pages/Index.ets
// ============================================================

// MARK: - Color Palette
class QFColor {
  static readonly background: string = '#FFFCF9';      // Global background
  static readonly cardBg: string = '#FFF3E8';          // Main card background
  static readonly textDark: string = '#291E17';        // Dark brown text
  static readonly textSub: string = '#6E6661';         // Gray text
  static readonly textGold: string = '#FCD462';        // 45% text
  static readonly headerCircle: string = '#FCE4D1';    // Header circles
  static readonly progressOrange: string = '#FF9642';  // Progress fill
  static readonly progressTrack: string = '#EBE6F5';   // Progress track
  static readonly optionBg: string = '#FFE4CC';        // Peach button fill
  static readonly optionBgActive: string = '#FFD3AE';  // Selected fill
  static readonly optionBorder: string = '#DFAA80';    // Peach border
  static readonly hintBg: string = '#FCECCF';          // Hint chip
  static readonly trackerBg: string = '#FFE4CE';       // Tracker card bg
}

@Entry
@Component
struct Index {
  @State private selectedIndex: number = -1;

  private options: string[] = [
    'Dried peel sachet',
    'Twist garnish',
    'Zester microplane',
    'Candied strip'
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Global background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(QFColor.background)

      Column({ space: 0 }) {
        // Header
        this.HeaderView()

        // Scrollable body
        Scroll() {
          Column({ space: 30 }) {
            this.QuizCard()
            this.TrackersSection()
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .layoutWeight(1)
        .width('100%')
        .scrollBar(BarState.Off)
        .align(Alignment.Top)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  // MARK: - Header
  @Builder
  HeaderView() {
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
          .fontColor('#000000')
        Text('Aroma sprint')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(QFColor.textSub)
      }
      .alignItems(HorizontalAlign.Center)

      Blank()

      Circle()
        .width(48)
        .height(48)
        .fill(QFColor.headerCircle)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 10, bottom: 10 })
  }

  // MARK: - Quiz Card
  @Builder
  QuizCard() {
    Column({ space: 0 }) {
      // Card header: title + percentage
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

      // Progress bar
      Row({ space: 4 }) {
        Row()
          .width(100)
          .height(5)
          .borderRadius(3)
          .backgroundColor(QFColor.progressOrange)

        Stack({ alignContent: Alignment.CenterEnd }) {
          Row()
            .width('100%')
            .height(5)
            .borderRadius(3)
            .backgroundColor(QFColor.progressTrack)

          Circle()
            .width(4)
            .height(4)
            .fill(QFColor.progressOrange)
            .margin({ right: 2 })
        }
        .layoutWeight(1)
        .height(5)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 10, bottom: 12 })

      // Question
      Text('Which zest carrier gives the brightest aroma when infused cold?')
        .fontSize(23)
        .fontWeight(FontWeight.Bold)
        .fontColor(QFColor.textDark)
        .lineSpacing(4)
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 24 })

      // Options
      Column({ space: 12 }) {
        ForEach(this.options, (item: string, index: number) => {
          this.OptionButton(item, index)
        }, (item: string) => item)
      }
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 24 })

      // Hint tag
      Text('Hint: Think surface area')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(QFColor.textDark)
        .padding({ top: 10, bottom: 10, left: 16, right: 16 })
        .backgroundColor(QFColor.hintBg)
        .borderRadius(12)
        .margin({ left: 24, bottom: 24 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(QFColor.cardBg)
    .borderRadius(36)
  }

  // MARK: - Option Button
  @Builder
  OptionButton(label: string, index: number) {
    Row() {
      Text(label)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(QFColor.textDark)
      Blank()
    }
    .width('100%')
    .padding({ top: 14, bottom: 14, left: 18, right: 18 })
    .backgroundColor(this.selectedIndex === index ? QFColor.optionBgActive : QFColor.optionBg)
    .borderRadius(16)
    .border({
      width: 1,
      color: this.selectedIndex === index ? QFColor.progressOrange : QFColor.optionBorder
    })
    .onClick(() => {
      this.selectedIndex = index;
    })
  }

  // MARK: - Trackers
  @Builder
  TrackersSection() {
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
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  // MARK: - Tracker Card
  @Builder
  TrackerCard(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(13)
        .fontWeight(FontWeight.Normal)
        .fontColor(QFColor.textSub)
        .textAlign(TextAlign.Start)

      Blank()

      Text(value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(QFColor.textDark)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .alignItems(HorizontalAlign.Start)
    .height(100)
    .layoutWeight(1)
    .padding({ top: 20, bottom: 20, left: 16, right: 16 })
    .backgroundColor(QFColor.trackerBg)
    .borderRadius(24)
  }
}