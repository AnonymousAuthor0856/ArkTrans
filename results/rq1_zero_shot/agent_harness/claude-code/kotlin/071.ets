@Entry
@Component
struct Index {
  @State selectedIndex: number = -1;
  private progress: number = 0.45;

  private question = {
    category: 'Citrus crafts',
    prompt: 'Which zest carrier gives the brightest aroma when infused cold?',
    options: ['Dried peel sachet', 'Twist garnish', 'Zester microplane', 'Candied strip'],
    hint: 'Think surface area'
  };

  private streaks = [
    { label: 'Current streak', value: '5 days' },
    { label: 'Accuracy', value: '84%' },
    { label: 'Rank', value: 'Top 12%' }
  ];

  build() {
    Column() {
      // Top app bar
      Row() {
        // Navigation icon placeholder
        Circle({ width: 30, height: 30 })
          .fill('#FFE4CC')
          .width(30)
          .height(30)

        Column() {
          Text('QuizForge')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#311F10')
          Text('Aroma sprint')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('rgba(49, 31, 16, 0.7)')
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)

        // Action icon placeholder
        Circle({ width: 30, height: 30 })
          .fill('rgba(255, 138, 42, 0.35)')
          .width(30)
          .height(30)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          // Question card
          Column() {
            // Category row
            Row() {
              Text(this.question.category)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#311F10')
              Blank()
              Text('45%')
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor('#FFC857')
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            // Linear progress indicator
            Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
              .color('#FF8A2A')
              .backgroundColor('#FFE4CC')
              .width('100%')
              .height(4)

            Text(this.question.prompt)
              .fontSize(22)
              .fontWeight(FontWeight.SemiBold)
              .fontColor('#311F10')
              .margin({ top: 12 })

            // Options
            Column() {
              ForEach(this.question.options, (option: string, index: number) => {
                Text(option)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#311F10')
                  .width('100%')
                  .padding(12)
                  .borderRadius(18)
                  .backgroundColor(this.selectedIndex === index ? 'rgba(255, 138, 42, 0.2)' : '#FFE4CC')
                  .border({
                    width: 1,
                    color: this.selectedIndex === index ? '#FF8A2A' : '#E2B088',
                    radius: 18
                  })
                  .onClick(() => {
                    this.selectedIndex = index;
                  })
              })
            }
            .width('100%')
            .margin({ top: 12 })

            // Hint
            Text('Hint: ' + this.question.hint)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#311F10')
              .padding({ left: 12, right: 12, top: 8, bottom: 8 })
              .borderRadius(10)
              .backgroundColor('rgba(255, 200, 87, 0.2)')
              .margin({ top: 12 })
          }
          .width('100%')
          .padding(16)
          .borderRadius(28)
          .backgroundColor('#FFFFFF')
          .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.22)', offsetY: 4 })

          // Trackers card
          Column() {
            Text('Trackers')
              .fontSize(22)
              .fontWeight(FontWeight.SemiBold)
              .fontColor('#311F10')

            // Streak cards row
            Row() {
              ForEach(this.streaks, (streak: { label: string; value: string }) => {
                Column() {
                  Text(streak.label)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('rgba(49, 31, 16, 0.7)')
                  Text(streak.value)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#311F10')
                }
                .layoutWeight(1)
                .padding(12)
                .borderRadius(18)
                .backgroundColor('#FFE4CC')
                .alignItems(HorizontalAlign.Center)
                .margin({ right: 12 })
              })
            }
            .width('100%')
            .margin({ top: 8 })

            // Submit button
            Button('Submit answer')
              .width('100%')
              .height(48)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2C0D00')
              .backgroundColor('#FF8A2A')
              .borderRadius(18)
              .margin({ top: 12 })
          }
          .width('100%')
          .padding(16)
          .borderRadius(28)
          .backgroundColor('#FFFFFF')
          .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.18)', offsetY: 2 })
          .margin({ top: 16 })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 12, bottom: 12 })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#FFF9F2')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF9F2')
  }
}
