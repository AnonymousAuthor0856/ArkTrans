@Entry
@Component
struct Index {
  @State selectedTab: number = 0
  private tabs: string[] = ['Meals', 'Chat', 'Stats']

  build() {
    Stack() {
      Column() {
        // Header Section
        Row() {
          Text('Diet Log')
            .fontColor('#1E293B')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .width('100%')
        }
        .padding({ left: 24, right: 24, top: 24, bottom: 16 })
        .backgroundColor('#E2E8F0')

        // Tab Bar Section
        Column() {
          Row() {
            ForEach(this.tabs, (tab: string, index: number) => {
              Button() {
                Text(tab)
                  .fontColor(index === this.selectedTab ? '#0EA5E9' : '#1E293B')
                  .fontSize(16)
                  .fontWeight(index === this.selectedTab ? FontWeight.Medium : FontWeight.Normal)
                  .width('100%')
                  .textAlign(TextAlign.Center)
              }
              .type(ButtonType.Normal)
              .backgroundColor(Color.Transparent)
              .layoutWeight(1)
              .onClick(() => {
                this.selectedTab = index
              })
            })
          }
          .width('100%')
          .height(48)

          // Animated Indicator
          Rect()
            .fill('#0EA5E9')
            .width(`${100 / this.tabs.length}%`)
            .height(2)
            .margin({ top: -2 }) // Align with bottom of buttons
            .position({ x: `${this.selectedTab * (100 / this.tabs.length)}%`, y: 0 })
            .animation({ duration: 200, curve: Curve.EaseInOut })
        }
        .width('100%')
        .backgroundColor('#FFFFFF')

        // Content Area
        Column() {
          if (this.selectedTab === 0) {
            // Meals Tab
            Column() {
              Text("Today's Meals")
                .fontColor('#1E293B')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .alignSelf(ItemAlign.Start)
                .margin({ bottom: 16 })

              ForEach([0, 1, 2], (index: number) => {
                Stack() {
                  Text(`Meal ${index + 1}`)
                    .fontColor('#1E293B')
                    .fontSize(14)
                }
                .width('100%')
                .height(80)
                .borderRadius(16)
                .backgroundColor('#FFFFFF')
                .border({ width: 1, color: '#CBD5E1' })
                .margin({ bottom: 16 })
              })

              Blank()
            }
            .width('100%')
            .layoutWeight(1)
            .padding(24)
            .backgroundColor('#E2E8F0')
          } else if (this.selectedTab === 1) {
            // Chat Tab
            Column() {
              Text('Diet Chat')
                .fontColor('#1E293B')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .alignSelf(ItemAlign.Start)
                .margin({ bottom: 16 })

              ForEach([0, 1, 2, 3, 4], (index: number) => {
                Row() {
                  if (index % 2 === 0) {
                    Text(`Message ${index + 1}`)
                      .borderRadius(16)
                      .backgroundColor('#E2E8F0')
                      .padding(8)
                      .fontColor('#1E293B')
                      .fontSize(14)
                    Blank()
                  } else {
                    Blank()
                    Text(`Message ${index + 1}`)
                      .borderRadius(16)
                      .backgroundColor('#0EA5E9')
                      .padding(8)
                      .fontColor('#FFFFFF')
                      .fontSize(14)
                  }
                }
                .width('100%')
                .margin({ bottom: 8 })
              })

              Blank()
            }
            .width('100%')
            .layoutWeight(1)
            .padding(24)
            .backgroundColor('#E2E8F0')
          } else {
            // Stats Tab
            Column() {
              Text('Weekly Calories')
                .fontColor('#1E293B')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .alignSelf(ItemAlign.Start)
                .margin({ bottom: 16 })

              ForEach([0, 1, 2, 3, 4, 5, 6], (index: number) => {
                Row() {
                  Rect()
                    .borderRadius(4)
                    .fill('#0EA5E9')
                    .width(`${30 + index * 10}%`)
                    .height(24)
                  Blank()
                }
                .width('100%')
                .height(24)
                .borderRadius(4)
                .backgroundColor('#E2E8F0')
                .margin({ bottom: 8 })
              })

              Blank().height(24)

              Button() {
                Text('View Details')
                  .fontColor('#FFFFFF')
                  .fontSize(14)
              }
              .borderRadius(24)
              .backgroundColor('#6366F1')
              .width('60%')
              .height(48)
            }
            .width('100%')
            .layoutWeight(1)
            .padding(24)
            .backgroundColor('#E2E8F0')
          }
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#E2E8F0')
    }
    .width('100%')
    .height('100%')
  }
}