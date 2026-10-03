// ArkTS (HarmonyOS ArkUI) translation of the SwiftUI source.
// 'import SwiftUI' is not required: ArkUI declarative components are built in.

// MARK: - AppTokens
// 封装了应用程序的所有设计令牌，便于集中管理和修改。
class ColorTokens {
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

class TypographyTokens {
  // Compose的displayLarge对应SwiftUI的Font.system(size:weight:)
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  // Compose的titleMedium对应SwiftUI的Font.system(size:weight:)
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  // Compose的bodyMedium对应SwiftUI的Font.system(size:weight:)
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  // Compose的labelMedium对应SwiftUI的Font.system(size:weight:)
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class SpacingTokens {
  // Compose的dp单位直接映射为SwiftUI的CGFloat点单位
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

// ShadowSpec 和 ElevationMapping 在当前 UI 中未使用，但保留以备将来扩展
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

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.16);
}

// MARK: - CustomLinearProgressViewStyle
// 自定义 ProgressViewStyle 以精确匹配 Compose 的 LinearProgressIndicator 的颜色和高度。
@Component
struct CustomLinearProgressView {
  @Prop progressColor: string = '';
  @Prop trackColor: string = '';
  @Prop barHeight: number = 0;
  @Prop progressValue: number = 0;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // 轨道 (track)
      Row()
        .width('100%')
        .height(this.barHeight)
        .borderRadius(this.barHeight / 2)
        .backgroundColor(this.trackColor)

      // 填充 (progress)，根据进度值计算填充部分的宽度
      Row()
        .width(`${Math.round(this.progressValue * 100)}%`)
        .height(this.barHeight)
        .borderRadius(this.barHeight / 2)
        .backgroundColor(this.progressColor)
    }
    .width('100%')
    .height(this.barHeight)
  }
}

// MARK: - RootScreen
// 应用程序的主要 UI 视图，对应 Kotlin 的 RootScreen Composable。
@Component
struct RootScreen {
  // @State 变量对应 Kotlin 的 mutableStateOf，用于管理 UI 状态。
  // markerPosition 的初始值 (200f, 400f) 直接映射为两个坐标值，
  // 假设它们是 Canvas 内部坐标系中的点。
  @State markerX: number = 200;
  @State markerY: number = 400;
  @State progress: number = 0.4;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawCanvas(): void {
    const centerX = this.context.width / 2;
    const centerY = this.context.height / 2;

    // 绘制大背景圆，对应 Kotlin 的 drawCircle(radius = 260f)
    this.context.beginPath();
    this.context.arc(centerX, centerY, 260, 0, 2 * Math.PI);
    this.context.fillStyle = ColorTokens.surfaceVariant;
    this.context.fill();

    // 绘制标记圆，对应 Kotlin 的 drawCircle(radius = 20f, center = markerPosition)
    this.context.beginPath();
    this.context.arc(this.markerX, this.markerY, 20, 0, 2 * Math.PI);
    this.context.fillStyle = ColorTokens.primary;
    this.context.fill();
  }

  build() {
    Stack() {
      Column() {
        // 顶部栏，对应 Kotlin 的 CenterAlignedTopAppBar
        Stack() {
          Text('Transfer Wizard')
            .fontSize(TypographyTokens.displaySize)
            .fontWeight(TypographyTokens.displayWeight)
            .fontColor(ColorTokens.onSurface)
        }
        .width('100%')
        .height(56)
        .backgroundColor(ColorTokens.background)

        // 主要内容区域
        Stack({ alignContent: Alignment.Center }) {
          // Canvas 视图，用于自定义绘制圆形
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .padding(SpacingTokens.xl)
            .onReady(() => {
              this.drawCanvas();
            })

          // 底部内容区域 (Transfer Progress, 进度条, 按钮)
          Column({ space: SpacingTokens.lg }) {
            Text('Transfer Progress')
              .fontSize(TypographyTokens.titleSize)
              .fontWeight(TypographyTokens.titleWeight)
              .fontColor(ColorTokens.onSurface)

            CustomLinearProgressView({
              progressColor: ColorTokens.primary,
              trackColor: ColorTokens.surfaceVariant,
              barHeight: 8,
              progressValue: this.progress
            })
              .width('80%')

            // 按钮行，对应 Kotlin 的 Row
            Row({ space: SpacingTokens.md }) {
              // "+" 按钮
              Button('+')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .width(64)
                .height(64)
                .backgroundColor(ColorTokens.primary)
                .fontColor(ColorTokens.onPrimary)
                .borderRadius(32)
                .onClick(() => {
                  this.progress = Math.min(this.progress + 0.1, 1.0);
                })

              // "-" 按钮
              Button('-')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .width(64)
                .height(64)
                .backgroundColor(ColorTokens.secondary)
                .fontColor(ColorTokens.onSecondary)
                .borderRadius(32)
                .onClick(() => {
                  this.progress = Math.max(this.progress - 0.1, 0.0);
                })
            }
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.End)
          .padding({ bottom: SpacingTokens.xxl })
        }
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        ['#33FFC300', 0.0], // secondary.opacity(0.2)
        ['#FFFBF2', 0.5], // background
        ['#33FFA500', 1.0] // primary.opacity(0.2)
      ]
    })
  }
}

// MARK: - App Entry Point
// 应用程序的入口点，对应 Kotlin 的 MainActivity 和 setContent。
@Entry
@Component
struct TransferWizardApp {
  build() {
    Stack() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}
