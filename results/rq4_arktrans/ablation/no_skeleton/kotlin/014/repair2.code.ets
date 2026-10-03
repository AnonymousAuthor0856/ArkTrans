// src/main/ets/view/PodcastScreen.ets

@Entry
@Component
struct PodcastScreen {
  @State selectedTab: number = 0
  @State showDialog: boolean = false

  private readonly tabs: string[] = ["Trending", "Following", "Recent"]
  private readonly podcasts: string[] = [
    "AI Insights",
    "Mindful Moments",
    "History Flash",
    "Tech Hour",
    "Design Flow"
  ]

  build() {
    Stack() {
      Column() {
        // Top Bar
        Text("Podcasts")
          .fontSize(28)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#082F49')
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ top: 40, bottom: 24 })

        // Segmented Buttons (Tabs)
        Row({ space: 8 }) {
          ForEach(this.tabs, (tab: string, index: number) => {
            Button(tab)
              .type(ButtonType.Normal)
              .backgroundColor(index === this.selectedTab ? '#38BDF8' : '#FFFFFF')
              .fontColor(index === this.selectedTab ? '#001F2F' : '#082F49')
              .borderRadius(8)
              .height(40)
              .layoutWeight(1)
              .onClick(() => {
                this.selectedTab = index
              })
              .border({ width: 1, color: '#BFE0F4' })
          })
        }
        .width('100%')
        .margin({ bottom: 24 })

        // Podcast List
        List({ space: 16 }) {
          ForEach(this.podcasts, (podcast: string) => {
            ListItem() {
              Row() {
                Column({ space: 4 }) {
                  Text(podcast)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#082F49')
                  
                  Text("30 min episode")
                    .fontSize(14)
                    .fontColor('#5C7A8E') // Approximated alpha color for readability
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Button("Play")
                  .type(ButtonType.Normal)
                  .backgroundColor('#0EA5E9')
                  .fontColor('#FFFFFF')
                  .borderRadius(8)
                  .height(40)
                  .width(80)
                  .onClick(() => {
                    this.showDialog = true
                  })
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#E0F2FE', 0], ['#F0F9FF', 1]]
      })
      .padding(16)

      // Dialog Overlay
      if (this.showDialog) {
        Stack() {
          // Backdrop
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor('#80000000')
            .onClick(() => {
              this.showDialog = false
            })

          // Dialog Content
          Column() {
            Text("Playing Podcast")
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#082F49')
              .margin({ bottom: 8 })
            
            Text("Streaming audio...")
              .fontSize(14)
              .fontColor('#333333')
              .margin({ bottom: 24 })

            Button("OK")
              .type(ButtonType.Capsule)
              .backgroundColor('#38BDF8')
              .fontColor('#001F2F')
              .width(80)
              .onClick(() => {
                this.showDialog = false
              })
          }
          .width(300)
          .padding(24)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .height('100%')
        .position({ x: 0, y: 0 })
      }
    }
    .width('100%')
    .height('100%')
  }
}