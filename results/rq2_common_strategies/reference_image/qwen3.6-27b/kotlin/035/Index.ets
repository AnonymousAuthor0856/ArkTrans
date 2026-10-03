import { router } from '@kit.ArkUI';
import { common, window } from '@kit.AbilityKit';

// Define App Tokens matching the Kotlin source
const AppTokens = {
  Colors: {
    primary: '#2563EB',
    secondary: '#60A5FA',
    tertiary: '#93C5FD',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#E2E8F0',
    outline: '#CBD5E1',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E3A8A',
    onTertiary: '#1E40AF',
    onBackground: '#0F172A',
    onSurface: '#0F172A'
  },
  Spacing: {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28
  }
};

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.5;

  build() {
    Column() {
      // Top Bar Area
      Row() {
        Text('Stock K-Line')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Color.Transparent)

      // Main Content Area
      Column({ space: AppTokens.Spacing.lg }) {
        
        // Chart Card
        Row() {
          CustomCanvas(this.progress)
        }
        .width('100%')
        .height(260)
        .borderRadius(16)
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetY: 4 })

        // Market Trend Label
        Text('Market Trend')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)

        // Slider
        Slider({ value: this.progress, min: 0, max: 1 })
          .width('100%')
          .blockColor(AppTokens.Colors.primary)
          .selectedColor(AppTokens.Colors.secondary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .onChange((value: number) => {
            this.progress = value;
          })

        // Linear Progress Indicator
        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .control(false)
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.secondary, 0.15],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.primary, 0.15]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct CustomCanvas {
  @Link progress: number;

  build() {
    Canvas(this)
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
  }

  draw(context: CanvasContext, canvas: Canvas) {
    const width = canvas.getWidth();
    const height = canvas.getHeight();
    const step = width / 50;
    
    context.beginPath();
    context.moveTo(0, height / 2);
    
    let prevY = height / 2;
    
    for (let i = 0; i <= 50; i++) {
      const x = i * step;
      // Replicating the sine wave logic from Kotlin
      const y = height / 2 + Math.sin(i * Math.PI / 8 + this.progress * Math.PI) * (height / 3);
      
      context.lineTo(x, y);
      prevY = y;
    }
    
    context.lineWidth = 4;
    context.strokeColor = AppTokens.Colors.primary;
    context.stroke();
  }
}