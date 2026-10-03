@Entry
@Component
struct StepChallengeApp {
  @State selectedTabIndex: number = 0
  private tabs: string[] = ['Overview', 'Ranking', 'Stats']

  build() {
    Stack() {
      Column({ space: 0 }) {
        // Title
        Text('Step Challenge')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#111827')
          .padding(16)
          .width('100%')
          .textAlign(TextAlign.Center)

        // Custom Tab Row
        Column({ space: 0 }) {
          Row({ space: 0 }) {
            ForEach(this.tabs, (tab: string, index: number) => {
              Button() {
                Text(tab)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor(this.selectedTabIndex === index ? '#111827' : '#1F2937')
                  .padding({ top: 12, bottom: 12 })
                  .width('100%')
                  .textAlign(TextAlign.Center)
              }
              .width('33.33%')
              .height(48)
              .backgroundColor('#FFFFFF')
              .onClick(() => {
                this.selectedTabIndex = index
              })
            })
          }
          .width('100%')
          .backgroundColor('#FFFFFF')

          // Underline indicator
          Divider()
            .height(2)
            .color('#111827')
            .width(100 / this.tabs.length + '%')
            .margin({ left: (100 / this.tabs.length) * this.selectedTabIndex + '%' })
        }
        .width('100%')
        .backgroundColor('#FFFFFF')

        // Content area based on selected tab
        if (this.selectedTabIndex === 0) {
          this.overviewPage()
        } else if (this.selectedTabIndex === 1) {
          this.rankingPage()
        } else {
          this.statsPage()
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F9FAFB')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  overviewPage() {
    Column({ space: 12 }) {
      Text('Today\'s Steps: 8452')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .foregroundColor('#1F2937')
        .width('100%')
        .textAlign(TextAlign.Center)

      Blank().height(24)

      Button() {
        Text('Sync Device')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#FFFFFF')
          .width('100%')
          .height(48)
          .textAlign(TextAlign.Center)
      }
      .width('60%')
      .height(48)
      .backgroundColor('#111827')
      .borderRadius(16)
      .alignSelf(ItemAlign.Center)

      Blank()
    }
    .padding(16)
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  rankingPage() {
    Column({ space: 8 }) {
      // Use List for ranking items
      List({ space: 8 }) {
        ForEach([0, 1, 2, 3, 4], (index: number) => {
          ListItem() {
            Row({ space: 0 }) {
              Text('User ' + (index + 1))
                .fontSize(14)
                .foregroundColor('#1F2937')
              Blank()
              Text((9000 - index * 500) + ' steps')
                .fontSize(14)
                .foregroundColor('#1F2937')
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#E5E7EB')
            .borderRadius(12)
          }
        })
      }
      .width('100%')
      .padding(0)
    }
    .padding(16)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  statsPage() {
    Column({ space: 8 }) {
      Text('Weekly Progress')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .foregroundColor('#1F2937')
        .width('100%')

      ForEach([0, 1, 2, 3, 4, 5, 6], (day: number) => {
        Progress({ value: 0.3 + day * 0.1, total: 1, type: ProgressType.Linear })
          .height(20)
          .color('#111827')
          .backgroundColor('#E5E7EB')
          .borderRadius(8)
          .width('100%')
      })

      Blank()
    }
    .padding(16)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }
}