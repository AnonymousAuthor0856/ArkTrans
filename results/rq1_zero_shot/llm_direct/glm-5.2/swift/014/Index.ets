import { Length, ResourceStr } from '@ohos.arkui';

// MARK: - Color Tokens
class PC_C {
  static readonly primary: string = '#38BDF8';
  static readonly secondary: string = '#0EA5E9';
  static readonly tertiary: string = '#0284C7';
  static readonly background: string = '#F0F9FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E0F2FE';
  static readonly outline: string = '#BFE0F4';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#DC2626';
  static readonly onPrimary: string = '#001F2F';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#082F49';
  static readonly onSurface: string = '#082F49';
}

@Entry
@Component
struct PodcastColdRoot {
  @State private var selectedTab: number = 0;
  @State private var showDialog: boolean = false;
  @State private var selectedPodcast: string = "";
  @State private var containerWidth: number = 360;
  @State private var containerHeight: number = 640;

  private tabs: string[] = ["Trending", "Following", "Recent"];
  private podcasts: string[] = [
    "AI Insights",
    "Mindful Moments",
    "History Flash",
    "Tech Hour",
    "Design Flow"
  ];

  private get scale(): number {
    return Math.min(this.containerWidth / 360.0, this.containerHeight / 640.0);
  }

  build() {
    Stack() {
      // Background Layer
      Column() {
        LinearGradient({
          direction: GradientDirection.TopBottom,
          colors: [[PC_C.surfaceVariant, 0.0], [PC_C.background, 1.0]]
        })
      }
      .width('100%')
      .height('100%')

      // Content Layer
      Column() {
        // ===== Top App Bar =====
        ZStack() {
          Text("Podcasts")
            .fontSize(28 * this.scale)
            .fontWeight(FontWeight.Medium)
            .fontColor(PC_C.onSurface)
        }
        .width('100%')
        .height(60 * this.scale)
        .padding({ bottom: 25 })

        // ===== Tab Selection =====
        Row({ space: 10 * this.scale }) {
          ForEach(this.tabs, (tab: string, index: number) => {
            Button() {
              this.selectedTab = index;
            } type: ButtonType.Normal {
              Row({ space: 1 * this.scale }) {
                if (this.selectedTab === index) {
                  Image($r('sys.symbol.checkmark'))
                    .width(13 * this.scale)
                    .height(13 * this.scale)
                    .fontWeight(FontWeight.Bold)
                    .fillColor(this.selectedTab === index ? PC_C.onPrimary : PC_C.onSurface)
                }
                Text(tab)
                  .fontSize(14 * this.scale)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedTab === index ? PC_C.onPrimary : PC_C.onSurface)
              }
              .width(112)
              .height(39 * this.scale)
              .justifyContent(FlexAlign.Center)
              .borderRadius(8 * this.scale)
              .backgroundColor(this.selectedTab === index ? PC_C.primary : PC_C.surface)
              .border({ width: 1, color: PC_C.outline })
            }
          }, (tab: string) => tab)
        }
        .width('100%')
        .padding({ left: 16 * this.scale, right: 16 * this.scale, top: 15 * this.scale, bottom: 15 * this.scale })
        .background(LinearGradient({
          direction: GradientDirection.TopBottom,
          colors: [[PC_C.surfaceVariant, 0.0], [PC_C.background, 1.0]]
        }))

        // ===== Podcast List =====
        Scroll() {
          Column({ space: 15 * this.scale }) {
            ForEach(this.podcasts, (podcast: string) => {
              Row() {
                Column() {
                  Text(podcast)
                    .fontSize(20 * this.scale)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(PC_C.onSurface)
                  Text("30 min episode")
                    .fontSize(14 * this.scale)
                    .fontColor(PC_C.onSurface)
                    .opacity(0.7)
                    .margin({ top: 5 * this.scale })
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Button() {
                  this.selectedPodcast = podcast;
                  this.showDialog = true;
                } type: ButtonType.Normal {
                  Text("Play")
                    .fontSize(14 * this.scale)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(PC_C.onSecondary)
                    .width(84 * this.scale)
                    .height(39 * this.scale)
                    .textAlign(TextAlign.Center)
                    .borderRadius(8 * this.scale)
                    .backgroundColor(PC_C.secondary)
                }
              }
              .width('100%')
              .padding(16 * this.scale)
              .borderRadius(12 * this.scale)
              .backgroundColor(PC_C.surface)
            }, (podcast: string) => podcast)
          }
          .padding({ top: 12 * this.scale, bottom: 12 * this.scale, left: 16 * this.scale, right: 16 * this.scale })
        }
        .layoutWeight(1)
        .backgroundColor(PC_C.background)

        // ===== Bottom Spacer =====
        Column()
          .width('100%')
          .height(20 * this.scale)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .onAreaChange(() => {
      // Fallback screen size logic if onAreaChange doesn't provide expected bounds
    })
    .bindContentCover(this.showDialog, {
      builder: () => {
        this.AlertDialogBuilder()
      },
      onDisappear: () => {
        this.showDialog = false;
      }
    })
  }

  @Builder
  AlertDialogBuilder() {
    Column() {
      Column() {
        Text("Playing Podcast")
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(PC_C.onSurface)
          .margin({ bottom: 8 })
        Text(`Streaming audio...`)
          .fontSize(16)
          .fontColor(PC_C.onSurface)
          .opacity(0.7)
      }
      .width('100%')
      .padding({ top: 24, bottom: 24, left: 24, right: 24 })
      .justifyContent(FlexAlign.Center)

      Divider().color(PC_C.outline).strokeWidth(1)

      Row() {
        Button("OK") {
          this.showDialog = false;
        }
        .type(ButtonType.Normal)
        .layoutWeight(1)
        .height(48)
        .fontSize(16)
        .fontColor(PC_C.primary)
        .backgroundColor(Color.Transparent)
      }
      .width('100%')
    }
    .width('80%')
    .borderRadius(12)
    .backgroundColor(PC_C.surface)
    .shadow({ radius: 20, color: 'rgba(0,0,0,0.15)', offsetX: 0, offsetY: 5 })
  }
}