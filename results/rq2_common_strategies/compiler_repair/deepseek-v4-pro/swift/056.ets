@Entry
@Component
struct DietLogApp {
  @State selectedTab: number = 0
  private tabs: string[] = ['Meals', 'Chat', 'Stats']

  build() {
    Stack() {
      // Background gradient (simulated with semi-transparent overlay)
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F1F5F9')

      // Main content
      Column({ space: 0 }) {
        // Title
        Row({ space: 0 }) {
          Text('Diet Log')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .foregroundColor('#1E293B')
            .padding({ top: 16, bottom: 16 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        // Custom Tab Row
        Column({ space: 0 }) {
          Row({ space: 0 }) {
            ForEach(this.tabs, (tab: string, index: number) => {
              Button() {
                Text(tab)
                  .fontSize(14)
                  .foregroundColor(this.selectedTab === index ? '#0EA5E9' : '#1E293B')
                  .padding({ top: 12, bottom: 12 })
                  .width('100%')
                  .textAlign(TextAlign.Center)
              }
              .width('33.33%')
              .height(44)
              .backgroundColor('#FFFFFF')
              .onClick(() => {
                this.selectedTab = index
              })
            })
          }
          .width('100%')

          // Tab indicator
          Divider()
            .height(2)
            .color('#0EA5E9')
            .width(100 / this.tabs.length + '%')
            .margin({ left: (100 / this.tabs.length) * this.selectedTab + '%' })
        }
        .width('100%')
        .backgroundColor('#FFFFFF')

        // Content area based on selected tab
        if (this.selectedTab === 0) {
          this.mealsPage()
        } else if (this.selectedTab === 1) {
          this.chatPage()
        } else {
          this.statsPage()
        }
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  mealsPage() {
    Column({ space: 12 }) {
      Text("Today's Meals")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .foregroundColor('#1E293B')
        .width('100%')

      ForEach([1, 2, 3], (meal: number) => {
        Stack() {
          Text('Meal ' + meal)
            .fontSize(14)
            .foregroundColor('#1E293B')
        }
        .width('100%')
        .height(80)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .border({ width: 1, color: '#D1D5DB', radius: 12 })
      })

      Blank()
    }
    .padding(16)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  chatPage() {
    Column({ space: 8 }) {
      Text('Diet Chat')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .foregroundColor('#1E293B')
        .width('100%')

      ForEach([1, 2, 3, 4, 5], (msg: number) => {
        if (msg % 2 === 0) {
          Row({ space: 0 }) {
            Text('Message ' + msg)
              .fontSize(14)
              .foregroundColor('#1E293B')
              .padding(12)
              .backgroundColor('#E2E8F0')
              .borderRadius(12)
            Blank()
          }
          .width('100%')
        } else {
          Row({ space: 0 }) {
            Blank()
            Text('Message ' + msg)
              .fontSize(14)
              .foregroundColor('#FFFFFF')
              .padding(12)
              .backgroundColor('#0EA5E9')
              .borderRadius(12)
          }
          .width('100%')
        }
      })

      Blank()
    }
    .padding(16)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  statsPage() {
    Column({ space: 12 }) {
      Text('Weekly Calories')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .foregroundColor('#1E293B')
        .width('100%')

      ForEach([0, 1, 2, 3, 4, 5, 6], (day: number) => {
        Row({ space: 0 }) {
          Progress({ value: 0.3 + day * 0.1, total: 1, type: ProgressType.Linear })
            .height(24)
            .color('#0EA5E9')
            .backgroundColor('#E2E8F0')
            .borderRadius(8)
            .width((0.3 + day * 0.1) * 100 + '%')
          Blank()
        }
        .width('100%')
        .height(24)
      })

      Blank().height(16)

      Button() {
        Text('Share Report')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#FFFFFF')
          .textAlign(TextAlign.Center)
          .width('100%')
          .height(48)
      }
      .width('60%')
      .height(48)
      .backgroundColor('#6366F1')
      .borderRadius(16)
      .margin({ left: '20%' })

      Blank()
    }
    .padding(16)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }
}