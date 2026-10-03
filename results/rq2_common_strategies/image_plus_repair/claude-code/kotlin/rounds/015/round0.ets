@Entry
@Component
struct Index {
  private videos: VideoItem[] = [
    { title: 'Nature Documentary', duration: '24:18' },
    { title: 'AI Explained', duration: '18:52' },
    { title: 'Space Travel', duration: '31:09' },
    { title: 'Modern Art Review', duration: '15:45' },
    { title: 'Retro Music Visuals', duration: '22:10' },
    { title: 'Daily News Recap', duration: '12:34' }
  ]

  build() {
    Column() {
      Text('Video Library')
        .fontSize(26)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#082F49')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })

      Column() {
        Text('Explore the latest videos')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#082F49')
          .width('100%')
          .margin({ bottom: 12 })

        Grid() {
          ForEach(this.videos, (item: VideoItem) => {
            GridItem() {
              VideoCard(item: item)
            }
          }, (item: VideoItem) => item.title)
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(12)
        .columnsGap(12)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#F0F9FF', 0.0], ['#E0F2FE', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}

interface VideoItem {
  title: string
  duration: string
}

@Component
struct VideoCard {
  item: VideoItem

  build() {
    Column() {
      Column() {
        Text('Thumbnail')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor('rgba(8, 47, 73, 0.6)')
      }
      .width('100%')
      .height(120)
      .backgroundColor('#E0F2FE')
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)

      Text(this.item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#082F49')
        .width('100%')
        .margin({ top: 8 })

      Text(this.item.duration)
        .fontSize(13)
        .fontWeight(FontWeight.Normal)
        .fontColor('rgba(8, 47, 73, 0.7)')
        .width('100%')
        .margin({ top: 4 })

      Button('Play')
        .width('100%')
        .height(40)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor('#001F2F')
        .backgroundColor('#38BDF8')
        .borderRadius(8)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetY: 2
    })
  }
}
