// entry/src/main/ets/pages/Index.ets

@Entry
@Component
struct PodcastApp {
  @State selectedTab: number = 0;
  @State showDialog: boolean = false;

  private readonly tabs: string[] = ["Trending", "Following", "Recent"];
  private readonly podcasts: string[] = [
    "AI Insights",
    "Mindful Moments",
    "History Flash",
    "Tech Hour",
    "Design Flow"
  ];

  // Color Tokens
  private readonly primaryColor: ResourceColor = '#38BDF8';
  private readonly secondaryColor: ResourceColor = '#0EA5E9';
  private readonly backgroundColor: ResourceColor = '#F0F9FF';
  private readonly surfaceColor: ResourceColor = '#FFFFFF';
  private readonly surfaceVariantColor: ResourceColor = '#E0F2FE';
  private readonly onSurfaceColor: ResourceColor = '#082F49';
  private readonly onPrimaryColor: ResourceColor = '#001F2F';
  private readonly onSecondaryColor: ResourceColor = '#FFFFFF';
  private readonly outlineColor: ResourceColor = '#BFE0F4';

  build() {
    Column() {
      Stack() {
        Column() {
          // Top Bar
          Text('Podcasts')
            .fontSize(28)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(this.onSurfaceColor)
            .width('100%')
            .textAlign(TextAlign.Center)
            .padding({ top: 20, bottom: 16 })

          // Tab Row
          Row() {
            ForEach(this.tabs, (tab: string, index: number) => {
              Button(tab)
                .type(ButtonType.Capsule)
                .backgroundColor(index === this.selectedTab ? this.primaryColor : this.surfaceColor)
                .fontColor(index === this.selectedTab ? this.onPrimaryColor : this.onSurfaceColor)
                .borderWidth(index === this.selectedTab ? 0 : 1)
                .borderColor(this.outlineColor)
                .margin({ right: index < this.tabs.length - 1 ? 8 : 0 })
                .onClick(() => {
                  this.selectedTab = index;
                })
                .layoutWeight(1)
                .height(40)
            })
          }
          .width('100%')
          .margin({ top: 16, bottom: 16 })

          // Podcast List
          List({ space: 12 }) {
            ForEach(this.podcasts, (podcast: string) => {
              ListItem() {
                Row() {
                  Column() {
                    Text(podcast)
                      .fontSize(18)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(this.onSurfaceColor)
                      .margin({ bottom: 4 })

                    Text('30 min episode')
                      .fontSize(14)
                      .fontColor('#5A7D91') // Approximate alpha version of onSurface
                  }
                  .alignItems(HorizontalAlign.Start)
                  .layoutWeight(1)

                  Button('Play')
                    .type(ButtonType.Capsule)
                    .backgroundColor(this.secondaryColor)
                    .fontColor(this.onSecondaryColor)
                    .height(40)
                    .width(80)
                    .onClick(() => {
                      this.showDialog = true;
                    })
                }
                .width('100%')
                .padding(16)
                .backgroundColor(this.surfaceColor)
                .borderRadius(12)
              }
            })
          }
          .width('100%')
          .layoutWeight(1)
        }
        .width('100%')
        .height('100%')
        .backgroundColor(this.backgroundColor)
        .padding(16)

        // Dialog Overlay
        if (this.showDialog) {
          Stack() {
            // Backdrop
            Column()
              .width('100%')
              .height('100%')
              .backgroundColor('#80000000') // Semi-transparent black
              .onClick(() => {
                this.showDialog = false;
              })

            // Dialog Content
            Column() {
              Text('Playing Podcast')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.onSurfaceColor)
                .margin({ bottom: 8 })

              Text('Streaming audio...')
                .fontSize(14)
                .fontColor('#CC082F49') // Approximate alpha version of onSurface
                .margin({ bottom: 16 })

              Button('OK')
                .type(ButtonType.Capsule)
                .backgroundColor(Color.Transparent)
                .fontColor(this.primaryColor)
                .width('100%')
                .onClick(() => {
                  this.showDialog = false;
                })
            }
            .width('80%')
            .padding(24)
            .backgroundColor(this.surfaceColor)
            .borderRadius(16)
            .align(Alignment.Center)
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
}