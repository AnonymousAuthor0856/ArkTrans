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
  static readonly activeMarkerBg: ResourceColor = 'rgba(56, 189, 248, 0.30)'
  static readonly gradientTop: ResourceColor = 'rgba(56, 189, 248, 0.15)'
  static readonly gradientBottom: ResourceColor = 'rgba(37, 99, 235, 0.15)'
}

class AppSpacing {
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 14
  static readonly xl: number = 20
}

class AppRadius {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 14
}

@Component
struct MarkerBox {
  unit: string = ''
  value: string = ''
  active: boolean = false

  build() {
    Row() {
      Column() {
        Text(this.unit)
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)

        Text(this.value)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(80)
    .padding(AppSpacing.md)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(this.active ? AppColors.activeMarkerBg : AppColors.surface)
    .border({
      width: 1,
      color: AppColors.outline,
      radius: AppRadius.medium
    })
  }
}

@Component
struct MapArea {
  selected: string = 'Length'

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Unit Map Visualization')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)

      Text(`Active Unit: ${this.selected}`)
        .fontSize(12)
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
      radius: AppRadius.large
    })
  }
}

@Entry
@Component
struct Index {
  @State active: string = 'Length'
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed']

  build() {
    Column({ space: AppSpacing.lg }) {
      Text('Unit Converter')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .textAlign(TextAlign.Center)

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
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.active === item ? AppColors.onPrimary : AppColors.onSurface)
          }
          .height(40)
          .padding({ left: 14, right: 14 })
          .backgroundColor(this.active === item ? AppColors.primary : AppColors.surfaceVariant)
          .onClick(() => {
            this.active = item
          })
        }, (item: string) => item)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      angle: 180,
      colors: [
        [AppColors.gradientTop, 0.0],
        [AppColors.gradientBottom, 1.0]
      ]
    })
  }
}