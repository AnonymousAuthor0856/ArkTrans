@Entry
@Component
struct Index {
  @State currentTab: number = 0
  private tabs: string[] = ['Meals', 'Chat', 'Stats']

  build() {
    Column() {
      // Header
      Row() {
        Text('Diet Log')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(16)

      // Tab Bar
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Column() {
            Text(tab)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.currentTab === index ? '#0EA5E9' : '#1E293B')
              .padding({ top: 12, bottom: 8 })
            Divider()
              .height(2)
              .backgroundColor(this.currentTab === index ? '#0EA5E9' : 'transparent')
          }
          .layoutWeight(1)
          .onClick(() => {
            this.currentTab = index
          })
        })
      }
      .width('100%')
      .backgroundColor('#FFFFFF')

      // Content
      if (this.currentTab === 0) {
        MealsPage()
      } else if (this.currentTab === 1) {
        ChatPage()
      } else {
        StatsPage()
      }
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#1A0EA5E9', 0.0], ['#1A6366F1', 1.0]]
    })
    .backgroundColor('#F1F5F9')
  }
}

@Component
struct MealsPage {
  build() {
    Column({ space: 12 }) {
      Text("Today's Meals")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')
        .width('100%')

      ForEach([1, 2, 3], (item: number) => {
        Row() {
          Text('Meal ' + item)
            .fontSize(14)
            .fontColor('#1E293B')
        }
        .width('100%')
        .height(80)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .border({ width: 1, color: '#D1D5DB' })
        .justifyContent(FlexAlign.Center)
      })
    }
    .width('100%')
    .layoutWeight(1)
    .padding(16)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ChatPage {
  private messages: number[] = [0, 1, 2, 3, 4]

  build() {
    Column({ space: 8 }) {
      Text('Diet Chat')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')
        .width('100%')

      ForEach(this.messages, (item: number) => {
        Row() {
          if (item % 2 === 0) {
            Row() {
              Text('Message ' + (item + 1))
                .fontSize(14)
                .fontColor('#1E293B')
                .padding(12)
                .backgroundColor('#E2E8F0')
                .borderRadius(12)
            }
            Blank()
          } else {
            Blank()
            Row() {
              Text('Message ' + (item + 1))
                .fontSize(14)
                .fontColor('#FFFFFF')
                .padding(12)
                .backgroundColor('#0EA5E9')
                .borderRadius(12)
            }
          }
        }
        .width('100%')
        .padding({ top: 4, bottom: 4 })
      })
    }
    .width('100%')
    .layoutWeight(1)
    .padding(16)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct StatsPage {
  private days: number[] = [0, 1, 2, 3, 4, 5, 6]

  getBarWidth(index: number): string {
    let ratio = 0.3 + index * 0.1
    if (ratio > 1.0) ratio = 1.0
    return (ratio * 100).toFixed(0) + '%'
  }

  build() {
    Column({ space: 12 }) {
      Text('Weekly Calories')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')
        .width('100%')
        .textAlign(TextAlign.Center)

      ForEach(this.days, (item: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(24)
            .backgroundColor('#E2E8F0')
            .borderRadius(8)

          Row()
            .width(this.getBarWidth(item))
            .height(24)
            .backgroundColor('#0EA5E9')
            .borderRadius(8)
        }
        .width('100%')
        .height(24)
      })

      Blank().height(16)

      Button('Share Report')
        .width('60%')
        .height(48)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#6366F1')
        .borderRadius(16)
    }
    .width('100%')
    .layoutWeight(1)
    .padding(16)
    .alignItems(HorizontalAlign.Center)
  }
}