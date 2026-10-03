// PodcastListenColdGradientApp.ets
// ArkTS compatible – full screen – Cold Gradient

// MARK: - Tokens
class PC {
  static C: Record<string, string> = {
    primary: '#38BDF8',
    secondary: '#0EA5E9',
    tertiary: '#0284C7',
    background: '#F0F9FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E0F2FE',
    outline: '#BFE0F4',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#DC2626',
    onPrimary: '#001F2F',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#082F49',
    onSurface: '#082F49'
  }
}

@Entry
@Component
struct PodcastColdRoot {
  @State private selectedTab: number = 0;
  @State private showDialog: boolean = false;
  @State private selectedPodcast: string = "";
  
  private tabs: string[] = ["Trending", "Following", "Recent"];
  private podcasts: string[] = [
    "AI Insights",
    "Mindful Moments", 
    "History Flash",
    "Tech Hour",
    "Design Flow"
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background Layer
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [[PC.C.surfaceVariant, 0.0], [PC.C.background, 1.0]]
        })
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

      // Content Layer
      Column() {
        // ===== Top App Bar =====
        Stack({ alignContent: Alignment.Center }) {
          Text("Podcasts")
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor(PC.C.onSurface)
        }
        .width('100%')
        .height(60)
        .backgroundColor(PC.C.background)
        .padding({ bottom: 25 })

        // ===== Tab Selection =====
        Row({ space: 10 }) {
          ForEach(this.tabs, (tab: string, index: number) => {
            Button({ type: ButtonType.Normal }) {
              Row({ space: 1 }) {
                if (this.selectedTab === index) {
                  Text('✓')
                    .fontSize(13)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(this.selectedTab === index ? PC.C.onPrimary : PC.C.onSurface)
                }
                Text(tab)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedTab === index ? PC.C.onPrimary : PC.C.onSurface)
              }
              .width(112)
              .height(39)
              .justifyContent(FlexAlign.Center)
            }
            .onClick(() => {
              this.selectedTab = index;
            })
            .borderRadius(8)
            .backgroundColor(this.selectedTab === index ? PC.C.primary : PC.C.surface)
            .border({ width: 1, color: PC.C.outline })
          })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 15, bottom: 15 })
        .linearGradient({
          angle: 180,
          colors: [[PC.C.surfaceVariant, 0.0], [PC.C.background, 1.0]]
        })

        // ===== Podcast List =====
        Scroll() {
          Column({ space: 15 }) {
            ForEach(this.podcasts, (podcast: string) => {
              Row() {
                Column() {
                  Text(podcast)
                    .fontSize(20)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(PC.C.onSurface)
                    .alignSelf(ItemAlign.Start)
                  
                  Text("30 min episode")
                    .fontSize(14)
                    .fontColor(PC.C.onSurface)
                    .opacity(0.7)
                    .alignSelf(ItemAlign.Start)
                    .margin({ top: 5 })
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Button({ type: ButtonType.Normal }) {
                  Text("Play")
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(PC.C.onSecondary)
                }
                .width(84)
                .height(39)
                .borderRadius(8)
                .backgroundColor(PC.C.secondary)
                .onClick(() => {
                  this.selectedPodcast = podcast;
                  this.showDialog = true;
                })
              }
              .width('100%')
              .padding(16)
              .borderRadius(12)
              .backgroundColor(PC.C.surface)
            })
          }
          .padding({ top: 12, bottom: 12, left: 16, right: 16 })
        }
        .layoutWeight(1)
        .backgroundColor(PC.C.background)
        
        // ===== Bottom Spacer =====
        Column()
          .width('100%')
          .height(20)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .bindContentCover(this.showDialog, this.alertBuilder)
  }

  @Builder
  alertBuilder() {
    Column() {
      Text('Playing Podcast')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 10 })
      
      Text('Streaming audio...')
        .fontSize(16)
        .margin({ bottom: 20 })
      
      Button('OK')
        .width(100)
        .height(40)
        .onClick(() => {
          this.showDialog = false;
        })
    }
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .justifyContent(FlexAlign.Center)
  }
}