import { AlertDialog } from '@kit.ArkUI'

@Entry
@Component
struct Index {
  @State showDialog: boolean = false
  @State selectedTab: number = 0
  @State tabs: string[] = ['All', 'Recent', 'Favorites']
  @State podcasts: PodcastItem[] = [
    { title: 'The Daily', duration: '30 min episode' },
    { title: 'Up Next', duration: '45 min episode' },
    { title: 'Planet Money', duration: '20 min episode' }
  ]

  build() {
    Stack() {
      Column() {
        // Spacer (Top)
        Blank().height(0)

        // Header Section
        Stack() {
          Rect().fill('#F1F0FB').height('100%')
          Text('Podcasts')
            .fontColor('#1C1B1F')
            .fontSize(28)
            .fontWeight(FontWeight.SemiBold)
            .position({ x: 0, y: 0 })
        }.height(60).width('100%')

        // Tabs Section
        Row() {
          ForEach(this.tabs, (tab: string, index: number) => {
            Button() {
              Row() {
                if (this.selectedTab === index) {
                  Image($r('app.media.startIcon'))
                    .width(13)
                    .height(13)
                    .objectFit(ImageFit.Contain)
                }
                Text(tab)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedTab === index ? '#FFFFFF' : '#1C1B1F')
                
                // Visual separator or background logic handled by button style
              }
              .width('100%')
              .justifyContent(FlexAlign.Start)
              .alignItems(VerticalAlign.Center)
              .padding({ left: 12, right: 12 })
            }
            .type(ButtonType.Normal)
            .backgroundColor(this.selectedTab === index ? '#938F91' : '#E7E0EC')
            .borderRadius(8)
            .height(39)
            .margin({ right: 10 })
            .onClick(() => {
              this.selectedTab = index
            })
          })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 15, bottom: 15 })
        .backgroundColor('#F1F0FB')

        // List Section
        Scroll() {
          Column() {
            ForEach(this.podcasts, (podcast: PodcastItem) => {
              Row() {
                Column() {
                  Text(podcast.title)
                    .fontColor('#1C1B1F')
                    .fontSize(20)
                    .fontWeight(FontWeight.Medium)
                  
                  Text(podcast.duration)
                    .fontColor('#49454F')
                    .opacity(0.7)
                    .fontSize(14)
                }
                .alignItems(HorizontalAlign.Start)
                .justifyContent(FlexAlign.Start)
                .layoutWeight(1)

                Button() {
                  Text('Play')
                    .fontColor('#FFFFFF')
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                }
                .type(ButtonType.Capsule)
                .backgroundColor('#6750A4')
                .width(84)
                .height(39)
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .margin({ bottom: 15 })
            })
          }
          .padding({ top: 12, bottom: 12 })
        }
        .layoutWeight(1)
        .backgroundColor('#F1F0FB')

        // Bottom Spacer
        Blank().height(20)

        // Alert Implementation
        if (this.showDialog) {
          AlertDialog.show({
            title: 'Playing Podcast',
            message: 'Streaming audio...',
            buttons: [
              {
                value: 'OK',
                action: () => {
                  this.showDialog = false
                }
              }
            ]
          })
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F1F0FB')
    }
    .width('100%')
    .height('100%')
  }
}

interface PodcastItem {
  title: string
  duration: string
}