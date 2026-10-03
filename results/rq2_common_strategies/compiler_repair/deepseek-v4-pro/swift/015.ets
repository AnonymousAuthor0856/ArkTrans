@Entry
@Component
struct VideoLibraryRoot {
  @State showDialog: boolean = false
  @State selectedVideo: string = ''
  private readonly videosTitle: string[] = [
    'Nature Documentary',
    'AI Explained',
    'Space Travel',
    'Modern Art Review',
    'Retro Music Visuals',
    'Daily News Recap'
  ]
  private readonly videosDuration: string[] = [
    '24:18',
    '18:52',
    '31:09',
    '15:45',
    '22:10',
    '12:34'
  ]

  // Color constants with names that don't conflict with methods
  private readonly colorPrimary: string = '#38BDF8'
  private readonly colorSecondary: string = '#0EA5E9'
  private readonly colorBg: string = '#F0F9FF'
  private readonly colorSurface: string = '#FFFFFF'
  private readonly colorSurfaceVariant: string = '#E0F2FE'
  private readonly colorOutline: string = '#BFE0F4'
  private readonly colorOnPrimary: string = '#001F2F'
  private readonly colorOnSurface: string = '#082F49'

  build() {
    Column({ space: 0 }) {
      // ===== Top Spacer =====
      Blank().height(30)

      // ===== Top App Bar =====
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%')
          .height(70)
          .backgroundColor(this.colorSurfaceVariant)
        Text('Video Library')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colorOnSurface)
      }.width('100%').height(70)

      // ===== Subtitle =====
      Text('Explore the latest videos')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colorOnSurface)
        .width('100%')
        .padding({ left: 16, right: 16 })
        .padding({ top: 12, bottom: 12 })

      // ===== Video Grid inside a List for scrollability =====
      List() {
        ListItem() {
          Grid() {
            // Row 1
            GridItem() { this.VideoCard(this.videosTitle[0], this.videosDuration[0]) }
            GridItem() { this.VideoCard(this.videosTitle[1], this.videosDuration[1]) }
            // Row 2
            GridItem() { this.VideoCard(this.videosTitle[2], this.videosDuration[2]) }
            GridItem() { this.VideoCard(this.videosTitle[3], this.videosDuration[3]) }
            // Row 3
            GridItem() { this.VideoCard(this.videosTitle[4], this.videosDuration[4]) }
            GridItem() { this.VideoCard(this.videosTitle[5], this.videosDuration[5]) }
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(12)
          .rowsGap(12)
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        }
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(this.colorSurfaceVariant)

      // ===== Dialog overlay =====
      if (this.showDialog) {
        Stack({ alignContent: Alignment.Center }) {
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor('#80000000')
            .onClick(() => {
              this.showDialog = false
            })

          Column({ space: 12 }) {
            Text('Playing Video')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
            Text('Now playing: ' + this.selectedVideo)
              .fontSize(16)
              .fontColor('#666666')
            Button() {
              Text('OK')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
            }
            .width(80)
            .height(40)
            .backgroundColor(this.colorPrimary)
            .borderRadius(8)
            .onClick(() => {
              this.showDialog = false
            })
          }
          .padding(24)
          .backgroundColor(this.colorSurface)
          .borderRadius(16)
          .shadow({ radius: 8, color: '#4D000000' })
        }
        .width('100%')
        .height('100%')
        .position({ x: 0, y: 0 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorBg)
    .padding(0)
  }

  @Builder VideoCard(title: string, duration: string) {
    Column({ space: 8 }) {
      // Thumbnail placeholder
      Column()
        .width('100%')
        .height(120)
        .backgroundColor(this.colorSurfaceVariant)
        .borderRadius(8)
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        // Thumbnail text
        Text('Thumbnail')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colorOnSurface)
          .opacity(0.6)

      // Title
      Text(title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colorOnSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')

      // Duration
      Text(duration)
        .fontSize(13)
        .fontColor(this.colorOnSurface)
        .opacity(0.7)

      // Play button
      Button() {
        Text('Play')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colorOnPrimary)
      }
      .width('100%')
      .height(32)
      .backgroundColor(this.colorPrimary)
      .borderRadius(8)
      .onClick(() => {
        this.selectedVideo = title
        this.showDialog = true
      })
    }
    .padding(12)
    .backgroundColor(this.colorSurface)
    .borderRadius(12)
    .shadow({ radius: 2, color: '#1A000000', offsetX: 0, offsetY: 1 })
    .width('100%')
    .height('100%')
  }
}