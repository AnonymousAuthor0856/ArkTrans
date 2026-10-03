@Entry
@Component
struct RootScreen {
  @State isRunning: boolean = false
  @State knobAngle: number = 0

  // Color tokens
  private colorPrimary: string = '#FF8FAB'
  private colorSecondary: string = '#B4E3D0'
  private colorTertiary: string = '#FFD6A5'
  private colorBackground: string = '#FFFCF9'
  private colorSurfaceVariant: string = '#FDE2E4'
  private colorSuccess: string = '#4ADE80'
  private colorError: string = '#FB7185'
  private colorOnPrimary: string = '#FFFFFF'
  private colorOnSecondary: string = '#1E1E1E'
  private colorOnSurface: string = '#1E1E1E'

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(this.colorBackground)

      Column({ space: 0 }) {
        // Spacer top
        Column()
          .height(16)

        // Top Bar
        Row() {
          Text('Pomodoro Timer')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.colorOnSurface)
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(this.colorBackground)

        // Main Content
        Column({ space: 24 }) {
          // Timer Circle
          Stack() {
            // Outer circle (surfaceVariant)
            Circle()
              .width(280)
              .height(280)
              .fill(this.colorSurfaceVariant)
              .shadow({
                radius: 8,
                color: '#1F000000',
                offsetX: 0,
                offsetY: 4
              })

            // Middle circle (secondary with opacity)
            Circle()
              .width(180)
              .height(180)
              .fill('#66B4E3D0')

            // Knob (draggable - shown at center for simplicity)
            Circle()
              .width(60)
              .height(60)
              .fill(this.colorPrimary)
          }
          .width(280)
          .height(280)
          .gesture(
            PanGesture()
              .onActionUpdate((event: GestureEvent) => {
                const centerX = 140
                const centerY = 140
                const dx = event.offsetX - centerX
                const dy = event.offsetY - centerY
                this.knobAngle = Math.atan2(dy, dx)
              })
          )

          // Focus Mode Text
          Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isRunning ? this.colorSuccess : this.colorError)

          // Start/Stop Buttons
          Row({ space: 16 }) {
            // Start Button
            Button('Start')
              .fontSize(14)
              .fontColor(this.colorOnPrimary)
              .width(90)
              .height(90)
              .borderRadius(45)
              .backgroundColor(this.colorPrimary)
              .onClick(() => {
                this.isRunning = true
              })

            // Stop Button
            Button('Stop')
              .fontSize(14)
              .fontColor(this.colorOnSecondary)
              .width(90)
              .height(90)
              .borderRadius(45)
              .backgroundColor(this.colorTertiary)
              .onClick(() => {
                this.isRunning = false
              })
          }

          // Progress Bar
          Stack({ alignContent: Alignment.Start }) {
            // Track
            Row()
              .width('100%')
              .height(8)
              .borderRadius(4)
              .backgroundColor(this.colorSurfaceVariant)

            // Progress (40%)
            Row()
              .width('40%')
              .height(8)
              .borderRadius(4)
              .backgroundColor(this.colorPrimary)
          }
          .width('100%')
          .padding({ left: 16, right: 16 })
        }
        .padding({ top: 16 })
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}