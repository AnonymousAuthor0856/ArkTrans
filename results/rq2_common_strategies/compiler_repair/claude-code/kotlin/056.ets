@Entry
@Component
struct DietLogPage {
  @State currentIndex: number = 0;
  private tabs: string[] = ['Meals', 'Chat', 'Stats'];

  build() {
    Column() {
      Column() {
        Text('Diet Log')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')
          .margin({ top: 16, bottom: 16 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)

      Tabs({ index: this.currentIndex, barPosition: BarPosition.Start }) {
        ForEach(this.tabs, (title: string, index: number) => {
          TabContent() {
            if (index === 0) {
              MealsPage()
            } else if (index === 1) {
              ChatPage()
            } else {
              StatsPage()
            }
          }
          .tabBar(this.TabBarBuilder(title, index))
        })
      }
      .barMode(BarMode.Fixed)
      .barHeight(48)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#0EA5E9', 0.0], ['#6366F1', 1.0]],
      repeating: false,
      angle: 180
    })
    .backgroundColor('#F1F5F9')
  }

  @Builder
  TabBarBuilder(title: string, index: number) {
    Column() {
      Text(title)
        .fontSize(14)
        .fontWeight(this.currentIndex === index ? FontWeight.Medium : FontWeight.Normal)
        .fontColor(this.currentIndex === index ? '#0EA5E9' : '#1E293B')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct MealsPage {
  build() {
    Column() {
      Text("Today's Meals")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1E293B')
        .margin({ bottom: 12 })

      ForEach([1, 2, 3], (item: number) => {
        Row() {
          Text(`Meal ${item}`)
            .fontColor('#1E293B')
            .fontSize(14)
        }
        .width('100%')
        .height(80)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .border({ width: 1, color: '#D1D5DB' })
        .justifyContent(FlexAlign.Center)
        .margin({ bottom: 12 })
      })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ChatPage {
  build() {
    Column() {
      Text('Diet Chat')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1E293B')
        .margin({ bottom: 8 })

      ForEach([0, 1, 2, 3, 4], (index: number) => {
        Row() {
          Text(`Message ${index + 1}`)
            .fontColor(index % 2 === 0 ? '#1E293B' : '#FFFFFF')
            .fontSize(14)
            .padding(12)
            .backgroundColor(index % 2 === 0 ? '#E2E8F0' : '#0EA5E9')
            .borderRadius(12)
        }
        .width('100%')
        .justifyContent(index % 2 === 0 ? FlexAlign.Start : FlexAlign.End)
        .margin({ top: 8, bottom: 8 })
      })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct StatsPage {
  build() {
    Column() {
      Text('Weekly Calories')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1E293B')
        .margin({ bottom: 12 })

      ForEach([0, 1, 2, 3, 4, 5, 6], (index: number) => {
        Row() {
          Row()
            .width(`${Math.min(30 + index * 10, 100)}%`)
            .height('100%')
            .backgroundColor('#0EA5E9')
            .borderRadius(8)
        }
        .width('100%')
        .height(24)
        .backgroundColor('#E2E8F0')
        .borderRadius(8)
        .margin({ bottom: 12 })
      })

      Blank()

      Button('Share Report')
        .width('60%')
        .height(48)
        .backgroundColor('#6366F1')
        .fontColor('#FFFFFF')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .borderRadius(16)
        .margin({ top: 16, bottom: 16 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Center)
  }
}
