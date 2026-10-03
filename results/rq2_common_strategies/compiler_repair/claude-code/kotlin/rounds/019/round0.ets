import promptAction from '@ohos.promptAction';

class AppTokens {
  static readonly Colors = class {
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
  };

  static readonly Spacing = class {
    static readonly xs: Length = 4;
    static readonly sm: Length = 8;
    static readonly md: Length = 12;
    static readonly lg: Length = 16;
    static readonly xl: Length = 24;
    static readonly xxl: Length = 32;
  };

  static readonly Shapes = class {
    static readonly small: Length = 8;
    static readonly medium: Length = 14;
    static readonly large: Length = 22;
  };

  static readonly Elevation = class {
    static readonly level1Radius: Length = 8;
    static readonly level1Y: Length = 2;
    static readonly level2Radius: Length = 12;
    static readonly level2Y: Length = 6;
  };
}

@Entry
@Component
struct SubtitleEditorPage {
  @State fontSize: number = 24;
  @State syncProgress: number = 0.3;

  build() {
    Column() {
      // Top bar
      Row() {
        Text('Subtitle Editor')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      Column() {
        // Subtitle preview surface
        Stack() {
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.Elevation.level2Radius,
          color: 'rgba(0, 0, 0, 0.18)',
          offsetY: AppTokens.Elevation.level2Y
        })

        Text(`Font Size: ${Math.round(this.fontSize)}sp`)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.lg })

        // Font size slider
        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          step: 1,
          style: SliderStyle.OutSet
        })
          .blockColor(AppTokens.Colors.secondary)
          .selectedColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .width('100%')
          .onChange((value: number) => {
            this.fontSize = value;
          })

        Text('Sync Progress')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.lg })

        // Sync progress indicator
        Progress({ value: this.syncProgress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(3)

        // Sync buttons row
        Row() {
          Button('Sync +', { type: ButtonType.Normal })
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0);
            })

          Button('Sync -', { type: ButtonType.Normal })
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.medium)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0);
            })
        }
        .width('100%')
        .margin({ top: AppTokens.Spacing.lg })
        .gap(AppTokens.Spacing.md)
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.LinearTB,
        colors: [
          [AppTokens.Colors.surfaceVariant, 0.0],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.surface, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
