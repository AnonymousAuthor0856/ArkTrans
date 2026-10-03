// 036.ets - translated from 036.swift (Crypto Market)

// MARK: - AppTokens

const CLEAR: string = '#00000000';

class AppTokensColors {
  static readonly primary: string = '#FFA8A8';
  static readonly secondary: string = '#FFE1A8';
  static readonly tertiary: string = '#A8FFE1';
  static readonly background: string = '#FFFCF5';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F7F7F7';
  static readonly outline: string = '#E2E2E2';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#1E1E1E';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#1E1E1E';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
}

class AppTokensTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppTokensShapes {
  static readonly small: number = 6;
  static readonly medium: number = 12;
  static readonly large: number = 20;
}

class AppTokensSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokensElevation {
  static readonly level1: ShadowSpec = { elevation: 2, radius: 4, dy: 2, opacity: 0.12 };
  static readonly level2: ShadowSpec = { elevation: 6, radius: 8, dy: 4, opacity: 0.18 };
}

class AppTokens {
  static readonly Colors = AppTokensColors;
  static readonly TypographyTokens = AppTokensTypography;
  static readonly Shapes = AppTokensShapes;
  static readonly Spacing = AppTokensSpacing;
  static readonly ElevationMapping = AppTokensElevation;
}

// MARK: - FilterChipView

@Component
struct FilterChipView {
  text: string;
  isSelected: boolean;
  chipAction: () => void;

  build() {
    Button(this.text)
      .fontSize(AppTokens.TypographyTokens.labelSize)
      .fontWeight(AppTokens.TypographyTokens.labelWeight)
      .fontColor(AppTokens.Colors.onPrimary)
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)
      .onClick(() => {
        this.chipAction();
      })
  }
}

// MARK: - RootScreen

@Component
struct RootScreen {
  @State selectedChip: string = 'BTC';
  @State progress: number = 0.6;
  @State isAutoUpdate: boolean = true;

  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA'];

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  progressPercent(): string {
    return (this.progress * 100).toString() + '%';
  }

  drawCanvas() {
    const w = this.ctx.width;
    const h = this.ctx.height;
    const step = w / 30;
    this.ctx.strokeStyle = AppTokens.Colors.primary;
    this.ctx.lineWidth = 5;
    this.ctx.beginPath();
    this.ctx.moveTo(-step, h / 2);
    for (let i = 0; i <= 30; i++) {
      const x = i * step;
      const y = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3);
      this.ctx.lineTo(x, y);
    }
    this.ctx.stroke();
  }

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column({ space: 0 }) {
        // Top Bar
        Text('Crypto Market')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          .backgroundColor(AppTokens.Colors.background)

        // Content area
        Column({ space: AppTokens.Spacing.lg }) {
          // Filter Chips Row
          Row({ space: AppTokens.Spacing.md }) {
            ForEach(this.chips, (chipText: string) => {
              FilterChipView({
                text: chipText,
                isSelected: this.selectedChip === chipText,
                chipAction: () => {
                  this.selectedChip = chipText;
                }
              })
            }, (chipText: string) => chipText)
          }

          // Chart Surface
          Stack() {
            Column()
              .width('100%')
              .height('100%')
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.large)
              .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: 'rgba(0,0,0,0.18)', offsetX: 0, offsetY: AppTokens.ElevationMapping.level2.dy })

            Canvas(this.ctx)
              .width('100%')
              .height('100%')
              .padding(AppTokens.Spacing.lg)
              .onReady(() => {
                this.drawCanvas();
              })
          }
          .width('100%')
          .height(260)

          // Price Variation Text
          Text('Price Variation')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.primary)

          // Linear Progress Indicator
          Stack({ alignContent: Alignment.Start }) {
            Row()
              .width('100%')
              .height(8)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(4)
            Row()
              .width(this.progressPercent())
              .height(8)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(4)
          }
          .width('100%')
          .height(8)

          // Auto Update Row
          Row() {
            Text('Auto Update')
              .fontSize(AppTokens.TypographyTokens.bodySize)
              .fontWeight(AppTokens.TypographyTokens.bodyWeight)
              .fontColor(AppTokens.Colors.onSurface)

            Blank()

            Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
              .selectedColor(AppTokens.Colors.primary)
              .switchPointColor(AppTokens.Colors.secondary)
              .onChange((isOn: boolean) => {
                this.isAutoUpdate = isOn;
              })
          }
          .width('100%')
        }
        .width('100%')
        .height('100%')
        .padding(AppTokens.Spacing.lg)
        .linearGradient({
          angle: 180,
          colors: [['rgba(255,225,168,0.3)', 0.0], [AppTokens.Colors.background, 0.5], ['rgba(168,255,225,0.3)', 1.0]]
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - App Entry Point

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}
