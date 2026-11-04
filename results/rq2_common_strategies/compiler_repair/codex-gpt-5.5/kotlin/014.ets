class PodcastColors {
  static primary: string = '#38BDF8';
  static secondary: string = '#0EA5E9';
  static tertiary: string = '#0284C7';
  static background: string = '#F0F9FF';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E0F2FE';
  static outline: string = '#BFE0F4';
  static onPrimary: string = '#001F2F';
  static onSecondary: string = '#FFFFFF';
  static onSurface: string = '#082F49';
}

@Entry
@Component
struct Index {
  @State selectedTab: number = 0;
  @State showDialog: boolean = false;

  private tabs: string[] = ['Trending', 'Following', 'Recent'];
  private podcasts: string[] = ['AI Insights', 'Mindful Moments', 'History Flash', 'Tech Hour', 'Design Flow'];

  @Builder
  TabButton(label: string, index: number) {
    Text(label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selectedTab === index ? PodcastColors.onPrimary : PodcastColors.onSurface)
      .lineHeight(20)
      .textAlign(TextAlign.Center)
      .layoutWeight(1)
      .padding({ top: 10, bottom: 10 })
      .backgroundColor(this.selectedTab === index ? PodcastColors.primary : PodcastColors.surface)
      .border({ width: 1, color: PodcastColors.outline, radius: 8 })
      .onClick(() => {
        this.selectedTab = index;
      })
  }

  @Builder
  PodcastCard(title: string) {
    Row() {
      Column() {
        Text(title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(PodcastColors.onSurface)
          .lineHeight(24)
        Text('30 min episode')
          .fontSize(14)
          .fontColor('#B3082F49')
          .lineHeight(20)
      }
      .layoutWeight(1)
      Button('Play')
        .fontSize(14)
        .fontColor(PodcastColors.onSecondary)
        .backgroundColor(PodcastColors.secondary)
        .borderRadius(8)
        .onClick(() => {
          this.showDialog = true;
        })
    }
    .width('100%')
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(PodcastColors.surface)
    .borderRadius(12)
  }

  @Builder
  PlayingDialog() {
    if (this.showDialog) {
      Stack() {
        Column({ space: 12 }) {
          Text('Playing Podcast')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(PodcastColors.onSurface)
            .lineHeight(24)
          Text('Streaming audio...')
            .fontSize(14)
            .fontColor('#CC082F49')
            .lineHeight(20)
          Button('OK')
            .fontSize(14)
            .fontColor(PodcastColors.primary)
            .backgroundColor(PodcastColors.surface)
            .alignSelf(ItemAlign.End)
            .onClick(() => {
              this.showDialog = false;
            })
        }
        .width('82%')
        .padding(20)
        .backgroundColor(PodcastColors.surface)
        .borderRadius(20)
        .shadow({ radius: 12, color: '#26000000', offsetX: 0, offsetY: 6 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#33000000')
      .alignContent(Alignment.Center)
    }
  }

  build() {
    Stack() {
      Column() {
        Text('Podcasts')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(PodcastColors.onSurface)
          .lineHeight(34)
          .width('100%')
          .height(64)
          .textAlign(TextAlign.Center)
          .backgroundColor(PodcastColors.background)

        Column({ space: 16 }) {
          Row() {
            ForEach(this.tabs, (label: string, index: number) => {
              this.TabButton(label, index)
            }, (label: string) => label)
          }
          .width('100%')

          Column({ space: 12 }) {
            ForEach(this.podcasts, (podcast: string) => {
              this.PodcastCard(podcast)
            }, (podcast: string) => podcast)
          }
          .width('100%')
        }
        .width('100%')
        .height('100%')
        .padding(16)
        .backgroundColor(PodcastColors.background)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(PodcastColors.background)

      this.PlayingDialog()
    }
    .width('100%')
    .height('100%')
  }
}
