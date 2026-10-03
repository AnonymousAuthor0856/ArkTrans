@Entry
@Component
struct RootScreen {
  @State private knobX: number = 90
  @State private knobY: number = 140
  @State private powerOn: boolean = false

  private readonly primary: string = '#FF7A00'
  private readonly secondary: string = '#FFC300'
  private readonly tertiary: string = '#FFF3C0'
  private readonly background: string = '#FFF8E7'
  private readonly surface: string = '#FFFFFF'
  private readonly surfaceVariant: string = '#FFEBC8'
  private readonly outline: string = '#BCA789'
  private readonly success: string = '#28A745'
  private readonly warning: string = '#FFC107'
  private readonly error: string = '#DC3545'
  private readonly onPrimary: string = '#FFFFFF'
  private readonly onSecondary: string = '#1E1E1E'
  private readonly onSurface: string = '#1E1E1E'

  private boundKnob(value: number, minValue: number, maxValue: number): number {
    return Math.max(minValue, Math.min(maxValue, value))
  }

  build() {
    Column({ space: 0 }) {
      Blank()
        .height(40)

      Stack() {
        Text('Retro Remote Control')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onSurface)
      }
      .width('100%')
      .height(64)
      .backgroundColor(this.background)

      Scroll() {
        Column({ space: 24 }) {
          Stack({ alignContent: Alignment.TopStart }) {
            Circle()
              .width(200)
              .height(200)
              .fill(this.secondary)
              .opacity(0.2)
              .position({ x: 40, y: 40 })

            Circle()
              .width(32)
              .height(32)
              .fill(this.primary)
              .position({ x: this.knobX - 16, y: this.knobY - 16 })
          }
          .width(280)
          .height(280)
          .backgroundColor(this.surfaceVariant)
          .borderRadius(24)
          .shadow({
            radius: 4,
            color: '#1F000000',
            offsetX: 0,
            offsetY: 2
          })
          .margin({ top: 16, left: 16, right: 16, bottom: 16 })
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Down || event.type === TouchType.Move) {
              if (event.touches.length > 0) {
                this.knobX = this.boundKnob(event.touches[0].x, 16, 264)
                this.knobY = this.boundKnob(event.touches[0].y, 16, 264)
              }
            }
          })

          Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.powerOn ? this.success : this.error)

          Row({ space: 60 }) {
            Stack() {
              Circle()
                .width(80)
                .height(80)
                .fill(this.primary)

              Text('On')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.onPrimary)
            }
            .width(80)
            .height(80)
            .onClick(() => {
              this.powerOn = !this.powerOn
            })

            Stack() {
              Circle()
                .width(80)
                .height(80)
                .fill(this.secondary)

              Column({ space: 0 }) {
                Text('Res')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.onSecondary)

                Text('et')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.onSecondary)
              }
              .alignItems(HorizontalAlign.Center)
            }
            .width(80)
            .height(80)
            .onClick(() => {
              this.knobX = 90
              this.knobY = 140
            })
          }
          .justifyContent(FlexAlign.Center)
          .width('100%')

          Row()
            .height(6)
            .width('100%')
            .backgroundColor(this.primary)
            .borderRadius(3)
            .margin({ left: 16, right: 16 })
        }
        .width('100%')
        .padding(16)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(this.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}