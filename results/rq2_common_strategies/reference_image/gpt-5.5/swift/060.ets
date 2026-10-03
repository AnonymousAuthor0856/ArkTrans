class AppColors {
  static readonly primary: ResourceColor = '#2563EB'
  static readonly secondary: ResourceColor = '#38BDF8'
  static readonly tertiary: ResourceColor = '#60A5FA'
  static readonly background: ResourceColor = '#F8FAFC'
  static readonly surface: ResourceColor = '#FFFFFF'
  static readonly surfaceVariant: ResourceColor = '#E2E8F0'
  static readonly outline: ResourceColor = '#CBD5E1'
  static readonly onPrimary: ResourceColor = '#FFFFFF'
  static readonly onSecondary: ResourceColor = '#0F172A'
  static readonly onTertiary: ResourceColor = '#FFFFFF'
  static readonly onBackground: ResourceColor = '#0F172A'
  static readonly onSurface: ResourceColor = '#1E293B'

  static readonly secondary30: ResourceColor = 'rgba(56, 189, 248, 0.30)'
  static readonly secondary15: ResourceColor = 'rgba(56, 189, 248, 0.15)'
  static readonly primary15: ResourceColor = 'rgba(37, 99, 235, 0.15)'
}

class AppTypography {
  static readonly display: number = 24
  static readonly headline: number = 18
  static readonly title: number = 14
  static readonly body: number = 12
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 14
}

class AppSpacing {
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 14
  static readonly xl: number = 20
  static readonly buttonContentHorizontal: number = 16
  static readonly buttonContentVertical: number = 8
}

@Component
struct MarkerBox {
  @Prop unit: string
  @Prop value: string
  @Prop active: boolean

  build() {
    Column() {
      Text(this.unit)
        .fontSize(AppTypography.headline)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)

      Text(this.value)
        .fontSize(AppTypography.body)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(80)
    .padding(AppSpacing.md)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.active ? AppColors.secondary30 : AppColors.surface)
    .borderRadius(AppShapes.medium)
    .border({
      width: 1,
      color: AppColors.outline,
      radius: AppShapes.medium
    })
  }
}

@Component
struct MapArea {
  @Prop selected: string

  build() {
    Column() {
      Column({ space: AppSpacing.md }) {
        Text('Unit Map Visualization')
          .fontSize(AppTypography.headline)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)

        Text(`Active Unit: ${this.selected}`)
          .fontSize(AppTypography.body)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(104)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.large)
      .border({
        width: 1,
        color: AppColors.outline,
        radius: AppShapes.large
      })
    }
    .width('100%')
    .padding(AppSpacing.lg)
  }
}

@Component
struct UnitButton {
  @Prop marker: string
  @Link active: string

  private buttonText(): string {
    if (this.marker === 'Temperature') {
      return 'Temper\nature'
    }
    return this.marker
  }

  private buttonWidth(): number {
    if (this.marker === 'Temperature') {
      return 82
    }
    if (this.marker === 'Speed') {
      return 75
    }
    return 78
  }

  private buttonHeight(): number {
    if (this.marker === 'Temperature') {
      return 49
    }
    return 34
  }

  build() {
    Text(this.buttonText())
      .width(this.buttonWidth())
      .height(this.buttonHeight())
      .fontSize(AppTypography.title)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.active === this.marker ? AppColors.onPrimary : AppColors.onSurface)
      .textAlign(TextAlign.Center)
      .lineHeight(17)
      .backgroundColor(this.active === this.marker ? AppColors.primary : AppColors.surfaceVariant)
      .borderRadius(AppShapes.small)
      .onClick(() => {
        this.active = this.marker
      })
  }
}

@Entry
@Component
struct RootScreen {
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed']
  @State active: string = 'Length'

  build() {
    Column({ space: AppSpacing.lg }) {
      Text('Unit Converter')
        .fontSize(AppTypography.display)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)

      MapArea({ selected: this.active })

      ForEach(this.markers, (marker: string) => {
        MarkerBox({
          unit: marker,
          value: 'Tap to convert',
          active: this.active === marker
        })
      }, (marker: string) => marker)

      Blank()
        .height(AppSpacing.md)

      Row({ space: AppSpacing.md }) {
        ForEach(this.markers, (marker: string) => {
          UnitButton({
            marker: marker,
            active: $active
          })
        }, (marker: string) => marker)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppColors.secondary15, 0.0],
        [AppColors.primary15, 1.0]
      ]
    })
  }
}