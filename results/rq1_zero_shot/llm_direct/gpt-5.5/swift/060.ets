class AppTokens {
  static Colors = class {
    static readonly primary: string = '#2563EB'
    static readonly secondary: string = '#38BDF8'
    static readonly tertiary: string = '#60A5FA'
    static readonly background: string = '#F8FAFC'
    static readonly surface: string = '#FFFFFF'
    static readonly surfaceVariant: string = '#E2E8F0'
    static readonly outline: string = '#CBD5E1'
    static readonly onPrimary: string = '#FFFFFF'
    static readonly onSecondary: string = '#0F172A'
    static readonly onTertiary: string = '#FFFFFF'
    static readonly onBackground: string = '#0F172A'
    static readonly onSurface: string = '#1E293B'

    static readonly secondaryOpacity30: string = '#4D38BDF8'
    static readonly secondaryOpacity15: string = '#2638BDF8'
    static readonly primaryOpacity15: string = '#262563EB'
  }

  static TypographyTokens = class {
    static readonly displaySize: number = 24
    static readonly headlineSize: number = 18
    static readonly titleSize: number = 14
    static readonly bodySize: number = 12

    static readonly displayWeight: FontWeight = FontWeight.Bold
    static readonly headlineWeight: FontWeight = FontWeight.Medium
    static readonly titleWeight: FontWeight = FontWeight.Medium
    static readonly bodyWeight: FontWeight = FontWeight.Regular
  }

  static Shapes = class {
    static readonly small: number = 6
    static readonly medium: number = 10
    static readonly large: number = 14
  }

  static Spacing = class {
    static readonly sm: number = 6
    static readonly md: number = 10
    static readonly lg: number = 14
    static readonly xl: number = 20
    static readonly buttonContentHorizontal: number = 16
    static readonly buttonContentVertical: number = 8
  }
}

@Component
struct CustomUnitButton {
  marker: string = ''
  isActive: boolean = false
  onTap: () => void = () => {}

  build() {
    Button(this.marker, { type: ButtonType.Normal })
      .fontSize(AppTokens.TypographyTokens.titleSize)
      .fontWeight(AppTokens.TypographyTokens.titleWeight)
      .fontColor(this.isActive ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({
        left: AppTokens.Spacing.buttonContentHorizontal,
        right: AppTokens.Spacing.buttonContentHorizontal,
        top: AppTokens.Spacing.buttonContentVertical,
        bottom: AppTokens.Spacing.buttonContentVertical
      })
      .backgroundColor(this.isActive ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)
      .stateEffect(true)
      .onClick(() => {
        this.onTap()
      })
  }
}

@Component
struct MarkerBox {
  unit: string = ''
  value: string = ''
  active: boolean = false

  build() {
    Column() {
      Text(this.unit)
        .fontSize(AppTokens.TypographyTokens.headlineSize)
        .fontWeight(AppTokens.TypographyTokens.headlineWeight)
        .fontColor(AppTokens.Colors.onSurface)

      Text(this.value)
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(AppTokens.TypographyTokens.bodyWeight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .padding(AppTokens.Spacing.md)
    .width('100%')
    .height(80)
    .backgroundColor(this.active ? AppTokens.Colors.secondaryOpacity30 : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.medium
    })
  }
}

@Component
struct MapArea {
  selected: string = ''

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text('Unit Map Visualization')
        .fontSize(AppTokens.TypographyTokens.headlineSize)
        .fontWeight(AppTokens.TypographyTokens.headlineWeight)
        .fontColor(AppTokens.Colors.onSurface)

      Text(`Active Unit: ${this.selected}`)
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(AppTokens.TypographyTokens.bodyWeight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(240)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.large
    })
    .padding(AppTokens.Spacing.lg)
  }
}

@Entry
@Component
struct RootScreen {
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed']
  @State private active: string = 'Length'

  build() {
    Column({ space: AppTokens.Spacing.lg }) {
      Text('Unit Converter')
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontWeight(AppTokens.TypographyTokens.displayWeight)
        .fontColor(AppTokens.Colors.onBackground)

      MapArea({ selected: this.active })

      ForEach(this.markers, (marker: string) => {
        MarkerBox({
          unit: marker,
          value: 'Tap to convert',
          active: this.active === marker
        })
      }, (marker: string) => marker)

      Blank()
        .height(AppTokens.Spacing.md)

      Row({ space: AppTokens.Spacing.md }) {
        ForEach(this.markers, (marker: string) => {
          CustomUnitButton({
            marker: marker,
            isActive: this.active === marker,
            onTap: () => {
              this.active = marker
            }
          })
        }, (marker: string) => marker)
      }
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppTokens.Colors.secondaryOpacity15, 0.0],
        [AppTokens.Colors.primaryOpacity15, 1.0]
      ]
    })
  }
}