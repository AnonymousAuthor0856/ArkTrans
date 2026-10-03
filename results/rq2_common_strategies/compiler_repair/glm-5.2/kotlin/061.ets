// 096_ParcelTracker_en - Tools Dashboard - Monochrome - en - 720x1280

interface AppColorsType {
  primary: number;
  secondary: number;
  tertiary: number;
  background: number;
  surface: number;
  surfaceVariant: number;
  outline: number;
  onPrimary: number;
  onSecondary: number;
  onBackground: number;
  onSurface: number;
}

interface AppTypographyType {
  display: number;
  headline: number;
  title: number;
  body: number;
}

interface AppShapesType {
  small: number;
  medium: number;
  large: number;
}

interface AppSpacingType {
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

class AppTokens {
  static Colors: AppColorsType = {
    primary: 0xFF111827,
    secondary: 0xFF374151,
    tertiary: 0xFF6B7280,
    background: 0xFFF9FAFB,
    surface: 0xFFFFFFFF,
    surfaceVariant: 0xFFE5E7EB,
    outline: 0xFFD1D5DB,
    onPrimary: 0xFFFFFFFF,
    onSecondary: 0xFFFFFFFF,
    onBackground: 0xFF111827,
    onSurface: 0xFF1F2937
  };

  static TypographyTokens: AppTypographyType = {
    display: 26,
    headline: 18,
    title: 14,
    body: 12
  };

  static Shapes: AppShapesType = {
    small: 6,
    medium: 10,
    large: 16
  };

  static Spacing: AppSpacingType = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 22
  };
}

interface Point {
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  @State dragOffsetX: number = 0;
  @State dragOffsetY: number = 0;
  private parcelPoints: Point[] = [];
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  aboutToAppear() {
    for (let i = 0; i < 25; i++) {
      this.parcelPoints.push({
        x: Math.random() * 400,
        y: Math.random() * 300
      });
    }
  }

  build() {
    Column() {
      Text('Parcel Tracker')
        .fontSize(AppTokens.TypographyTokens.display)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)
        .margin({ bottom: AppTokens.Spacing.xl });

      Stack({ alignContent: Alignment.Center }) {
        Canvas(this.context)
          .width('100%')
          .height(300)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large })
          .onReady(() => {
            this.context.fillStyle = '#FF374151';
            this.parcelPoints.forEach((point: Point) => {
              this.context.beginPath();
              this.context.arc(point.x, point.y, 4, 0, Math.PI * 2);
              this.context.fill();
            });

            this.context.strokeStyle = '#FF111827';
            this.context.lineWidth = 3;
            this.context.beginPath();
            this.context.arc(this.dragOffsetX, this.dragOffsetY, 20, 0, Math.PI * 2);
            this.context.stroke();
          })
          .gesture(
            PanGesture()
              .onActionUpdate((event: GestureEvent) => {
                this.dragOffsetX = Math.max(0, Math.min(400, this.dragOffsetX + event.offsetX));
                this.dragOffsetY = Math.max(0, Math.min(300, this.dragOffsetY + event.offsetY));
                this.context.fillStyle = '#FF374151';
                this.parcelPoints.forEach((point: Point) => {
                  this.context.beginPath();
                  this.context.arc(point.x, point.y, 4, 0, Math.PI * 2);
                  this.context.fill();
                });

                this.context.strokeStyle = '#FF111827';
                this.context.lineWidth = 3;
                this.context.beginPath();
                this.context.arc(this.dragOffsetX, this.dragOffsetY, 20, 0, Math.PI * 2);
                this.context.stroke();
              })
          )

        Text('Drag to locate parcel')
          .fontSize(AppTokens.TypographyTokens.body)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(300)
      .margin({ bottom: AppTokens.Spacing.xl });

      Text('Visualize parcel movements and positions.')
        .fontSize(AppTokens.TypographyTokens.body)
        .fontColor(AppTokens.Colors.onSurface);
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.background, 1.0]]
    })
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center);
  }
}