@Entry
@Component
struct RootScreen {
  @State selectedTab: number = 0
  private tabs: string[] = ['Meals', 'Chat', 'Stats']

  build() {
    Stack() {
      // Background gradient
      LinearGradient({
        colors: [[0x0EA5E9, 0.1], [0x6366F1, 0.1]],
        startPoint: [0, 0],
        endPoint: [0, 1]
      })
      .width('100%')
      .height('100%')

      Column() {
        // Title
        Text('Diet Log')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')
          .width('100%')
          .padding(16)

        // Custom TabRow
        Column() {
          Row() {
            ForEach(this.tabs, (tab: string, index: number) => {
              Button(tab)
                .fontSize(14)
                .fontColor(this.selectedTab === index ? '#0EA5E9' : '#1E293B')
                .layoutWeight(1)
                .padding({ top: 12, bottom: 12 })
                .backgroundColor(Color.Transparent)
                .onClick(() => {
                  this.selectedTab = index
                })
            })
          }
          .width('100%')

          // Tab indicator
          Row() {
            Blank()
              .width(`${100 / this.tabs.length}%`)
              .height(2)
              .backgroundColor('#0EA5E9')
              .borderRadius(1)
              .translate({
                x: `${(this.selectedTab - (this.tabs.length - 1) / 2) * (100 / this.tabs.length)}%`
              })
              .animation({ duration: 200, curve: Curve.EaseInOut })
          }
          .width('100%')
        }
        .width('100%')
        .backgroundColor('#FFFFFF')

        // Page content
        Swiper() {
          MealsPage()
          ChatPage()
          StatsPage()
        }
        .index(this.selectedTab)
        .indicator(false)
        .loop(false)
        .duration(200)
        .curve(Curve.EaseInOut)
        .onChange((index: number) => {
          this.selectedTab = index
        })
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F5F9')
  }
}

@Component
struct MealsPage {
  build() {
    Column({ space: 12 }) {
      Text("Today's Meals")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1E293B')

      ForEach([1, 2, 3], (item: number) => {
        Stack() {
          Text(`Meal ${item}`)
            .fontSize(14)
            .fontColor('#1E293B')
        }
        .width('100%')
        .height(80)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .border({ width: 1, color: '#D1D5DB' })
      })

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
  }
}

@Component
struct ChatPage {
  build() {
    Column({ space: 8 }) {
      Text('Diet Chat')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1E293B')

      ForEach([0, 1, 2, 3, 4], (item: number) => {
        Row() {
          if (item % 2 === 0) {
            Text(`Message ${item + 1}`)
              .fontSize(14)
              .fontColor('#1E293B')
              .padding(12)
              .backgroundColor('#E2E8F0')
              .borderRadius(12)
            Blank()
          } else {
            Blank()
            Text(`Message ${item + 1}`)
              .fontSize(14)
              .fontColor('#FFFFFF')
              .padding(12)
              .backgroundColor('#0EA5E9')
              .borderRadius(12)
          }
        }
        .width('100%')
      })

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
  }
}

@Component
struct StatsPage {
  build() {
    Column({ space: 12 }) {
      Text('Weekly Calories')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1E293B')

      ForEach([0, 1, 2, 3, 4, 5, 6], (item: number) => {
        Row() {
          Blank()
            .width(`${(0.3 + item * 0.1) * 100}%`)
            .height(24)
            .backgroundColor('#0EA5E9')
            .borderRadius(8)
          Blank()
        }
        .width('100%')
        .height(24)
        .backgroundColor('#E2E8F0')
        .borderRadius(8)
      })

      Blank()
        .height(16)

      Button('Share Report')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .width('60%')
        .height(48)
        .backgroundColor('#6366F1')
        .borderRadius(16)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }
}