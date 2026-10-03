@Entry
@Component
struct PodcastColdRoot {
  @State selectedTab: number = 0;
  @State showDialog: boolean = false;
  @State selectedPodcast: string = "";

  private tabs: string[] = ["Trending", "Following", "Recent"];
  private podcasts: string[] = [
    "AI Insights",
    "Mindful Moments",
    "History Flash",
    "Tech Hour",
    "Design Flow"
  ];

  build() {
    Stack() {
      Column() {
        Column() {
          Text("Podcasts")
            .fontSize(28)
            .fontWeight(600)
            .fontColor("#082F49")
        }
        .width("100%")
        .height(60)
        .justifyContent(FlexAlign.Center)
        .backgroundColor("#F0F9FF")

        Row() {
          ForEach(this.tabs, (item: string, index: number) => {
            Row() {
              if (this.selectedTab === index) {
                Text("✓")
                  .fontSize(13)
                  .fontWeight(FontWeight.Bold)
                  .fontColor("#001F2F")
                  .margin({ right: 4 })
              }
              Text(item)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedTab === index ? "#001F2F" : "#082F49")
            }
            .width(112)
            .height(39)
            .justifyContent(FlexAlign.Center)
            .backgroundColor(this.selectedTab === index ? "#38BDF8" : "#FFFFFF")
            .borderRadius(8)
            .border({ width: 1, color: "#BFE0F4" })
            .onClick(() => {
              this.selectedTab = index;
            })
          })
        }
        .width("100%")
        .justifyContent(FlexAlign.SpaceEvenly)
        .padding({ top: 15, bottom: 15 })
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [["#E0F2FE", 0.0], ["#F0F9FF", 1.0]]
        })

        List({ space: 15 }) {
          ForEach(this.podcasts, (podcast: string) => {
            ListItem() {
              Row() {
                Column() {
                  Text(podcast)
                    .fontSize(20)
                    .fontWeight(FontWeight.Medium)
                    .fontColor("#082F49")
                  Text("30 min episode")
                    .fontSize(14)
                    .fontColor("rgba(8, 47, 73, 0.7)")
                    .margin({ top: 5 })
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Text("Play")
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor("#FFFFFF")
                  .width(84)
                  .height(39)
                  .textAlign(TextAlign.Center)
                  .backgroundColor("#0EA5E9")
                  .borderRadius(8)
                  .onClick(() => {
                    this.selectedPodcast = podcast;
                    this.showDialog = true;
                  })
              }
              .width("100%")
              .padding(16)
              .backgroundColor("#FFFFFF")
              .borderRadius(12)
            }
            .padding({ left: 16, right: 16 })
          })
        }
        .width("100%")
        .layoutWeight(1)
        .backgroundColor("#F0F9FF")
      }
      .width("100%")
      .height("100%")

      if (this.showDialog) {
        Column() {
          Column() {
            Text("Playing Podcast")
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor("#082F49")
              .margin({ bottom: 10 })
            Text("Streaming audio...")
              .fontSize(14)
              .fontColor("#082F49")
              .margin({ bottom: 20 })
            Text("OK")
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor("#0EA5E9")
              .padding({ left: 30, right: 30, top: 8, bottom: 8 })
              .onClick(() => {
                this.showDialog = false;
              })
          }
          .width(260)
          .padding(24)
          .backgroundColor("#FFFFFF")
          .borderRadius(12)
          .alignItems(HorizontalAlign.Center)
        }
        .width("100%")
        .height("100%")
        .backgroundColor("rgba(0, 0, 0, 0.5)")
        .justifyContent(FlexAlign.Center)
      }
    }
    .width("100%")
    .height("100%")
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [["#E0F2FE", 0.0], ["#F0F9FF", 1.0]]
    })
  }
}
