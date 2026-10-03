@Entry
@Component
struct RetroMusicPlayer {
  // State for the knob position
  @State knobPosition: Point = { x: 300, y: 300 }
  
  // Constants matching the Kotlin AppTokens
  private readonly COLORS = {
    primary: '#EF476F',
    secondary: '#FFD166',
    tertiary: '#06D6A0',
    background: '#FFF8E1', // Using Surface color from tokens to match screenshot tint
    surface: '#FFF8E1',
    outline: '#BDBDBD',
    onPrimary: '#FFFFFF',
    onSecondary: '#1F1F1F',
    onSurface: '#1F1F1F'
  }

  build() {
    Column() {
      // Top Bar / Title
      Text('Retro Music Player')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.COLORS.onSurface)
        .margin({ top: 50, bottom: 30 })

      // Main Canvas Area
      Stack({ alignContent: Alignment.Center }) {
        // Background Box
        Rect()
          .width(280)
          .height(280)
          .border({ width: 3, color: this.COLORS.outline })
          .borderRadius(16)
          .backgroundColor(this.COLORS.surface)

        // Drawing Layer
        DrawTask((context: CanvasRenderingContext2D, size: Size) => {
          const centerX = size.width / 2;
          const centerY = size.height / 2;
          
          // 1. Draw the large yellow ring
          context.beginPath();
          context.arc(centerX, centerY, (size.minDimension / 2) - 20, 0, 2 * Math.PI);
          context.lineWidth = 12;
          context.strokeStyle = this.COLORS.secondary;
          context.stroke();

          // 2. Draw the draggable pink knob
          context.beginPath();
          context.arc(this.knobPosition.x, this.knobPosition.y, 20, 0, 2 * Math.PI);
          context.fillStyle = this.COLORS.primary;
          context.fill();
        })
        .width(280)
        .height(280)
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Move || event.type === TouchType.Down) {
            // Update state based on touch coordinates relative to the component
            this.knobPosition = {
              x: event.touches[0].x,
              y: event.touches[0].y
            };
          }
        })
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)

      // Track Info
      Text('Track: Summer Nights')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.COLORS.onSurface)
        .margin({ top: 30 })

      // Buttons Row
      Row() {
        // Play Button
        Button('Play')
          .type(ButtonType.Capsule)
          .backgroundColor(this.COLORS.primary)
          .fontColor(this.COLORS.onPrimary)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .width(120)
          .height(48)
          .margin({ right: 20 })

        // Pause Button
        Button('Pause')
          .type(ButtonType.Capsule)
          .backgroundColor(this.COLORS.secondary)
          .fontColor(this.COLORS.onSecondary)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .width(120)
          .height(48)
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .width('100%')
      .margin({ top: 30 })

      // Debug Text
      Text(`Knob X:${Math.round(this.knobPosition.x)} Y:${Math.round(this.knobPosition.y)}`)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.COLORS.tertiary)
        .margin({ top: 30 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor(this.COLORS.background)
  }
}