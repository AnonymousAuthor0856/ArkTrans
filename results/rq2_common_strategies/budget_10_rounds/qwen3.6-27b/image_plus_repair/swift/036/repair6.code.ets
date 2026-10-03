// AppEntry.ets or MainView.ets

import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens Definition

interface ColorToken {
  value: string;
}

interface ColorsConfig {
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

interface SpacingConfig {
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

interface ShapesConfig {
  small: number;
  large: number;
}

interface TypographyConfig {
  displaySize: number;
  titleSize: number;
  bodySize: number;
  labelSize: number;
}

const AppTokens = {
  Colors: {
    primary: '#FFA8A8',
    secondary: '#FFE1A8',
    tertiary: '#A8FFE1',
    background: '#FFFDF5', // Slightly adjusted for better visibility if needed, matching hex
    surface: '#FFFFFF',
    surfaceVariant: '#F7F7F7',
    outline: '#E2E2E2',
    onPrimary: '#1E1E1E',
    onSurface: '#1E1E1E'
  } as ColorsConfig,
  Spacing: {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  } as SpacingConfig,
  Shapes: {
    small: 6,
    large: 20
  } as ShapesConfig,
  Typography: {
    displaySize: 28,
    titleSize: 18,
    bodySize: 14,
    labelSize: 12
  } as TypographyConfig
};

// MARK: - FilterChip Component

@Component
struct FilterChip {
  @Prop text: string;
  @Link isSelected: boolean;
  private onClickHandler: () => void = () => {};

  build() {
    Button(this.text) {
      Text(this.text)
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
    }
    .type(ButtonType.Normal)
    .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.small)
    .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .onClick(() => {
      this.onClickHandler();
    })
  }
}

// MARK: - Custom Switch Component

@Component
struct CustomSwitch {
  @Link isChecked: boolean;

  build() {
    Stack() {
      Capsule()
        .width(51)
        .height(31)
        .fill(this.isChecked ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
        .shadow({ radius: 2, color: new Color('#000000').withAlpha(0.1), offsetY: 1 })

      Circle()
        .width(27)
        .height(27)
        .fill(this.isChecked ? AppTokens.Colors.secondary : AppTokens.Colors.outline)
        .offset({ x: this.isChecked ? 10 : -10, y: 0 })
        .animation({ duration: 200, curve: Curve.EaseInOut })
    }
    .onClick(() => {
      this.isChecked = !this.isChecked;
    })
  }
}

// MARK: - Linear Progress Component

@Component
struct LinearProgress {
  @Prop value: number; // 0.0 to 1.0

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Rect()
        .fill(AppTokens.Colors.surfaceVariant)
        .borderRadius(4)
        .height(8)

      // Progress Bar
      Rect()
        .fill(AppTokens.Colors.primary)
        .borderRadius(4)
        .height(8)
        .width(`${this.value * 100}%`)
    }
    .width('100%')
  }
}

// MARK: - Chart Canvas Component

@Component
struct WaveChart {
  @State progress: number = 0.6;
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D();

  aboutToAppear() {
    // Simulate animation loop if desired, but static for now based on input
  }

  build() {
    Column() {
      Canvas(this.ctx)
        .width('100%')
        .height(200) // Fixed height for the drawing area
    }
    .width('100%')
    .height(260)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 8, color: new Color('#000000').withAlpha(0.18), offsetY: 4 })
    .padding(AppTokens.Spacing.lg)
  }

  drawPath(ctx: CanvasRenderingContext2D, rect: Size) {
    const w = rect.width;
    const h = rect.height;
    const step = w / 30;
    const initialPrevY = h / 2;

    ctx.beginPath();
    ctx.moveTo(-step, initialPrevY);

    for (let i = 0; i <= 30; i++) {
      const x = i * step;
      const y = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3);
      ctx.lineTo(x, y);
    }

    ctx.lineWidth = 5;
    ctx.strokeStyle = '#FFA8A8'; // AppTokens.Colors.primary
    ctx.stroke();
  }
}

// MARK: - Root Screen

@Entry
@Component
struct CryptoMarketApp {
  @State selectedChip: string = 'BTC';
  @State isAutoUpdate: boolean = true;
  @State progressValue: number = 0.6;

  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA'];

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Crypto Market')
          .fontSize(AppTokens.Typography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Content Area
      Column() {
        // Filter Chips
        Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
          ForEach(this.chips, (chip: string) => {
            FilterChip({
              text: chip,
              isSelected: $selectedChip === chip,
              onClickHandler: () => {
                this.selectedChip = chip;
              }
            })
            .margin({ right: AppTokens.Spacing.md })
          })
        }
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.lg })

        // Chart
        WaveChart({ progress: this.progressValue })
          .margin({ bottom: AppTokens.Spacing.lg })

        // Price Variation Text
        Text('Price Variation')
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
          .margin({ bottom: AppTokens.Spacing.md })

        // Progress Bar
        LinearProgress({ value: this.progressValue })
          .margin({ bottom: AppTokens.Spacing.xl })

        // Auto Update Row
        Row() {
          Text('Auto Update')
            .fontSize(AppTokens.Typography.bodySize)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          CustomSwitch({ isChecked: $isAutoUpdate })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 90,
        colors: [
          ['#FFE1A8', 0.3], // Secondary with opacity
          ['#FFFDF5', 0.5], // Background
          ['#A8FFE1', 0.3]  // Tertiary with opacity
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}