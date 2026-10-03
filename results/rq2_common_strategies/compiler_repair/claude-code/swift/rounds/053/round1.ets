// MARK: - AppTokens (Atomic Design System)
// Design tokens with atomic correspondence to the SwiftUI version.
// All dp/sp values map directly to vp/fp units in ArkTS (default units).

class AppTokens {
  static class Colors {
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

  static class Shapes {
    static readonly small: Length = 4
    static readonly medium: Length = 8
    static readonly large: Length = 12
  }

  static class Spacing {
    static readonly xs: Length = 4
    static readonly sm: Length = 8
    static readonly md: Length = 12
    static readonly lg: Length = 16
    static readonly xl: Length = 24
    static readonly xxl: Length = 36
  }

  static class ShadowSpec {
    static readonly level1 = { radius: 2, y: 1, opacity: 0.1 }
    static readonly level2 = { radius: 4, y: 2, opacity: 0.14 }
    static readonly level3 = { radius: 6, y: 3, opacity: 0.16 }
  }
}

// MARK: - Data Model

interface CodeMarker {
  id: number
  name: string
  desc: string
}

// MARK: - Custom Views

@Component
struct CustomTopAppBar {
  @Prop title: string = ''

  build() {
    Row() {
      Text(this.title)
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct CodeMarkerCard {
  @Prop marker: CodeMarker = { id: 0, name: '', desc: '' }

  build() {
    Row() {
      Stack() {
        Rect()
          .width(32)
          .height(32)
          .fill(AppTokens.Colors.secondary)
          .radius(AppTokens.Shapes.small)
        Text(this.marker.id.toString())
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
      }
      .width(32)
      .height(32)

      Column() {
        Text(this.marker.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.marker.desc)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: AppTokens.Spacing.md })
      .layoutWeight(1)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: AppTokens.ShadowSpec.level1.radius,
      color: `rgba(0, 0, 0, ${AppTokens.ShadowSpec.level1.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ShadowSpec.level1.y
    })
  }
}

// MARK: - RootScreen

@Entry
@Component
struct RootScreen {
  private markers: CodeMarker[] = [
    { id: 1, name: 'Main.kt', desc: 'Entry point for Compose app' },
    { id: 2, name: 'Utils.kt', desc: 'Helper functions' },
    { id: 3, name: 'Theme.kt', desc: 'Color & Typography setup' },
    { id: 4, name: 'Data.kt', desc: 'Repository and model classes' }
  ]

  build() {
    Column() {
      CustomTopAppBar({ title: 'CodeIDE Terminal' })

      Scroll() {
        Column() {
          Text('Project Files')
            .fontSize(20)
            .fontWeight(600)
            .fontColor(AppTokens.Colors.onBackground)

          Column() {
            ForEach(this.markers, (marker: CodeMarker) => {
              CodeMarkerCard({ marker: marker })
            }, (marker: CodeMarker) => marker.id.toString())
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.xl })

          Text('Live Terminal')
            .fontSize(20)
            .fontWeight(600)
            .fontColor(AppTokens.Colors.onBackground)

          Stack() {
            Rect()
              .fill(AppTokens.Colors.surfaceVariant)
              .radius(AppTokens.Shapes.medium)

            Text('> println("Hello, Kotlin!")')
              .fontSize(14)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppTokens.Colors.onSurface)
              .padding(AppTokens.Spacing.md)
          }
          .width('100%')
          .height(240)
          .border({
            width: 1,
            color: AppTokens.Colors.outline,
            radius: AppTokens.Shapes.medium
          })
          .alignContent(Alignment.TopStart)

          Button('Run Code')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSecondary)
            .width('60%')
            .height(48)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({
              radius: AppTokens.ShadowSpec.level1.radius,
              color: `rgba(0, 0, 0, ${AppTokens.ShadowSpec.level1.opacity})`,
              offsetX: 0,
              offsetY: AppTokens.ShadowSpec.level1.y
            })
            .margin({ top: AppTokens.Spacing.lg })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
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
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}
