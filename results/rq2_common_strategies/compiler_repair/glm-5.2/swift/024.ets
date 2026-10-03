// AppTokens.ets
export class AppTokens {
  static Colors: Record<string, string> = {
    primary: '#FFEF476F',
    secondary: '#FFFFD166',
    tertiary: '#FF06D6A0',
    background: '#FFFFFCF2',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFF7EDE2',
    outline: '#FFE5D4B1',
    success: '#FF06D6A0',
    warning: '#FFFFA600',
    error: '#FFD62828',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E1E1E',
    onTertiary: '#FF1E1E1E',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E'
  };

  static TypographyTokens: Record<string, [number, number, number]> = {
    // [FontWeight, Size, LineHeight]
    display: [FontWeight.Bold, 26, 30],
    title: [FontWeight.Medium, 18, 24],
    body: [FontWeight.Normal, 14, 20],
    label: [FontWeight.Medium, 12, 16]
  };

  static Shapes: Record<string, number> = {
    smallCornerRadius: 6.0,
    mediumCornerRadius: 10.0,
    largeCornerRadius: 16.0
  };

  static Spacing: Record<string, number> = {
    xs: 4.0,
    sm: 8.0,
    md: 12.0,
    lg: 16.0,
    xl: 24.0
  };

  static ElevationMapping: Record<string, [number, number, number, number]> = {
    // [elevation, radius, dy, opacity]
    level1: [2.0, 4.0, 2.0, 0.12],
    level2: [4.0, 8.0, 4.0, 0.16]
  };
}

// Point interface for drawing
interface DrawPoint {
  x: number;
  y: number;
  color: string;
}

// RootScreen.ets
@Entry
@Component
struct RootScreen {
  @State points: DrawPoint[] = [];
  @State currentColor: string = AppTokens.Colors.primary;

  // Control sizes
  private buttonHeight: number = 44.0;
  private fabSize: number = 56.0;
  private circleRadius: number = 10.0;

  // Layout calculations
  private get topBarActualHeight(): number {
    return 30.0 + (2 * AppTokens.Spacing.md);
  }

  private get bottomBarActualHeight(): number {
    return this.buttonHeight + (2 * AppTokens.Spacing.md);
  }

  private get fabBottomMargin(): number {
    return AppTokens.Spacing.xl;
  }

  private get canvasBottomPadding(): number {
    return Math.max(this.bottomBarActualHeight, this.fabSize + this.fabBottomMargin);
  }

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Stack() {
      // 1. Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // 2. Drawing Canvas Area
      Column() {
        Canvas(this.context)
          .width('100%')
          .height('100%')
          .backgroundColor(AppTokens.Colors.background)
          .onReady(() => {
            this.context.fillStyle = AppTokens.Colors.background;
            this.context.fillRect(0, 0, this.context.width, this.context.height);
          })
          .gesture(
            PanGesture({ fingers: 1, distance: 0 })
              .onActionUpdate((event: GestureEvent) => {
                this.points.push({
                  x: event.fingerList[0].localX,
                  y: event.fingerList[0].localY,
                  color: this.currentColor
                });
                this.drawPoints();
              })
          )
      }
      .width('100%')
      .height('100%')
      .padding({ top: this.topBarActualHeight, bottom: this.canvasBottomPadding })

      // 3. Top Bar
      Column() {
        Text("Retro Whiteboard")
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(AppTokens.TypographyTokens.display[1])
          .fontWeight(AppTokens.TypographyTokens.display[0])
          .lineHeight(AppTokens.TypographyTokens.display[2])
          .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor(AppTokens.Colors.background)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Start)

      // 4. Bottom Color Selection Bar
      Column() {
        Blank()
        Row({ space: AppTokens.Spacing.md }) {
          Blank()
          Button("Red", { type: ButtonType.Normal })
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(AppTokens.TypographyTokens.body[1])
            .fontWeight(AppTokens.TypographyTokens.body[0])
            .height(this.buttonHeight)
            .layoutWeight(1)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .onClick(() => this.currentColor = AppTokens.Colors.primary)

          Blank()
          Button("Yellow", { type: ButtonType.Normal })
            .fontColor(AppTokens.Colors.onSecondary)
            .fontSize(AppTokens.TypographyTokens.body[1])
            .fontWeight(AppTokens.TypographyTokens.body[0])
            .height(this.buttonHeight)
            .layoutWeight(1)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .onClick(() => this.currentColor = AppTokens.Colors.secondary)

          Blank()
          Button("Green", { type: ButtonType.Normal })
            .fontColor(AppTokens.Colors.onTertiary)
            .fontSize(AppTokens.TypographyTokens.body[1])
            .fontWeight(AppTokens.TypographyTokens.body[0])
            .height(this.buttonHeight)
            .layoutWeight(1)
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .onClick(() => this.currentColor = AppTokens.Colors.tertiary)
          Blank()
        }
        .width('100%')
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.ElevationMapping.level1[0],
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1[3]})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level1[2]
        })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)

      // 5. Floating Action Button (Clear)
      Column() {
        Blank()
        Row() {
          Blank()
          Button("Clear", { type: ButtonType.Circle })
            .fontColor(AppTokens.Colors.onSecondary)
            .fontSize(AppTokens.TypographyTokens.label[1])
            .fontWeight(AppTokens.TypographyTokens.label[0])
            .width(this.fabSize)
            .height(this.fabSize)
            .backgroundColor(AppTokens.Colors.secondary)
            .shadow({
              radius: AppTokens.ElevationMapping.level1[0],
              color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1[3]})`,
              offsetX: 0,
              offsetY: AppTokens.ElevationMapping.level1[2]
            })
            .onClick(() => {
              this.points = [];
              this.context.clearRect(0, 0, this.context.width, this.context.height);
            })
            .margin({ right: AppTokens.Spacing.xl, bottom: this.fabBottomMargin })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height('100%')
  }

  private drawPoints() {
    if (this.points.length === 0) return;
    const point = this.points[this.points.length - 1];
    this.context.fillStyle = point.color;
    this.context.beginPath();
    this.context.arc(point.x, point.y, this.circleRadius, 0, Math.PI * 2);
    this.context.fill();
  }
}