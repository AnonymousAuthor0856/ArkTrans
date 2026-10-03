@Entry
@Component
struct QuizForgeApp {
  build() {
    Stack() {
      // Global Background
      Column() {
        // Header
        HeaderView()
          .margin({ top: 10, bottom: 10 })

        Scroll() {
          Column({ space: 30 }) {
            // Quiz Card Section
            Column({ space: 0 }) {
              // Card Header: Title + Progress
              Row() {
                Text('Citrus crafts')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#291E17')

                Blank()

                Text('45%')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FCD462')
              }
              .width('100%')
              .padding({ left: 24, right: 24, top: 24 })

              // Progress Bar
              Row({ space: 4 }) {
                // Filled portion
                Row()
                  .width(100)
                  .height(5)
                  .borderRadius(3)
                  .backgroundColor('#FF9642')

                // Track portion
                Stack({ alignContent: Alignment.End }) {
                  Row()
                    .width('100%')
                    .height(5)
                    .borderRadius(3)
                    .backgroundColor('#EBE6F5')

                  Circle()
                    .width(6)
                    .height(6)
                    .fill('#FF9642')
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
                .fontColor('#291E17')
                .lineHeight(32)
                .width('100%')
                .padding({ left: 24, right: 24, bottom: 24 })

              // Options
              Column({ space: 12 }) {
                OptionButton({ text: 'Dried peel sachet' })
                OptionButton({ text: 'Twist garnish' })
                OptionButton({ text: 'Zester microplane' })
                OptionButton({ text: 'Candied strip' })
              }
              .width('100%')
              .padding({ left: 24, right: 24, bottom: 24 })

              // Hint Tag
              Text('Hint: Think surface area')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#291E17')
                .padding({ top: 10, bottom: 10, left: 16, right: 16 })
                .backgroundColor('#FCECCF')
                .borderRadius(12)
                .margin({ left: 24, right: 24, bottom: 24 })
                .alignSelf(ItemAlign.Start)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .backgroundColor('#FFF3E8')
            .borderRadius(36)

            // Trackers Section
            Column({ space: 16 }) {
              Text('Trackers')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#291E17')
                .margin({ left: 4 })
                .alignSelf(ItemAlign.Start)

              Row({ space: 12 }) {
                TrackerCard({ label: 'Current\nstreak', value: '5 days' })
                TrackerCard({ label: 'Accuracy', value: '84%' })
                TrackerCard({ label: 'Rank', value: 'Top 12%' })
              }
              .width('100%')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFCF9')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFCF9')
  }
}

@Component
struct HeaderView {
  build() {
    Row() {
      Circle()
        .width(48)
        .height(48)
        .fill('#FCE4D1')

      Blank()

      Column({ space: 2 }) {
        Text('QuizForge')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Text('Aroma sprint')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#6E6661')
      }
      .alignItems(HorizontalAlign.Center)

      Blank()

      Circle()
        .width(48)
        .height(48)
        .fill('#FCE4D1')
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct OptionButton {
  text: string = ''

  build() {
    Row() {
      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#291E17')

      Blank()
    }
    .width('100%')
    .padding({ top: 14, bottom: 14, left: 18, right: 18 })
    .backgroundColor('#FFE4CC')
    .borderRadius(16)
    .border({ width: 1, color: '#DFAA80', radius: 16 })
  }
}

@Component
struct TrackerCard {
  label: string = ''
  value: string = ''

  build() {
    Column({ space: 8 }) {
      Text(this.label)
        .fontSize(13)
        .fontWeight(FontWeight.Normal)
        .fontColor('#6E6661')
        .textAlign(TextAlign.Start)
        .width('100%')

      Blank()

      Text(this.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#291E17')
        .textAlign(TextAlign.Start)
        .width('100%')
        .maxFontSize(18)
        .minFontSize(14)
    }
    .padding({ top: 20, bottom: 20, left: 16, right: 16 })
    .layoutWeight(1)
    .height(100)
    .backgroundColor('#FFE4CE')
    .borderRadius(24)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}