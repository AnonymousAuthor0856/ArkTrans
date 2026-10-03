/*
 * 093_UnitConverter_en
 * UI_TYPE: Tools Messenger | STYLE_THEME: Modern Blue | LANG: en | BASELINE_SIZE: 720x1280
 * HarmonyOS ArkTS (Stage model, API 11+)
 *
 * Full-screen immersive mode (equivalent to WindowCompat.setDecorFitsSystemWindows +
 * WindowInsetsControllerCompat.hide(...)) — put inside EntryAbility.onWindowStageCreate:
 *
 *   windowStage.getMainWindow().then((win: window.Window) => {
 *     win.setWindowLayoutFullScreen(true);
 *     win.setWindowSystemBarEnable([]);
 *   });
 */

const NAME: string = '093_UnitConverter_en';
const UI_TYPE: string = 'Tools Messenger';
const STYLE_THEME: string = 'Modern Blue';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#2563EB';
  static readonly secondary: string = '#38BDF8';
  static readonly tertiary: string = '#60A5FA';
  static readonly background: string = '#F8FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#CBD5E1';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#0F172A';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#1E293B';
  // secondary @ 30% alpha (Kotlin: secondary.copy(alpha = 0.3f))
  static readonly secondaryAlpha30: string = '#4D38BDF8';
  // secondary @ 15% alpha — gradient stop
  static readonly secondaryAlpha15: string = '#2638BDF8';
  // primary @ 15% alpha — gradient stop
  static readonly primaryAlpha15: string = '#262563EB';
}

class AppTypography {
  static readonly displaySize: number = 24;
  static readonly displayWeight: number = 700;
  static readonly headlineSize: number = 18;
  static readonly headlineWeight: number = 600;
  static readonly titleSize: number = 14;
  static readonly titleWeight: number = 500;
  static readonly bodySize: number = 12;
  static readonly bodyWeight: number = 400;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 20;
}

@Component
struct MarkerBox {
  @Prop unit: string = '';
  @Prop value: string = '';
  @Prop active: boolean = false;
  onTap: (unit: string) => void = () => {};

  build() {
    Column() {
      Text(this.unit)
        .fontSize(AppTypography.headlineSize)
        .fontWeight(AppTypography.headlineWeight)
        .fontColor(AppColors.onSurface)
      Text(this.value)
        .fontSize(AppTypography.bodySize)
        .fontWeight(AppTypography.bodyWeight)
        .fontColor(AppColors.onSurface)
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height(80)
    .padding(AppSpacing.md)
    .backgroundColor(this.active ? AppColors.secondaryAlpha30 : AppColors.surface)
    .borderRadius(AppShapes.medium)
    .border({ width: 1, color: AppColors.outline, radius: AppShapes.medium })
    .onClick(() => {
      this.onTap(this.unit);
    })
  }
}

@Component
struct MapArea {
  @Prop selected: string = '';

  build() {
    Column() {
      Text('Unit Map Visualization')
        .fontSize(AppTypography.headlineSize)
        .fontWeight(AppTypography.headlineWeight)
        .fontColor(AppColors.onSurface)
      Text(`Active Unit: ${this.selected}`)
        .fontSize(AppTypography.bodySize)
        .fontWeight(AppTypography.bodyWeight)
        .fontColor(AppColors.onSurface)
        .margin({ top: AppSpacing.md })
    }
    .width('100%')
    .height(240)
    .padding(AppSpacing.lg)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.large)
    .border({ width: 1, color: AppColors.outline, radius: AppShapes.large })
  }
}

@Entry
@Component
struct RootScreen {
  @State active: string = 'Length';
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed'];

  build() {
    Column({ space: AppSpacing.lg }) {
      Text('Unit Converter')
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(AppColors.onBackground)

      MapArea({ selected: this.active })

      ForEach(this.markers, (item: string) => {
        MarkerBox({
          unit: item,
          value: 'Tap to convert',
          active: this.active === item,
          onTap: (unit: string) => {
            this.active = unit;
          }
        })
      }, (item: string) => item)

      // Spacer(Modifier.height(AppTokens.Spacing.md))
      Row()
        .width('100%')
        .height(AppSpacing.md)

      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
        ForEach(this.markers, (item: string) => {
          Button(item)
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(this.active === item ? AppColors.onPrimary : AppColors.onSurface)
            .backgroundColor(this.active === item ? AppColors.primary : AppColors.surfaceVariant)
            .borderRadius(AppShapes.small)
            .height(36)
            .padding({ left: AppSpacing.md, right: AppSpacing.md })
            .margin(AppSpacing.md / 2)
            .onClick(() => {
              this.active = item;
            })
        }, (item: string) => item)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      angle: 180,
      colors: [[AppColors.secondaryAlpha15, 0.0], [AppColors.primaryAlpha15, 1.0]]
    })
  }
}