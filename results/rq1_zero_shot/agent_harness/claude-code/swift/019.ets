import prompt from '@ohos.promptAction';

// Design tokens for colors, typography, shapes, spacing, and elevation
class AppTokens {
  static class Colors {
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

  static class Spacing {
    static readonly xs: Length = 4;
    static readonly sm: Length = 8;
    static readonly md: Length = 12;
    static readonly lg: Length = 16;
    static readonly xl: Length = 24;
    static readonly xxl: Length = 32;
  }

  static class Shapes {
    static readonly small: Length = 8;
    static readonly medium: Length = 14;
    static readonly large: Length = 22;
  }

  static class ElevationMapping {
    static readonly level1 = { radius: 4, y: 2, opacity: 0.14 };
    static readonly level2 = { radius: 8, y: 6, opacity: 0.18 };
  }
}

// Display size enum for typography
class TypographyTokens {
  // Display: size 48, bold
  static setDisplayStyle(t: TextAttribute): void {
    t.fontSize(48).fontWeight(FontWeight.Bold);
  }
  // Title: size 18, medium
  static setTitleStyle(t: TextAttribute): void {
    t.fontSize(18).fontWeight(FontWeight.Medium);
  }
  // Body: size 14, regular
  static setBodyStyle(t: TextAttribute): void {
    t.fontSize(14).fontWeight(FontWeight.Regular);
  }
  // Label: size 42, medium
  static setLabelStyle(t: TextAttribute): void {
    t.fontSize(42).fontWeight(FontWeight.Medium);
  }
}

@Entry
@Component
struct SubtitleEditorPage {
  @State fontSize: number = 23.0;
  @State syncProgress: number = 0.3;

  build() {
    Navigation() {
      Column({ space: AppTokens.Spacing.xl }) {
        // Sample Subtitle Line display surface
        Text('Sample Subtitle Line')
          .fontSize(this.fontSize)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')
          .height(200)
          .textAlign(TextAlign.Center)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level2.radius,
            color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level2.y
          });

        Text(`Font Size: ${Math.floor(this.fontSize)}sp`)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%');

        // Font size slider
        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          step: 1,
          style: SliderStyle.OutSet
        })
          .blockColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .selectedColor(AppTokens.Colors.primary)
          .width('100%')
          .onChange((value: number) => {
            this.fontSize = value;
          });

        Text('Sync Progress')
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%');

        // Linear progress indicator
        Progress({
          value: this.syncProgress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .height(6)
          .width('100%');

        // Sync buttons row
        Row({ space: AppTokens.Spacing.md }) {
          Button('Sync +') {
            Text('Sync +')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onPrimary)
          }
            .type(ButtonType.Normal)
            .height(48)
            .layoutWeight(1)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0);
            });

          Button('Sync -') {
            Text('Sync -')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSecondary)
          }
            .type(ButtonType.Normal)
            .height(48)
            .layoutWeight(1)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0);
            });
        }
        .width('100%');
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .height('100%')
      .linearGradient({
        colors: [
          [AppTokens.Colors.surfaceVariant as string, 0],
          [AppTokens.Colors.background as string, 0.5],
          [AppTokens.Colors.surface as string, 1]
        ],
        direction: GradientDirection.Bottom
      })
      .padding({ bottom: 50 });
    }
    .title('Subtitle Editor')
    .titleMode(NavigationTitleMode.Mini)
    .backgroundColor(AppTokens.Colors.background)
    .hideToolBar(true)
    .hideBackButton(true)
    .width('100%')
    .height('100%');
  }
}
