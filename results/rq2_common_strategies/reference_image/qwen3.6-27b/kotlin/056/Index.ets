// entry/src/main/ets/pages/Index.ets

@Entry
@Component
struct DietLogApp {
  @State currentPageIndex: number = 0;
  private tabs: string[] = ['Meals', 'Chat', 'Stats'];

  build() {
    Column() {
      // Header
      Text('Diet Log')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 40, bottom: 20 })
        .backgroundColor('#D6EAF8') // Light blue header background to match screenshot

      // Tab Row
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Column() {
            Text(tab)
              .fontSize(16)
              .fontWeight(this.currentPageIndex === index ? FontWeight.Medium : FontWeight.Normal)
              .fontColor(this.currentPageIndex === index ? '#0EA5E9' : '#1E293B')
              .padding({ bottom: 8 })
            
            if (this.currentPageIndex === index) {
              Divider()
                .width('100%')
                .height(4)
                .color('#0EA5E9')
                .borderRadius(2)
            }
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.currentPageIndex = index;
          })
        })
      }
      .width('100%')
      .backgroundColor(Color.White)
      .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })

      // Content Area with Gradient Background
      Column() {
        if (this.currentPageIndex === 0) {
          MealsPage()
        } else if (this.currentPageIndex === 1) {
          ChatPage()
        } else {
          StatsPage()
        }
      }
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.BOTTOM,
        colors: [['#0EA5E9', 0.1], ['#6366F1', 0.1]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F5F9')
  }
}

@Component
struct MealsPage {
  build() {
    Column() {
      Text("Today's Meals")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#1E293B')
        .margin({ left: 16, top: 16, bottom: 12 })

      ForEach([1, 2, 3], (mealNum: number) => {
        Row() {
          Text(`Meal ${mealNum}`)
            .fontSize(16)
            .fontColor('#1E293B')
        }
        .width('90%')
        .height(80)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(Color.White)
        .borderRadius(12)
        .border({ width: 1, color: '#D1D5DB' })
        .margin({ bottom: 12 })
      })
    }
    .width('100%')
    .padding({ left: 16, right: 16 })
  }
}

@Component
struct ChatPage {
  build() {
    Column() {
      Text("Diet Chat")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#1E293B')
        .margin({ left: 16, top: 16, bottom: 12 })

      ForEach([1, 2, 3, 4, 5], (msgNum: number) => {
        Row() {
          Text(`Message ${msgNum}`)
            .fontSize(14)
            .fontColor(msgNum % 2 === 0 ? '#1E293B' : '#FFFFFF')
            .padding(12)
        }
        .width('auto')
        .backgroundColor(msgNum % 2 === 0 ? '#E2E8F0' : '#0EA5E9')
        .borderRadius(12)
        .margin({ bottom: 8 })
        .alignSelf(msgNum % 2 === 0 ? ItemAlign.Start : ItemAlign.End)
      })
    }
    .width('100%')
    .padding({ left: 16, right: 16 })
  }
}

@Component
struct StatsPage {
  build() {
    Column() {
      Text("Weekly Calories")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#1E293B')
        .margin({ left: 16, top: 16, bottom: 12 })

      ForEach([0, 1, 2, 3, 4, 5, 6], (dayIndex: number) => {
        Row() {
          Row() {
            // Simulated bar chart
          }
          .width(`${Math.min(30 + dayIndex * 10, 100)}%`)
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

      Button("Share Report")
        .width('60%')
        .height(48)
        .backgroundColor('#6366F1')
        .fontColor('#FFFFFF')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .borderRadius(16)
        .margin({ top: 24 })
    }
    .width('100%')
    .padding({ left: 16, right: 16 })
    .alignItems(HorizontalAlign.Center)
  }
}