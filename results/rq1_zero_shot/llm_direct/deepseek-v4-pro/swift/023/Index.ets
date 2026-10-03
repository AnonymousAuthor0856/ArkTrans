@Entry
@Component
struct RootScreen {
  @State private knobPositionX: number = 140
  @State private knobPositionY: number = 140
  @State private isRunning: boolean = false
  private centerX: number = 140
  private centerY: number = 140
  private trackRadius: number = 90

  // AppTokens Colors
  private primaryColor: string = '#FF8FAB'
  private secondaryColor: string = '#B4E3D0'
  private tertiaryColor: string = '#FFD6A5'
  private backgroundColor: string = '#FFFCF9'
  private surfaceColor: string = '#FFFFFF'
  private surfaceVariantColor: string = '#FDE2E4'
  private outlineColor: string = '#FCC2D7'
  private successColor: string = '#4ADE80'
  private warningColor: string = '#FACC15'
  private errorColor: string = '#FB7185'
  private onPrimaryColor: string = '#FFFFFF'
  private onSecondaryColor: string = '#1E1E1E'
  private onTertiaryColor: string = '#1E1E1E'
  private onBackgroundColor: string = '#1E1E1E'
  private onSurfaceColor: string = '#1E1E1E'

  // Spacing
  private spacingSm: number = 8
  private spacingMd: number = 12
  private spacingLg: number = 16
  private spacingXl: number = 24

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(this.backgroundColor)

      Column() {
        // Top spacing
        Row()
          .height(this.spacingLg)

        // Top Bar
        Row() {
          Text('Pomodoro Timer')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.onSurfaceColor)
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(this.backgroundColor)

        // Main Content
        Column({ space: this.spacingXl }) {
          // Timer Circle with concentric circles
          Stack() {
            // Outer circle (background)
            Circle()
              .fill(this.surfaceVariantColor)
              .width(280)
              .height(280)
              .shadow({
                radius: 8,
                color: 'rgba(0, 0, 0, 0.18)',
                offsetY: 4
              })

            // Middle circle (secondary)
            Circle()
              .fill(this.secondaryColor)
              .opacity(0.4)
              .width(180)
              .height(180)

            // Knob (draggable)
            Circle()
              .fill(this.primaryColor)
              .width(60)
              .height(60)
              .position({
                x: this.knobPositionX,
                y: this.knobPositionY
              })
              .gesture(
                PanGesture()
                  .onActionStart((event: GestureEvent) => {
                    this.updateKnobPosition(event.offsetX, event.offsetY)
                  })
                  .onActionUpdate((event: GestureEvent) => {
                    this.updateKnobPosition(event.offsetX, event.offsetY)
                  })
              )
          }
          .width(280)
          .height(280)

          // Focus Mode Text
          Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isRunning ? this.successColor : this.errorColor)

          // Start/Stop Buttons
          Row({ space: this.spacingLg }) {
            Button() {
              this.isRunning = true
            }
            .width(90)
            .height(90)
            .backgroundColor(this.primaryColor)
            .borderRadius(45)
            .type(ButtonType.Circle)

            Button() {
              this.isRunning = false
            }
            .width(90)
            .height(90)
            .backgroundColor(this.tertiaryColor)
            .borderRadius(45)
            .type(ButtonType.Circle)
          }
          .justifyContent(FlexAlign.Center)

          // Progress Bar
          Stack({ alignContent: Alignment.Start }) {
            // Track
            Row()
              .width('100%')
              .height(8)
              .backgroundColor(this.surfaceVariantColor)
              .borderRadius(4)

            // Progress - 40% filled
            Row()
              .width('40%')
              .height(8)
              .backgroundColor(this.primaryColor)
              .borderRadius(4)
          }
          .width('100%')
          .padding({
            left: this.spacingLg,
            right: this.spacingLg
          })
        }
        .padding({ top: this.spacingLg })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  private updateKnobPosition(offsetX: number, offsetY: number) {
    // Calculate angle and position to keep knob on the track
    const vectorX = offsetX - this.centerX
    const vectorY = offsetY - this.centerY
    const distance = Math.sqrt(vectorX * vectorX + vectorY * vectorY)

    if (distance > 0) {
      const normalizedX = vectorX / distance
      const normalizedY = vectorY / distance

      // Keep knob on the track (radius = 90 for 180 diameter circle)
      this.knobPositionX = this.centerX + normalizedX * this.trackRadius
      this.knobPositionY = this.centerY + normalizedY * this.trackRadius
    }
  }
}