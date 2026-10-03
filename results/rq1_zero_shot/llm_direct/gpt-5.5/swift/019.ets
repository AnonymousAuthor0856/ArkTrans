class AppColors {
  static readonly primary: ResourceColor = '#8B5CF6';
  static readonly secondary: ResourceColor = '#D946EF';
  static readonly tertiary: ResourceColor = '#3B82F6';
  static readonly background: ResourceColor = '#F9F5FF';
  static readonly surface: ResourceColor = '#FFFFFF';
  static readonly surfaceVariant: ResourceColor = '#F1E9FE';
  static readonly outline: ResourceColor = '#E3D7FE';
  static readonly success: ResourceColor = '#22C55E';
  static readonly warning: ResourceColor = '#FACC15';
  static readonly error: ResourceColor = '#EF4444';
  static readonly onPrimary: ResourceColor = '#FFFFFF';
  static readonly onSecondary: ResourceColor = '#FFFFFF';
  static readonly onTertiary: ResourceColor = '#FFFFFF';
  static readonly onBackground: ResourceColor = '#1E1E1E';
  static readonly onSurface: ResourceColor = '#1E1E1E';
}

class FontSpec {
  size: number;
  weight: FontWeight;

  constructor(size: number, weight: FontWeight) {
    this.size = size;
    this.weight = weight;
  }
}

class TypographyTokens {
  static readonly display: FontSpec = new FontSpec(48, FontWeight.Bold);
  static readonly title: FontSpec = new FontSpec(18, FontWeight.Medium);
  static readonly body: FontSpec = new FontSpec(14, FontWeight.Regular);
  static readonly label: FontSpec = new FontSpec(42, FontWeight.Medium);
}

class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 14;
  static readonly large: number = 22;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class ShadowSpec {
  elevation: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(4, 2, 0.14);
  static readonly level2: ShadowSpec = new ShadowSpec(8, 6, 0.18);
}

@Entry
@Component
struct RootScreen {
  @State private fontSize: number = 23.0;
  @State private syncProgress: number = 0.3;

  build() {
    Column() {
      Row() {
        Text('Subtitle Editor')
          .fontSize(TypographyTokens.title.size)
          .fontWeight(TypographyTokens.title.weight)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.xl }) {
        Column() {
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(200)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
        .shadow({
          radius: ElevationMapping.level2.elevation,
          color: 'rgba(0, 0, 0, 0.18)',
          offsetX: 0,
          offsetY: ElevationMapping.level2.dy
        })

        Text(`Font Size: ${Math.trunc(this.fontSize)}sp`)
          .fontSize(TypographyTokens.body.size)
          .fontWeight(TypographyTokens.body.weight)
          .fontColor(AppColors.onSurface)

        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .selectedColor(AppColors.primary)
          .trackColor(AppColors.surfaceVariant)
          .blockColor(AppColors.primary)
          .onChange((value: number) => {
            this.fontSize = value;
          })

        Text('Sync Progress')
          .fontSize(TypographyTokens.body.size)
          .fontWeight(TypographyTokens.body.weight)
          .fontColor(AppColors.onSurface)

        Progress({
          value: this.syncProgress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(6)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(3)

        Row({ space: AppSpacing.md }) {
          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('Sync +')
              .fontSize(TypographyTokens.title.size)
              .fontWeight(TypographyTokens.title.weight)
              .fontColor(AppColors.onPrimary)
          }
          .height(48)
          .layoutWeight(1)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
          .onClick(() => {
            this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0);
          })

          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('Sync -')
              .fontSize(TypographyTokens.title.size)
              .fontWeight(TypographyTokens.title.weight)
              .fontColor(AppColors.onSecondary)
          }
          .height(48)
          .layoutWeight(1)
          .backgroundColor(AppColors.secondary)
          .borderRadius(AppShapes.medium)
          .onClick(() => {
            this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0);
          })
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: AppSpacing.lg + 50
      })
      .linearGradient({
        direction: GradientDirection.Bottom,
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