class AppTokens {
  static readonly Colors = {
    primary: '#FF2563EB',
    secondary: '#FF38BDF8',
    tertiary: '#FF60A5FA',
    background: '#FFF8FAFC',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE2E8F0',
    outline: '#FFCBD5E1',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF0F172A',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF0F172A',
    onSurface: '#FF1E293B',
  }
  static readonly Typography = {
    display: { size: 24, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Medium },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal },
  }
  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  }
  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
  }
}

@Component
struct MarkerBox {
  @Prop unit: string
  @Prop value: string
  @Prop active: boolean

  build() {
    Column() {
      Text(this.unit)
        .fontSize(AppTokens.Typography.headline.size)
        .fontWeight(AppTokens.Typography.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Text(this.value)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(80)
    .padding(AppTokens.Spacing.md)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.active ? '#4D38BDF8' : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

@Component
struct MapArea {
  @Prop selected: string

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text('Unit Map Visualization')
        .fontSize(AppTokens.Typography.headline.size)
        .fontWeight(AppTokens.Typography.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Text(`Active Unit: ${this.selected}`)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(240)
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

@Entry
@Component
struct RootScreen {
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed']
  @State active: string = 'Length'

  build() {
    Column({ space: AppTokens.Spacing.lg }) {
      Text('Unit Converter')
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.onBackground)

      MapArea({ selected: this.active })

      ForEach(this.markers, (marker: string) => {
        MarkerBox({ unit: marker, value: 'Tap to convert', active: this.active === marker })
      })

      Row({ space: AppTokens.Spacing.md }) {
        ForEach(this.markers, (marker: string) => {
          Button(marker)
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(this.active === marker ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .backgroundColor(this.active === marker ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.small)
            .onClick(() => {
              this.active = marker
            })
        })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .linearGradient({
      angle: 180,
      colors: [['#2638BDF8', 0.0], ['#262563EB', 1.0]]
    })
  }
}