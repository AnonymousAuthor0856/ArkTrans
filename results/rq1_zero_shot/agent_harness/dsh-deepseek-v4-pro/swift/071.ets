// Translated from SwiftUI (071.swift) to ArkTS / ArkUI

// MARK: - Color Palette
const QF_BACKGROUND = '#FFFCF9'; // Global background
const QF_CARD_BG = '#FFF5F0'; // Main Card Background
const QF_TEXT_DARK = '#291E17'; // Dark Brown Text
const QF_TEXT_SUB = '#6E6661'; // Gray Text
const QF_TEXT_GOLD = '#FCD462'; // 45% text
const QF_HEADER_CIRCLE = '#FCE4D1';
const QF_PROGRESS_ORANGE = '#FF9642';
const QF_PROGRESS_TRACK = '#EBE6F5';
const QF_OPTION_BG = '#FDECD9'; // Peach button fill
const QF_OPTION_BORDER = '#EBCBA6'; // Darker peach border
const QF_HINT_BG = '#FCECCF';
const QF_TRACKER_BG = '#FFE4CE'; // Tracker Card Bg

// MARK: - Entry Point
@Entry
@Component
struct Index {
  build() {
    ContentView()
  }
}

// MARK: - Main Content View
@Component
struct ContentView {
  build() {
    Stack() {
      Column({ space: 0 }) {
        // Header
        HeaderView()
          .padding({ top: 10, bottom: 10 })

        Scroll() {
          Column({ space: 30 }) {
            // Quiz Card Section
            Column({ space: 0 }) {
              // Card Header: Title + Progress
              Row() {
                Text('Citrus crafts')
                  .fontSize(18)
                  .fontWeight(FontWeight.Semibold)
                  .fontColor(QF_TEXT_DARK)
                Blank()
                Text('45%')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(QF_TEXT_GOLD)
              }
              .padding({ left: 24, right: 24, top: 24 })

              // Progress Bar
              Row({ space: 4 }) {
                Blank().width(100).height(5).backgroundColor(QF_PROGRESS_ORANGE).borderRadius(2.5)
                Blank().layoutWeight(1).height(5).backgroundColor(QF_PROGRESS_TRACK).borderRadius(2.5)
                Blank().width(4).height(4).backgroundColor(QF_PROGRESS_ORANGE).borderRadius(2)
              }
              .padding({ left: 24, right: 24, top: 10, bottom: 12 })

              // Question
              Text('Which zest carrier gives the brightest aroma when infused cold?')
                .fontSize(23)
                .fontWeight(FontWeight.Bold)
                .fontColor(QF_TEXT_DARK)
                .padding({ left: 24, right: 24, bottom: 24 })
                // lineSpacing(4)

              // Options
              Column({ space: 12 }) {
                OptionButton({ text: 'Dried peel sachet' })
                OptionButton({ text: 'Twist garnish' })
                OptionButton({ text: 'Zester microplane' })
                OptionButton({ text: 'Candied strip' })
              }
              .padding({ left: 24, right: 24, bottom: 24 })

              // Hint Tag
              Text('Hint: Think surface area')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(QF_TEXT_DARK)
                .padding({ top: 10, bottom: 10, left: 16, right: 16 })
                .backgroundColor(QF_HINT_BG)
                .borderRadius(12)
                .padding({ left: 24, right: 24, bottom: 24 })
            }
            .alignItems(HorizontalAlign.Start)
            .backgroundColor('#FFF3E8') // Color(red: 1, green: 243/255, blue: 232/255)
            .borderRadius(36)

            // Trackers Section
            Column({ space: 16 }) {
              Text('Trackers')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(QF_TEXT_DARK)
                .padding({ left: 4 })

              Row({ space: 12 }) {
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
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(QF_BACKGROUND)
    // .statusBar(hidden: true)
  }
}

// MARK: - Components

@Component
struct HeaderView {
  build() {
    Row() {
      Blank().width(48).height(48).backgroundColor(QF_HEADER_CIRCLE).borderRadius(24)
      Blank()
      Column({ space: 2 }) {
        Text('QuizForge')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text('Aroma sprint')
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(QF_TEXT_SUB)
      }
      Blank()
      Blank().width(48).height(48).backgroundColor(QF_HEADER_CIRCLE).borderRadius(24)
    }
    .padding({ left: 24, right: 24 })
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
        .fontColor(QF_TEXT_DARK)
      Blank()
    }
    .padding({ top: 14, bottom: 14, left: 18, right: 18 })
    .backgroundColor('#FFE4CC') // Color(red: 1, green: 228/255, blue: 204/255)
    .borderRadius(16)
    .border({ width: 1, color: '#DFAA80' }) // stroke Color(red: 223/255, green: 170/255, blue: 128/255)
  }
}

@Component
struct TrackerCard {
  @Prop label: string = ''
  @Prop value: string = ''

  build() {
    Column({ space: 8 }) {
      Text(this.label)
        .fontSize(13)
        .fontWeight(FontWeight.Regular)
        .fontColor(QF_TEXT_SUB)
      Blank()
      Text(this.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(QF_TEXT_DARK)
    }
    .alignItems(HorizontalAlign.Start)
    .padding({ top: 20, bottom: 20, left: 16, right: 16 })
    .layoutWeight(1)
    .height(100)
    .backgroundColor(QF_TRACKER_BG)
    .borderRadius(24)
  }
}
