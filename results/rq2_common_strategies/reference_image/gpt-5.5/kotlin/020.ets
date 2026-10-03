const NAME: string = '020RemoteControlen'
const UI_TYPE: string = 'Media'
const STYLE_THEME: string = 'Retro Flat'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

const PRIMARY: ResourceColor = '#FF7A00'
const SECONDARY: ResourceColor = '#FFC300'
const SECONDARY_20: ResourceColor = 'rgba(255, 195, 0, 0.2)'
const BACKGROUND: ResourceColor = '#FFF8E7'
const SURFACE_VARIANT: ResourceColor = '#FFEBC8'
const SUCCESS: ResourceColor = '#28A745'
const ERROR: ResourceColor = '#DC3545'
const ON_PRIMARY: ResourceColor = '#FFFFFF'
const ON_SECONDARY: ResourceColor = '#1E1E1E'
const ON_SURFACE: ResourceColor = '#1E1E1E'

@Entry
@Component
struct Index {
  @State private knobX: number = 0
  @State private knobY: number = 0
  @State private powerOn: boolean = false

  private readonly panelSize: number = 280
  private readonly panelPadding: number = 16
  private readonly knobSize: number = 24
  private readonly bigCircleSize: number = 200

  private clamp(value: number, min: number, max: number): number {
    if (value < min) {
      return min
    }
    if (value > max) {
      return max
    }
    return value
  }

  private updateKnob(x: number, y: number): void {
    const innerSize: number = this.panelSize - this.panelPadding * 2
    this.knobX = this.clamp(x - this.panelPadding, 0, innerSize)
    this.knobY = this.clamp(y - this.panelPadding, 0, innerSize)
  }

  private progressFraction(): number {
    return ((this.knobX + this.knobY) % 400) / 400
  }

  private progressWidth(): string {
    return `${this.progressFraction() * 100}%`
  }

  build() {
    Column({ space: 24 }) {
      Text('Retro Remote Control')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(ON_SURFACE)
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 20 })

      Stack({ alignContent: Alignment.TopStart }) {
        Circle()
          .width(this.bigCircleSize)
          .height(this.bigCircleSize)
          .fill(SECONDARY_20)
          .position({
            x: (this.panelSize - this.bigCircleSize) / 2,
            y: (this.panelSize - this.bigCircleSize) / 2
          })

        Circle()
          .width(this.knobSize)
          .height(this.knobSize)
          .fill(PRIMARY)
          .position({
            x: this.panelPadding + this.knobX - this.knobSize / 2,
            y: this.panelPadding + this.knobY - this.knobSize / 2
          })
      }
      .width(this.panelSize)
      .height(this.panelSize)
      .backgroundColor(SURFACE_VARIANT)
      .borderRadius(24)
      .shadow({
        radius: 8,
        color: 'rgba(0, 0, 0, 0.16)',
        offsetX: 0,
        offsetY: 4
      })
      .onTouch((event: TouchEvent) => {
        if (event.type === TouchType.Down || event.type === TouchType.Move) {
          if (event.touches.length > 0) {
            this.updateKnob(event.touches[0].x, event.touches[0].y)
          }
        }
      })

      Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.powerOn ? SUCCESS : ERROR)
        .textAlign(TextAlign.Center)
        .width('100%')

      Row() {
        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text(this.powerOn ? 'Off' : 'On')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(ON_PRIMARY)
            .textAlign(TextAlign.Center)
        }
        .width(80)
        .height(80)
        .padding(0)
        .borderRadius(40)
        .backgroundColor(PRIMARY)
        .onClick(() => {
          this.powerOn = !this.powerOn
        })

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Reset')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(ON_SECONDARY)
            .textAlign(TextAlign.Center)
        }
        .width(80)
        .height(80)
        .padding(0)
        .borderRadius(40)
        .backgroundColor(SECONDARY)
        .onClick(() => {
          this.knobX = 0
          this.knobY = 0
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)

      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width(this.progressWidth())
          .height(6)
          .backgroundColor(PRIMARY)
          .borderRadius(3)
      }
      .width('100%')
      .height(6)
      .backgroundColor(SURFACE_VARIANT)
      .borderRadius(3)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16 })
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(BACKGROUND)
  }
}