import { curves } from '@kit.ArkUI';

// MARK: - AppTokens Definition

class AppTokens {
  static Colors = class {
    static primary = '#FFFFA8A8';
    static secondary = '#FFFFE1A8';
    static tertiary = '#FFA8FFE1';
    static background = '#FFFFFCF5';
    static surface = '#FFFFFFFF';
    static surfaceVariant = '#FFF7F7F7';
    static outline = '#FFE2E2E2';
    static success = '#FF22C55E';
    static warning = '#FFF59E0B';
    static error = '#FFEF4444';
    static onPrimary = '#FF1E1E1E';
    static onSecondary = '#FF1E1E1E';
    static onTertiary = '#FF1E1E1E';
    static onBackground = '#FF1E1E1E';
    static onSurface = '#FF1E1E1E';
  };

  static Typography = class {
    static display: number = 28;
    static title: number = 18;
    static body: number = 14;
    static label: number = 12;
  };

  static Shapes = class {
    static small: number = 6;
    static medium: number = 12;
    static large: number = 20;
  };

  static Spacing = class {
    static sm: number = 8;
    static md: number = 12;
    static lg: number = 16;
    static xl: number = 24;
    static xxl: number = 32;
  };

  static ElevationMapping = class {
    static level1 = { elevation: 2, radius: 4, dy: 2, opacity: 0.12 };
    static level2 = { elevation: 6, radius: 8, dy: 4, opacity: 0.18 };
  };
}

// MARK: - FilterChip Component

@Component
struct FilterChipView {
  text: string = '';
  isSelected: boolean = false;
  action: () => void = () => {};

  build() {
    Text(this.text)
      .fontSize(AppTokens.Typography.label)
      .fontColor(AppTokens.Colors.onPrimary)
      .fontWeight(FontWeight.Medium)
      .padding({
        left: AppTokens.Spacing.md,
        right: AppTokens.Spacing.md,
        top: AppTokens.Spacing.sm,
        bottom: AppTokens.Spacing.sm
      })
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)
      .onClick(() => {
        this.action();
      })
  }
}

// MARK: - Waveform Canvas Component

@Component
struct WaveformCanvas {
  progress: number = 0.6;

  build() {
    Canvas(new CanvasRenderingContext2D(new RenderingContextSettings(true)))
      .width('100%')
      .height('100%')
      .onReady((context: CanvasRenderingContext2D) => {
        this.drawWaveform(context);
      })
      .onAreaChange((_oldValue: Area, _newValue: Area) => {
      })
  }

  drawWaveform(context: CanvasRenderingContext2D) {
    const w = context.width;
    const h = context.height;
    const step = w / 30;
    const initialPrevY = h / 2;

    context.clearRect(0, 0, w, h);
    context.beginPath();
    context.moveTo(-step, initialPrevY);

    for (let i = 0; i <= 30; i++) {
      const x = i * step;
      const y = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3);
      context.lineTo(x, y);
    }

    context.strokeStyle = AppTokens.Colors.primary;
    context.lineWidth = 5;
    context.stroke();
  }
}

// MARK: - RootScreen View

@Entry
@Component
struct RootScreen {
  @State selectedChip: string = 'BTC';
  @State progress: number = 0.6;
  @State isAutoUpdate: boolean = true;

  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA'];

  build() {
    Column() {
      // Top Bar
      Text('Crypto Market')
        .fontSize(AppTokens.Typography.display)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({
          top: AppTokens.Spacing.lg,
          bottom: AppTokens.Spacing.lg
        })
        .backgroundColor(AppTokens.Colors.background)

      // Content Area
      Column({ space: AppTokens.Spacing.lg }) {

        // Filter Chips Row
        Row({ space: AppTokens.Spacing.md }) {
          ForEach(this.chips, (chipText: string) => {
            FilterChipView({
              text: chipText,
              isSelected: this.selectedChip === chipText,
              action: () => {
                this.selectedChip = chipText;
              }
            })
          })
        }
        .width('100%')

        // Chart Surface
        Stack() {
          // Background card
          Column()
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

          // Waveform Canvas
          Canvas(new CanvasRenderingContext2D(new RenderingContextSettings(true)))
            .width('100%')
            .height(260)
            .padding(AppTokens.Spacing.lg)
            .onReady((context: CanvasRenderingContext2D) => {
              this.drawWaveform(context);
            })
        }
        .width('100%')
        .height(260)

        // Price Variation Text
        Text('Price Variation')
          .fontSize(AppTokens.Typography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')

        // Linear Progress Indicator
        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .style({ strokeWidth: 8, enableScanEffect: false })

        // Auto Update Row
        Row() {
          Text('Auto Update')
            .fontSize(AppTokens.Typography.body)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
            .selectedColor(AppTokens.Colors.primary)
            .switchPointColor(this.isAutoUpdate ? AppTokens.Colors.secondary : AppTokens.Colors.outline)
            .onChange((isOn: boolean) => {
              this.isAutoUpdate = isOn;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [`${AppTokens.Colors.secondary}4D`, 0.0],
          [AppTokens.Colors.background, 0.5],
          [`${AppTokens.Colors.tertiary}4D`, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  drawWaveform(context: CanvasRenderingContext2D) {
    const w = context.width;
    const h = context.height;
    const paddingVal = AppTokens.Spacing.lg;
    const drawW = w - paddingVal * 2;
    const drawH = h - paddingVal * 2;
    const step = drawW / 30;
    const initialPrevY = drawH / 2;

    context.clearRect(0, 0, w, h);
    context.beginPath();
    context.moveTo(paddingVal - step, paddingVal + initialPrevY);

    for (let i = 0; i <= 30; i++) {
      const x = paddingVal + i * step;
      const y = paddingVal + drawH / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (drawH / 3);
      context.lineTo(x, y);
    }

    context.strokeStyle = AppTokens.Colors.primary;
    context.lineWidth = 5;
    context.stroke();
  }
}