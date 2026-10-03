const NAME: string = '016AudioMixeren'
const UI_TYPE: string = 'Media'
const STYLE_THEME: string = 'Monochrome Terminal'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

const AppTokens = {
  Colors: {
    primary: '#00FF66',
    secondary: '#CCCCCC',
    tertiary: '#999999',
    background: '#000000',
    surface: '#0A0A0A',
    surfaceVariant: '#141414',
    outline: '#2A2A2A',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#000000',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#E0E0E0',
    onSurface: '#E0E0E0'
  },
  TypographyTokens: {
    display: {
      fontSize: 26,
      fontWeight: FontWeight.Bold
    },
    title: {
      fontSize: 16,
      fontWeight: FontWeight.Medium
    },
    body: {
      fontSize: 13,
      fontWeight: FontWeight.Normal
    },
    label: {
      fontSize: 11,
      fontWeight: FontWeight.Medium
    }
  },
  Shapes: {
    small: 6,
    medium: 10,
    large: 14
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  },
  ElevationMapping: {
    level1: new ShadowSpec(0, 0, 0, 0),
    level2: new ShadowSpec(2, 4, 2, 0.12)
  }
}

@Entry
@Component
struct RootScreen {
  @State bass: number = 0.4
  @State mid: number = 0.5
  @State treble: number = 0.6
  @State master: number = 0.7

  @Builder
  MixerSlider(label: string, value: number, onChange: (value: number) => void) {
    Column({ space: AppTokens.Spacing.xs }) {
      Text(`${label} ${Math.floor(value * 100)}%`)
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)

      Slider({
        value: value,
        min: 0,
        max: 1,
        step: 0.01,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .blockColor(AppTokens.Colors.primary)
        .selectedColor(AppTokens.Colors.primary)
        .trackColor(AppTokens.Colors.surfaceVariant)
        .showSteps(false)
        .showTips(false)
        .onChange((sliderValue: number) => {
          onChange(sliderValue)
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      Row() {
        Text('Audio Mixer Terminal')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      Column({ space: AppTokens.Spacing.lg }) {
        this.MixerSlider('Bass', this.bass, (value: number) => {
          this.bass = value
        })

        this.MixerSlider('Mid', this.mid, (value: number) => {
          this.mid = value
        })

        this.MixerSlider('Treble', this.treble, (value: number) => {
          this.treble = value
        })

        Blank()
          .height(AppTokens.Spacing.lg)

        Progress({
          value: this.master * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(6)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)

        Text(`Master Volume ${Math.floor(this.master * 100)}%`)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)

        Slider({
          value: this.master,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .blockColor(AppTokens.Colors.primary)
          .selectedColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .showSteps(false)
          .showTips(false)
          .onChange((value: number) => {
            this.master = value
          })

        Button('Apply Settings', { type: ButtonType.Normal, stateEffect: true })
          .width('100%')
          .height(48)
          .borderRadius(AppTokens.Shapes.medium)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .onClick(() => {
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}