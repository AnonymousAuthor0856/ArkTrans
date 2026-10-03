// ============================================================================
// Index.ets
// ArkTS (HarmonyOS / OpenHarmony) port of the SwiftUI "Bill Calendar" screen.
// Register this file as a page in  entry/src/main/resources/base/profile/main_pages.json
// ("src": ["pages/Index"]) and point "srcEntry" of the UIAbility at it.
// ============================================================================

// ----------------------------------------------------------------------------
// MARK: - AppTokens
// ----------------------------------------------------------------------------

class AppColors {
  static readonly primary: string = '#06B6D4';
  static readonly secondary: string = '#3B82F6';
  static readonly tertiary: string = '#8B5CF6';
  static readonly background: string = '#F0F9FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E0F2FE';
  static readonly outline: string = '#BAE6FD';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#FACC15';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#0F172A';

  // Alpha variants used by the gradient / translucent card.
  // ArkTS colors are '#AARRGGBB' — the leading pair is opacity.
  static readonly secondary30: string = '#4D3B82F6'; // secondary @ 0.3
  static readonly primary20: string = '#3306B6D4';   // primary   @ 0.2
  static readonly surface90: string = '#E6FFFFFF';   // surface   @ 0.9
}

class AppTypography {
  // Kotlin: displayLarge = 28.sp / Bold
  static readonly displaySize: number = 28;
  // Kotlin: titleMedium = 18.sp / Medium
  static readonly titleSize: number = 18;
  // Kotlin: bodyMedium = 14.sp / Normal
  static readonly bodySize: number = 14;
  // Kotlin: labelMedium = 12.sp / Medium
  static readonly labelSize: number = 12;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 12;
  static readonly large: number = 20;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

// Compose ShadowSpec -> ArkUI ShadowOptions
class AppElevation {
  static readonly level1Blur: number = 4;
  static readonly level1Dy: number = 2;
  static readonly level1Color: string = '#1F000000'; // black @ ~0.12

  static readonly level2Blur: number = 8;
  static readonly level2Dy: number = 4;
  static readonly level2Color: string = '#2E000000'; // black @ ~0.18
}

// ----------------------------------------------------------------------------
// MARK: - Helpers
// ----------------------------------------------------------------------------

/** Mirrors Android's NumberFormat thousands separators for the "$1,000" label. */
function formatUsd(value: number): string {
  const rounded: number = Math.round(value);
  const digits: string = rounded.toString();
  let grouped: string = '';
  let count: number = 0;
  for (let i: number = digits.length - 1; i >= 0; i--) {
    grouped = digits.charAt(i) + grouped;
    count++;
    if (count % 3 === 0 && i > 0) {
      grouped = ',' + grouped;
    }
  }
  return '$' + grouped;
}

// ----------------------------------------------------------------------------
// MARK: - RootScreen
// ----------------------------------------------------------------------------

@Entry
@Component
struct RootScreen {
  // Kotlin: mutableFloatStateOf(500f)
  @State spending: number = 500;
  private goal: number = 1000;

  build() {
    Column() {
      // ---- CenterAlignedTopAppBar ----
      Column() {
        Text('Bill Calendar')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.background)

      // ---- Content area (Scaffold body) ----
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          // ---- Surface card ----
          Column() {
            Text('Current Spending')
              .fontSize(AppTypography.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.primary)

            Text(`${formatUsd(this.spending)} / ${formatUsd(this.goal)}`)
              .fontSize(AppTypography.displaySize)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onSurface)

            Progress({
              value: this.spending,
              total: this.goal,
              type: ProgressType.Linear
            })
              .style({ strokeWidth: 8 })
              .color(AppColors.primary)
              .backgroundColor(AppColors.surfaceVariant)
              .width('100%')
              .height(8)
          }
          .width('100%')
          .height(160)
          .padding(AppSpacing.lg)
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.SpaceBetween)
          .backgroundColor(AppColors.surface90)
          .borderRadius(AppShapes.large)
          .shadow({
            radius: AppElevation.level2Blur,
            color: AppElevation.level2Color,
            offsetX: 0,
            offsetY: AppElevation.level2Dy
          })

          // ---- Section title ----
          Text('Adjust Spending')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          // ---- Slider ----
          Slider({
            value: this.spending,
            min: 0,
            max: 2000,
            step: 1,
            style: SliderStyle.OutSet,
            direction: Axis.Horizontal,
            reverse: false
          })
            .width('100%')
            .selectedColor(AppColors.primary)
            .trackColor(AppColors.surfaceVariant)
            .blockColor(AppColors.secondary)
            .onChange((value: number, mode: SliderChangeMode) => {
              this.spending = value;
            })

          // ---- Filled button ----
          Button('Reset', { type: ButtonType.Normal, stateEffect: true })
            .width('100%')
            .height(48)
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onTertiary)
            .backgroundColor(AppColors.tertiary)
            .borderRadius(AppShapes.medium)
            .onClick(() => {
              this.spending = 0;
            })
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      // Brush.verticalGradient(secondary@0.3 -> background -> primary@0.2)
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.secondary30, 0.0],
          [AppColors.background, 0.5],
          [AppColors.primary20, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}