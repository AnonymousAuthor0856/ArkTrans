// Index.ets  —  ArkTS conversion of the SwiftUI "Subtitle Editor" screen

// MARK: - AppTokens
class AppColors {
  static readonly primary: string = '#8B5CF6';
  static readonly secondary: string = '#D946EF';
  static readonly tertiary: string = '#3B82F6';
  static readonly background: string = '#F9F5FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F1E9FE';
  static readonly outline: string = '#E3D7FE';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#FACC15';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
}

class Typography {
  static readonly display: number = 48;
  static readonly title: number = 18;
  static readonly body: number = 14;
  static readonly label: number = 42;

  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class Shapes {
  static readonly small: number = 8;
  static readonly medium: number = 14;
  static readonly large: number = 22;
}

class Spacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

interface ShadowSpec {
  elevation: number; // blur radius
  dy: number;        // y offset
  opacity: number;   // shadow alpha
}

class Elevation {
  static readonly level1: ShadowSpec = { elevation: 4, dy: 2, opacity: 0.14 };
  static readonly level2: ShadowSpec = { elevation: 8, dy: 6, opacity: 0.18 };

  // ArkUI takes the alpha inside the color string (#AARRGGBB).
  static shadowColor(spec: ShadowSpec): string {
    const alpha = Math.round(spec.opacity * 255).toString(16).padStart(2, '0').toUpperCase();
    return `#${alpha}000000`;
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State fontSize: number = 23.0;
  @State syncProgress: number = 0.3;

  build() {
    Column() {
      // ---- TopAppBar ---------------------------------------------------
      Column() {
        Text('Subtitle Editor')
          .fontSize(Typography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.background)
      .border({ width: { bottom: 1 }, color: AppColors.outline })

      // ---- Body ---------------------------------------------------------
      Column({ space: Spacing.xl }) {

        // Surface card holding the sample subtitle line
        Stack() {
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppColors.surface)
        .borderRadius(Shapes.large)
        .shadow({
          radius: Elevation.level2.elevation,
          color: Elevation.shadowColor(Elevation.level2),
          offsetX: 0,
          offsetY: Elevation.level2.dy
        })

        Text(`Font Size: ${Math.round(this.fontSize)}sp`)
          .fontSize(Typography.body)
          .fontWeight(Typography.bodyWeight)
          .fontColor(AppColors.onSurface)

        // Font size slider
        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .blockColor(Color.White)
          .trackColor(AppColors.outline)
          .selectedColor(AppColors.primary)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.fontSize = value;
          })

        Text('Sync Progress')
          .fontSize(Typography.body)
          .fontWeight(Typography.bodyWeight)
          .fontColor(AppColors.onSurface)

        // LinearProgressIndicator equivalent
        Progress({
          value: this.syncProgress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(6)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .style({ strokeWidth: 6 })

        // Button row
        Row({ space: Spacing.md }) {
          Button('Sync +', { type: ButtonType.Normal })
            .layoutWeight(1)
            .height(48)
            .fontSize(Typography.title)
            .fontWeight(Typography.titleWeight)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(Shapes.medium)
            .onClick(() => {
              this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0);
            })

          Button('Sync -', { type: ButtonType.Normal })
            .layoutWeight(1)
            .height(48)
            .fontSize(Typography.title)
            .fontWeight(Typography.titleWeight)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(Shapes.medium)
            .onClick(() => {
              this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0);
            })
        }
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.lg, bottom: 50 })
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.surfaceVariant, 0.0],
          [AppColors.background, 0.5],
          [AppColors.surface, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}