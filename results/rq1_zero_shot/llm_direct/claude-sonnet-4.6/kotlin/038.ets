import { router } from '@kit.ArkUI';

// Token definitions
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#06B6D4';
    export const secondary: string = '#3B82F6';
    export const tertiary: string = '#8B5CF6';
    export const background: string = '#F0F9FF';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#E0F2FE';
    export const outline: string = '#BAE6FD';
    export const success: string = '#22C55E';
    export const warning: string = '#FACC15';
    export const error: string = '#EF4444';
    export const onPrimary: string = '#FFFFFF';
    export const onSecondary: string = '#FFFFFF';
    export const onTertiary: string = '#FFFFFF';
    export const onBackground: string = '#0F172A';
    export const onSurface: string = '#0F172A';
  }

  export namespace Spacing {
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
    export const xl: number = 24;
    export const xxl: number = 32;
  }
}

interface MarkerData {
  x: number;
  y: number;
  label: string;
}

@Entry
@Component
struct RootScreen {
  @State markers: MarkerData[] = [
    { x: 120, y: 200, label: 'A1' },
    { x: 300, y: 400, label: 'B2' },
    { x: 520, y: 600, label: 'C3' },
  ];
  @State scanning: boolean = false;
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawCanvas() {
    const ctx = this.context;
    ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    const centerX = this.canvasWidth / 2;
    const centerY = this.canvasHeight / 2;
    const radius = Math.min(this.canvasWidth, this.canvasHeight) / 2.5;

    // Draw background circle
    ctx.beginPath();
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2);
    ctx.fillStyle = AppTokens.Colors.surfaceVariant;
    ctx.fill();

    // Draw markers
    this.markers.forEach((marker) => {
      ctx.beginPath();
      ctx.arc(marker.x, marker.y, 12, 0, Math.PI * 2);
      ctx.fillStyle = AppTokens.Colors.primary;
      ctx.fill();
    });
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Invoice Scanner')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main content
      Column({ space: AppTokens.Spacing.lg }) {
        // Canvas card
        Column() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .padding(AppTokens.Spacing.md)
            .onReady(() => {
              this.canvasWidth = this.context.width;
              this.canvasHeight = this.context.height;
              this.drawCanvas();
            })
        }
        .width('100%')
        .height(400)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(20)
        .shadow({
          radius: 8,
          color: '#1E000000',
          offsetX: 0,
          offsetY: 4
        })
        .clip(true)

        // Scanning toggle row
        Row() {
          Text('Scanning Active')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)

          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .selectedColor(AppTokens.Colors.secondary)
            .switchPointColor(AppTokens.Colors.outline)
            .onChange((isOn: boolean) => {
              this.scanning = isOn;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // Add Marker button
        Button('Add Marker')
          .width('100%')
          .height(48)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(12)
          .onClick(() => {
            if (this.scanning) {
              const newX = Math.floor(Math.random() * (580 - 80 + 1)) + 80;
              const newY = Math.floor(Math.random() * (650 - 150 + 1)) + 150;
              const newLabel = `N${this.markers.length + 1}`;
              this.markers = [...this.markers, { x: newX, y: newY, label: newLabel }];
              this.drawCanvas();
            }
          })
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#4D3B82F6', 0.0],
          ['#F0F9FF', 0.5],
          ['#4D06B6D4', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}