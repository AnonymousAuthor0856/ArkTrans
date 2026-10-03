const NAME = '093_UnitConverter_en'
const UI_TYPE = 'Tools Messenger'
const STYLE_THEME = 'Modern Blue'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
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
    onSurface: '#1E293B',
  }

  static TypographyTokens = {
    display: { fontSize: 24, fontWeight: FontWeight.Bold },
    headline: { fontSize: 18, fontWeight: FontWeight.Medium },
    title: { fontSize: 14, fontWeight: FontWeight.Medium },
    body: { fontSize: 12, fontWeight: FontWeight.Normal },
  }

  static Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  }

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
  }
}

@Entry
@Component
struct RootScreen {
  @State active: string = 'Length'
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed']

  build() {
    Column() {
      Text('Unit Converter')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)

      Column() {
        Text('Unit Map Visualization')
          .fontSize(AppTokens.TypographyTokens.headline.fontSize)
          .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)

        Text(`Active Unit: ${this.active}`)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.md })
      }
      .width('100%')
      .height(240)
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.large)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .margin({ top: AppTokens.Spacing.lg })

      ForEach(this.markers, (unit: string) => {
        Column() {
          Text(unit)
            .fontSize(AppTokens.TypographyTokens.headline.fontSize)
            .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Text('Tap to convert')
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(80)
        .padding(AppTokens.Spacing.md)
        .backgroundColor(this.active === unit ? '#4D38BDF8' : AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .alignItems(HorizontalAlign.Start)
        .margin({ top: AppTokens.Spacing.lg })
      }, (unit: string) => unit)

      Row() {
        ForEach(this.markers, (unit: string) => {
          Button(unit)
            .type(ButtonType.Normal)
            .backgroundColor(this.active === unit ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
            .fontColor(this.active === unit ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .margin({ right: AppTokens.Spacing.md })
            .onClick(() => {
              this.active = unit
            })
        }, (unit: string) => unit)
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.md })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      angle: 180,
      colors: [['#2638BDF8', 0.0], ['#262563EB', 1.0]]
    })
  }
}