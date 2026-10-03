const NAME: string = "093_UnitConverter_en";
const UI_TYPE: string = "Tools Messenger";
const STYLE_THEME: string = "Modern Blue";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  static readonly primary: string = '#2563EB';
  static readonly secondary: string = '#38BDF8';
  static readonly background: string = '#F8FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#CBD5E1';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSurface: string = '#1E293B';
  static readonly onBackground: string = '#0F172A';
}

class AppSpacing {
  static readonly md: number = 10;
  static readonly lg: number = 14;
}

@Entry
@Component
struct MainActivity {
  @State active: string = 'Length';
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed'];

  @Builder
  MarkerBox(unit: string) {
    Column() {
      Text(unit)
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
      Text('Tap to convert')
        .fontSize(12)
        .fontColor(AppColors.onSurface)
        .opacity(0.78)
        .margin({ top: 4 })
    }
    .width('100%')
    .height(80)
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.active === unit ? '#4D38BDF8' : AppColors.surface)
    .borderRadius(10)
    .border({ width: 1, color: AppColors.outline })
    .onClick(() => {
      this.active = unit;
    })
  }

  @Builder
  MapArea() {
    Column({ space: AppSpacing.md }) {
      Text('Unit Map Visualization')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
      Text(`Active Unit: ${this.active}`)
        .fontSize(12)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(240)
    .padding(AppSpacing.lg)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(14)
    .border({ width: 1, color: AppColors.outline })
  }

  build() {
    Scroll() {
      Column({ space: AppSpacing.lg }) {
        Text('Unit Converter')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)

        this.MapArea()

        ForEach(this.markers, (unit: string) => {
          this.MarkerBox(unit)
        })

        Row({ space: AppSpacing.md }) {
          ForEach(this.markers, (unit: string) => {
            Button(unit)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.active === unit ? AppColors.onPrimary : AppColors.onSurface)
              .height(40)
              .padding({ left: 10, right: 10 })
              .backgroundColor(this.active === unit ? AppColors.primary : AppColors.surfaceVariant)
              .borderRadius(10)
              .onClick(() => {
                this.active = unit;
              })
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .linearGradient({
      angle: 180,
      colors: [['#2638BDF8', 0.0], ['#262563EB', 1.0]]
    })
    .scrollBar(BarState.Off)
  }
}
