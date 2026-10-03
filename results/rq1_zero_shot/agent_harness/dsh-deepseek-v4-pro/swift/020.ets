// Translated from SwiftUI to ArkTS (ArkUI declarative syntax)

// MARK: - AppTokens
class AppTokens {
  static readonly Colors = {
    primary: "#FF7A00",
    secondary: "#FFC300",
    tertiary: "#FFF3C0",
    background: "#FFF8E7",
    surface: "#FFFFFF",
    surfaceVariant: "#FFEBC8",
    outline: "#BCA789",
    success: "#28A745",
    warning: "#FFC107",
    error: "#DC3545",
    onPrimary: "#FFFFFF",
    onSecondary: "#1E1E1E",
    onTertiary: "#1E1E1E",
    onBackground: "#1E1E1E",
    onSurface: "#1E1E1E",
  };

  static readonly TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static readonly Shapes = {
    small: 8,
    medium: 14,
    large: 24,
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };
}

class Point {
  x: number;
  y: number;
  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

// MARK: - RootScreen
@Component
struct RootScreen {
  @State knobPosition: Point = new Point(90, 140); // 初始位置靠左
  @State powerOn: boolean = false;

  build() {
    Column({ space: 0 }) {
      // 顶部空白
      Blank()
        .height(40)

      // Top Bar
      Stack() {
        Rect()
          .width("100%")
          .height(64)
          .fill(AppTokens.Colors.background)

        Text("Retro Remote Control")
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width("100%")
      .height(64)

      Scroll() {
        Column({ space: AppTokens.Spacing.xl }) {
          // Knob Surface
          Stack() {
            Rect()
              .width(280)
              .height(280)
              .fill(AppTokens.Colors.surfaceVariant)

            // Background circle
            Circle({ width: 200, height: 200 })
              .fill("#FFC30033")

            // Knob circle - 直径32
            Circle({ width: 32, height: 32 })
              .fill(AppTokens.Colors.primary)
              .position({ x: this.knobPosition.x - 16, y: this.knobPosition.y - 16 })
              .onTouch((event: TouchEvent) => {
                if (event.touches.length > 0) {
                  let x = event.touches[0].x;
                  let y = event.touches[0].y;
                  this.knobPosition = new Point(
                    Math.max(16, Math.min(264, x)),
                    Math.max(16, Math.min(264, y))
                  );
                }
              })
          }
          .width(280)
          .height(280)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({ radius: 4, color: "#0000001F", offsetX: 0, offsetY: 2 })
          .padding(AppTokens.Spacing.lg)

          // Power Status
          Text(this.powerOn ? "Power: ON" : "Power: OFF")
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(this.powerOn ? AppTokens.Colors.success : AppTokens.Colors.error)

          // Buttons Row
          Row({ space: 60 }) {
            Button() {
              Text("On")
                .fontSize(AppTokens.TypographyTokens.title.size)
                .fontWeight(AppTokens.TypographyTokens.title.weight)
                .fontColor(AppTokens.Colors.onPrimary)
                .width(80)
                .height(80)
            }
            .width(80)
            .height(80)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(40)
            .onClick(() => {
              this.powerOn = !this.powerOn;
            })

            Button() {
              Column({ space: 0 }) {
                Text("Res")
                Text("et")
              }
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.onSecondary)
              .width(80)
              .height(80)
              .justifyContent(FlexAlign.Center)
            }
            .width(80)
            .height(80)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(40)
            .onClick(() => {
              this.knobPosition = new Point(90, 140); // 重置到靠左位置
            })
          }

          // Progress Bar
          Rect()
            .width("100%")
            .height(6)
            .fill(AppTokens.Colors.primary)
            .radius(3)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        }
        .width("100%")
        .alignItems(HorizontalAlign.Center)
        .padding(AppTokens.Spacing.lg)
      }
      .backgroundColor(AppTokens.Colors.background)
      .layoutWeight(1)
    }
    .width("100%")
    .height("100%")
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}
