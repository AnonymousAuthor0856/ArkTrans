// entry/src/main/ets/pages/CryptoMarketPage.ets

import { common } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

// --- App Tokens & Theme Constants ---

const COLORS = {
  primary: '#FFA8A8',
  secondary: '#FFE1A8',
  tertiary: '#A8FFE1',
  background: '#FFF9F0', // Slightly adjusted to match screenshot gradient base
  surface: '#FFFFFF',
  surfaceVariant: '#F2F2F7',
  outline: '#E2E2E2',
  onPrimary: '#1E1E1E',
  onSurface: '#1E1E1E'
};

const TYPOGRAPHY = {
  display: { fontSize: 32, fontWeight: FontWeight.Bold },
  title: { fontSize: 20, fontWeight: FontWeight.Medium },
  body: { fontSize: 16, fontWeight: FontWeight.Normal },
  label: { fontSize: 14, fontWeight: FontWeight.Medium }
};

const SHAPES = {
  small: 8,
  medium: 12,
  large: 24
};

const SPACING = {
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24
};

// --- Main Entry Component ---

@Entry
@Component
struct CryptoMarketApp {
  @State selectedChip: string = 'BTC';
  @State progress: number = 0.6;
  @State isAutoUpdate: boolean = true;

  aboutToAppear() {
    // Hide system bars for immersive experience similar to Android implementation
    let windowClass: window.Window = undefined as unknown as window.Window;
    try {
      let context = getContext(this) as common.UIAbilityContext;
      windowClass = context.getWindowSync();
      windowClass.setWindowSystemBarEnable([], (err) => {
        if (err) {
          console.error(`Failed to hide system bars. Code: ${err.code}, message: ${err.message}`);
        }
      });
    } catch (e) {
      console.error(`Error accessing window: ${JSON.stringify(e)}`);
    }
  }

  build() {
    Column() {
      // Header
      Text('Crypto Market')
        .font(TYPOGRAPHY.display)
        .fontColor(COLORS.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: SPACING.xl, bottom: SPACING.lg })

      // Chip Selection Row
      Row() {
        this.createChip('BTC')
        this.createChip('ETH')
        this.createChip('SOL')
        this.createChip('ADA')
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .width('100%')
      .margin({ bottom: SPACING.lg })

      // Chart Card
      Column() {
        Canvas(this)
          .width('100%')
          .height(260)
      }
      .width('100%')
      .backgroundColor(COLORS.surface)
      .borderRadius(SHAPES.large)
      .shadow({ radius: 10, color: '#10000000', offsetY: 4 })
      .margin({ bottom: SPACING.md })

      // Price Variation Label
      Text('Price Variation')
        .font(TYPOGRAPHY.title)
        .fontColor(COLORS.primary)
        .margin({ bottom: SPACING.sm })

      // Progress Bar
      ProgressBar({ value: this.progress * 100, total: 100 })
        .width('100%')
        .height(8)
        .color(COLORS.primary)
        .trackColor(COLORS.surfaceVariant)
        .margin({ bottom: SPACING.lg })

      // Auto Update Switch
      Row() {
        Text('Auto Update')
          .font(TYPOGRAPHY.body)
          .fontColor(COLORS.onSurface)
        
        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
          .onChange((isOn: boolean) => {
            this.isAutoUpdate = isOn;
          })
          .selectedColor(COLORS.secondary)
          .width(50)
          .height(30)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Blank()
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        [COLORS.secondary, 0.1],
        [COLORS.background, 0.5],
        [COLORS.tertiary, 0.1]
      ]
    })
    .padding(SPACING.lg)
  }

  // Helper method to create Filter Chips
  @Builder
  createChip(label: string) {
    Button(label)
      .type(ButtonType.Capsule)
      .backgroundColor(this.selectedChip === label ? COLORS.primary : COLORS.surfaceVariant)
      .fontColor(COLORS.onPrimary)
      .font(TYPOGRAPHY.label)
      .onClick(() => {
        this.selectedChip = label;
      })
      .margin({ right: SPACING.sm })
  }
}

// --- Custom Canvas Drawing Logic ---

@Component
struct ChartCanvas {
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D();
  private progress: number = 0.6;

  drawChart(context: CanvasRenderingContext2D, canvasSize: Size) {
    const width = canvasSize.width;
    const height = canvasSize.height;
    
    // Setup context
    context.lineWidth = 5;
    context.strokeStyle = COLORS.primary;
    context.lineCap = 'round';
    context.lineJoin = 'round';

    const step = width / 30;
    let prevX = 0;
    let prevY = height / 2;

    context.beginPath();
    context.moveTo(prevX, prevY);

    for (let i = 1; i <= 30; i++) {
      const x = i * step;
      // Replicating the sine wave logic from Kotlin: sin(i * PI / 6 + progress * PI)
      const y = (height / 2) + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (height / 3);
      
      context.lineTo(x, y);
      prevX = x;
      prevY = y;
    }
    
    context.stroke();
  }

  build() {
    Canvas(this)
      .onReady((context: CanvasRenderingContext2D) => {
        this.ctx = context;
        this.drawChart(context, { width: 300, height: 200 }); // Initial draw with dummy size
      })
      .onLayout((size: Size) => {
        // Redraw when layout changes
        if (this.ctx) {
          this.drawChart(this.ctx, size);
        }
      })
  }
}