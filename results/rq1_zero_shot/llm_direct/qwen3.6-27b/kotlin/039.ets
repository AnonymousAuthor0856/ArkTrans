import { common, window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

// --- App Tokens & Constants ---
const NAME = "051*InstallmentPlan*en";
const UI_TYPE = "Finance";
const STYLE_THEME = "Warm Gradient";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

class AppTokens {
  static Colors = {
    primary: '#FFA500',
    secondary: '#FFC107',
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

  static Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };
}

@Entry
@Component
struct RootScreen {
  @State paymentProgress: number = 0.3;
  private ctx: Context = getContext(this) as common.UIAbilityContext;

  aboutToAppear() {
    // Hide system bars for immersive experience similar to Android code
    let windowClass: window.Window = null;
    try {
      windowClass = window.getWindowSync(this.ctx);
      windowClass.setWindowSystemBarEnable([], (err) => {
        if (err) {
          console.error(`Failed to set system bar enable. Code is ${err.code}, message is ${err.message}`);
        }
      });
    } catch (exception) {
      let err: BusinessError = exception as BusinessError;
      console.error(`Failed to get window. Code is ${err.code}, message is ${err.message}`);
    }
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Text("Installment Plan")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Column() {
        // Chart Card
        Row() {
          CanvasRenderingContext2d()
            .onReady((context: CanvasRenderingContext2D) => {
              this.drawChart(context);
            })
        }
        .width('100%')
        .height(240)
        .borderRadius(20)
        .backgroundColor('#E6FFFFFF') // Surface with alpha approx
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetY: 4 })
        .margin({ top: AppTokens.Spacing.lg })

        // Progress Label
        Text("Payment Progress")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: AppTokens.Spacing.lg })

        // Linear Progress Indicator
        Progress({ value: this.paymentProgress, total: 1.0, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .margin({ top: AppTokens.Spacing.md })

        // Slider
        Slider({ value: this.paymentProgress, min: 0, max: 1, step: 0.01 })
          .width('100%')
          .blockColor(AppTokens.Colors.secondary)
          .selectedColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .onChange((value: number) => {
            this.paymentProgress = value;
            // Redraw chart when slider changes
            // Note: In a real app, we might trigger a redraw via state or event emitter
            // For simplicity in this single file, we rely on the fact that 
            // ArkUI canvas doesn't auto-redraw on state change unless re-rendered.
            // We will force a re-render of the canvas component by toggling a key or just accepting 
            // that the initial draw happens. To make it dynamic, we need a ref or rebuild.
            // Here, we will use a simple trick: update a state that triggers canvas rebuild.
            this.triggerRedraw = !this.triggerRedraw;
          })
          .margin({ top: AppTokens.Spacing.md })

        // Reset Button
        Button("Reset Progress")
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.tertiary)
          .fontColor(AppTokens.Colors.onTertiary)
          .borderRadius(12)
          .width('100%')
          .height(48)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.paymentProgress = 0;
            this.triggerRedraw = !this.triggerRedraw;
          })
          .margin({ top: AppTokens.Spacing.lg })

      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 90,
        colors: [
          ['rgba(255, 193, 7, 0.25)', 0],
          ['#FFFBF2', 0.5],
          ['rgba(255, 165, 0, 0.25)', 1]
        ]
      })

    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @State triggerRedraw: boolean = false;

  drawChart(context: CanvasRenderingContext2D) {
    const width = context.canvas.width;
    const height = context.canvas.height;
    
    // Clear previous drawing
    context.clearRect(0, 0, width, height);

    const step = width / 20;
    let prevY = height / 2;
    
    context.beginPath();
    context.strokeStyle = AppTokens.Colors.primary;
    context.lineWidth = 5;
    context.lineCap = 'round';
    context.lineJoin = 'round';

    // Start at first point
    let startX = 0;
    let startY = height / 2 + Math.sin(0 * Math.PI / 5 + this.paymentProgress * Math.PI) * (height / 3);
    context.moveTo(startX, startY);

    for (let i = 1; i <= 20; i++) {
      const x = i * step;
      const y = height / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (height / 3);
      context.lineTo(x, y);
    }
    context.stroke();
  }
}