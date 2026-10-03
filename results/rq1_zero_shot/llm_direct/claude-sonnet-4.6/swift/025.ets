import { display } from '@kit.ArkUI';

// AppTokens
const AppColors = {
  primary: 0xFF00FFFF,
  secondary: 0xFF00FF88,
  tertiary: 0xFFBB86FC,
  background: 0xFF0D0D0D,
  surface: 0xFF1C1C1C,
  surfaceVariant: 0xFF2E2E2E,
  outline: 0xFF3F3F3F,
  success: 0xFF00FFAA,
  warning: 0xFFFFC107,
  error: 0xFFFF1744,
  onPrimary: 0xFF000000,
  onSecondary: 0xFF000000,
  onTertiary: 0xFF000000,
  onBackground: 0xFFFFFFFF,
  onSurface: 0xFFFFFFFF,
};

const AppSpacing = {
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
};

const ElevationLevel1 = {
  radius: 4,
  dy: 2,
  opacity: 0.12,
};

const ElevationLevel2 = {
  radius: 8,
  dy: 4,
  opacity: 0.18,
};

interface NodePoint {
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  @State nodes: NodePoint[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 },
  ];
  @State currentColor: number = AppColors.primary;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  hexToRgba(hex: number, alpha: number = 1.0): string {
    const r = (hex >> 16) & 0xFF;
    const g = (hex >> 8) & 0xFF;
    const b = hex & 0xFF;
    return `rgba(${r},${g},${b},${alpha})`;
  }

  drawCanvas() {
    const ctx = this.canvasContext;
    ctx.clearRect(0, 0, ctx.width, ctx.height);

    // Draw lines
    if (this.nodes.length > 1) {
      ctx.strokeStyle = this.hexToRgba(this.currentColor);
      ctx.lineWidth = 6;
      ctx.beginPath();
      for (let i = 1; i < this.nodes.length; i++) {
        const start = this.nodes[i - 1];
        const end = this.nodes[i];
        ctx.moveTo(start.x, start.y);
        ctx.lineTo(end.x, end.y);
      }
      ctx.stroke();
    }

    // Draw nodes
    ctx.fillStyle = this.hexToRgba(this.currentColor);
    for (const node of this.nodes) {
      ctx.beginPath();
      ctx.arc(node.x, node.y, 20, 0, Math.PI * 2);
      ctx.fill();
    }
  }

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppColors.background)

      // Canvas layer
      Canvas(this.canvasContext)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.drawCanvas();
        })
        .onTouch((event: TouchEvent) => {
          if (
            event.type === TouchType.Move ||
            event.type === TouchType.Down
          ) {
            const touch = event.touches[0];
            this.nodes = [...this.nodes, { x: touch.x, y: touch.y }];
            this.drawCanvas();
          }
        })

      // Top Bar
      Column() {
        Text('Neon Mind Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
          .backgroundColor(AppColors.background)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)
      .height('100%')

      // Bottom Bar
      Column() {
        Row({ space: AppSpacing.md }) {
          // Cyan Button
          Button('Cyan')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(15)
            .padding({
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              top: AppSpacing.sm,
              bottom: AppSpacing.sm,
            })
            .onClick(() => {
              this.currentColor = AppColors.primary;
              this.drawCanvas();
            })

          // Green Button
          Button('Green')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(15)
            .padding({
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              top: AppSpacing.sm,
              bottom: AppSpacing.sm,
            })
            .onClick(() => {
              this.currentColor = AppColors.secondary;
              this.drawCanvas();
            })

          // Purple Button
          Button('Purple')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onTertiary)
            .backgroundColor(AppColors.tertiary)
            .borderRadius(15)
            .padding({
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              top: AppSpacing.sm,
              bottom: AppSpacing.sm,
            })
            .onClick(() => {
              this.currentColor = AppColors.tertiary;
              this.drawCanvas();
            })
        }
        .padding(AppSpacing.md)
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppColors.surfaceVariant)
        .shadow({
          color: `rgba(0,0,0,${ElevationLevel1.opacity})`,
          radius: ElevationLevel1.radius,
          offsetX: 0,
          offsetY: -ElevationLevel1.dy,
        })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)

      // FAB
      Column() {
        Row() {
          Button('+')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .width(56)
            .height(56)
            .backgroundColor(AppColors.secondary)
            .borderRadius(28)
            .shadow({
              color: `rgba(0,0,0,${ElevationLevel2.opacity})`,
              radius: ElevationLevel2.radius,
              offsetX: 0,
              offsetY: ElevationLevel2.dy,
            })
            .onClick(() => {
              const screenInfo = display.getDefaultDisplaySync();
              const screenWidth = screenInfo.width;
              const screenHeight = screenInfo.height;
              const randomX = Math.random() * (screenWidth - 200) + 100;
              const randomY = Math.random() * (screenHeight - 400) + 200;
              this.nodes = [...this.nodes, { x: randomX, y: randomY }];
              this.drawCanvas();
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.End)
        .padding({ right: AppSpacing.lg, bottom: AppSpacing.lg })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height('100%')
  }
}