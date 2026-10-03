/*
 * 033TransferWizarden — Finance / Warm Gradient / en / 720x1280
 */

const NAME: string = '033TransferWizarden';
const UI_TYPE: string = 'Finance';
const STYLE_THEME: string = 'Warm Gradient';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#FFA500';
  static readonly primarySoft: string = '#33FFA500';
  static readonly secondary: string = '#FFC300';
  static readonly secondarySoft: string = '#33FFC300';
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

class AppTypography {
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

@Entry
@Component
struct TransferWizardScreen {
  @State progress: number = 0.4;
  private markerX: number = -55;
  private markerY: number = -63;

  private step(delta: number): void {
    const next: number = Math.round((this.progress + delta) * 10) / 10;
    if (next > 1) {
      this.progress = 1;
    } else if (next < 0) {
      this.progress = 0;
    } else {
      this.progress = next;
    }
  }

  @Builder
  ProgressTrack() {
    Row() {
      Stack({ alignContent: Alignment.Start }) {
        Row() {
        }
        .width('100%')
        .height(8)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(4)

        Row() {
        }
        .width(`${Math.round(this.progress * 100)}%`)
        .height(8)
        .backgroundColor(AppColors.primary)
        .borderRadius(4)
      }
      .layoutWeight(1)
      .height(8)

      Circle({ width: 6, height: 6 })
        .fill(AppColors.primary)
        .margin({ left: AppSpacing.sm })
    }
    .width('80%')
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      // ---- CenterAlignedTopAppBar ----
      Row() {
        Text('Transfer Wizard')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.background)

      // ---- Body ----
      Stack() {
        Column() {
          Stack({ alignContent: Alignment.Center }) {
            Circle({ width: 260, height: 260 })
              .fill(AppColors.surfaceVariant)

            Circle({ width: 20, height: 20 })
              .fill(AppColors.primary)
              .offset({ x: this.markerX, y: this.markerY })
          }
          .width('100%')
          .layoutWeight(1)

          Column({ space: AppSpacing.lg }) {
            Text('Transfer Progress')
              .fontSize(AppTypography.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)

            this.ProgressTrack()

            Row({ space: AppSpacing.md }) {
              Button('+')
                .type(ButtonType.Normal)
                .width(60)
                .height(40)
                .borderRadius(20)
                .backgroundColor(AppColors.primary)
                .fontColor(AppColors.onPrimary)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .onClick(() => {
                  this.step(0.1);
                })

              Button('-')
                .type(ButtonType.Normal)
                .width(60)
                .height(40)
                .borderRadius(20)
                .backgroundColor(AppColors.secondary)
                .fontColor(AppColors.onSecondary)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .onClick(() => {
                  this.step(-0.1);
                })
            }
          }
          .width('100%')
          .padding({ bottom: AppSpacing.xxl })
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.secondarySoft, 0.0],
          [AppColors.background, 0.5],
          [AppColors.primarySoft, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}