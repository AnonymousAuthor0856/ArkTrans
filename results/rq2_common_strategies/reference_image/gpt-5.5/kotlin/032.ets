const NAME: string = '033TransferWizarden';
const UI_TYPE: string = 'Finance';
const STYLE_THEME: string = 'Warm Gradient';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#FFA500';
  static readonly secondary: string = '#FFC300';
  static readonly tertiary: string = '#FFE066';
  static readonly background: string = '#FFFBF2';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFEED6';
  static readonly outline: string = '#F1C27D';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#1E1E1E';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
}

class AppTypographyTokens {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.16);
}

@Entry
@Component
struct Index {
  @State private progress: number = 0.4;
  @State private markerX: number = 114;
  @State private markerY: number = 214;

  @Builder
  private ProgressIndicator() {
    Stack({ alignContent: Alignment.Start }) {
      Blank()
        .width('100%')
        .height(8)
        .borderRadius(4)
        .backgroundColor(AppColors.surfaceVariant)

      Blank()
        .width(`${this.progress * 100}%`)
        .height(8)
        .borderRadius(4)
        .backgroundColor(AppColors.primary)

      Blank()
        .width(4)
        .height(4)
        .borderRadius(2)
        .backgroundColor(AppColors.primary)
        .align(Alignment.End)
    }
    .width('80%')
    .height(8)
  }

  build() {
    Column() {
      Row() {
        Text('Transfer Wizard')
          .fontSize(AppTypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Stack({ alignContent: Alignment.Center }) {
        Blank()
          .width(260)
          .height(260)
          .borderRadius(130)
          .backgroundColor(AppColors.surfaceVariant)

        Blank()
          .width(20)
          .height(20)
          .borderRadius(10)
          .backgroundColor(AppColors.primary)
          .position({
            x: this.markerX,
            y: this.markerY
          })

        Column({ space: AppSpacing.lg }) {
          Text('Transfer Progress')
            .fontSize(AppTypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          this.ProgressIndicator()

          Row({ space: AppSpacing.md }) {
            Button('+', { type: ButtonType.Capsule, stateEffect: true })
              .width(58)
              .height(40)
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onPrimary)
              .backgroundColor(AppColors.primary)
              .onClick(() => {
                this.progress = Math.min(1, this.progress + 0.1);
              })

            Button('-', { type: ButtonType.Capsule, stateEffect: true })
              .width(58)
              .height(40)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onSecondary)
              .backgroundColor(AppColors.secondary)
              .onClick(() => {
                this.progress = Math.max(0, this.progress - 0.1);
              })
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .align(Alignment.Bottom)
        .margin({ bottom: AppSpacing.xxl })
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#33FFC300', 0.0],
          [AppColors.background, 0.48],
          ['#33FFA500', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}