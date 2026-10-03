interface VideoItem {
  title: string;
  duration: string;
}

@Entry
@Component
struct VideoLibrary {
  @State videos: Array<VideoItem> = [
    { title: 'Nature Documentary', duration: '24:18' },
    { title: 'AI Explained', duration: '18:52' },
    { title: 'Space Travel', duration: '31:09' },
    { title: 'Modern Art Review', duration: '15:45' },
    { title: 'Retro Music Visuals', duration: '22:10' },
    { title: 'Daily News Recap', duration: '12:34' }
  ]

  build() {
    // === Column (Root) ===
    // props: { space: 12 }
    // modifier: { width: '100%', height: '100%', padding: 16, backgroundColor: '#F0F9FF' }
    // children: 3
    Column() {
      // === Text ===
      // props: { text: 'Video Library' }
      // modifier: { fontSize: 26, fontWeight: FontWeight.SemiBold, color: '#082F49', textAlign: TextAlign.Center, margin: { top: 24, bottom: 12 } }
      Text('Video Library')
        .fontSize(26)
        .fontWeight(FontWeight.Medium)
        .fontColor('#082F49')
        .textAlign(TextAlign.Center)
        .margin({ top: 24, bottom: 12 })

      // === Text ===
      // props: { text: 'Explore the latest videos' }
      // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#082F49' }
      Text('Explore the latest videos')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#082F49')

      // === Grid ===
      // props: { columnsTemplate: '1fr 1fr', columnsGap: 12, rowsGap: 12 }
      // modifier: { width: '100%', layoutWeight: 1 }
      // children: 6
      Grid() {
        ForEach(this.videos, (item: VideoItem) => {
          GridItem() {
            // === Column (Card) ===
            // props: { space: 8 }
            // modifier: { width: '100%', padding: 12, backgroundColor: '#FFF', borderRadius: 12, shadow: { radius: 4, offsetY: 2, color: '#1F000000' } }
            // children: 4
            Column() {
              // === Row (Thumbnail Placeholder) ===
              // props: { justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }
              // modifier: { width: '100%', height: 120, backgroundColor: '#E0F2FE', borderRadius: 8 }
              // children: 1
              Row() {
                // === Text ===
                // props: { text: 'Thumbnail' }
                // modifier: { fontSize: 11, fontWeight: FontWeight.Medium, color: '#082F49', opacity: 0.6 }
                Text('Thumbnail')
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#082F49')
                  .opacity(0.6)
              }.width('100%').height(120).backgroundColor('#E0F2FE').borderRadius(8)

              // === Text ===
              // props: { text: item.title }
              // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#082F49', maxHeight: 44 }
              Text(item.title)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#082F49')
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

              // === Text ===
              // props: { text: item.duration }
              // modifier: { fontSize: 13, fontWeight: FontWeight.Normal, color: '#082F49', opacity: 0.7 }
              Text(item.duration)
                .fontSize(13)
                .fontWeight(FontWeight.Normal)
                .fontColor('#082F49')
                .opacity(0.7)

              // === Button ===
              // modifier: { width: '100%', height: 40, backgroundColor: '#38BDF8', fontColor: '#001F2F', borderRadius: 8, margin: { top: 4 } }
              // children: 1
              Button() {
                // === Text ===
                // props: { text: 'Play' }
                // modifier: { fontSize: 11, fontWeight: FontWeight.Medium, color: '#001F2F' }
                Text('Play')
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#001F2F')
              }.width('100%').height(40).backgroundColor('#38BDF8').borderRadius(8).margin({ top: 4 })
            }.width('100%').padding(12).backgroundColor('#FFF').borderRadius(12).shadow({ radius: 4, offsetY: 2, color: '#1F000000' })
          }
        }, (item: VideoItem) => JSON.stringify(item))
      }.columnsTemplate('1fr 1fr').columnsGap(12).rowsGap(12).width('100%').layoutWeight(1)
    }.width('100%').height('100%').padding(16).backgroundColor('#F0F9FF')
  }
}