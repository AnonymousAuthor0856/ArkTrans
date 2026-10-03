interface ShadowConfig {
  radius: number
  y: number
  opacity: number
}

class AppColors {
  static readonly primary: ResourceColor = '#1E293B'
  static readonly secondary: ResourceColor = '#0EA5E9'
  static readonly tertiary: ResourceColor = '#FACC15'
  static readonly background: ResourceColor = '#1E293B'
  static readonly surface: ResourceColor = '#1E293B'
  static readonly surfaceVariant: ResourceColor = '#334155'
  static readonly outline: ResourceColor = '#475569'
  static readonly success: ResourceColor = '#22C55E'
  static readonly warning: ResourceColor = '#F59E0B'
  static readonly error: ResourceColor = '#EF4444'
  static readonly onPrimary: ResourceColor = '#FFFFFF'
  static readonly onSecondary: ResourceColor = '#FFFFFF'
  static readonly onTertiary: ResourceColor = '#0B1220'
  static readonly onBackground: ResourceColor = '#E2E8F0'
  static readonly onSurface: ResourceColor = '#E2E8F0'
}

class AppShapes {
  static readonly small: Length = 4
  static readonly medium: Length = 8
  static readonly large: Length = 12
}

class AppSpacing {
  static readonly xs: Length = 4
  static readonly sm: Length = 8
  static readonly md: Length = 12
  static readonly lg: Length = 16
  static readonly xl: Length = 24
  static readonly xxl: Length = 36
}

class AppShadow {
  static readonly level1: ShadowConfig = { radius: 2, y: 1, opacity: 0.1 }
  static readonly level2: ShadowConfig = { radius: 4, y: 2, opacity: 0.14 }
  static readonly level3: ShadowConfig = { radius: 6, y: 3, opacity: 0.16 }
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
struct CustomTopAppBar {
  @Prop title: string = ''

  build() {
    Row() {
      Text(this.title)
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.background)
  }
}

@Component
struct CodeMarkerCard {
  @Prop marker: CodeMarker = new CodeMarker(0, '', '')

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
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: AppSpacing.md })
      .layoutWeight(1)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.medium)
    .shadow({
      radius: AppShadow.level1.radius,
      color: `rgba(0, 0, 0, ${AppShadow.level1.opacity})`,
      offsetX: 0,
      offsetY: AppShadow.level1.y
    })
  }
}

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

      Scroll() {
        Column() {
          Text('Project Files')
            .fontSize(20)
            .fontWeight(600)
            .fontColor(AppColors.onBackground)

          Column() {
            ForEach(this.markers, (marker: CodeMarker) => {
              CodeMarkerCard({ marker: marker })
            }, (marker: CodeMarker) => marker.id.toString())
          }
          .width('100%')
          .margin({ bottom: AppSpacing.xl })

          Text('Live Terminal')
            .fontSize(20)
            .fontWeight(600)
            .fontColor(AppColors.onBackground)

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
          .border({ width: 1, color: AppColors.outline })
          .borderRadius(AppShapes.medium)
          .alignContent(Alignment.TopStart)

          Button('Run Code')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .width('60%')
            .height(48)
            .backgroundColor(AppColors.secondary)
            .borderRadius(AppShapes.large)
            .shadow({
              radius: AppShadow.level1.radius,
              color: `rgba(0, 0, 0, ${AppShadow.level1.opacity})`,
              offsetX: 0,
              offsetY: AppShadow.level1.y
            })
            .margin({ top: AppSpacing.lg })
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .linearGradient({
        colors: [
          ['#CC1E293B', 0.0],
          ['#E61E293B', 1.0]
        ],
        direction: GradientDirection.Bottom
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}
