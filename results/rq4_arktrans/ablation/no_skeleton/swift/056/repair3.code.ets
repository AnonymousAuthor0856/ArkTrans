@Entry
@Component
struct DietLogApp {
  @State selectedTab: number = 0

  build() {
    Column() {
      // === Header ===
      Row() {
        Text('Diet Log')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F1F5F9')

      // === Tabs ===
      Column() {
        Row() {
          Button() {
            Text('Meals')
              .fontSize(14)
              .fontColor(this.selectedTab === 0 ? '#0EA5E9' : '#1E293B')
          }
          .layoutWeight(1)
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .onClick(() => { this.selectedTab = 0 })

          Button() {
            Text('Chat')
              .fontSize(14)
              .fontColor(this.selectedTab === 1 ? '#0EA5E9' : '#1E293B')
          }
          .layoutWeight(1)
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .onClick(() => { this.selectedTab = 1 })

          Button() {
            Text('Stats')
              .fontSize(14)
              .fontColor(this.selectedTab === 2 ? '#0EA5E9' : '#1E293B')
          }
          .layoutWeight(1)
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .onClick(() => { this.selectedTab = 2 })
        }
        .width('100%')

        // Tab Indicator
        Row() {
          if (this.selectedTab === 0) {
            Blank().layoutWeight(1)
          }
          if (this.selectedTab === 1) {
            Blank().layoutWeight(1)
          }
          if (this.selectedTab === 2) {
            Blank().layoutWeight(1)
          }
        }
        .width('100%')
        .height(2)
        .backgroundColor('#0EA5E9')
        .margin({ top: -2 }) // Overlap slightly to match visual style
      }
      .width('100%')
      .backgroundColor('#FFFFFF')

      // === Content Area ===
      Column() {
        if (this.selectedTab === 0) {
          this.MealsPage()
        } else if (this.selectedTab === 1) {
          this.ChatPage()
        } else {
          this.StatsPage()
        }
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F1F5F9')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F5F9')
  }

  @Builder
  MealsPage() {
    Column() {
      Text("Today's Meals")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1E293B')
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 12 })

      ForEach([0, 1, 2], (index: number) => {
        Column() {
          Text(`Meal ${index + 1}`)
            .fontSize(14)
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
      
      Blank()
    }
    .width('100%')
    .padding(16)
  }

  @Builder
  ChatPage() {
    Column() {
      Text("Diet Chat")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1E293B')
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 8 })

      ForEach([0, 1, 2, 3, 4], (index: number) => {
        Row() {
          if (index % 2 === 0) {
            Text(`Message ${index + 1}`)
              .fontSize(14)
              .fontColor('#1E293B')
              .padding(12)
              .backgroundColor('#E2E8F0')
              .borderRadius(12)
            Blank()
          } else {
            Blank()
            Text(`Message ${index + 1}`)
              .fontSize(14)
              .fontColor('#FFFFFF')
              .padding(12)
              .backgroundColor('#0EA5E9')
              .borderRadius(12)
          }
        }
        .width('100%')
        .margin({ bottom: 8 })
      })

      Blank()
    }
    .width('100%')
    .padding(16)
  }

  @Builder
  StatsPage() {
    Column() {
      Text("Weekly Calories")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1E293B')
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 12 })

      ForEach([0, 1, 2, 3, 4, 5, 6], (index: number) => {
        Column() {
          Row() {
            // Simulating dynamic width based on index for demo purposes
            // In a real app, you'd calculate this based on data
            let widthPercent = 0.3 + (index * 0.1)
            if (widthPercent > 1) widthPercent = 1
            
            Row()
              .width(`${Math.round(widthPercent * 100)}%`)
              .height(24)
              .backgroundColor('#0EA5E9')
              .borderRadius(8)
            
            Blank()
          }
          .width('100%')
          .height(24)
          .backgroundColor('#E2E8F0')
          .borderRadius(8)
        }
        .width('100%')
        .margin({ bottom: 12 })
      })

      Blank()

      Button() {
        Text("Share Report")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
      }
      .width('60%')
      .height(48)
      .backgroundColor('#6366F1')
      .borderRadius(16)
      .margin({ top: 16 })
    }
    .width('100%')
    .padding(16)
  }
}