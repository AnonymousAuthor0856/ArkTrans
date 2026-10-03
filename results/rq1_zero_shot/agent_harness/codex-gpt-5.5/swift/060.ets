class AppColors {
  static primary: string = '#2563EB';
  static secondary: string = '#38BDF8';
  static tertiary: string = '#60A5FA';
  static background: string = '#F8FAFC';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E2E8F0';
  static outline: string = '#CBD5E1';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#0F172A';
  static onTertiary: string = '#FFFFFF';
  static onBackground: string = '#0F172A';
  static onSurface: string = '#1E293B';
}

class AppSpacing {
  static sm: number = 6;
  static md: number = 10;
  static lg: number = 14;
  static xl: number = 20;
  static buttonContentHorizontal: number = 16;
  static buttonContentVertical: number = 8;
}

@Entry
@Component
struct RootScreen {
  @State private active: string = 'Length';
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed'];

  @Builder
  private MarkerBox(unit: string, value: string, active: boolean) {
    Column() {
      Text(unit)
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
      Text(value)
        .fontSize(12)
        .fontColor(AppColors.onSurface)
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .padding(AppSpacing.md)
    .width('100%')
    .height(80)
    .backgroundColor(active ? '#38BDF84D' : AppColors.surface)
    .borderRadius(10)
    .border({ width: 1, color: AppColors.outline })
  }

  @Builder
  private MapArea(selected: string) {
    Column({ space: AppSpacing.md }) {
      Text('Unit Map Visualization')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
      Text(`Active Unit: ${selected}`)
        .fontSize(12)
        .fontColor(AppColors.onSurface)
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height(240)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(14)
    .border({ width: 1, color: AppColors.outline })
    .padding(AppSpacing.lg)
  }

  @Builder
  private UnitButton(marker: string) {
    Text(marker)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.active === marker ? AppColors.onPrimary : AppColors.onSurface)
      .padding({ left: AppSpacing.buttonContentHorizontal, right: AppSpacing.buttonContentHorizontal, top: AppSpacing.buttonContentVertical, bottom: AppSpacing.buttonContentVertical })
      .backgroundColor(this.active === marker ? AppColors.primary : AppColors.surfaceVariant)
      .borderRadius(6)
      .onClick(() => {
        this.active = marker;
      })
  }

  build() {
    Column({ space: AppSpacing.lg }) {
      Text('Unit Converter')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)

      this.MapArea(this.active)

      ForEach(this.markers, (marker: string) => {
        this.MarkerBox(marker, 'Tap to convert', this.active === marker)
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
    .padding(AppSpacing.lg)
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
