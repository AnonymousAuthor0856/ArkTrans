@Entry
@Component
struct Index {
  @State selectedTab: number = 0
  @State showDialog: boolean = false
  @State selectedPodcast: string = ''

  private cPrimary: string = '#38BDF8'
  private cSecondary: string = '#0EA5E9'
  private cTertiary: string = '#0284C7'
  private cBackground: string = '#F0F9FF'
  private cSurface: string = '#FFFFFF'
  private cSurfaceVariant: string = '#E0F2FE'
  private cOutline: string = '#BFE0F4'
  private cText: string = '#082F49'
  private tabs: string[] = ['Trending', 'Following', 'Recent']
  private podcasts: string[] = ['AI Insights', 'Mindful Moments', 'History Flash', 'Tech Hour', 'Design Flow']

  @Builder
  TabButton(label: string, index: number) {
    Button() {
      Row() {
        if (this.selectedTab === index) {
          Text('✓')
            .fontSize(13)
            .fontWeight(FontWeight.Bold)
            .fontColor('#001F2F')
            .margin({ right: 2 })
        }
        Text(label)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.selectedTab === index ? '#001F2F' : this.cText)
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
    }
    .width(112)
    .height(39)
    .backgroundColor(this.selectedTab === index ? this.cPrimary : this.cSurface)
    .border({ width: 1, color: this.cOutline, radius: 8 })
    .onClick(() => {
      this.selectedTab = index
    })
  }

  @Builder
  PodcastRow(podcast: string) {
    Row() {
      Column() {
        Text(podcast)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cText)
          .width('100%')
        Text('30 min episode')
          .fontSize(14)
          .fontColor('#B3082F49')
          .width('100%')
          .margin({ top: 5 })
      }
      .layoutWeight(1)

      Button('Play')
        .width(84)
        .height(39)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.White)
        .backgroundColor(this.cSecondary)
        .borderRadius(8)
        .onClick(() => {
          this.selectedPodcast = podcast
          this.showDialog = true
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(this.cSurface)
    .borderRadius(12)
    .margin({ left: 16, right: 16, bottom: 15 })
  }

  @Builder
  PlayingDialog() {
    if (this.showDialog) {
      Stack({ alignContent: Alignment.Center }) {
        Rect()
          .width('100%')
          .height('100%')
          .fill('#66000000')
        Column() {
          Text('Playing Podcast')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.cText)
            .width('100%')
            .textAlign(TextAlign.Center)
          Text('Streaming audio...')
            .fontSize(14)
            .fontColor(this.cText)
            .width('100%')
            .textAlign(TextAlign.Center)
            .margin({ top: 12, bottom: 20 })
          Button('OK')
            .width(120)
            .height(40)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
            .backgroundColor(this.cSecondary)
            .borderRadius(8)
            .onClick(() => {
              this.showDialog = false
            })
        }
        .width(280)
        .padding(20)
        .backgroundColor(this.cSurface)
        .borderRadius(16)
      }
      .width('100%')
      .height('100%')
    }
  }

  build() {
    Stack() {
      Column() {
        Blank().height(25)
        Stack({ alignContent: Alignment.Center }) {
          Rect()
            .width('100%')
            .height(60)
            .fill(this.cBackground)
          Text('Podcasts')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.cText)
        }
        .height(60)
        .width('100%')

        Row() {
          ForEach(this.tabs, (tab: string, index: number) => {
            this.TabButton(tab, index)
          }, (tab: string) => tab)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 16, right: 16, top: 15, bottom: 15 })
        .backgroundColor(this.cSurfaceVariant)

        Scroll() {
          Column() {
            ForEach(this.podcasts, (podcast: string) => {
              this.PodcastRow(podcast)
            }, (podcast: string) => podcast)
          }
          .padding({ top: 12, bottom: 12 })
        }
        .layoutWeight(1)
        .backgroundColor(this.cBackground)

        Blank().height(20)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.cBackground)

      this.PlayingDialog()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBackground)
  }
}
