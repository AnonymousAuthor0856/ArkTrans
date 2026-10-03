// VideoLibraryApp.ets - ArkTS version of Video Library App

interface VideoItem {
  title: string
  duration: string
}

interface ColorConstants {
  primary: string
  secondary: string
  tertiary: string
  background: string
  surface: string
  surfaceVariant: string
  outline: string
  onSurface: string
  onPrimary: string
}

@Component
struct CustomDialogComponent {
  controller?: CustomDialogController
  title: string = ''
  message: string = ''
  onClose: () => void = () => {}

  build() {
    Stack() {
      Column() {
        Text(this.title)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 10 })
        
        Text(this.message)
          .fontSize(16)
          .margin({ bottom: 20 })
        
        Button('OK')
          .onClick(() => {
            this.onClose()
          })
      }
      .width('80%')
      .padding(20)
      .backgroundColor(Color.White)
      .borderRadius(10)
      .shadow({ radius: 10, color: '#00000033', offsetY: 5 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#00000055')
    .onClick(() => {
      this.onClose()
    })
  }
}

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
  private readonly colors: ColorConstants = {
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
          .fontWeight(FontWeight.Bold)
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
                VideoCard({ video: video })
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
      
      // Alert dialog using custom component wrapper or conditional rendering within a container
      if (this.showDialog) {
        CustomDialogComponent({
          title: 'Playing Video',
          message: `Now playing: ${this.selectedVideo}`,
          onClose: () => { this.showDialog = false }
        })
      }
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [[this.colors.surfaceVariant, 0], [this.colors.background, 1]]
    })
  }
}

@Component
struct VideoCard {
  @Prop video: VideoItem
  
  private readonly colors: ColorConstants = {
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
      // Thumbnail placeholder
      Stack() {
        Rect()
          .width('100%')
          .height('120vp')
          .fillColor(this.colors.surfaceVariant)
        
        Text('Thumbnail')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.onSurface)
          .opacity(0.6)
      }
      .width('100%')
      .height('120vp')
      .borderRadius(8)
      
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