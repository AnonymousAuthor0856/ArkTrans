// Design tokens for colors
class AppColors {
  static readonly primary: ResourceColor = '#FF8B5CF6';
  static readonly secondary: ResourceColor = '#FFD946EF';
  static readonly tertiary: ResourceColor = '#FF3B82F6';
  static readonly background: ResourceColor = '#FFF9F5FF';
  static readonly surface: ResourceColor = '#FFFFFFFF';
  static readonly surfaceVariant: ResourceColor = '#FFF1E9FE';
  static readonly outline: ResourceColor = '#FFE3D7FE';
  static readonly success: ResourceColor = '#FF22C55E';
  static readonly warning: ResourceColor = '#FFFACC15';
  static readonly error: ResourceColor = '#FFEF4444';
  static readonly onPrimary: ResourceColor = '#FFFFFFFF';
  static readonly onSecondary: ResourceColor = '#FFFFFFFF';
  static readonly onTertiary: ResourceColor = '#FFFFFFFF';
  static readonly onBackground: ResourceColor = '#FF1E1E1E';
  static readonly onSurface: ResourceColor = '#FF1E1E1E';
}

// Design tokens for spacing
class AppSpacing {
  static readonly xs: Length = 4;
  static readonly sm: Length = 8;
  static readonly md: Length = 12;
  static readonly lg: Length = 16;
  static readonly xl: Length = 24;
  static readonly xxl: Length = 32;
}

// Design tokens for shapes (corner radii)
class AppShapes {
  static readonly small: Length = 8;
  static readonly medium: Length = 14;
  static readonly large: Length = 22;
}

// Shadow specification interface
interface ShadowSpec {
  radius: number;
  y: number;
  opacity: number;
}

// Elevation mapping with shadow levels
class AppElevation {
  static readonly level1: ShadowSpec = { radius: 4, y: 2, opacity: 0.14 };
  static readonly level2: ShadowSpec = { radius: 8, y: 6, opacity: 0.18 };
}

// Typography token values
class TypographyTokens {
  static readonly displaySize: number = 48;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 42;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

@Entry
@Component
struct SubtitleEditorPage {
  @State fontSize: number = 23.0;
  @State syncProgress: number = 0.3;

  build() {
    Navigation() {
      Column({ space: AppSpacing.xl }) {
        // Sample Subtitle Line display surface
        Text('Sample Subtitle Line')
          .fontSize(this.fontSize)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .height(200)
          .textAlign(TextAlign.Center)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .shadow({
            radius: AppElevation.level2.radius,
            color: `rgba(0, 0, 0, ${AppElevation.level2.opacity})`,
            offsetX: 0,
            offsetY: AppElevation.level2.y
          });

        Text(`Font Size: ${Math.floor(this.fontSize)}sp`)
          .fontSize(TypographyTokens.bodySize)
          .fontWeight(TypographyTokens.bodyWeight)
          .fontColor(AppColors.onSurface)
          .width('100%');

        // Font size slider
        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          step: 1,
          style: SliderStyle.OutSet
        })
          .blockColor(AppColors.primary)
          .trackColor(AppColors.surfaceVariant)
          .selectedColor(AppColors.primary)
          .width('100%')
          .onChange((value: number) => {
            this.fontSize = value;
          });

        Text('Sync Progress')
          .fontSize(TypographyTokens.bodySize)
          .fontWeight(TypographyTokens.bodyWeight)
          .fontColor(AppColors.onSurface)
          .width('100%');

        // Linear progress indicator
        Progress({
          value: this.syncProgress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .height(6)
          .width('100%');

        // Sync buttons row
        Row({ space: AppSpacing.md }) {
          Button() {
            Text('Sync +')
              .fontSize(TypographyTokens.titleSize)
              .fontWeight(TypographyTokens.titleWeight)
              .fontColor(AppColors.onPrimary)
          }
            .type(ButtonType.Normal)
            .height(48)
            .layoutWeight(1)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.medium)
            .onClick(() => {
              this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0);
            });

          Button() {
            Text('Sync -')
              .fontSize(TypographyTokens.titleSize)
              .fontWeight(TypographyTokens.titleWeight)
              .fontColor(AppColors.onSecondary)
          }
            .type(ButtonType.Normal)
            .height(48)
            .layoutWeight(1)
            .backgroundColor(AppColors.secondary)
            .borderRadius(AppShapes.medium)
            .onClick(() => {
              this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0);
            });
        }
        .width('100%');
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .height('100%')
      .linearGradient({
        colors: [
          ['#FFF1E9FE', 0],
          ['#FFF9F5FF', 0.5],
          ['#FFFFFFFF', 1]
        ],
        direction: GradientDirection.Bottom
      })
      .padding({ bottom: 50 });
    }
    .title('Subtitle Editor')
    .titleMode(NavigationTitleMode.Mini)
    .backgroundColor(AppColors.background)
    .hideToolBar(true)
    .hideBackButton(true)
    .width('100%')
    .height('100%');
  }
}
