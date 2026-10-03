@Entry
@Component
struct PodcastsPage {
  @State selectedTab: number = 0;
  @State showDialog: boolean = false;

  private tabs: string[] = ["Trending", "Following", "Recent"];
  private podcasts: string[] = [
    "AI Insights",
    "Mindful Moments",
    "History Flash",
    "Tech Hour",
    "Design Flow"
  ];

  private readonly colors = {
    primary: '#38BDF8',
    secondary: '#0EA5E9',
    tertiary: '#0284C7',
    background: '#F0F9FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E0F2FE',
    outline: '#BFE0F4',
    onSurface: '#082F49',
    onPrimary: '#001F2F',
    onSecondary: '#FFFFFF'
  };

  build() {
    Stack() {
      Column() {
        Text("Podcasts")
          .fontSize(28)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.colors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 48, bottom: 24 })
          .backgroundColor(this.colors.background)

        Column({ space: 16 }) {
          Row() {
            ForEach(this.tabs, (tab: string, index: number) => {
              Text(tab)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedTab === index ? this.colors.onPrimary : this.colors.onSurface)
                .width('100%')
                .height(48)
                .textAlign(TextAlign.Center)
                .backgroundColor(this.selectedTab === index ? this.colors.primary : this.colors.surface)
                .borderRadius(12)
                .border({
                  width: { left: index > 0 ? 1 : 0, right: 0, top: 1, bottom: 1 },
                  color: this.colors.outline
                })
                .onClick(() => {
                  this.selectedTab = index;
                })
            }, (tab: string) => tab)
          }
          .width('100%')
          .borderRadius(12)
          .clip(true)
          .border({ width: 1, color: this.colors.outline })

          Column({ space: 12 }) {
            ForEach(this.podcasts, (podcast: string) => {
              Row() {
                Column() {
                  Text(podcast)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.colors.onSurface)
                  Text("30 min episode")
                    .fontSize(14)
                    .fontColor(this.colors.onSurface)
                    .opacity(0.7)
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Button("Play")
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.colors.onSecondary)
                  .backgroundColor(this.colors.secondary)
                  .borderRadius(12)
                  .width(120)
                  .height(56)
                  .onClick(() => {
                    this.showDialog = true;
                  })
              }
              .width('100%')
              .padding(16)
              .backgroundColor(this.colors.surface)
              .borderRadius(16)
              .alignItems(VerticalAlign.Center)
            }, (podcast: string) => podcast)
          }
          .width('100%')
        }
        .width('100%')
        .padding(16)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[this.colors.background, 0.0], [this.colors.surfaceVariant, 1.0]]
      })

      if (this.showDialog) {
        Stack() {
          Column() {
            Text("Playing Podcast")
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.onSurface)
              .width('100%')
              .textAlign(TextAlign.Start)
              .margin({ bottom: 12 })

            Text("Streaming audio...")
              .fontSize(14)
              .fontColor(this.colors.onSurface)
              .opacity(0.8)
              .width('100%')
              .textAlign(TextAlign.Start)
              .margin({ bottom: 20 })

            Row() {
              Text("OK")
                .fontSize(14)
                .fontColor(this.colors.primary)
                .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                .onClick(() => {
                  this.showDialog = false;
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.End)
          }
          .width(280)
          .padding(20)
          .backgroundColor(this.colors.surface)
          .borderRadius(16)
          .shadow({
            radius: 16,
            color: 'rgba(0, 0, 0, 0.15)',
            offsetY: 4
          })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0, 0, 0, 0.3)')
        .alignContent(Alignment.Center)
        .onClick(() => {
          this.showDialog = false;
        })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
  }
}
