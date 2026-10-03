// AppTokens - Design System Tokens
class AppColors {
  static readonly primary: ResourceColor = '#1E293B'
  static readonly secondary: ResourceColor = '#0EA5E9'
  static readonly tertiary: ResourceColor = '#FACC15'
  static readonly background: ResourceColor = '#1E293B'
  static readonly surface: ResourceColor = '#1E293B'
  static readonly surfaceVariant: ResourceColor = '#334155'
  static readonly outline: ResourceColor = '#475569'
  static readonly onPrimary: ResourceColor = '#FFFFFF'
  static readonly onSecondary: ResourceColor = '#FFFFFF'
  static readonly onTertiary: ResourceColor = '#0B1220'
  static readonly onBackground: ResourceColor = '#E2E8F0'
  static readonly onSurface: ResourceColor = '#E2E8F0'
}

class AppSpacing {
  static readonly xs: Length = 4
  static readonly sm: Length = 8
  static readonly md: Length = 12
  static readonly lg: Length = 16
  static readonly xl: Length = 24
  static readonly xxl: Length = 36
}

class AppShapes {
  static readonly small: Length = 4
  static readonly medium: Length = 8
  static readonly large: Length = 12
}

// Data Model
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

// CustomTopAppBar Component
@Component
struct CustomTopAppBar {
  title: string = ''

  build() {
    Row() {
      Blank()
      Text(this.title)
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
      Blank()
    }
    .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.background)
  }
}

// CodeMarkerCard Component
@Component
struct CodeMarkerCard {
  marker: CodeMarker = new CodeMarker(0, '', '')

  build() {
    Row() {
      Stack() {
        Text(this.marker.id.toString())
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
      }
      .width(32)
      .height(32)
      .backgroundColor(AppColors.secondary)
      .borderRadius(AppShapes.small)

      Column() {
        Text(this.marker.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(this.marker.desc)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: AppSpacing.md })
    }
    .padding(AppSpacing.md)
    .width('100%')
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.medium)
  }
}

// RootScreen - Main Page
@Entry
@Component
struct RootScreen {
  private markers: CodeMarker[] = [
    new CodeMarker(1, 'Main.kt', 'Entry point for Compose app'),
    new CodeMarker(2, 'Utils.kt', 'Helper functions'),
    new CodeMarker(3, 'Theme.kt', 'Color & Typography setup'),
    new CodeMarker(4, 'Data.kt', 'Repository and model classes')
  ]

  build() {
    Column() {
      CustomTopAppBar({ title: 'CodeIDE Terminal' })

      Column() {
        Text('Project Files')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onBackground)
          .width('100%')
          .margin({ bottom: AppSpacing.lg })

        ForEach(this.markers, (marker: CodeMarker) => {
          CodeMarkerCard({ marker: marker })
            .margin({ bottom: AppSpacing.sm })
        }, (marker: CodeMarker) => marker.id.toString())

        Text('Live Terminal')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onBackground)
          .width('100%')
          .margin({ top: AppSpacing.xl, bottom: AppSpacing.lg })

        Stack() {
          Text('> println("Hello, Kotlin!")')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onSurface)
            .padding(AppSpacing.md)
        }
        .width('100%')
        .height(240)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)
        .border({
          width: 1,
          color: AppColors.outline,
          radius: AppShapes.medium
        })
        .alignContent(Alignment.TopStart)

        Button('Run Code')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .width('60%')
          .height(48)
          .backgroundColor(AppColors.secondary)
          .borderRadius(AppShapes.large)
          .margin({ top: AppSpacing.xl })
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .linearGradient({
        colors: [
          ['#1E293B', 0.0],
          ['#1E293B', 1.0]
        ],
        direction: GradientDirection.Bottom
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
