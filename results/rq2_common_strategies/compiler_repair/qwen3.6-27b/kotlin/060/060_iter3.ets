import { Colors } from '@kit.ArkUI'

interface ColorToken {
  hex: string
}

interface TypographySpec {
  fontSize: number
  fontWeight: FontWeight
}

// App Tokens Definition
const AppTokens = {
  Colors: {
    primary: '#2563EB',
    secondary: '#38BDF8',
    tertiary: '#60A5FA',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#E2E8F0',
    outline: '#CBD5E1',
    onPrimary: '#FFFFFF',
    onSecondary: '#0F172A',
    onTertiary: '#FFFFFF',
    onBackground: '#0F172A',
    onSurface: '#1E293B'
  },
  Typography: {
    display: { fontSize: 24, fontWeight: FontWeight.Bold },
    headline: { fontSize: 18, fontWeight: FontWeight.Semibold },
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
        .fontSize(AppTokens.Typography.display.fontSize)
        .fontWeight(AppTokens.Typography.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)
        .margin({ bottom: AppTokens.Spacing.lg })

      // Map Area Visualization
      Column() {
        Text('Unit Map Visualization')
          .fontSize(AppTokens.Typography.headline.fontSize)
          .fontWeight(AppTokens.Typography.headline.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
        
        Text(`Active Unit: ${this.activeUnit}`)
          .fontSize(AppTokens.Typography.body.fontSize)
          .fontWeight(AppTokens.Typography.body.fontWeight)
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

      Blank().height(AppTokens.Spacing.md)

      // Action Buttons
      Row() {
        ForEach(this.markers, (unit: string) => {
          Button(unit)
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
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
        .fontSize(AppTokens.Typography.headline.fontSize)
        .fontWeight(AppTokens.Typography.headline.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
      
      Text(value)
        .fontSize(AppTokens.Typography.body.fontSize)
        .fontWeight(AppTokens.Typography.body.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(80)
    .backgroundColor(isActive ? AppTokens.Colors.secondary + '4D' : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .padding(AppTokens.Spacing.md)
    .alignItems(HorizontalAlign.Start)
    .margin({ bottom: AppTokens.Spacing.lg })
  }
}