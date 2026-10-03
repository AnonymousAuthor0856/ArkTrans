@Entry
@Component
struct RootScreen {
  @State knobX: number = 90
  @State knobY: number = 140
  @State powerOn: boolean = false

  // Colors
  private colorPrimary: string = '#FF7A00'
  private colorSecondary: string = '#FFC300'
  private colorBackground: string = '#FFF8E7'
  private colorSurfaceVariant: string = '#FFEBCC'
  private colorSuccess: string = '#28A745'
  private colorError: string = '#DC3545'
  private colorOnPrimary: string = '#FFFFFF'
  private colorOnSecondary: string = '#1E1E1E'
  private colorOnSurface: string = '#1E1E1E'

  build() {
    Column() {
      // Top spacer
      Blank().height(40)

      // Top Bar
      Row() {
        Text('Retro Remote Control')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colorOnSurface)
      }
      .width('100%')
      .height(64)
      .backgroundColor(this.colorBackground)
      .justifyContent(FlexAlign.Center)

      // Scroll content
      Scroll() {
        Column({ space: 24 }) {
          // Knob Surface
          Stack() {
            // Background circle (large yellow circle)
            Circle()
              .width(200)
              .height(200)
              .backgroundColor('#33FFC300')

            // Knob circle (draggable orange dot)
            Circle()
              .width(32)
              .height(32)
              .backgroundColor(this.colorPrimary)
              .position({ x: this.knobX - 16, y: this.knobY - 16 })
          }
          .width(280)
          .height(280)
          .backgroundColor(this.colorSurfaceVariant)
          .borderRadius(24)
          .shadow({
            radius: 4,
            color: '#1F000000',
            offsetX: 0,
            offsetY: 2
          })
          .clip(true)
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Move || event.type === TouchType.Down) {
              const touch = event.touches[0]
              let newX = touch.x
              let newY = touch.y
              newX = Math.max(16, Math.min(264, newX))
              newY = Math.max(16, Math.min(264, newY))
              this.knobX = newX
              this.knobY = newY
            }
          })

          // Power Status
          Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.powerOn ? this.colorSuccess : this.colorError)

          // Buttons Row
          Row({ space: 60 }) {
            // On Button
            Button('On')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colorOnPrimary)
              .width(80)
              .height(80)
              .backgroundColor(this.colorPrimary)
              .borderRadius(40)
              .onClick(() => {
                this.powerOn = !this.powerOn
              })

            // Reset Button
            Column({ space: 0 }) {
              Text('Res')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colorOnSecondary)
              Text('et')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colorOnSecondary)
            }
            .width(80)
            .height(80)
            .backgroundColor(this.colorSecondary)
            .borderRadius(40)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .onClick(() => {
              this.knobX = 90
              this.knobY = 140
            })
          }
          .justifyContent(FlexAlign.Center)
          .width('100%')

          // Progress Bar (full primary color bar)
          Row() {
            Row()
              .width('100%')
              .height(6)
              .backgroundColor(this.colorPrimary)
              .borderRadius(3)
          }
          .width('100%')
          .padding({ left: 16, right: 16 })
        }
        .padding(16)
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .backgroundColor(this.colorBackground)
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorBackground)
  }
}