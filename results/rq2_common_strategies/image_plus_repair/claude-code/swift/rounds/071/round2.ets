@Entry
@Component
struct QuizForgePage {
  build() {
    Stack() {
      Column() {
        HeaderView()
          .margin({ top: 10, bottom: 10 })

        Scroll() {
          Column({ space: 30 }) {
            // Quiz Card Section
            Column() {
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
                // Orange filled portion
                Row()
                  .width(100)
                  .height(5)
                  .backgroundColor('#FF9642')
                  .borderRadius(2.5)

                // Track portion with dot
                Stack({ alignContent: Alignment.End }) {
                  Row()
                    .height(5)
                    .backgroundColor('#EBE6F5')
                    .borderRadius(2.5)
                  Circle()
                    .width(4)
                    .height(4)
                    .fill('#FF9642')
                    .margin({ right: -1 })
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
                .lineHeight(27)
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
                .margin({ left: 24, bottom: 24 })
            }
            .width('100%')
            .backgroundColor('#FFF5F0')
            .borderRadius(36)

            // Trackers Section
            Column({ space: 16 }) {
              Text('Trackers')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#291E17')
                .margin({ left: 4 })

              Row({ space: 12 }) {
                TrackerCard({ label: 'Current\nstreak', value: '5 days' })
                  .layoutWeight(1)
                TrackerCard({ label: 'Accuracy', value: '84%' })
                  .layoutWeight(1)
                TrackerCard({ label: 'Rank', value: 'Top 12%' })
                  .layoutWeight(1)
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
      }
      .width('100%')
      .height('100%')
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
          .fontWeight(FontWeight.Regular)
          .fontColor('#6E6661')
      }

      Blank()

      Circle()
        .width(48)
        .height(48)
        .fill('#FCE4D1')
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
  }
}

@Component
struct OptionButton {
  text: string = ''

  build() {
    Row() {
      Text(this.text)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor('#291E17')
      Blank()
    }
    .width('100%')
    .padding({ top: 14, bottom: 14, left: 18, right: 18 })
    .backgroundColor('#FDE4CC')
    .borderRadius(16)
    .border({ width: 1, color: '#DFAA80' })
  }
}

@Component
struct TrackerCard {
  label: string = ''
  value: string = ''

  build() {
    Column() {
      Text(this.label)
        .fontSize(13)
        .fontWeight(FontWeight.Regular)
        .fontColor('#6E6661')
        .width('100%')

      Blank()

      Text(this.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#291E17')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width('100%')
    .height(100)
    .padding({ top: 20, bottom: 20, left: 16, right: 16 })
    .alignItems(HorizontalAlign.Start)
    .backgroundColor('#FFE4CE')
    .borderRadius(24)
  }
}
