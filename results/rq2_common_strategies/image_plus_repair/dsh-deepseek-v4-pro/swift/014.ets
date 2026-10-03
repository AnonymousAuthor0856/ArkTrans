//
//  PodcastListenColdGradientApp.swift
//  iOS 16 compatible – full screen – Cold Gradient
//

// MARK: - Hex Color Helper (Swift's Color(hex:) extension equivalent)
function hexColor(hex: number): string {
  let r: number = (hex >> 16) & 0xFF
  let g: number = (hex >> 8) & 0xFF
  let b: number = hex & 0xFF
  let rr: string = (r < 16 ? '0' : '') + r.toString(16)
  let gg: string = (g < 16 ? '0' : '') + g.toString(16)
  let bb: string = (b < 16 ? '0' : '') + b.toString(16)
  return ('#' + rr + gg + bb).toUpperCase()
}

// MARK: - Tokens
class PC {
  static readonly primary: string = hexColor(0x38BDF8)
  static readonly secondary: string = hexColor(0x0EA5E9)
  static readonly tertiary: string = hexColor(0x0284C7)
  static readonly background: string = hexColor(0xF0F9FF)
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = hexColor(0xE0F2FE)
  static readonly outline: string = hexColor(0xBFE0F4)
  static readonly success: string = hexColor(0x16A34A)
  static readonly warning: string = hexColor(0xF59E0B)
  static readonly error: string = hexColor(0xDC2626)
  static readonly onPrimary: string = hexColor(0x001F2F)
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#FFFFFF'
  static readonly onBackground: string = hexColor(0x082F49)
  static readonly onSurface: string = hexColor(0x082F49)
}

@Entry
@Component
struct PodcastColdRoot {
  @State selectedTab: number = 0
  @State showDialog: boolean = false
  @State selectedPodcast: string = ''
  @State scaleFactor: number = 1

  private tabs: string[] = ['Trending', 'Following', 'Recent']
  private podcasts: string[] = [
    'AI Insights',
    'Mindful Moments',
    'History Flash',
    'Tech Hour',
    'Design Flow'
  ]

  private playPodcast(podcast: string): void {
    this.selectedPodcast = podcast
    this.showDialog = true
    AlertDialog.show({
      title: 'Playing Podcast',
      message: 'Streaming audio...',
      primaryButton: {
        value: 'OK',
        action: () => {
          this.showDialog = false
        }
      }
    })
  }

  build() {
    Column({ space: 0 }) {
      // ===== Top Spacer =====
      Blank()
        .height(0 * this.scaleFactor) // 增加顶部空白
        .padding({ bottom: 25 })

      // ===== Top App Bar =====
      Stack() {
        Rect()
          .fill(PC.background)
          .width('100%')
          .height(790 * this.scaleFactor)

        Text('Podcasts')
          .fontSize(28 * this.scaleFactor)
          .fontWeight(FontWeight.Medium)
          .fontColor(PC.onSurface)
      }
      .width('100%')
      .height(60 * this.scaleFactor)

      // ===== Tab Selection =====
      Row({ space: 10 * this.scaleFactor }) {
        ForEach(this.tabs, (tab: string, index: number) => {
          Button() {
            Row({ space: 1 * this.scaleFactor }) {
              if (this.selectedTab === index) {
                Text('✓')
                  .fontSize(13 * this.scaleFactor)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(PC.onPrimary)
              }
              Text(tab)
                .fontSize(14 * this.scaleFactor)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedTab === index ? PC.onPrimary : PC.onSurface)
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
          }
          .type(ButtonType.Normal)
          .width(112)
          .height(39 * this.scaleFactor)
          .backgroundColor(this.selectedTab === index ? PC.primary : PC.surface)
          .borderRadius(8 * this.scaleFactor)
          .border({ width: 1 * this.scaleFactor, color: PC.outline })
          .onClick(() => {
            this.selectedTab = index
          })
        }, (tab: string) => tab)
      }
      .width('100%')
      .padding({
        left: 16 * this.scaleFactor,
        right: 16 * this.scaleFactor,
        top: 15 * this.scaleFactor,
        bottom: 15 * this.scaleFactor
      })
      .linearGradient({
        angle: 180,
        colors: [[PC.surfaceVariant, 0.0], [PC.background, 1.0]]
      })

      // ===== Podcast List =====
      Scroll() {
        Column({ space: 15 * this.scaleFactor }) {
          ForEach(this.podcasts, (podcast: string) => {
            Row() {
              Column({ space: 5 * this.scaleFactor }) {
                Text(podcast)
                  .fontSize(20 * this.scaleFactor)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(PC.onSurface)
                Text('30 min episode')
                  .fontSize(14 * this.scaleFactor)
                  .fontColor(PC.onSurface)
                  .opacity(0.7)
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Button() {
                Text('Play')
                  .fontSize(14 * this.scaleFactor)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(PC.onSecondary)
              }
              .type(ButtonType.Normal)
              .width(84 * this.scaleFactor)
              .height(39 * this.scaleFactor)
              .backgroundColor(PC.secondary)
              .borderRadius(8 * this.scaleFactor)
              .onClick(() => {
                this.playPodcast(podcast)
              })
            }
            .width('100%')
            .padding(16 * this.scaleFactor)
            .backgroundColor(PC.surface)
            .borderRadius(12 * this.scaleFactor)
            .padding({ left: 16 * this.scaleFactor, right: 16 * this.scaleFactor })
          }, (podcast: string) => podcast)
        }
        .width('100%')
        .padding({ top: 12 * this.scaleFactor, bottom: 12 * this.scaleFactor })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(PC.background)

      // ===== Bottom Spacer =====
      Blank()
        .height(20 * this.scaleFactor) // 增加底部空白
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [[PC.surfaceVariant, 0.0], [PC.background, 1.0]]
    })
    .onAreaChange((oldValue: Area, newValue: Area) => {
      let w: number = Number(newValue.width)
      let h: number = Number(newValue.height)
      this.scaleFactor = Math.min(w / 360, h / 640)
    })
  }
}
