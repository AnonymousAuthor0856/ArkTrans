@Entry
@Component
struct DietLogApp {
  @State currentPage: number = 0
  private tabs: string[] = ['Meals', 'Chat', 'Stats']

  build() {
    Column() {
      // Header
      Text('Diet Log')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 40, bottom: 20 })
        .backgroundColor('#F1F5F9')

      // Tabs
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Column() {
            Text(tab)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.currentPage === index ? '#0EA5E9' : '#1E293B')
              .textAlign(TextAlign.Center)
            
            if (this.currentPage === index) {
              Divider()
                .width('100%')
                .height(4)
                .color('#0EA5E9')
                .borderRadius(2)
            }
          }
          .layoutWeight(1)
          .onClick(() => {
            this.currentPage = index
          })
        })
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      // Content Area
      Column() {
        if (this.currentPage === 0) {
          this.MealsPage()
        } else if (this.currentPage === 1) {
          this.ChatPage()
        } else {
          this.StatsPage()
        }
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor('#F1F5F9')
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#0EA5E9', 0.1], ['#6366F1', 0.1]]
    })
  }

  @Builder
  MealsPage() {
    Column() {
      Text("Today's Meals")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#1E293B')
        .margin({ top: 16, bottom: 16 })

      ForEach([1, 2, 3], (num: number) => {
        Column() {
          Text(`Meal ${num}`)
            .fontSize(16)
            .fontColor('#1E293B')
        }
        .width('100%')
        .height(80)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .border({ width: 1, color: '#D1D5DB', radius: 12 })
        .margin({ bottom: 12 })
      })
    }
    .width('100%')
    .padding(16)
  }

  @Builder
  ChatPage() {
    Column() {
      Text("Diet Chat")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#1E293B')
        .margin({ top: 16, bottom: 16 })

      ForEach([1, 2, 3, 4, 5], (num: number) => {
        Row() {
          Column() {
            Text(`Message ${num}`)
              .fontSize(14)
              .fontColor(num % 2 === 0 ? '#1E293B' : '#FFFFFF')
          }
          .padding(12)
          .backgroundColor(num % 2 === 0 ? '#E2E8F0' : '#0EA5E9')
          .borderRadius(12)
        }
        .width('100%')
        .justifyContent(num % 2 === 0 ? FlexAlign.Start : FlexAlign.End)
        .margin({ bottom: 8 })
      })
    }
    .width('100%')
    .padding(16)
  }

  @Builder
  StatsPage() {
    Column() {
      Text("Weekly Calories")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#1E293B')
        .margin({ top: 16, bottom: 16 })

      ForEach([1, 2, 3, 4, 5, 6, 7], (num: number) => {
        Row() {
          Row()
            .width(`${Math.min(30 + num * 10, 100)}%`)
            .height(24)
            .backgroundColor('#0EA5E9')
            .borderRadius(8)
        }
        .width('100%')
        .height(24)
        .backgroundColor('#E2E8F0')
        .borderRadius(8)
        .margin({ bottom: 8 })
      })

      Button('Share Report')
        .width('60%')
        .height(48)
        .backgroundColor('#6366F1')
        .fontColor('#FFFFFF')
        .borderRadius(16)
        .margin({ top: 24 })
    }
    .width('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Center)
  }
}