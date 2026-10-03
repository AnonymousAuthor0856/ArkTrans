class AppColors {
  static readonly primary: string = '#00FFFF'
  static readonly secondary: string = '#9D00FF'
  static readonly tertiary: string = '#00FFA3'
  static readonly background: string = '#0B0B0D'
  static readonly surface: string = '#1A1A1D'
  static readonly surfaceVariant: string = '#2E2E33'
  static readonly outline: string = '#3F3F46'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#000000'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#000000'
  static readonly onBackground: string = '#E5E7EB'
  static readonly onSurface: string = '#E5E7EB'
  static readonly onSurface70: string = 'rgba(229, 231, 235, 0.70)'
}

class AppTypography {
  static readonly displaySize: number = 28
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 14
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
}

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

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16)
}

@Entry
@Component
struct RootScreen {
  @State private title: string = ''
  @State private recording: boolean = false
  @State private seconds: number = 0

  private outputName(): string {
    return this.title.trim().length === 0 ? 'untitled' : this.title
  }

  build() {
    Column() {
      Row() {
        Text('Neon Recorder')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        TextInput({
          placeholder: 'Recording name',
          text: this.title
        })
          .width('100%')
          .height(56)
          .fontSize(AppTypography.titleSize)
          .fontColor(AppColors.onSurface)
          .fontWeight(FontWeight.Regular)
          .placeholderColor(AppColors.onSurface)
          .placeholderFont({
            size: AppTypography.titleSize,
            weight: FontWeight.Regular
          })
          .caretColor(AppColors.primary)
          .singleLine(true)
          .padding({
            left: AppSpacing.lg,
            right: AppSpacing.lg
          })
          .backgroundColor('rgba(0, 0, 0, 0)')
          .border({
            width: 1,
            color: AppColors.outline,
            radius: AppShapes.medium
          })
          .onChange((value: string) => {
            this.title = value
          })

        Stack({ alignContent: Alignment.Center }) {
          Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.recording ? AppColors.primary : AppColors.onSurface)
        }
        .width('100%')
        .height(200)
        .borderRadius(AppShapes.large)
        .backgroundColor(AppColors.surfaceVariant)

        Row() {
          Button(this.recording ? 'Stop' : 'Record', { type: ButtonType.Normal, stateEffect: true })
            .width(160)
            .height(52)
            .borderRadius(AppShapes.large)
            .backgroundColor(this.recording ? AppColors.error : AppColors.primary)
            .fontColor(AppColors.onPrimary)
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.recording = !this.recording
              if (this.recording) {
                this.seconds = 0
              }
            })

          Button('Reset', { type: ButtonType.Normal, stateEffect: true })
            .width(120)
            .height(52)
            .borderRadius(AppShapes.large)
            .backgroundColor(AppColors.secondary)
            .fontColor(AppColors.onSecondary)
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.seconds = 0
            })
        }
        .width('100%')
        .height(52)
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)

        Blank()
          .height(AppSpacing.xxl)

        Text(`Output Path: /storage/recordings/${this.outputName()}.mp3`)
          .width('100%')
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface70)
          .textAlign(TextAlign.Center)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppColors.background, 0.0],
          [AppColors.surfaceVariant, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}