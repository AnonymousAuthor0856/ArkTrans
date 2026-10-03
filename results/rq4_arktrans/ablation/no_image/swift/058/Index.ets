@Entry
@Component
struct Index {
  @State selectedTabIndex: number = 0
  private tabs: string[] = ['Today', 'Friends', 'Progress']

  build() {
    Stack() {
      Column() {
        // Header
        Text('Step Challenge')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding(12)
          .fontColor('#111827')
          .fontSize(28)

        // Tab Bar Container
        Column() {
          Row() {
            ForEach(this.tabs, (tab: string, index: number) => {
              Button() {
                Text(tab)
                  .fontColor(this.selectedTabIndex === index ? '#111827' : '#6B7280')
                  .fontWeight(this.selectedTabIndex === index ? FontWeight.Bold : FontWeight.Normal)
              }
              .type(ButtonType.Normal)
              .backgroundColor(Color.Transparent)
              .width('33.33%')
              .height(40)
              .onClick(() => {
                this.selectedTabIndex = index
              })
            })
          }
          
          // Animated Indicator
          Rect()
            .fill('#111827')
            .width(`${100 / this.tabs.length}%`)
            .height(2)
            .offset({ x: `${this.selectedTabIndex * (100 / this.tabs.length)}%`, y: 0 })
            .animation({ duration: 200, curve: Curve.EaseInOut })
        }.width('100%').backgroundColor('#FFFFFF')

        // Tab Content View
        Swiper() {
          // Tab 1: Today
          Column() {
            Text("Today's Steps: 8452")
              .fontColor('#1F2937')
              .fontSize(20)
            
            Blank().height(12)
            
            Button() {
              Text('Sync Device')
                .fontColor('#FFFFFF')
            }
            .borderRadius(16)
            .backgroundColor('#111827')
            .width('60%')
            .height(48)
            
            Blank()
          }
          .width('100%')
          .height('100%')
          .padding(12)
          .alignItems(HorizontalAlign.Center)

          // Tab 2: Friends
          Column() {
            ForEach(Array.from({ length: 5 }, (_, i: number) => i), (it: number) => {
              Row() {
                Text(`User ${it + 1}`)
                  .fontSize(14)
                  .fontColor('#1F2937')
                
                Blank()
                
                Text(`${9000 - it * 500} steps`)
                  .fontSize(14)
                  .fontColor('#1F2937')
              }
              .width('100%')
              .borderRadius(8)
              .backgroundColor('#F3F4F6')
              .padding(12)
            })
          }
          .width('100%')
          .height('100%')
          .padding(12)
          .alignItems(HorizontalAlign.Start)

          // Tab 3: Progress
          Column() {
            Text('Weekly Progress')
              .fontColor('#1F2937')
              .fontSize(20)
            
            ForEach(Array.from({ length: 7 }, (_, i: number) => i), (it: number) => {
              Row() {
                Rect()
                  .borderRadius(4)
                  .width(`${Math.min(100, 30 + it * 10)}%`)
                  .fill('#111827')
                
                Blank()
              }
              .height(20)
              .borderRadius(4)
              .backgroundColor('#F3F4F6')
            })
            
            Blank()
          }
          .width('100%')
          .height('100%')
          .padding(12)
          .alignItems(HorizontalAlign.Start)
        }
        .index(this.selectedTabIndex)
        .loop(false)
        .autoPlay(false)
        .duration(300)
        .onChange((index: number) => {
          this.selectedTabIndex = index
        })
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#FFFFFF')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F3F4F6') // Surface Variant approximation
    }
    .width('100%')
    .height('100%')
  }
}