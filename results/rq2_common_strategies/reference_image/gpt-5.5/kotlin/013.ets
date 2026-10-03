const NAME: string = '011*MusicPlayer*en'
const UI_TYPE: string = 'Media'
const STYLE_THEME: string = 'Retro Flat'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

const PRIMARY: string = '#EF476F'
const SECONDARY: string = '#FFD166'
const TERTIARY: string = '#06D6A0'
const BACKGROUND: string = '#FFFCF2'
const SURFACE: string = '#FFF8E1'
const OUTLINE: string = '#BDBDBD'
const ON_PRIMARY: string = '#FFFFFF'
const ON_SECONDARY: string = '#1F1F1F'
const ON_SURFACE: string = '#1F1F1F'

@Entry
@Component
struct Index {
  @State private knobX: number = 300
  @State private knobY: number = 300

  private readonly boxSize: number = 280
  private readonly rawCanvasSize: number = 560
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private clamp(value: number, min: number, max: number): number {
    return Math.min(Math.max(value, min), max)
  }

  private drawPlayer(): void {
    const scale: number = this.boxSize / this.rawCanvasSize
    const center: number = this.boxSize / 2

    this.context.clearRect(0, 0, this.boxSize, this.boxSize)

    this.context.beginPath()
    this.context.strokeStyle = SECONDARY
    this.context.lineWidth = 12 * scale
    this.context.arc(
      center,
      center,
      (this.rawCanvasSize / 2 - 20) * scale,
      0,
      Math.PI * 2
    )
    this.context.stroke()

    this.context.beginPath()
    this.context.fillStyle = PRIMARY
    this.context.arc(
      this.knobX * scale,
      this.knobY * scale,
      20 * scale,
      0,
      Math.PI * 2
    )
    this.context.fill()
  }

  private updateKnob(localX: number, localY: number): void {
    this.knobX = this.clamp(localX / this.boxSize * this.rawCanvasSize, 0, this.rawCanvasSize)
    this.knobY = this.clamp(localY / this.boxSize * this.rawCanvasSize, 0, this.rawCanvasSize)
    this.drawPlayer()
  }

  build() {
    Column() {
      Text('Retro Music Player')
        .height(64)
        .width('100%')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(ON_SURFACE)
        .textAlign(TextAlign.Center)

      Column() {
        Stack() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawPlayer()
            })
        }
        .width(this.boxSize)
        .height(this.boxSize)
        .backgroundColor(SURFACE)
        .borderRadius(16)
        .border({
          width: 3,
          color: OUTLINE
        })
        .clip(true)
        .onTouch((event: TouchEvent) => {
          if ((event.type === TouchType.Down || event.type === TouchType.Move) &&
            event.touches.length > 0) {
            this.updateKnob(event.touches[0].x, event.touches[0].y)
          }
        })

        Text('Track: Summer Nights')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SURFACE)
          .textAlign(TextAlign.Center)

        Row() {
          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('Play')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(ON_PRIMARY)
          }
          .width(120)
          .height(48)
          .borderRadius(12)
          .backgroundColor(PRIMARY)
          .onClick(() => {
          })

          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('Pause')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(ON_SECONDARY)
          }
          .width(120)
          .height(48)
          .borderRadius(12)
          .backgroundColor(SECONDARY)
          .onClick(() => {
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)

        Text(`Knob X:${Math.round(this.knobX)} Y:${Math.round(this.knobY)}`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(TERTIARY)
          .textAlign(TextAlign.Center)

        Blank()
          .height(32)
      }
      .layoutWeight(1)
      .width('100%')
      .padding({
        left: 16,
        right: 16,
        top: 16,
        bottom: 16
      })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}