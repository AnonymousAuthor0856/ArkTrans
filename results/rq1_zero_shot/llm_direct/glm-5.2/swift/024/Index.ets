// AppTokens.ets
export class AppTokens {
  static Colors = {
    primary: '#FFEF476F',
    secondary: '#FFD166',
    tertiary: '#FF06D6A0',
    background: '#FFFCF2',
    surface: '#FFFFFFFF',
    surfaceVariant: '#F7EDE2',
    outline: '#FFE5D4B1',
    success: '#FF06D6A0',
    warning: '#FFA600',
    error: '#FFD62828',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E1E1E',
    onTertiary: '#FF1E1E1E',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E'
  }

  static TypographyTokens = {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static Shapes = {
    smallCornerRadius: 6.0,
    mediumCornerRadius: 10.0,
    largeCornerRadius: 16.0
  }

  static Spacing = {
    xs: 4.0,
    sm: 8.0,
    md: 12.0,
    lg: 16.0,
    xl: 24.0
  }

  static ElevationMapping = {
    level1: { elevation: 2.0, radius: 4.0, dy: 2.0, opacity: 0.12 },
    level2: { elevation: 4.0, radius: 8.0, dy: 4.0, opacity: 0.16 }
  }
}

// RootScreen.ets
interface Point {
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  @State points: Point[] = [];
  @State currentColor: string = AppTokens.Colors.primary;

  private buttonHeight: number = 44.0;
  private fabSize: number = 56.0;
  private circleRadius: number = 10.0;

  get topBarActualHeight(): number {
    return 30.0 + (2 * AppTokens.Spacing.md);
  }

  get bottomBarActualHeight(): number {
    return this.buttonHeight + (2 * AppTokens.Spacing.md);
  }

  get fabBottomMargin(): number {
    return AppTokens.Spacing.xl;
  }

  get canvasBottomPadding(): number {
    return Math.max(this.bottomBarActualHeight, this.fabSize + this.fabBottomMargin);
  }

  build() {
    Stack() {
      // 1. Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // 2. Canvas Area
      Column() {
        // Canvas equivalent using Pan gesture on a Column
        Column()
          .width('100%')
          .height('100%')
          .gesture(
            PanGesture()
              .onActionStart((event: GestureEvent) => {
                this.points.push({ x: event.fingerList[0].localX, y: event.fingerList[0].localY });
              })
              .onActionUpdate((event: GestureEvent) => {
                this.points.push({ x: event.fingerList[0].localX, y: event.fingerList[0].localY });
              })
          )
          .overlay(
            // Render points using overlay
            ForEach(this.points, (point: Point) => {
              Circle()
                .width(this.circleRadius * 2)
                .height(this.circleRadius * 2)
                .position({ x: point.x - this.circleRadius, y: point.y - this.circleRadius })
                .fill(this.currentColor)
            })
          )
      }
      .padding({ top: this.topBarActualHeight, bottom: this.canvasBottomPadding })
      .width('100%')
      .height('100%')

      // 3. Top Bar
      Column() {
        Text('Retro Whiteboard')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
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
        Row() {
          Blank()
          Button('Red')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .height(this.buttonHeight)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .layoutWeight(1)
            .onClick(() => {
              this.currentColor = AppTokens.Colors.primary;
            })
          Blank()
          Button('Yellow')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .height(this.buttonHeight)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .layoutWeight(1)
            .onClick(() => {
              this.currentColor = AppTokens.Colors.secondary;
            })
          Blank()
          Button('Green')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onTertiary)
            .height(this.buttonHeight)
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .layoutWeight(1)
            .onClick(() => {
              this.currentColor = AppTokens.Colors.tertiary;
            })
          Blank()
        }
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.ElevationMapping.level1.elevation,
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`,
          offsetY: AppTokens.ElevationMapping.level1.dy
        })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)

      // 5. Floating Action Button (FAB)
      Column() {
        Blank()
        Row() {
          Blank()
          Button('Clear')
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .width(this.fabSize)
            .height(this.fabSize)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(this.fabSize / 2)
            .shadow({
              radius: AppTokens.ElevationMapping.level1.elevation,
              color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`,
              offsetY: AppTokens.ElevationMapping.level1.dy
            })
            .onClick(() => {
              this.points = [];
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
}