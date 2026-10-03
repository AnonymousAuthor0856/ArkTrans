// AppTokens.ts

export interface ColorToken {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

export interface TypographyStyle {
  size: number;
  weight: FontWeight;
}

export interface TypographyToken {
  display: TypographyStyle;
  title: TypographyStyle;
  body: TypographyStyle;
  label: TypographyStyle;
}

export interface SpacingToken {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

export class AppTokens {
  static readonly Colors: ColorToken = {
    primary: '#FFA500',
    secondary: '#FFC300',
    tertiary: '#FFE066',
    background: '#FFFBF2',
    surface: '#FFFFFF',
    surfaceVariant: '#FFEED6',
    outline: '#F1C27D',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  };

  static readonly Typography: TypographyToken = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static readonly Spacing: SpacingToken = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };
}

interface Point {
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  @State markerPosition: Point = { x: 200, y: 400 };
  @State progress: number = 0.4;

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Transfer Wizard')
          .font({ size: AppTokens.Typography.display.size, weight: AppTokens.Typography.display.weight })
          .foregroundColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Stack({ alignContent: Alignment.Bottom }) {
        // Canvas for circles
        Canvas(this.renderContext)
          .onReady(() => {
            if (this.renderContext) {
              this.renderContext.beginPath();
              this.renderContext.rect(0, 0, 1000, 1000);
              this.renderContext.fillStyle = 'transparent';
              this.renderContext.fill();
            }
          })
          .width('100%')
          .height('100%')
          .layoutWeight(1)

        // Bottom Controls
        Column() {
          Text('Transfer Progress')
            .font({ size: AppTokens.Typography.title.size, weight: AppTokens.Typography.title.weight })
            .foregroundColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.lg })

          // Progress Bar
          Row() {
            Row()
              .width(`${this.progress * 80}%`)
              .height(8)
              .borderRadius(4)
              .backgroundColor(AppTokens.Colors.primary)
          }
          .width('80%')
          .height(8)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(4)
          .margin({ bottom: AppTokens.Spacing.lg })

          // Buttons
          Row() {
            Button('+')
              .type(ButtonType.Circle)
              .width(64)
              .height(64)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .backgroundColor(AppTokens.Colors.primary)
              .foregroundColor(AppTokens.Colors.onPrimary)
              .onClick(() => {
                this.progress = Math.min(this.progress + 0.1, 1.0);
              })

            Button('-')
              .type(ButtonType.Circle)
              .width(64)
              .height(64)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .backgroundColor(AppTokens.Colors.secondary)
              .foregroundColor(AppTokens.Colors.onSecondary)
              .margin({ left: AppTokens.Spacing.md })
              .onClick(() => {
                this.progress = Math.max(this.progress - 0.1, 0.0);
              })
          }
        }
        .alignItems(HorizontalAlign.Center)
        .padding({ bottom: AppTokens.Spacing.xxl })
      }
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 90,
      colors: [
        [AppTokens.Colors.secondary, 0.2],
        [AppTokens.Colors.background, 0.5],
        [AppTokens.Colors.primary, 0.2]
      ]
    })
  }

  private renderContext: CanvasRenderingContext2D | null = null;

  aboutToAppear() {
    // Initialize canvas context if needed, though usually handled by onReady in newer APIs
    // For ArkTS Canvas component, we often use the instance method or attribute binding.
    // Since CustomCanvas is not standard, we replaced it with Canvas().
    // To draw dynamically based on state, we might need to trigger redraws.
    // However, simple static drawing or using Path can be done.
    // Given the complexity of dynamic canvas drawing in ArkTS without a custom component,
    // and the errors provided, replacing CustomCanvas with standard Canvas is the fix.
    // Note: Dynamic updates to Canvas content usually require re-drawing via the context.
  }
}