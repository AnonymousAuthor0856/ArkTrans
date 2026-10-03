@Entry
@Component
struct VideoPlayerApp {
  // Color constants matching the SwiftUI source
  private static readonly COLORS: Record<string, string> = {
    primary: '#1E3A8A',
    background: '#0F172A',
    surfaceVariant: '#334155',
    outline: '#475569',
    onSurface: '#E2E8F0',
    chip: '#E8DEF8'
  }

  build() {
    Column() {
      // Top Title
      Text('Video Player')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#e2e8f0')
        .width('100%')
        .textAlign(TextAlign.Center)
        .height(56)

      // Video Surface
      Row() {
        Text('Video Surface')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(VideoPlayerApp.COLORS.onSurface)
          .opacity(0.9)
      }
      .width('100%')
      .height(300)
      .backgroundColor(VideoPlayerApp.COLORS.surfaceVariant)
      .borderRadius(24)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Movie Title
      Text('Journey through the Skies')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#e0e8f0')
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })

      // Progress Area
      Column() {
        // Progress Bar Row
        Row() {
          // Left filled capsule
          Capsule()
            .fill(VideoPlayerApp.COLORS.primary)
            .width('40%')
            .height(32)

          // Vertical separator
          Rectangle()
            .fill(VideoPlayerApp.COLORS.primary)
            .width(6)
            .height(72)
            .borderRadius(3)

          // Right track with dot
          Row() {
            // Empty spacer to push dot to end
            Blank()
            
            Circle()
              .fill(VideoPlayerApp.COLORS.primary)
              .width(12)
              .height(12)
              .margin({ right: -10 }) // Offset to match SwiftUI logic
          }
          .width('47%')
          .height(32)
          .clip(true)
          .background(Capsule().fill(VideoPlayerApp.COLORS.outline))
          
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .padding({ top: 8, bottom: 6 })

        // Time Labels
        Row() {
          Text('1:35')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#a3aab5')
            .margin({ left: 10 })
          
          Blank()
          
          Text('4:00')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#a3aab5')
            .margin({ right: 10 })
        }
        .width('100%')
      }
      .padding({ left: 24, right: 24 })

      // Controls Area
      Row() {
        // -10s Button
        Text('−10s')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#1d192b')
          .width(180)
          .height(96)
          .textAlign(TextAlign.Center)
          .verticalCenter(VerticalAlign.Center)
          .backgroundColor(VideoPlayerApp.COLORS.chip)
          .borderRadius(18)

        // Play Button
        Row() {
          Image($r('app.media.ic_play')) // Assuming a play icon exists, otherwise use text or shape
            .width(40)
            .height(40)
            .fillColor(Color.White)
        }
        .width(120)
        .height(120)
        .backgroundColor(VideoPlayerApp.COLORS.primary)
        .borderRadius(60)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        // +30s Button
        Text('+30s')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#1d192b')
          .width(180)
          .height(96)
          .textAlign(TextAlign.Center)
          .verticalCenter(VerticalAlign.Center)
          .backgroundColor(VideoPlayerApp.COLORS.chip)
          .borderRadius(18)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding({ top: 10, bottom: 10 })

      // Fullscreen Button
      Button({ type: ButtonType.Capsule, stateEffect: true }) {
        Text('Fullscreen')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#47434e')
      }
      .width(220)
      .height(64)
      .backgroundColor(Color.Transparent)
      .border({ width: 1, color: VideoPlayerApp.COLORS.outline, radius: 12 })
      .margin({ top: 12 })

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(VideoPlayerApp.COLORS.background)
  }
}