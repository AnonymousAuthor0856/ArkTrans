@Entry
@Component
struct Index {
  @State selectedTab: number = 0
  @State showDialog: boolean = false

  build() {
    Stack() {
      Column() {
        // Header Section
        Column() {
          Text('Podcasts')
            .fontSize(28)
            .fontWeight(FontWeight.Semibold)
            .fontColor('#172554')
            .textAlign(TextAlign.Center)
            .width('100%')
            .margin({ top: 60, bottom: 20 })
        }

        // Tabs Section
        Row() {
          ForEach(['Trending', 'Following', 'Recent'], (item: string, index: number) => {
            Button() {
              Row() {
                if (this.selectedTab === index) {
                  Image($r('app.media.startIcon'))
                    .width(13)
                    .height(13)
                    .fillColor(this.selectedTab === index ? '#FFFFFF' : '#172554')
                    .margin({ right: 4 })
                }
                Text(item)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedTab === index ? '#FFFFFF' : '#172554')
              }
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
            }
            .backgroundColor(this.selectedTab === index ? '#0EA5E9' : '#FFFFFF')
            .borderRadius(8)
            .width('30%')
            .height(39)
            .onClick(() => {
              this.selectedTab = index
            })
            .margin({ right: index < 2 ? 10 : 0 })
          })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 15, bottom: 15 })

        // List Section
        Scroll() {
          Column() {
            ForEach([
              'AI Insights',
              'Mindful Moments',
              'History Flash',
              'Tech Hour',
              'Design Flow'
            ], (podcast: string) => {
              Row() {
                Column() {
                  Text(podcast)
                    .fontSize(20)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#172554')
                  
                  Text('30 min episode')
                    .fontSize(14)
                    .fontColor('#64748B')
                    .margin({ top: 5 })
                }
                .alignItems(HorizontalAlign.Start)
                .justifyContent(FlexAlign.Start)
                
                Blank()

                Button('Play')
                  .backgroundColor('#0EA5E9')
                  .fontColor('#FFFFFF')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .borderRadius(8)
                  .width(84)
                  .height(39)
                  .onClick(() => {
                    this.showDialog = true
                  })
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .margin({ bottom: 15 })
            })
          }
          .padding({ top: 12, bottom: 20 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [['#F0F9FF', 0], ['#FFFFFF', 1]]
      })

      // Alert Dialog Simulation
      if (this.showDialog) {
        Column() {
          Column() {
            Text('Playing Podcast')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 10 })
            
            Text('Streaming audio...')
              .fontSize(14)
              .fontColor('#666666')
              .margin({ bottom: 20 })

            Button('OK')
              .backgroundColor('#0EA5E9')
              .fontColor('#FFFFFF')
              .borderRadius(8)
              .width('100%')
              .height(40)
              .onClick(() => {
                this.showDialog = false
              })
          }
          .width(280)
          .padding(20)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 10, color: '#00000033', offsetY: 4 })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#00000080')
        .onClick(() => {
          this.showDialog = false
        })
      }
    }
    .width('100%')
    .height('100%')
  }
}