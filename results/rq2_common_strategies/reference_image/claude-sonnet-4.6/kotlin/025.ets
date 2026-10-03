/**
 * 026MindMapen | Productivity | Dark Neon | en | 720x1280
 * ArkTS / ArkUI port of the Compose "Neon Mind Map" screen.
 */

const NAME: string = '026MindMapen';
const UI_TYPE: string = 'Productivity';
const STYLE_THEME: string = 'Dark Neon';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

/** Design tokens: colors */
class AppColors {
  static readonly primary: string = '#00FFFF';
  static readonly secondary: string = '#00FF88';
  static readonly tertiary: string = '#BB86FC';
  static readonly background: string = '#0D0D0D';
  static readonly surface: string = '#1C1C1C';
  static readonly surfaceVariant: string = '#2E2E2E';
  static readonly outline: string = '#3F3F3F';
  static readonly success: string = '#00FFAA';
  static readonly warning: string = '#FFC107';
  static readonly error: string = '#FF1744';
  static readonly onPrimary: string = '#000000';
  static readonly onSecondary: string = '#000000';
  static readonly onTertiary: string = '#000000';
  static readonly onBackground: string = '#FFFFFF';
  static readonly onSurface: string = '#FFFFFF';
}

/** Design tokens: typography */
class AppTypography {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

/** Design tokens: spacing (vp) */
class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

/** Design tokens: elevation */
class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18);
}

/** A mind-map node position, in canvas coordinates (vp). */
class Point2D {
  x: number;
  y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

@Entry
@Component
struct MindMapPage {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  @State nodes: Point2D[] = [
    new Point2D(200, 400),
    new Point2D(500, 700),
    new Point2D(350, 250)
  ];
  @State currentColor: string = AppColors.primary;

  private draw(): void {
    const w: number = this.ctx.width;
    const h: number = this.ctx.height;
    if (w <= 0 || h <= 0) {
      return;
    }

    this.ctx.clearRect(0, 0, w, h);
    this.ctx.fillStyle = AppColors.background;
    this.ctx.fillRect(0, 0, w, h);

    // Edges: chain node[i-1] -> node[i]
    this.ctx.lineWidth = 6;
    this.ctx.lineCap = 'round';
    this.ctx.strokeStyle = this.currentColor;
    for (let i: number = 1; i < this.nodes.length; i++) {
      this.ctx.beginPath();
      this.ctx.moveTo(this.nodes[i - 1].x, this.nodes[i - 1].y);
      this.ctx.lineTo(this.nodes[i].x, this.nodes[i].y);
      this.ctx.stroke();
    }

    // Nodes
    this.ctx.fillStyle = this.currentColor;
    for (let i: number = 0; i < this.nodes.length; i++) {
      this.ctx.beginPath();
      this.ctx.arc(this.nodes[i].x, this.nodes[i].y, 20, 0, Math.PI * 2);
      this.ctx.fill();
    }
  }

  @Builder
  topBar() {
    Row() {
      Text('Neon Mind Map')
        .fontSize(AppTypography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
    }
    .width('100%')
    .height(84)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.background)
  }

  @Builder
  colorButton(label: string, color: string, labelColor: string) {
    Button(label)
      .type(ButtonType.Capsule)
      .backgroundColor(color)
      .fontColor(labelColor)
      .fontSize(AppTypography.bodySize)
      .fontWeight(FontWeight.Medium)
      .height(40)
      .onClick(() => {
        this.currentColor = color;
        this.draw();
      })
  }

  @Builder
  bottomBar() {
    Row({ space: AppSpacing.md }) {
      this.colorButton('Cyan', AppColors.primary, AppColors.onPrimary)
      this.colorButton('Green', AppColors.secondary, AppColors.onSecondary)
      this.colorButton('Purple', AppColors.tertiary, AppColors.onTertiary)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surfaceVariant)
    .shadow({
      radius: ElevationMapping.level1.radius,
      color: 'rgba(0,0,0,0.18)',
      offsetX: 0,
      offsetY: ElevationMapping.level1.dy
    })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.topBar()

        // Drawing surface: tap or drag to append nodes
        Canvas(this.ctx)
          .width('100%')
          .layoutWeight(1)
          .onReady(() => {
            this.draw();
          })
          .onAreaChange(() => {
            this.draw();
          })
          .onClick((event: ClickEvent) => {
            this.nodes.push(new Point2D(event.x, event.y));
            this.draw();
          })
          .gesture(
            PanGesture({ fingers: 1, distance: 5 })
              .onActionUpdate((event: GestureEvent) => {
                if (event.fingerList.length === 0) {
                  return;
                }
                const fx: number = event.fingerList[0].localX;
                const fy: number = event.fingerList[0].localY;
                const last: Point2D = this.nodes[this.nodes.length - 1];
                const dx: number = fx - last.x;
                const dy: number = fy - last.y;
                if (dx * dx + dy * dy > 900) {
                  this.nodes.push(new Point2D(fx, fy));
                  this.draw();
                }
              })
          )

        this.bottomBar()
      }
      .width('100%')
      .height('100%')

      // Floating action button
      Button() {
        Text('+')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
      }
      .type(ButtonType.Circle)
      .width(56)
      .height(56)
      .backgroundColor(AppColors.secondary)
      .margin({ right: AppSpacing.xl, bottom: 96 })
      .onClick(() => {
        const cw: number = this.ctx.width > 0 ? this.ctx.width : 360;
        const ch: number = this.ctx.height > 0 ? this.ctx.height : 600;
        const x: number = 60 + Math.random() * (cw - 120);
        const y: number = 80 + Math.random() * (ch - 160);
        this.nodes.push(new Point2D(x, y));
        this.draw();
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}