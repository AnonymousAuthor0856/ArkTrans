// Index.ets — Neon Recorder
// Single-file ArkTS port of the Kotlin/Compose screen (Dark Neon, 720x1280 baseline).

const NAME: string = '015Recorderen'
const UI_TYPE: string = 'Media'
const STYLE_THEME: string = 'Dark Neon'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

// ---------- Design tokens ----------
const PRIMARY: string = '#00FFFF'
const SECONDARY: string = '#9D00FF'
const TERTIARY: string = '#00FFA3'
const BACKGROUND: string = '#0B0B0D'
const SURFACE: string = '#1A1A1D'
const SURFACE_VARIANT: string = '#2E2E33'
const OUTLINE: string = '#3F3F46'
const SUCCESS: string = '#22C55E'
const WARNING: string = '#F59E0B'
const ERROR: string = '#EF4444'
const ON_PRIMARY: string = '#000000'
const ON_SECONDARY: string = '#FFFFFF'
const ON_TERTIARY: string = '#000000'
const ON_BACKGROUND: string = '#E5E7EB'
const ON_SURFACE: string = '#E5E7EB'
const TRANSPARENT: string = '#00000000'

// Spacing
const SP_XS: number = 4
const SP_SM: number = 8
const SP_MD: number = 12
const SP_LG: number = 16
const SP_XL: number = 24
const SP_XXL: number = 32

// Corner radii
const RADIUS_SM: number = 6
const RADIUS_MD: number = 10
const RADIUS_LG: number = 14

// Typography
const FS_DISPLAY: number = 28
const FS_TITLE: number = 18
const FS_BODY: number = 14
const FS_LABEL: number = 12

@Entry
@Component
struct Index {
  @State title: string = ''
  @State recording: boolean = false
  @State seconds: number = 0
  private timerId: number = -1

  aboutToDisappear(): void {
    this.stopTimer()
  }

  private startTimer(): void {
    this.stopTimer()
    this.timerId = setInterval(() => {
      this.seconds = this.seconds + 1
    }, 1000)
  }

  private stopTimer(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId)
      this.timerId = -1
    }
  }

  private outputPath(): string {
    const trimmed: string = this.title.trim()
    const name: string = trimmed.length === 0 ? 'untitled' : trimmed
    return 'Output Path: /storage/recordings/' + name + '.mp3'
  }

  @Builder
  TopBar() {
    Row() {
      Text('Neon Recorder')
        .fontSize(FS_DISPLAY)
        .fontWeight(FontWeight.Bold)
        .fontColor(PRIMARY)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(88)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(BACKGROUND)
  }

  @Builder
  NameField() {
    TextInput({ text: this.title, placeholder: 'Recording name' })
      .type(InputType.Normal)
      .placeholderColor(ON_SURFACE)
      .placeholderFont({ size: FS_BODY, weight: FontWeight.Normal })
      .fontSize(FS_BODY)
      .fontColor(ON_SURFACE)
      .caretColor(PRIMARY)
      .backgroundColor(TRANSPARENT)
      .border({ width: 1, color: OUTLINE, radius: RADIUS_MD, style: BorderStyle.Solid })
      .height(56)
      .width('100%')
      .onChange((value: string) => {
        this.title = value
      })
  }

  @Builder
  StatusCard() {
    Column() {
      Text(this.recording ? 'Recording... ' + this.seconds.toString() + 's' : 'Press Record')
        .fontSize(FS_TITLE)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.recording ? PRIMARY : ON_SURFACE)
    }
    .width('100%')
    .height(200)
    .borderRadius(RADIUS_LG)
    .backgroundColor(SURFACE_VARIANT)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  Controls() {
    Row() {
      Button(this.recording ? 'Stop' : 'Record')
        .width(160)
        .height(52)
        .fontSize(FS_TITLE)
        .fontWeight(FontWeight.Medium)
        .fontColor(ON_PRIMARY)
        .backgroundColor(this.recording ? ERROR : PRIMARY)
        .borderRadius(RADIUS_LG)
        .onClick(() => {
          if (this.recording) {
            this.recording = false
            this.stopTimer()
          } else {
            this.recording = true
            this.seconds = 0
            this.startTimer()
          }
        })

      Button('Reset')
        .width(120)
        .height(52)
        .fontSize(FS_TITLE)
        .fontWeight(FontWeight.Medium)
        .fontColor(ON_SECONDARY)
        .backgroundColor(SECONDARY)
        .borderRadius(RADIUS_LG)
        .onClick(() => {
          this.seconds = 0
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  Content() {
    Column({ space: SP_LG }) {
      this.NameField()
      this.StatusCard()
      this.Controls()

      Row().layoutWeight(1)

      Text(this.outputPath())
        .fontSize(FS_BODY)
        .fontWeight(FontWeight.Normal)
        .fontColor(ON_SURFACE)
        .opacity(0.7)
        .textAlign(TextAlign.Center)
        .width('100%')

      Row().height(96)
    }
    .width('100%')
    .layoutWeight(1)
    .padding({ left: SP_LG, right: SP_LG, top: SP_LG, bottom: SP_LG })
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      angle: 180,
      colors: [[BACKGROUND, 0.0], [SURFACE_VARIANT, 1.0]]
    })
  }

  build() {
    Column() {
      this.TopBar()
      this.Content()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}