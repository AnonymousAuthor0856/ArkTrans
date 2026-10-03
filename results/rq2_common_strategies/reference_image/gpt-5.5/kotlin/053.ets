const NAME: string = '078_CodeIDE_en'
const UI_TYPE: string = 'Education Terminal'
const STYLE_THEME: string = 'Retro Flat'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class AppColors {
  static readonly primary: string = '#1E293B'
  static readonly primary80: string = '#CC1E293B'
  static readonly secondary: string = '#0EA5E9'
  static readonly tertiary: string = '#FACC15'
  static readonly background: string = '#111827'
  static readonly surface: string = '#1E293B'
  static readonly surface90: string = '#E61E293B'
  static readonly surfaceVariant: string = '#334155'
  static readonly outline: string = '#475569'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#0B1220'
  static readonly onBackground: string = '#E2E8F0'
  static readonly onSurface: string = '#E2E8F0'
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 36
}

class AppShape {
  static readonly small: number = 4
  static readonly medium: number = 12
  static readonly large: number = 12
}

class CodeMarker {
  id: number
  name: string
  desc: string

  constructor(id: number, name: string, desc: string) {
    this.id = id
    this.name = name
    this.desc = desc
  }
}

@Component
struct MarkerCard {
  marker: CodeMarker = new CodeMarker(0, '', '')

  build() {
    Row({ space: 24 }) {
      Stack({ alignContent: Alignment.Center }) {
        Text(this.marker.id.toString())
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
      }
      .width(64)
      .height(64)
      .backgroundColor(AppColors.secondary)
      .borderRadius(AppShape.small)

      Column() {
        Text(this.marker.name)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .maxLines(1)

        Text(this.marker.desc)
          .fontSize(28)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(119)
    .padding({
      left: 24,
      right: 24,
      top: 16,
      bottom: 16
    })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShape.medium)
  }
}

@Entry
@Component
struct Index {
  private markers: CodeMarker[] = [
    new CodeMarker(1, 'Main.kt', 'Entry point for Compose app'),
    new CodeMarker(2, 'Utils.kt', 'Helper functions'),
    new CodeMarker(3, 'Theme.kt', 'Color & Typography setup'),
    new CodeMarker(4, 'Data.kt', 'Repository and model classes')
  ]

  build() {
    Column() {
      Text('CodeIDE Terminal')
        .width('100%')
        .textAlign(TextAlign.Center)
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .margin({ top: 34 })

      Text('Project Files')
        .width('100%')
        .fontSize(38)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .margin({ top: 72 })

      Column({ space: 16 }) {
        ForEach(this.markers, (marker: CodeMarker) => {
          MarkerCard({ marker: marker })
        }, (marker: CodeMarker) => marker.id.toString())
      }
      .width('100%')
      .margin({ top: 34 })

      Text('Live Terminal')
        .width('100%')
        .fontSize(38)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .margin({ top: 78 })

      Stack({ alignContent: Alignment.TopStart }) {
        Text('> println("Hello, Kotlin!")')
          .fontSize(27)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
          .margin({
            left: 23,
            top: 24
          })
      }
      .width('100%')
      .height(324)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShape.medium)
      .border({
        width: 1,
        color: AppColors.outline
      })
      .margin({ top: 34 })

      Button('Run Code')
        .width('60%')
        .height(48)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShape.large)
        .alignSelf(ItemAlign.Center)
        .margin({ top: AppSpacing.lg })
        .onClick(() => {
        })
    }
    .width('100%')
    .height('100%')
    .padding({
      left: 32,
      right: 32
    })
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.background)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppColors.primary80, 0.0],
        [AppColors.surface90, 1.0]
      ]
    })
  }
}