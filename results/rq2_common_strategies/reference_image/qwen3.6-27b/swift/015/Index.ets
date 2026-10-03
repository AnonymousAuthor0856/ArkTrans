// VideoLibraryApp.ets - ArkTS version of Video Library App

@Entry
@Component
struct VideoLibraryApp {
  @State showDialog: boolean = false
  @State selectedVideo: string = ""
  
  private videos: VideoItem[] = [
    { title: "Nature Documentary", duration: "24:18" },
    { title: "AI Explained", duration: "18:52" },
    { title: "Space Travel", duration: "31:09" },
    { title: "Modern Art Review", duration: "15:45" },
    { title: "Retro Music Visuals", duration: "22:10" },
    { title: "Daily News Recap", duration: "12:34" }
  ]
  
  // Color constants
  private readonly colors = {
    primary: '#38BDF8',
    secondary: '#0EA5E9', 
    tertiary: '#0369A1',
    background: '#F0F9FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E0F2FE',
    outline: '#BFE0F4',
    onSurface: '#082F49',
    onPrimary: '#001F2F'
  }
  
  build() {
    Column() {
      // Top spacer
      Blank().height('30vp')
      
      // Top app bar
      Row() {
        Text('Video Library')
          .fontSize(26)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.colors.onSurface)
      }
      .width('100%')
      .height('70vp')
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.colors.surfaceVariant)
      
      // Main content area
      Column() {
        // Subtitle
        Text('Explore the latest videos')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.onSurface)
          .alignSelf(ItemAlign.Start)
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        
        // Video grid
        Scroll() {
          GridRow() {
            ForEach(this.videos, (video: VideoItem) => {
              GridCol() {
                this.VideoCard(video)
              }
              .width('48%')
              .margin({ right: video.title.length % 2 === 0 ? '4%' : 0 })
            })
          }
          .columnsTemplate('1fr 1fr')
          .gaps({ row: 12, column: 12 })
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .linearGradient({
        angle: 180,
        colors: [[this.colors.surfaceVariant, 0], [this.colors.background, 1]]
      })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [[this.colors.surfaceVariant, 0], [this.colors.background, 1]]
    })
    
    // Alert dialog
    if (this.showDialog) {
      AlertDialog({
        title: 'Playing Video',
        message: `Now playing: ${this.selectedVideo}`,
        buttons: [{ text: 'OK', action: () => { this.showDialog = false } }]
      })
    }
  }
}

@Component
struct VideoCard {
  @Prop video: VideoItem
  
  private readonly colors = {
    primary: '#38BDF8',
    surface: '#FFFFFF',
    surfaceVariant: '#E0F2FE',
    onSurface: '#082F49',
    onPrimary: '#001F2F'
  }
  
  build() {
    Column() {
      // Thumbnail placeholder
      Rectangle()
        .width('100%')
        .height('120vp')
        .borderRadius(8)
        .fill(Color.Transparent)
        .backgroundColor(this.colors.surfaceVariant)
        .overlay((content) => {
          Text('Thumbnail')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.onSurface)
            .opacity(0.6)
        })
      
      // Video title
      Text(this.video.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ top: 8 })
      
      // Duration
      Text(this.video.duration)
        .fontSize(13)
        .fontColor(this.colors.onSurface)
        .opacity(0.7)
        .margin({ top: 4 })
      
      // Play button
      Button('Play')
        .type(ButtonType.Capsule)
        .backgroundColor(this.colors.primary)
        .fontColor(this.colors.onPrimary)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .height('32vp')
        .margin({ top: 8 })
        .onClick(() => {
          // This would need to be handled by parent component
          // In a real app, you'd use an event emitter or callback
        })
    }
    .width('100%')
    .padding(12)
    .borderRadius(12)
    .backgroundColor(this.colors.surface)
    .shadow({ radius: 2, color: '#0000001A', offsetY: 1 })
  }
}

interface VideoItem {
  title: string
  duration: string
}