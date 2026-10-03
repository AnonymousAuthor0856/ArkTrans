import { promptAction } from '@kit.ArkUI';

const PRIMARY_COLOR = '#38BDF8';
const SECONDARY_COLOR = '#0EA5E9';
const SURFACE_COLOR = '#FFFFFF';
const SURFACE_VARIANT_COLOR = '#E0F2FE';
const BACKGROUND_COLOR = '#F0F9FF';
const ON_SURFACE_COLOR = '#082F49';
const ON_PRIMARY_COLOR = '#001F2F';
const ON_SECONDARY_COLOR = '#FFFFFF';

@Entry
@Component
struct RootScreen {
  @State selectedTab: number = 0;
  @State showDialog: boolean = false;

  private tabs: string[] = ['Trending', 'Following', 'Recent'];
  private podcasts: string[] = ['AI Insights', 'Mindful Moments', 'History Flash', 'Tech Hour', 'Design Flow'];

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Podcasts')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SURFACE_COLOR)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(BACKGROUND_COLOR)

      // Main Content
      Column() {
        // Segmented Tabs
        Row() {
          ForEach(this.tabs, (tab: string, index: number) => {
            Text(tab)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedTab === index ? ON_PRIMARY_COLOR : ON_SURFACE_COLOR)
              .backgroundColor(this.selectedTab === index ? PRIMARY_COLOR : SURFACE_COLOR)
              .padding({ top: 8, bottom: 8, left: 16, right: 16 })
              .borderRadius(8)
              .border({ width: 1, color: '#BFE0F4' })
              .onClick(() => {
                this.selectedTab = index;
              })
              .layoutWeight(1)
              .textAlign(TextAlign.Center)
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ bottom: 16 })

        // Podcast Cards
        Scroll() {
          Column({ space: 12 }) {
            ForEach(this.podcasts, (podcast: string) => {
              Row() {
                Column() {
                  Text(podcast)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(ON_SURFACE_COLOR)
                    .margin({ bottom: 4 })
                  Text('30 min episode')
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#82A8C0')
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Button('Play')
                  .fontSize(14)
                  .fontColor(ON_SECONDARY_COLOR)
                  .backgroundColor(SECONDARY_COLOR)
                  .borderRadius(8)
                  .padding({ top: 8, bottom: 8, left: 16, right: 16 })
                  .onClick(() => {
                    this.showDialog = true;
                  })
              }
              .width('100%')
              .padding(16)
              .backgroundColor(SURFACE_COLOR)
              .borderRadius(12)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .shadow({ radius: 8, color: '#1A000000', offsetX: 0, offsetY: 4 })
            })
          }
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[0xFFE0F2FE, 0.0], [0xFFF0F9FF, 1.0]]
      })

      // Dialog
      if (this.showDialog) {
        Column() {
          Column() {
            Text('Playing Podcast')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(ON_SURFACE_COLOR)
              .margin({ bottom: 12 })

            Text('Streaming audio...')
              .fontSize(14)
              .fontColor('#82A8C0')
              .margin({ bottom: 24 })

            Row() {
              Text('OK')
                .fontSize(14)
                .fontColor(PRIMARY_COLOR)
                .fontWeight(FontWeight.Medium)
                .onClick(() => {
                  this.showDialog = false;
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.End)
          }
          .width('85%')
          .padding(24)
          .backgroundColor(SURFACE_COLOR)
          .borderRadius(20)
          .shadow({ radius: 12, color: '#29000000', offsetX: 0, offsetY: 6 })
        }
        .width('100%')
        .height('100%')
        .position({ x: 0, y: 0 })
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#80000000')
        .onClick(() => {
          this.showDialog = false;
        })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_COLOR)
  }
}