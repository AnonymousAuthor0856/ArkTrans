const NAME: string = '093_UnitConverter_en'
const UI_TYPE: string = 'Tools Messenger'
const STYLE_THEME: string = 'Modern Blue'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class AppColors {
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
  static readonly secondaryAlpha15: string = '#2638BDF8'
  static readonly primaryAlpha15: string = '#262563EB'
  static readonly secondaryAlpha30: string = '#4D38BDF8'
}

class AppTypography {
  static readonly displaySize: number = 24
  static readonly headlineSize: number = 18
  static readonly titleSize: number = 14
  static readonly bodySize: number = 12
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
}

@Component
struct MarkerBox {
  @Prop unit: string
  @Prop value: string
  @Prop active: boolean

  build() {
    Column() {
      Text(this.unit)
        .fontSize(AppTypography.headlineSize)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)

      Text(this.value)
        .fontSize(AppTypography.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(80)
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.active ? AppColors.secondaryAlpha30 : AppColors.surface)
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
      Text('Unit Map Visualization')
        .fontSize(AppTypography.headlineSize)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)

      Blank()
        .height(AppSpacing.md)

      Text(`Active Unit: ${this.selected}`)
        .fontSize(AppTypography.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(240)
    .padding(AppSpacing.lg)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surfaceVariant)
    .border({
      width: 1,
      color: AppColors.outline,
      radius: AppShapes.large
    })
  }
}

@Component
struct RootScreen {
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed']
  @State active: string = 'Length'

  build() {
    Column({ space: AppSpacing.lg }) {
      Text('Unit Converter')
        .fontSize(AppTypography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)

      MapArea({ selected: this.active })

      ForEach(this.markers, (item: string) => {
        MarkerBox({
          unit: item,
          value: 'Tap to convert',
          active: this.active === item
        })
      }, (item: string) => item)

      Blank()
        .height(AppSpacing.md)

      Row({ space: AppSpacing.md }) {
        ForEach(this.markers, (item: string) => {
          Button() {
            Text(item)
              .fontSize(AppTypography.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.active === item ? AppColors.onPrimary : AppColors.onSurface)
          }
          .backgroundColor(this.active === item ? AppColors.primary : AppColors.surfaceVariant)
          .borderRadius(AppShapes.medium)
          .onClick(() => {
            this.active = item
          })
        }, (item: string) => item)
      }
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppColors.secondaryAlpha15, 0.0],
        [AppColors.primaryAlpha15, 1.0]
      ]
    })
  }
}

@Entry
@Component
struct MainActivity {
  build() {
    Stack() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}