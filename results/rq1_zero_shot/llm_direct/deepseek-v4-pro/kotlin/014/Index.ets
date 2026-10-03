import { UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct RootScreen {
  @State selectedTab: number = 0;
  @State showDialog: boolean = false;
  private tabs: string[] = ['Trending', 'Following', 'Recent'];
  private podcasts: string[] = ['AI Insights', 'Mindful Moments', 'History Flash', 'Tech Hour', 'Design Flow'];

  // AppTokens Colors
  private primary: string = '#38BDF8';
  private secondary: string = '#0EA5E9';
  private tertiary: string = '#0284C7';
  private background: string = '#F0F9FF';
  private surface: string = '#FFFFFF';
  private surfaceVariant: string = '#E0F2FE';
  private outline: string = '#BFE0F4';
  private onPrimary: string = '#001F2F';
  private onSecondary: string = '#FFFFFF';
  private onSurface: string = '#082F49';

  @Builder
  PlayButton(index: number) {
    Button() {
      Text('Play')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.onSecondary)
    }
    .backgroundColor(this.secondary)
    .borderRadius(8)
    .height(36)
    .padding({ left: 16, right: 16 })
    .onClick(() => {
      this.showDialog = true;
    })
  }

  @Builder
  PodcastCard(podcast: string) {
    Column() {
      Row() {
        Column() {
          Text(podcast)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurface)
          Text('30 min episode')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#B3082F49')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        this.PlayButton(0)
      }
      .width('100%')
      .padding(16)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .backgroundColor(this.surface)
    .borderRadius(12)
    .shadow({ radius: 8, color: '#24082F49', offsetY: 4 })
  }

  @Builder
  SegmentedTab(index: number, label: string) {
    Text(label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selectedTab === index ? this.onPrimary : this.onSurface)
      .textAlign(TextAlign.Center)
      .width('100%')
      .padding({ top: 10, bottom: 10 })
      .backgroundColor(this.selectedTab === index ? this.primary : this.surface)
      .borderRadius(8)
      .onClick(() => {
        this.selectedTab = index;
      })
  }

  build() {
    Stack() {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [[this.surfaceVariant, 0.0], [this.background, 1.0]]
        })

      Column() {
        // Top App Bar
        Row() {
          Text('Podcasts')
            .fontSize(28)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(this.onSurface)
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(this.background)

        // Main content
        Column() {
          // Segmented buttons
          Row() {
            ForEach(this.tabs, (tab: string, index: number) => {
              Column() {
                this.SegmentedTab(index, tab)
              }
              .layoutWeight(1)
              .margin({ left: index === 0 ? 0 : 4, right: index === this.tabs.length - 1 ? 0 : 4 })
            })
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 16 })

          // Podcast list
          Scroll() {
            Column() {
              ForEach(this.podcasts, (podcast: string) => {
                this.PodcastCard(podcast)
                  .margin({ bottom: 12 })
              })
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 16 })
          }
          .layoutWeight(1)
          .scrollBar(BarState.Off)
          .edgeEffect(EdgeEffect.Spring)
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      // Dialog
      if (this.showDialog) {
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('#66000000')
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.showDialog = false;
          })

        Column() {
          Text('Playing Podcast')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurface)
            .margin({ bottom: 8 })

          Text('Streaming audio...')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#CC082F49')
            .margin({ bottom: 20 })

          Button() {
            Text('OK')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.primary)
          }
          .backgroundColor(Color.Transparent)
          .borderRadius(8)
          .padding({ left: 16, right: 16 })
          .onClick(() => {
            this.showDialog = false;
          })
        }
        .width('80%')
        .padding(24)
        .backgroundColor(this.surface)
        .borderRadius(20)
        .shadow({ radius: 12, color: '#29082F49', offsetY: 6 })
        .onClick((event: ClickEvent) => {
          event.stopPropagation();
        })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}