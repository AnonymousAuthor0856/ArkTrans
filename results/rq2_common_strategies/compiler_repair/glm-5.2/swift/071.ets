// index.ets

// MARK: - 2. Color Palette
class QFColors {
  static readonly qfBackground: string = '#FFFCF9';
  static readonly qfCardBg: string = '#FFF5F0';
  static readonly qfTextDark: string = '#291E17';
  static readonly qfTextSub: string = '#6E6661';
  static readonly qfTextGold: string = '#FCD462';
  static readonly qfHeaderCircle: string = '#FCE4D1';
  static readonly qfProgressOrange: string = '#FF9642';
  static readonly qfProgressTrack: string = '#EBE6F5';
  static readonly qfOptionBg: string = '#FDECD9';
  static readonly qfOptionBorder: string = '#EBCBA6';
  static readonly qfHintBg: string = '#FCECCF';
  static readonly qfTrackerBg: string = '#FFE4CE';
}

// MARK: - 3. Main Content View
@Entry
@Component
struct ContentView {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Global Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(QFColors.qfBackground)

      Column() {
        // Header
        HeaderView()
          .padding({ top: 10, bottom: 10 })

        // ScrollView Content
        Scroll() {
          Column({ space: 30 }) {
            // Quiz Card Section
            Column() {
              // Card Header: Title + Progress
              Row() {
                Text('Citrus crafts')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(QFColors.qfTextDark)
                
                Blank()
                
                Text('45%')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(QFColors.qfTextGold)
              }
              .width('100%')
              .padding({ left: 24, right: 24, top: 24 })

              // Progress Bar
              Row({ space: 4 }) {
                // Filled Progress
                Column()
                  .width(100)
                  .height(5)
                  .backgroundColor(QFColors.qfProgressOrange)
                  .borderRadius(2.5)

                // Track
                Stack({ alignContent: Alignment.End }) {
                  Column()
                    .width('100%')
                    .height(5)
                    .backgroundColor(QFColors.qfProgressTrack)
                    .borderRadius(2.5)
                  
                  // Small orange dot at end for detail
                  Column()
                    .width(4)
                    .height(4)
                    .backgroundColor(QFColors.qfProgressOrange)
                    .borderRadius(2)
                    .margin({ right: -2 })
                }
                .layoutWeight(1)
              }
              .width('100%')
              .padding({ left: 24, right: 24, top: 10, bottom: 12 })

              // Question
              Text('Which zest carrier gives the brightest aroma when infused cold?')
                .fontSize(23)
                .fontWeight(FontWeight.Bold)
                .fontColor(QFColors.qfTextDark)
                .lineHeight(27)
                .padding({ left: 24, right: 24, bottom: 24 })

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
                .fontColor(QFColors.qfTextDark)
                .padding({ top: 10, bottom: 10, left: 16, right: 16 })
                .backgroundColor(QFColors.qfHintBg)
                .borderRadius(12)
                .margin({ left: 24, right: 24, bottom: 24 })
            }
            .width('100%')
            .backgroundColor('#FFF3E8')
            .borderRadius(36)

            // Trackers Section
            Column({ space: 16 }) {
              Text('Trackers')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(QFColors.qfTextDark)
                .margin({ left: 4 })

              Row({ space: 12 }) {
                TrackerCard({ label: 'Current\nstreak', value: '5 days' })
                TrackerCard({ label: 'Accuracy', value: '84%' })
                TrackerCard({ label: 'Rank', value: 'Top 12%' })
              }
              .width('100%')
            }
            .alignItems(HorizontalAlign.Start)
          }
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.Top)
      }
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - 4. Components

@Component
struct HeaderView {
  build() {
    Row() {
      Circle({ width: 48, height: 48 })
        .fill(QFColors.qfHeaderCircle)

      Blank()

      Column({ space: 2 }) {
        Text('QuizForge')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text('Aroma sprint')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(QFColors.qfTextSub)
      }

      Blank()

      Circle({ width: 48, height: 48 })
        .fill(QFColors.qfHeaderCircle)
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
  }
}

@Component
struct OptionButton {
  private text: string = '';

  build() {
    Row() {
      Text(this.text)
        .fontSize(16) // Adjusted from 10 for better readability/standard sizing
        .fontWeight(FontWeight.Medium)
        .fontColor(QFColors.qfTextDark)
      
      Blank()
    }
    .width('100%')
    .padding({ top: 14, bottom: 14, left: 18, right: 18 })
    .backgroundColor('#FFE4CC')
    .borderRadius(16)
    .border({ width: 1, color: '#DFAA80' })
  }
}

@Component
struct TrackerCard {
  private label: string = '';
  private value: string = '';

  build() {
    Column({ space: 8 }) {
      Text(this.label)
        .fontSize(13)
        .fontWeight(FontWeight.Normal)
        .fontColor(QFColors.qfTextSub)

      Blank()

      Text(this.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(QFColors.qfTextDark)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .alignItems(HorizontalAlign.Start)
    .layoutWeight(1)
    .height(100)
    .padding({ top: 20, bottom: 20, left: 16, right: 16 })
    .backgroundColor(QFColors.qfTrackerBg)
    .borderRadius(24)
  }
}