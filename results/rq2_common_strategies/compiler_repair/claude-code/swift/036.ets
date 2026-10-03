// MARK: - AppTokens Definition

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FFA8A8';
    export const secondary: string = '#FFE1A8';
    export const tertiary: string = '#A8FFE1';
    export const background: string = '#FFFCF5';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#F7F7F7';
    export const outline: string = '#E2E2E2';
    export const onPrimary: string = '#1E1E1E';
    export const onSurface: string = '#1E1E1E';
  }

  export namespace Shapes {
    export const small: Length = 6;
    export const medium: Length = 12;
    export const large: Length = 20;
  }

  export namespace Spacing {
    export const sm: Length = 8;
    export const md: Length = 12;
    export const lg: Length = 16;
    export const xl: Length = 24;
    export const xxl: Length = 32;
  }

  export namespace Elevation {
    export const level2Radius: number = 8;
    export const level2Dy: number = 4;
    export const level2Opacity: number = 0.18;
  }
}

// MARK: - FilterChip Component

@Component
struct FilterChip {
  text: string = '';
  isSelected: boolean = false;
  onSelect: () => void = () => {};

  build() {
    Button(this.text)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      .onClick(() => this.onSelect())
  }
}

// MARK: - Custom Switch Component

@Component
struct CustomSwitch {
  @Link isOn: boolean;
  checkedThumbColor: ResourceColor = AppTokens.Colors.secondary;
  uncheckedThumbColor: ResourceColor = AppTokens.Colors.outline;

  build() {
    Row() {
      Circle({ width: 27, height: 27 })
        .fill(this.isOn ? this.checkedThumbColor : this.uncheckedThumbColor)
        .shadow({
          radius: 2,
          color: 'rgba(0, 0, 0, 0.1)',
          offsetY: 1
        })
        .margin({ left: this.isOn ? 22 : 2, right: this.isOn ? 2 : 22 })
        .animation({
          duration: 200,
          curve: Curve.EaseInOut,
          delay: 0,
          iterations: 1,
          playMode: PlayMode.Normal
        })
    }
    .width(51)
    .height(31)
    .borderRadius(15.5)
    .backgroundColor(this.isOn ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .animation({
      duration: 200,
      curve: Curve.EaseInOut,
      delay: 0,
      iterations: 1,
      playMode: PlayMode.Normal
    })
    .onClick(() => {
      this.isOn = !this.isOn;
    })
  }
}

// MARK: - Linear Progress Bar Component

@Component
struct LinearProgressBar {
  progress: number = 0;
  tintColor: ResourceColor = AppTokens.Colors.primary;
  trackColor: ResourceColor = AppTokens.Colors.surfaceVariant;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(8)
        .backgroundColor(this.trackColor)
        .borderRadius(4)

      Row()
        .width(`${this.progress * 100}%`)
        .height(8)
        .backgroundColor(this.tintColor)
        .borderRadius(4)
    }
    .width('100%')
    .height(8)
  }
}

// MARK: - Waveform Chart Component

@Component
struct WaveformChart {
  @Prop @Watch('onProgressChange') progress: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  @State private canvasWidth: number = 0;
  @State private canvasHeight: number = 0;

  onProgressChange(): void {
    this.drawWaveform();
  }

  private drawWaveform(): void {
    const w: number = this.canvasWidth;
    const h: number = this.canvasHeight;
    if (w === 0 || h === 0) {
      return;
    }
    const step: number = w / 30;

    this.ctx.clearRect(0, 0, w, h);
    this.ctx.beginPath();
    this.ctx.strokeStyle = AppTokens.Colors.primary;
    this.ctx.lineWidth = 5;

    const initialPrevY: number = h / 2;
    this.ctx.moveTo(-step, initialPrevY);

    for (let i = 0; i <= 30; i++) {
      const x: number = i * step;
      const y: number = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3);
      this.ctx.lineTo(x, y);
    }
    this.ctx.stroke();
  }

  build() {
    Canvas(this.ctx)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawWaveform();
      })
      .onAreaChange((oldArea: Area, newArea: Area) => {
        this.canvasWidth = newArea.width as number;
        this.canvasHeight = newArea.height as number;
        this.drawWaveform();
      })
  }
}

// MARK: - Root Screen

@Entry
@Component
struct RootScreen {
  @State selectedChip: string = 'BTC';
  @State progress: number = 0.6;
  @State isAutoUpdate: boolean = true;
  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA'];

  build() {
    Stack() {
      Column() {
        // Top Bar
        Text('Crypto Market')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor(AppTokens.Colors.background)

        // Content area with gradient background
        Column({ space: AppTokens.Spacing.lg as number }) {
          // Filter Chips Row
          Row({ space: AppTokens.Spacing.md as number }) {
            ForEach(this.chips, (chipText: string) => {
              FilterChip({
                text: chipText,
                isSelected: this.selectedChip === chipText,
                onSelect: () => {
                  this.selectedChip = chipText;
                }
              })
            }, (chipText: string) => chipText)
          }

          // Chart Surface
          Stack() {
            WaveformChart({ progress: this.progress })
              .padding(AppTokens.Spacing.lg)
          }
          .width('100%')
          .height(260)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.Elevation.level2Radius,
            color: `rgba(0, 0, 0, ${AppTokens.Elevation.level2Opacity})`,
            offsetY: AppTokens.Elevation.level2Dy,
            offsetX: 0
          })

          // Price Variation Text
          Text('Price Variation')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.primary)

          // Linear Progress Indicator
          LinearProgressBar({
            progress: this.progress,
            tintColor: AppTokens.Colors.primary,
            trackColor: AppTokens.Colors.surfaceVariant
          })

          // Auto Update Row
          Row() {
            Text('Auto Update')
              .fontSize(14)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppTokens.Colors.onSurface)

            Blank()

            CustomSwitch({
              isOn: $isAutoUpdate,
              checkedThumbColor: AppTokens.Colors.secondary,
              uncheckedThumbColor: AppTokens.Colors.outline
            })
          }
          .width('100%')
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .layoutWeight(1)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            ['rgba(255, 225, 168, 0.3)', 0.0],
            [AppTokens.Colors.background, 0.5],
            ['rgba(168, 255, 225, 0.3)', 1.0]
          ]
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
