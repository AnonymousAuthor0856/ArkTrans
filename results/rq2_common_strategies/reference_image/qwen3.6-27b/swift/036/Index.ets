// AppEntry.ets (or your main entry file)
import { window } from '@kit.ArkUI';

// MARK: - AppTokens Definition

const AppTokens = {
  Colors: {
    primary: '#FFA8A8',
    secondary: '#FFE1A8',
    tertiary: '#A8FFE1',
    background: '#FFFDF5', // Adjusted slightly for better visibility if needed, kept close to source
    surface: '#FFFFFF',
    surfaceVariant: '#F7F7F7',
    outline: '#E2E2E2',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#1E1E1E',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  },
  TypographyTokens: {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  },
  Shapes: {
    small: 6,
    medium: 12,
    large: 20
  },
  Spacing: {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  },
  ElevationMapping: {
    level2: { opacity: 0.18, radius: 8, dy: 4 }
  }
};

// MARK: - Custom Components

/**
 * Filter Chip Component
 */
@Component
struct FilterChip {
  @Prop text: string;
  @Link isSelected: boolean;
  private action: () => void;

  build() {
    Button({ type: ButtonType.Normal }) {
      Text(this.text)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
    }
    .onClick(() => {
      this.action();
    })
    .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.small)
    .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .width('auto')
  }
}

/**
 * Linear Progress Indicator
 */
@Component
struct LinearProgress {
  @Prop value: number; // 0.0 to 1.0
  @Prop height: number = 8;
  @Prop trackColor: string = AppTokens.Colors.surfaceVariant;
  @Prop fillColor: string = AppTokens.Colors.primary;

  build() {
    Row() {
      // Track
      Rectangle()
        .fill(this.trackColor)
        .height(this.height)
        .borderRadius(4)
        .width('100%')

      // Fill
      Rectangle()
        .fill(this.fillColor)
        .height(this.height)
        .borderRadius(4)
        .width(`${this.value * 100}%`)
    }
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }
}

/**
 * Custom Switch Toggle
 */
@Component
struct CustomSwitch {
  @Link isChecked: boolean;
  private checkedThumbColor: string = AppTokens.Colors.secondary;
  private uncheckedThumbColor: string = AppTokens.Colors.outline;
  private trackWidth: number = 51;
  private trackHeight: number = 31;
  private thumbSize: number = 27; // Slightly smaller than track height minus padding

  build() {
    Row() {
      Circle()
        .width(this.thumbSize)
        .height(this.thumbSize)
        .fill(this.isChecked ? this.checkedThumbColor : this.uncheckedThumbColor)
        .shadow({ radius: 2, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
        .margin({ left: this.isChecked ? (this.trackWidth - this.trackHeight) / 2 : 2 })
        .animation({ duration: 200, curve: Curve.EaseInOut })
    }
    .width(this.trackWidth)
    .height(this.trackHeight)
    .backgroundColor(this.isChecked ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .borderRadius(this.trackHeight / 2)
    .onClick(() => {
      this.isChecked = !this.isChecked;
    })
  }
}

// MARK: - Root Screen

@Entry
@Component
struct CryptoMarketApp {
  @State selectedChip: string = 'BTC';
  @State progress: number = 0.6;
  @State isAutoUpdate: boolean = true;
  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA'];

  aboutToAppear() {
    // Optional: Hide status bar if supported by environment
    try {
      const windowClass = window.getWindowSync(getContext());
      windowClass.setWindowLayoutFullScreen(true);
    } catch (e) {
      console.error('Failed to set full screen');
    }
  }

  build() {
    Column() {
      // Top Bar
      Text('Crypto Market')
        .fontColor(AppTokens.Colors.onSurface)
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })

      // Content Area
      Column({ space: AppTokens.Spacing.lg }) {
        
        // Filter Chips
        Row({ space: AppTokens.Spacing.md }) {
          ForEach(this.chips, (chip: string) => {
            FilterChip({
              text: chip,
              isSelected: $selectedChip === chip,
              action: () => { this.selectedChip = chip }
            })
          })
        }
        .justifyContent(FlexAlign.Start) // Align start like SwiftUI HStack default
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

        // Chart Surface
        Column() {
          Canvas(this.renderChart)
            .width('100%')
            .height('100%')
        }
        .width('100%')
        .height(260)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
        .padding(AppTokens.Spacing.lg)

        // Price Variation Text
        Text('Price Variation')
          .fontColor(AppTokens.Colors.primary)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .textAlign(TextAlign.Center)
          .width('100%')

        // Linear Progress
        LinearProgress({
          value: this.progress,
          trackColor: AppTokens.Colors.surfaceVariant,
          fillColor: AppTokens.Colors.primary
        })
        .width('100%')

        // Auto Update Row
        Row() {
          Text('Auto Update')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
          
          Blank()
          
          CustomSwitch({
            isChecked: $isAutoUpdate
          })
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.sm })

      }
      .width('100%')
      .layoutWeight(1) // Take remaining space
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 90,
        colors: [
          [AppTokens.Colors.secondary, 0.3],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.tertiary, 0.3]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  // Canvas Drawing Logic
  renderChart(ctx: CanvasRenderingContext2D, size: Size) {
    const w = size.width;
    const h = size.height;
    const step = w / 30;
    
    ctx.beginPath();
    ctx.lineWidth = 5;
    ctx.strokeStyle = AppTokens.Colors.primary;
    ctx.lineCap = LineCap.Round;
    ctx.lineJoin = LineJoin.Round;

    // Initial point
    let prevY = h / 2;
    ctx.moveTo(-step, prevY);

    for (let i = 0; i <= 30; i++) {
      const x = i * step;
      // Replicating the sin wave logic: y = h/2 + sin(i * pi/6 + progress * pi) * (h/3)
      const y = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3);
      ctx.lineTo(x, y);
    }
    ctx.stroke();
  }
}