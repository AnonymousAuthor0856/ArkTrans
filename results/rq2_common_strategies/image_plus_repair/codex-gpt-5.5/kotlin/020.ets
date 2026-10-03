class AppColors {
  readonly background: string = '#FFF8E7'
  readonly panel: string = '#FFEBC8'
  readonly dial: string = '#FFE39A'
  readonly primary: string = '#FF7A00'
  readonly secondary: string = '#FFC300'
  readonly text: string = '#1E1E1E'
  readonly error: string = '#DC3545'
  readonly success: string = '#28A745'
}

const COLORS: AppColors = new AppColors()

@Entry
@Component
struct RemoteControl {
  @State private powerOn: boolean = false
  @State private knobX: number = 0
  @State private knobY: number = 0

  private readonly panelSize: number = 560
  private readonly dialRadius: number = 200
  private readonly knobRadius: number = 24

  private clamp(value: number, min: number, max: number): number {
    return Math.max(min, Math.min(max, value))
  }

  private updateKnob(event: GestureEvent): void {
    const localX = event.fingerList[0].localX - this.panelSize / 2
    const localY = event.fingerList[0].localY - this.panelSize / 2
    const limit = this.panelSize / 2 - this.knobRadius
    this.knobX = this.clamp(localX, -limit, limit)
    this.knobY = this.clamp(localY, -limit, limit)
  }

  private progressValue(): number {
    const raw = (this.knobX + this.knobY + 400) / 800
    return this.clamp(raw, 0, 1)
  }

  build() {
    Column() {
      Text('Retro Remote Control')
        .fontSize(56)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.text)
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: 34, bottom: 62 })

      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width(this.panelSize)
          .height(this.panelSize)
          .borderRadius(48)
          .backgroundColor(COLORS.panel)
          .shadow({
            radius: 8,
            color: '#30000000',
            offsetX: 0,
            offsetY: 4
          })

        Circle()
          .width(this.dialRadius * 2)
          .height(this.dialRadius * 2)
          .fill(COLORS.dial)

        Circle()
          .width(this.knobRadius * 2)
          .height(this.knobRadius * 2)
          .fill(COLORS.primary)
          .translate({ x: this.knobX, y: this.knobY })
      }
      .width(this.panelSize)
      .height(this.panelSize)
      .gesture(
        PanGesture({ direction: PanDirection.All })
          .onActionStart((event: GestureEvent) => {
            this.updateKnob(event)
          })
          .onActionUpdate((event: GestureEvent) => {
            this.updateKnob(event)
          })
      )

      Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
        .fontSize(36)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.powerOn ? COLORS.success : COLORS.error)
        .margin({ top: 48, bottom: 48 })

      Row() {
        Button(this.powerOn ? 'Off' : 'On', { type: ButtonType.Circle })
          .width(160)
          .height(160)
          .fontSize(36)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor(COLORS.primary)
          .onClick(() => {
            this.powerOn = !this.powerOn
          })

        Button('Reset', { type: ButtonType.Circle })
          .width(160)
          .height(160)
          .fontSize(36)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.text)
          .backgroundColor(COLORS.secondary)
          .onClick(() => {
            this.knobX = 0
            this.knobY = 0
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ bottom: 48 })

      Stack() {
        Progress({
          value: this.progressValue() * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(12)
          .borderRadius(6)
          .backgroundColor(COLORS.panel)
          .color(COLORS.primary)

        Circle()
          .width(10)
          .height(10)
          .fill(COLORS.primary)
          .align(Alignment.End)
      }
      .width('92%')
      .height(12)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
    .alignItems(HorizontalAlign.Center)
  }
}
