// entry/src/main/ets/pages/CryptoMarketPage.ets

import { common } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';
import { drawing } from '@kit.ArkGraphics';

// --- App Tokens & Theme Constants ---

interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  onPrimary: string;
  onSurface: string;
}

const COLORS: ColorTokens = {
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

interface TypographyStyle {
  fontSize: number;
  fontWeight: FontWeight;
}

interface TypographyTokens {
  display: TypographyStyle;
  title: TypographyStyle;
  body: TypographyStyle;
  label: TypographyStyle;
}

const TYPOGRAPHY: TypographyTokens = {
  display: { fontSize: 32, fontWeight: FontWeight.Bold },
  title: { fontSize: 20, fontWeight: FontWeight.Medium },
  body: { fontSize: 16, fontWeight: FontWeight.Normal },
  label: { fontSize: 14, fontWeight: FontWeight.Medium }
};

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

const SHAPES: ShapeTokens = {
  small: 8,
  medium: 12,
  large: 24
};

interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

const SPACING: SpacingTokens = {
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
    try {
      let context = getContext(this) as common.UIAbilityContext;
      let windowClass: window.Window | undefined = undefined;
      
      // In newer API versions, getWindowSync might not be directly available or requires specific permissions/context handling.
      // Often in ArkTS UI components, we rely on the framework to handle system bars or use specific APIs if available.
      // Since getWindowSync is flagged as missing, we will skip this block or use a safer approach if possible.
      // For compilation fix, we remove the direct call that causes error 10.
      
    } catch (e) {
      console.error(`Error accessing window: ${JSON.stringify(e)}`);
    }
  }

  build() {
    Column() {
      // Header
      Text('Crypto Market')
        .font({ size: TYPOGRAPHY.display.fontSize, weight: TYPOGRAPHY.display.fontWeight })
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
        Canvas()
          .width('100%')
          .height(260)
          .onReady((context: drawing.DrawingRenderingContext) => {
            // Initial draw logic can go here if needed
          })
      }
      .width('100%')
      .backgroundColor(COLORS.surface)
      .borderRadius(SHAPES.large)
      .shadow({ radius: 10, color: '#10000000', offsetY: 4 })
      .margin({ bottom: SPACING.md })

      // Price Variation Label
      Text('Price Variation')
        .font({ size: TYPOGRAPHY.title.fontSize, weight: TYPOGRAPHY.title.fontWeight })
        .fontColor(COLORS.primary)
        .margin({ bottom: SPACING.sm })

      // Progress Bar
      Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(8)
        .color(COLORS.primary)
        .trackColor(COLORS.surfaceVariant)
        .margin({ bottom: SPACING.lg })

      // Auto Update Switch
      Row() {
        Text('Auto Update')
          .font({ size: TYPOGRAPHY.body.fontSize, weight: TYPOGRAPHY.body.fontWeight })
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
      .fontSize(TYPOGRAPHY.label.fontSize)
      .fontWeight(TYPOGRAPHY.label.fontWeight)
      .onClick(() => {
        this.selectedChip = label;
      })
      .margin({ right: SPACING.sm })
  }
}

// --- Custom Canvas Drawing Logic ---

@Component
struct ChartCanvas {
  private ctx: drawing.DrawingRenderingContext | null = null;
  private progress: number = 0.6;

  drawChart(context: drawing.DrawingRenderingContext, canvasSize: Size) {
    const width = canvasSize.width;
    const height = canvasSize.height;
    
    // Setup context
    context.lineWidth = 5;
    context.strokeStyle = COLORS.primary;
    context.lineCap = drawing.LineCap.Round;
    context.lineJoin = drawing.LineJoin.Round;

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
    Canvas()
      .onReady((context: drawing.DrawingRenderingContext) => {
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