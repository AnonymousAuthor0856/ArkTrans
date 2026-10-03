const PRIMARY: string = '#38BDF8'
const SECONDARY: string = '#0EA5E9'
const BACKGROUND: string = '#F0F9FF'
const SURFACE_VARIANT: string = '#E0F2FE'
const OUTLINE: string = '#BFE0F4'
const ON_SURFACE: string = '#082F49'
const ON_PRIMARY: string = '#001F2F'

@Entry
@Component
struct PodcastColdRoot {
  @State private selectedTab: number = 0
  private readonly tabs: string[] = ['Trending', 'Following', 'Recent']
  private readonly podcasts: string[] = [
    'AI Insights',
    'Mindful Moments',
    'History Flash',
    'Tech Hour',
    'Design Flow'
  ]

  build() {
    Column() {
      Column() {
        Text('Podcasts')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(ON_SURFACE)
      }
      .height(84)
      .width('100%')
      .justifyContent(FlexAlign.End)
      .padding({ bottom: 18 })
      .backgroundColor(BACKGROUND)

      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Button() {
            Row({ space: 2 }) {
              if (this.selectedTab === index) {
                Text('✓')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
              }
              Text(tab)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
            }
            .justifyContent(FlexAlign.Center)
            .width('100%')
            .height('100%')
          }
          .fontColor(this.selectedTab === index ? ON_PRIMARY : ON_SURFACE)
          .backgroundColor(this.selectedTab === index ? PRIMARY : Color.White)
          .border({
            width: 1,
            color: OUTLINE,
            radius: 8
          })
          .borderRadius(8)
          .height(40)
          .layoutWeight(1)
          .onClick(() => {
            this.selectedTab = index
          })
        })
      }
      .width('100%')
      .height(69)
      .padding({ left: 16, right: 16, top: 15, bottom: 14 })
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor(SURFACE_VARIANT)

      Scroll() {
        Column({ space: 15 }) {
          ForEach(this.podcasts, (podcast: string) => {
            Row() {
              Column() {
                Text(podcast)
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(ON_SURFACE)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })

                Text('30 min episode')
                  .fontSize(14)
                  .fontColor('#55738A')
                  .margin({ top: 5 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Button('Play')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.White)
                .backgroundColor(SECONDARY)
                .borderRadius(8)
                .width(84)
                .height(40)
                .onClick(() => {
                  AlertDialog.show({
                    title: 'Playing Podcast',
                    message: 'Streaming audio...',
                    autoCancel: true,
                    alignment: DialogAlignment.Center,
                    primaryButton: {
                      value: 'OK',
                      action: () => {}
                    }
                  })
                })
            }
            .width('100%')
            .height(78)
            .padding({ left: 16, right: 16 })
            .backgroundColor(Color.White)
            .borderRadius(12)
          })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(BACKGROUND)
      .scrollBar(BarState.Off)

      Blank()
        .height(20)
        .backgroundColor(BACKGROUND)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
    .padding({ top: 0 })
  }
}
