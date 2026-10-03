// Translated from SwiftUI to ArkTS (ArkUI declarative syntax)
// PodcastListenColdGradientApp - full screen - Cold Gradient

// MARK: - Tokens
class PC {
  static readonly C = {
    primary: "#38BDF8",
    secondary: "#0EA5E9",
    tertiary: "#0284C7",
    background: "#F0F9FF",
    surface: "#FFFFFF",
    surfaceVariant: "#E0F2FE",
    outline: "#BFE0F4",
    success: "#16A34A",
    warning: "#F59E0B",
    error: "#DC2626",
    onPrimary: "#001F2F",
    onSecondary: "#FFFFFF",
    onTertiary: "#FFFFFF",
    onBackground: "#082F49",
    onSurface: "#082F49",
  };
}

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
    "Design Flow",
  ];

  build() {
    Stack() {
      Column({ space: 0 }) {
        // ===== Top Spacer =====
        Blank()
          .height(25)

        // ===== Top App Bar =====
        Stack() {
          Rect()
            .width("100%")
            .height(60)
            .fill(PC.C.background)

          Text("Podcasts")
            .fontSize(28)
            .fontWeight(FontWeight.Semibold)
            .fontColor(PC.C.onSurface)
        }
        .width("100%")
        .height(60)

        // ===== Tab Selection =====
        Row({ space: 10 }) {
          ForEach(this.tabs, (tab: string, index: number) => {
            Button() {
              Row({ space: 1 }) {
                if (this.selectedTab == index) {
                  Text("\u2713")
                    .fontSize(13)
                    .fontWeight(FontWeight.Bold)
                }
                Text(tab)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
              }
              .fontColor(this.selectedTab == index ? PC.C.onPrimary : PC.C.onSurface)
              .width(112)
              .height(39)
              .justifyContent(FlexAlign.Center)
              .backgroundColor(this.selectedTab == index ? PC.C.primary : PC.C.surface)
              .borderRadius(8)
              .border({ width: 1, color: PC.C.outline })
            }
            .width(112)
            .height(39)
            .onClick(() => {
              this.selectedTab = index;
            })
          }, (tab: string, index: number) => index.toString())
        }
        .width("100%")
        .padding({ left: 16, right: 16 })
        .padding({ top: 15, bottom: 15 })
        .linearGradient({
          angle: 180,
          colors: [[PC.C.surfaceVariant, 0.0], [PC.C.background, 1.0]]
        })

        // ===== Podcast List =====
        Scroll() {
          Column({ space: 15 }) {
            ForEach(this.podcasts, (podcast: string) => {
              Row() {
                Column({ space: 5 }) {
                  Text(podcast)
                    .fontSize(20)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(PC.C.onSurface)
                  Text("30 min episode")
                    .fontSize(14)
                    .fontColor(PC.C.onSurface)
                    .opacity(0.7)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Button() {
                  Text("Play")
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(PC.C.onSecondary)
                    .width(84)
                    .height(39)
                }
                .width(84)
                .height(39)
                .backgroundColor(PC.C.secondary)
                .borderRadius(8)
                .onClick(() => {
                  this.selectedPodcast = podcast;
                  this.showDialog = true;
                })
              }
              .width("100%")
              .padding(16)
              .backgroundColor(PC.C.surface)
              .borderRadius(12)
              .padding({ left: 16, right: 16 })
            }, (podcast: string) => podcast)
          }
          .padding({ top: 12, bottom: 12 })
        }
        .backgroundColor(PC.C.background)
        .layoutWeight(1)

        // ===== Bottom Spacer =====
        Blank()
          .height(20)
      }
      .width("100%")
      .height("100%")
      .linearGradient({
        angle: 180,
        colors: [[PC.C.surfaceVariant, 0.0], [PC.C.background, 1.0]]
      })

      // Alert dialog equivalent
      if (this.showDialog) {
        Stack() {
          Column({ space: 16 }) {
            Text("Playing Podcast")
              .fontSize(18)
              .fontWeight(FontWeight.Semibold)
              .fontColor("#000000")
            Text("Streaming audio...")
              .fontSize(14)
              .fontColor("#000000")
            Button() {
              Text("OK")
                .fontSize(14)
                .fontColor(PC.C.primary)
            }
            .onClick(() => {
              this.showDialog = false;
            })
          }
          .padding(24)
          .backgroundColor("#FFFFFF")
          .borderRadius(12)
        }
        .width("100%")
        .height("100%")
        .backgroundColor("#00000066")
      }
    }
  }
}

@Entry
@Component
struct Index {
  build() {
    PodcastColdRoot()
  }
}
