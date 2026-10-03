// MARK: - AppTokens (原子级对应 Kotlin/Swift 的 AppTokens)
// 定义应用所需的颜色、字体、形状和间距，方便统一管理和修改。
namespace AppTokens {
  export namespace Colors {
    export const primary: ResourceColor = '#FF2563EB'
    export const secondary: ResourceColor = '#FF38BDF8'
    export const tertiary: ResourceColor = '#FF60A5FA'
    export const background: ResourceColor = '#FFF8FAFC'
    export const surface: ResourceColor = '#FFFFFFFF'
    export const surfaceVariant: ResourceColor = '#FFE2E8F0'
    export const outline: ResourceColor = '#FFCBD5E1'
    export const onPrimary: ResourceColor = '#FFFFFFFF'
    export const onSecondary: ResourceColor = '#FF0F172A'
    export const onTertiary: ResourceColor = '#FFFFFFFF'
    export const onBackground: ResourceColor = '#FF0F172A'
    export const onSurface: ResourceColor = '#FF1E293B'
  }

  export namespace TypographyTokens {
    export const displayFontSize: number = 24
    export const displayFontWeight: FontWeight = FontWeight.Bold
    export const headlineFontSize: number = 18
    export const headlineFontWeight: number = 600
    export const titleFontSize: number = 14
    export const titleFontWeight: FontWeight = FontWeight.Medium
    export const bodyFontSize: number = 12
    export const bodyFontWeight: FontWeight = FontWeight.Regular
  }

  export namespace Shapes {
    export const small: Length = 6
    export const medium: Length = 10
    export const large: Length = 14
  }

  export namespace Spacing {
    export const sm: Length = 6
    export const md: Length = 10
    export const lg: Length = 14
    export const xl: Length = 20
    export const buttonContentHorizontal: Length = 16
    export const buttonContentVertical: Length = 8
  }
}

// MARK: - CustomUnitButton (自定义按钮组件，实现原子级对应)
// 这个自定义按钮组件模仿了 SwiftUI ButtonStyle / Compose Button 的条件颜色和形状。
@Component
struct CustomUnitButton {
  @Prop label: string = ''
  @Prop isActive: boolean = false
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
  @Prop unit: string = ''
  @Prop value: string = ''
  @Prop active: boolean = false

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
  @Prop selected: string = ''

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
            isActive: this.active === marker,
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
    .linearGradient({
      colors: [['#2638BDF8', 0.0], ['#262563EB', 1.0]],
      direction: GradientDirection.Bottom
    })
  }
}
