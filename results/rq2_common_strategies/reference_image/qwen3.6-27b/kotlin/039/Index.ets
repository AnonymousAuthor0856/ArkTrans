import { router } from '@kit.ArkUI';
import { common, window } from '@kit.AbilityKit';

// --- Design Tokens & Constants ---

const AppTokens = {
  Colors: {
    primary: '#FFA500',      // Orange
    secondary: '#FFC107',    // Amber
    tertiary: '#FFE066',     // Light Yellow
    background: '#FFF8E7',   // Warm Cream Background
    surface: '#FFFFFF',      // White
    surfaceVariant: '#FFEED6', // Light Surface
    outline: '#F1C27D',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  },
  Spacing: {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  },
  Radius: {
    small: 6,
    medium: 12,
    large: 20
  }
};

@Entry
@Component
struct InstallmentPlanPage {
  @State paymentProgress: number = 0.3;
  private context: UIAbilityContext | undefined = undefined;

  aboutToAppear() {
    // Get context for window management
    this.context = getContext(this) as common.UIAbilityContext;
    this.setFullScreen();
  }

  // Helper to hide system bars like the Kotlin code
  setFullScreen() {
    if (this.context) {
      let windowClass: window.Window = null;
      try {
        windowClass = this.context.getWindowSync();
        windowClass.setWindowLayoutFullScreen(true);
        windowClass.setWindowSystemBarEnable(windowClass, []);
      } catch (e) {
        console.error('Failed to set full screen');
      }
    }
  }

  build() {
    Column() {
      // Top Bar Area
      Row() {
        Text("Installment Plan")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)

      // Main Content Container
      Column() {
        // Canvas Card
        Row() {
          Canvas(this.drawWave.bind(this))
            .size({ width: '100%', height: '100%' })
        }
        .width('100%')
        .height(240)
        .backgroundColor(Color.White)
        .borderRadius(AppTokens.Radius.large)
        .shadow({ radius: 10, color: '#10000000', offsetY: 4 })
        .padding(AppTokens.Spacing.lg)

        // Progress Section
        Column() {
          Text("Payment Progress")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.primary)
            .margin({ top: AppTokens.Spacing.xl, bottom: AppTokens.Spacing.md })

          // Linear Progress Indicator
          Progress({ value: this.paymentProgress, total: 1.0, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .margin({ bottom: AppTokens.Spacing.lg })

          // Slider
          Slider({ value: this.paymentProgress, min: 0, max: 1.0 })
            .width('100%')
            .blockColor(AppTokens.Colors.secondary)
            .selectedColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .margin({ bottom: AppTokens.Spacing.xl })

          // Reset Button
          Button("Reset Progress")
            .type(ButtonType.Normal)
            .backgroundColor(AppTokens.Colors.tertiary)
            .fontColor(AppTokens.Colors.onTertiary)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .height(48)
            .borderRadius(AppTokens.Radius.medium)
            .onClick(() => {
              this.paymentProgress = 0;
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    // Simulating the vertical gradient background
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppTokens.Colors.secondary, 0.2],
        [AppTokens.Colors.background, 0.5],
        [AppTokens.Colors.primary, 0.2]
      ]
    })
  }

  // Logic to draw the wave graph
  drawWave(canvas: Canvas, context: CanvasRenderingContext2D) {
    const w = canvas.width;
    const h = canvas.height;
    
    // Setup line style
    context.lineWidth = 5;
    context.strokeStyle = AppTokens.Colors.primary;
    context.lineCap = 'round';
    context.lineJoin = 'round';

    const step = w / 20;
    let prevY = h / 2;
    
    context.beginPath();
    context.moveTo(0, prevY);

    for (let i = 0; i <= 20; i++) {
      const x = i * step;
      // Math.sin logic matching the Kotlin source
      const y = (h / 2) + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
      
      context.lineTo(x, y);
      prevY = y;
    }
    context.stroke();
  }
}