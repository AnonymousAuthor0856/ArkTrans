import { Color, FontSize, FontWeight, PixelMap } from '@kit.ArkUI'

// App Tokens Definition
const AppTokens = {
  Colors: {
    primary: new Color('#2563EB'),
    secondary: new Color('#38BDF8'),
    tertiary: new Color('#60A5FA'),
    background: new Color('#F8FAFC'),
    surface: new Color('#FFFFFF'),
    surfaceVariant: new Color('#E2E8F0'),
    outline: new Color('#CBD5E1'),
    onPrimary: new Color('#FFFFFF'),
    onSecondary: new Color('#0F172A'),
    onTertiary: new Color('#FFFFFF'),
    onBackground: new Color('#0F172A'),
    onSurface: new Color('#1E293B')
  },
  Typography: {
    display: { fontSize: 24, fontWeight: FontWeight.Bold },
    headline: { fontSize: 18, fontWeight: FontWeight.SemiBold },
    title: { fontSize: 14, fontWeight: FontWeight.Medium },
    body: { fontSize: 12, fontWeight: FontWeight.Normal }
  },
  Shapes: {
    small: 6,
    medium: 10,
    large: 14
  },
  Spacing: {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20
  }
}

@Entry
@Component
struct UnitConverterApp {
  @State activeUnit: string = 'Length'
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed']

  build() {
    Column() {
      // Header
      Text('Unit Converter')
        .fontSpec(AppTokens.Typography.display)
        .fontColor(AppTokens.Colors.onBackground)
        .margin({ bottom: AppTokens.Spacing.lg })

      // Map Area Visualization
      Column() {
        Text('Unit Map Visualization')
          .fontSpec(AppTokens.Typography.headline)
          .fontColor(AppTokens.Colors.onSurface)
        
        Text(`Active Unit: ${this.activeUnit}`)
          .fontSpec(AppTokens.Typography.body)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.md })
      }
      .width('100%')
      .height(240)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.large)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .padding(AppTokens.Spacing.lg)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .margin({ bottom: AppTokens.Spacing.lg })

      // Marker Boxes
      ForEach(this.markers, (unit: string) => {
        this.MarkerBox(unit, 'Tap to convert', this.activeUnit === unit)
      }, (item: string) => item)

      Spacer().height(AppTokens.Spacing.md)

      // Action Buttons
      Row() {
        ForEach(this.markers, (unit: string) => {
          Button(unit)
            .fontSpec(AppTokens.Typography.title)
            .backgroundColor(this.activeUnit === unit ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
            .fontColor(this.activeUnit === unit ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.activeUnit = unit
            })
        }, (item: string) => item)
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 90,
      colors: [
        [AppTokens.Colors.secondary, 0.15],
        [AppTokens.Colors.primary, 0.15]
      ]
    })
    .padding(AppTokens.Spacing.lg)
  }

  @Builder
  MarkerBox(unit: string, value: string, isActive: boolean) {
    Column() {
      Text(unit)
        .fontSpec(AppTokens.Typography.headline)
        .fontColor(AppTokens.Colors.onSurface)
      
      Text(value)
        .fontSpec(AppTokens.Typography.body)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(80)
    .backgroundColor(isActive ? AppTokens.Colors.secondary.withAlpha(0.3) : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .padding(AppTokens.Spacing.md)
    .alignItems(HorizontalAlign.Start)
    .margin({ bottom: AppTokens.Spacing.lg })
  }
}