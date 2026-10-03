@Entry
@Component
struct RootScreen {
  @State knobX: number = 90
  @State knobY: number = 140
  @State powerOn: boolean = false

  // Colors
  private readonly COLOR_PRIMARY: string = '#FF7A00'
  private readonly COLOR_SECONDARY: string = '#FFC300'
  private readonly COLOR_BACKGROUND: string = '#FFF8E7'
  private readonly COLOR_SURFACE_VARIANT: string = '#FFEBC8'
  private readonly COLOR_SUCCESS: string = '#28A745'
  private readonly COLOR_ERROR: string = '#DC3545'
  private readonly COLOR_ON_PRIMARY: string = '#FFFFFF'
  private readonly COLOR_ON_SECONDARY: string = '#1E1E1E'
  private readonly COLOR_ON_SURFACE: string = '#1E1E1E'

  build() {
    Column({ space: 0 }) {
      // Top spacer
      Blank().height(40)

      // Top Bar
      Stack({ alignContent: Alignment.Center }) {
        Column().width('100%').height(64).backgroundColor(this.COLOR_BACKGROUND)
        Text('Retro Remote Control')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.COLOR_ON_SURFACE)
      }.width('100%').height(64)

      // Scrollable content
      List() {
        ListItem() {
          Column({ space: 24 }) {
            // Knob Surface
            Stack({ alignContent: Alignment.Center }) {
              // Background square
              Column()
                .width(280)
                .height(280)
                .backgroundColor(this.COLOR_SURFACE_VARIANT)
                .borderRadius(24)
                .shadow({
                  radius: 4,
                  color: '#1F000000',
                  offsetY: 2
                })

              // Knob (small circle)
              Button() {
                Text('')
                  .width(32)
                  .height(32)
                  .backgroundColor(this.COLOR_PRIMARY)
                  .borderRadius(16)
              }
              .position({ x: this.knobX, y: this.knobY })
              .width(32).height(32)
            }.width(280).height(280).padding(16)

            // Sliders to adjust knob position
            Text('Knob X: ' + Math.round(this.knobX).toString())
              .fontSize(14)
              .fontColor(this.COLOR_ON_SURFACE)
            Slider({
              value: this.knobX,
              min: 16,
              max: 264,
              step: 1
            })
              .width('100%')
              .onChange((value: number) => {
                this.knobX = value
              })

            Text('Knob Y: ' + Math.round(this.knobY).toString())
              .fontSize(14)
              .fontColor(this.COLOR_ON_SURFACE)
            Slider({
              value: this.knobY,
              min: 16,
              max: 264,
              step: 1
            })
              .width('100%')
              .onChange((value: number) => {
                this.knobY = value
              })

            // Power Status
            Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.powerOn ? this.COLOR_SUCCESS : this.COLOR_ERROR)

            // Buttons Row
            Row({ space: 60 }) {
              // On/Off toggle
              Button() {
                Text('On')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.COLOR_ON_PRIMARY)
              }
              .width(80)
              .height(80)
              .backgroundColor(this.COLOR_PRIMARY)
              .borderRadius(40)
              .onClick(() => {
                this.powerOn = !this.powerOn
              })

              // Reset button
              Button() {
                Column({ space: 0 }) {
                  Text('Res')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.COLOR_ON_SECONDARY)
                  Text('et')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.COLOR_ON_SECONDARY)
                }
                // Notice: fontSize is on Text, not on Column
              }
              .width(80)
              .height(80)
              .backgroundColor(this.COLOR_SECONDARY)
              .borderRadius(40)
              .onClick(() => {
                this.knobX = 90
                this.knobY = 140
              })
            }

            // Progress bar (colored line)
            Column()
              .width('100%')
              .height(6)
              .backgroundColor(this.COLOR_PRIMARY)
              .borderRadius(3)
              .padding({ left: 16, right: 16 })
          }
          .padding(16)
          .width('100%')
          .alignItems(HorizontalAlign.Center)
        }
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(this.COLOR_BACKGROUND)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.COLOR_BACKGROUND)
    .padding(0)
  }
}