import prompt from '@ohos.promptAction'

// MARK: - AppTokens (原子级对应 Kotlin/Swift 的 AppTokens)
// 定义应用所需的颜色、字体、形状和间距，方便统一管理和修改。
class AppTokens {
  static class Colors {
    static readonly primary: ResourceColor = '#FF2563EB'
    static readonly secondary: ResourceColor = '#FF38BDF8'
    static readonly tertiary: ResourceColor = '#FF60A5FA'
    static readonly background: ResourceColor = '#FFF8FAFC'
    static readonly surface: ResourceColor = '#FFFFFFFF'
    static readonly surfaceVariant: ResourceColor = '#FFE2E8F0'
    static readonly outline: ResourceColor = '#FFCBD5E1'
    static readonly onPrimary: ResourceColor = '#FFFFFFFF'
    static readonly onSecondary: ResourceColor = '#FF0F172A'
    static readonly onTertiary: ResourceColor = '#FFFFFFFF'
    static readonly onBackground: ResourceColor = '#FF0F172A'
    static readonly onSurface: ResourceColor = '#FF1E293B'
  }

  static class TypographyTokens {
    static readonly displayFontSize: number = 24
    static readonly displayFontWeight: number = FontWeight.Bold
    static readonly headlineFontSize: number = 18
    static readonly headlineFontWeight: number = FontWeight.SemiBold
    static readonly titleFontSize: number = 14
    static readonly titleFontWeight: number = FontWeight.Medium
    static readonly bodyFontSize: number = 12
    static readonly bodyFontWeight: number = FontWeight.Regular
  }

  static class Shapes {
    static readonly small: number = 6
    static readonly medium: number = 10
    static readonly large: number = 14
  }

  static class Spacing {
    static readonly sm: number = 6
    static readonly md: number = 10
    static readonly lg: number = 14
    static readonly xl: number = 20
    static readonly buttonContentHorizontal: number = 16
    static readonly buttonContentVertical: number = 8
  }
}

// MARK: - CustomUnitButton (自定义按钮组件，实现原子级对应)
// 这个自定义按钮组件模仿了 SwiftUI ButtonStyle / Compose Button 的条件颜色和形状。
@Component
struct CustomUnitButton {
  @Link isActive: boolean
  label: string = ''
  onTap: () => void = () => {}

  build() {
    Text(this.label)
      .fontSize(AppTokens.TypographyTokens.titleFontSize)
      .fontWeight(AppTokens.TypographyTokens.titleFontWeight)
      .padding({
        left: AppTokens.Spacing.buttonContentHorizontal,
        right: AppTokens.Spacing.buttonContentHorizontal,
        top: AppTokens.Spacing.buttonContentVertical,
        bottom: AppTokens.Spacing.buttonContentVertical
      })
      .backgroundColor(this.isActive ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
      .fontColor(this.isActive ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .borderRadius(AppTokens.Shapes.small)
      .onClick(() => {
        this.onTap()
      })
  }
}

// MARK: - MarkerBox (对应 SwiftUI 的 MarkerBox / Kotlin 的 MarkerBox Composable)
@Component
struct MarkerBox {
  unit: string = ''
  value: string = ''
  active: boolean = false

  build() {
    Column() {
      Text(this.unit)
        .fontSize(AppTokens.TypographyTokens.headlineFontSize)
        .fontWeight(AppTokens.TypographyTokens.headlineFontWeight)
        .fontColor(AppTokens.Colors.onSurface)
      Text(this.value)
        .fontSize(AppTokens.TypographyTokens.bodyFontSize)
        .fontWeight(AppTokens.TypographyTokens.bodyFontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: 4 })
    }
    .width('100%')
    .height(80)
    .padding(AppTokens.Spacing.md)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.active ? 'rgba(56, 189, 248, 0.3)' : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.medium
    })
  }
}

// MARK: - MapArea (对应 SwiftUI 的 MapArea / Kotlin 的 MapArea Composable)
@Component
struct MapArea {
  selected: string = ''

  build() {
    Column() {
      Text('Unit Map Visualization')
        .fontSize(AppTokens.TypographyTokens.headlineFontSize)
        .fontWeight(AppTokens.TypographyTokens.headlineFontWeight)
        .fontColor(AppTokens.Colors.onSurface)
      Text('Active Unit: ' + this.selected)
        .fontSize(AppTokens.TypographyTokens.bodyFontSize)
        .fontWeight(AppTokens.TypographyTokens.bodyFontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.md })
    }
    .width('100%')
    .height(240)
    .padding(AppTokens.Spacing.lg)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.large
    })
  }
}

// MARK: - RootScreen (对应 SwiftUI 的 RootScreen / Kotlin 的 RootScreen Composable)
@Entry
@Component
struct RootScreen {
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed']
  @State active: string = 'Length'

  aboutToAppear() {
    // 隐藏状态栏，对应 Swift 的 .statusBarHidden(true)
  }

  build() {
    Column() {
      Text('Unit Converter')
        .fontSize(AppTokens.TypographyTokens.displayFontSize)
        .fontWeight(AppTokens.TypographyTokens.displayFontWeight)
        .fontColor(AppTokens.Colors.onBackground)

      MapArea({ selected: this.active })
        .margin({ top: AppTokens.Spacing.lg })

      ForEach(this.markers, (marker: string) => {
        MarkerBox({
          unit: marker,
          value: 'Tap to convert',
          active: this.active === marker
        })
          .margin({ top: AppTokens.Spacing.lg })
      }, (marker: string) => marker)

      // 对应 Swift 中的 Spacer().frame(height: AppTokens.Spacing.md)
      Blank()
        .height(AppTokens.Spacing.md)
        .margin({ top: AppTokens.Spacing.lg })

      Row() {
        ForEach(this.markers, (marker: string) => {
          CustomUnitButton({
            label: marker,
            isActive: $active === marker ? true : false,
            onTap: () => {
              this.active = marker
            }
          })
        }, (marker: string) => marker)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({ top: AppTokens.Spacing.lg })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .background(this.buildGradient())
  }

  @Builder
  buildGradient() {
    Column()
      .width('100%')
      .height('100%')
      .linearGradient({
        colors: [['#2638BDF8', 0.0], ['#262563EB', 1.0]],
        direction: GradientDirection.Bottom
      })
  }
}
