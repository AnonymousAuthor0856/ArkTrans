class AppColors {
  static primary: string = '#2563EB'
  static secondary: string = '#38BDF8'
  static tertiary: string = '#60A5FA'
  static background: string = '#F8FAFC'
  static surface: string = '#FFFFFF'
  static surfaceVariant: string = '#E2E8F0'
  static outline: string = '#CBD5E1'
  static onPrimary: string = '#FFFFFF'
  static onSecondary: string = '#0F172A'
  static onTertiary: string = '#FFFFFF'
  static onBackground: string = '#0F172A'
  static onSurface: string = '#1E293B'
}

class AppSpacing {
  static sm: number = 6
  static md: number = 10
  static lg: number = 14
  static xl: number = 20
  static buttonContentHorizontal: number = 16
  static buttonContentVertical: number = 8
}

class AppShape {
  static small: number = 6
  static medium: number = 10
  static large: number = 14
}

@Entry
@Component
struct Index {
  @State active: string = 'Length'
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed']

  @Builder
  MarkerBox(unit: string) {
    Column() {
      Text(unit)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
      Text('Tap to convert')
        .fontSize(12)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(80)
    .padding(AppSpacing.md)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.active === unit ? '#4D38BDF8' : AppColors.surface)
    .border({ width: 1, color: AppColors.outline, radius: AppShape.medium })
    .onClick(() => {
      this.active = unit
    })
  }

  @Builder
  MapArea() {
    Column({ space: AppSpacing.md }) {
      Text('Unit Map Visualization')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
      Text('Active Unit: ' + this.active)
        .fontSize(12)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(240)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surfaceVariant)
    .border({ width: 1, color: AppColors.outline, radius: AppShape.large })
  }

  @Builder
  UnitButton(marker: string) {
    Button(marker)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.active === marker ? AppColors.onPrimary : AppColors.onSurface)
      .padding({ left: AppSpacing.buttonContentHorizontal, right: AppSpacing.buttonContentHorizontal, top: AppSpacing.buttonContentVertical, bottom: AppSpacing.buttonContentVertical })
      .backgroundColor(this.active === marker ? AppColors.primary : AppColors.surfaceVariant)
      .borderRadius(AppShape.small)
      .onClick(() => {
        this.active = marker
      })
  }

  build() {
    Column({ space: AppSpacing.lg }) {
      Text('Unit Converter')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)

      this.MapArea()

      ForEach(this.markers, (marker: string) => {
        this.MarkerBox(marker)
      })

      Blank()
        .height(AppSpacing.md)

      Row({ space: AppSpacing.md }) {
        ForEach(this.markers, (marker: string) => {
          this.UnitButton(marker)
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .linearGradient({
      angle: 180,
      colors: [['#2638BDF8', 0.0], ['#262563EB', 1.0]]
    })
  }
}
