// Index.ets
import { drawing } from '@kit.ArkUI';

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface TextStyleSpec {
  fontSize: number;
  fontWeight: number;
}

class AppTokens {
  static readonly Colors: Record<string, string> = {
    primary: '#FFFF8FAB',
    secondary: '#FFB4E3D0',
    tertiary: '#FFFFD6A5',
    background: '#FFFFFCF9',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFFDE2E4',
    outline: '#FFFCC2D7',
    success: '#FF4ADE80',
    warning: '#FFFACC15',
    error: '#FFFB7185',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E1E1E',
    onTertiary: '#FF1E1E1E',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E'
  };

  static readonly TypographyTokens: Record<string, TextStyleSpec> = {
    display: { fontSize: 30, fontWeight: FontWeight.Bold },
    title: { fontSize: 20, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static readonly Spacing: Record<string, number> = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  };

  static readonly ElevationMapping: Record<string, ShadowSpec> = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 }
  };
}

@Entry
@Component
struct RootScreen {
  @State knobPositionX: number = 0;
  @State knobPositionY: number = 0;
  @State isRunning: boolean = false;
  private panOffsetX: number = 0;
  private panOffsetY: number = 0;

  build() {
    Column() {
      // TopAppBar
      Row() {
        Text('Pomodoro Timer')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background);

      // Content
      Column() {
        // Circular Surface with Canvas
        Stack() {
          Circle({ width: 280, height: 280 })
            .fill(AppTokens.Colors.surfaceVariant)
            .shadow({
              radius: AppTokens.ElevationMapping.level2.radius,
              color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
              offsetX: 0,
              offsetY: AppTokens.ElevationMapping.level2.dy
            });

          // Canvas for drawing
          Canvas(this)
            .width(280)
            .height(280)
            .onReady((context: CanvasRenderingContext2D) => {
              this.drawCanvas(context);
            })
            .gesture(
              PanGesture()
                .onActionStart((event: GestureEvent) => {
                  this.knobPositionX = event.fingerList[0].localX;
                  this.knobPositionY = event.fingerList[0].localY;
                })
                .onActionUpdate((event: GestureEvent) => {
                  this.knobPositionX = event.fingerList[0].localX;
                  this.knobPositionY = event.fingerList[0].localY;
                })
            );
        }
        .width(280)
        .height(280)
        .margin({ bottom: AppTokens.Spacing.xl });

        // Status Text
        Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(this.isRunning ? AppTokens.Colors.success : AppTokens.Colors.error)
          .margin({ bottom: AppTokens.Spacing.xl });

        // Buttons Row
        Row() {
          Button('Start')
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .onClick(() => {
              this.isRunning = true;
            })
            .margin({ right: AppTokens.Spacing.lg });

          Button('Stop')
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor(AppTokens.Colors.tertiary)
            .fontColor(AppTokens.Colors.onSecondary)
            .onClick(() => {
              this.isRunning = false;
            });
        }
        .margin({ bottom: AppTokens.Spacing.xl });

        // Linear Progress Indicator
        Progress({
          value: Math.abs((this.knobPositionX + this.knobPositionY) % 400) / 400 * 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(8)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(4);
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Center);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }

  private drawCanvas(context: CanvasRenderingContext2D) {
    const w = 280;
    const h = 280;
    const center = { x: w / 2, y: h / 2 };
    
    // Clear previous
    context.clearRect(0, 0, w, h);
    
    // Draw outer circle
    context.beginPath();
    context.arc(center.x, center.y, 120, 0, Math.PI * 2);
    context.fillStyle = '#66B4E3D0';
    context.fill();
    
    // Draw knob
    context.beginPath();
    context.arc(this.knobPositionX, this.knobPositionY, 30, 0, Math.PI * 2);
    context.fillStyle = AppTokens.Colors.primary;
    context.fill();
  }
}