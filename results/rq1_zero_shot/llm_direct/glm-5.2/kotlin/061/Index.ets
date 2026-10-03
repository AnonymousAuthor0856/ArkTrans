// 096_ParcelTracker_en
// UI_TYPE: Tools Dashboard
// STYLE_THEME: Monochrome
// LANG: en
// BASELINE_SIZE: 720x1280

const NAME = "096_ParcelTracker_en";
const UI_TYPE = "Tools Dashboard";
const STYLE_THEME = "Monochrome";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

class AppTokens {
  static Colors = {
    primary: "#111827",
    secondary: "#374151",
    tertiary: "#6B7280",
    background: "#F9FAFB",
    surface: "#FFFFFF",
    surfaceVariant: "#E5E7EB",
    outline: "#D1D5DB",
    onPrimary: "#FFFFFF",
    onSecondary: "#FFFFFF",
    onBackground: "#111827",
    onSurface: "#1F2937",
  };
  static Typography = {
    display: { fontSize: 26, fontWeight: FontWeight.Bold },
    headline: { fontSize: 18, fontWeight: FontWeight.Medium },
    title: { fontSize: 14, fontWeight: FontWeight.Normal },
    body: { fontSize: 12, fontWeight: FontWeight.Normal },
  };
  static Shapes = {
    small: 6,
    medium: 10,
    large: 16,
  };
  static Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 22,
  };
}

@Entry
@Component
struct RootScreen {
  @State dragOffsetX: number = 0;
  @State dragOffsetY: number = 0;
  @State parcelPoints: any[] = [];

  aboutToAppear() {
    for (let i = 0; i < 25; i++) {
      this.parcelPoints.push({
        x: Math.random() * 400,
        y: Math.random() * 300,
      });
    }
  }

  build() {
    Column() {
      Text("Parcel Tracker")
        .fontSize(AppTokens.Typography.display.fontSize)
        .fontWeight(AppTokens.Typography.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)
        .margin({ bottom: AppTokens.Spacing.xl });

      Stack() {
        // Canvas
        Column() {
          ForEach(this.parcelPoints, (point: any) => {
            Circle()
              .width(8)
              .height(8)
              .backgroundColor(AppTokens.Colors.secondary)
              .position({ x: point.x, y: point.y });
          });

          // Drag indicator
          Column() {
            Column()
              .width(40)
              .height(40)
              .border({ width: 3, color: AppTokens.Colors.primary, radius: 20 })
              .backgroundColor(Color.Transparent);
          }
          .position({ x: this.dragOffsetX - 20, y: this.dragOffsetY - 20 });
        }
        .width('100%')
        .height('100%')
        .padding(10)
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.dragOffsetX = Math.max(0, Math.min(400, this.dragOffsetX + event.offsetX));
              this.dragOffsetY = Math.max(0, Math.min(300, this.dragOffsetY + event.offsetY));
            })
        );

        // Text overlay
        Column() {
          Text("Drag to locate parcel")
            .fontSize(AppTokens.Typography.body.fontSize)
            .fontColor(AppTokens.Colors.onSurface);
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center);
      }
      .width('100%')
      .height(300)
      .backgroundColor(AppTokens.Colors.surface)
      .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large })
      .margin({ bottom: AppTokens.Spacing.xl });

      Text("Visualize parcel movements and positions.")
        .fontSize(AppTokens.Typography.body.fontSize)
        .fontColor(AppTokens.Colors.onSurface);
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        [AppTokens.Colors.surfaceVariant, 0.0],
        [AppTokens.Colors.background, 1.0],
      ],
    })
    .padding(AppTokens.Spacing.lg);
  }
}