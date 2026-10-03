import { window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

/**
 * 设计系统代币，集中管理颜色、字号、间距、圆角与阴影。
 */
class Colors {
  static readonly primary: string = '#111111';
  static readonly secondary: string = '#333333';
  static readonly tertiary: string = '#777777';
  static readonly background: string = '#FFFFFF';
  static readonly surface: string = '#F9F9F9';
  static readonly surfaceVariant: string = '#E5E5E5';
  static readonly outline: string = '#CCCCCC';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#DC2626';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#111111';
  static readonly onBackground: string = '#111111';
  static readonly onSurface: string = '#111111';
}

class TypographyTokens {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class Shapes {
  static readonly smallCornerRadius: number = 6;
  static readonly mediumCornerRadius: number = 10;
  static readonly largeCornerRadius: number = 14;
}

class Spacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

/**
 * 阴影规格：elevation 为 Compose 中的层级参考值，
 * radius / dy / opacity 映射到 ArkUI 的 shadow 修饰符。
 */
class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
  color: string;

  constructor(elevation: number, radius: number, dy: number, opacity: number, color: string) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
    this.color = color;
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.1, '#1A000000');
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.12, '#1F000000');
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.15, '#26000000');
}

/**
 * 地图标记点数据模型。
 */
class Marker {
  id: number;
  x: number;
  y: number;
  label: string;

  constructor(id: number, x: number, y: number, label: string) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    new Marker(1, 120, 200, 'Store A'),
    new Marker(2, 360, 400, 'Store B')
  ];

  private nextId: number = 3;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  aboutToAppear(): void {
    // 全屏显示并隐藏顶部状态栏
    window.getLastWindow(getContext(this) as common.UIAbilityContext)
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      })
      .catch((err: Error) => {
        console.error(`window setup failed: ${err.message}`);
      });
  }

  private drawMarkers(): void {
    const ctx: CanvasRenderingContext2D = this.context;
    const w: number = ctx.width;
    const h: number = ctx.height;

    ctx.clearRect(0, 0, w, h);

    // 背景矩形
    ctx.fillStyle = Colors.surfaceVariant;
    ctx.fillRect(0, 0, w, h);

    // 标记点圆
    ctx.fillStyle = Colors.primary;
    for (let i = 0; i < this.markers.length; i++) {
      const marker: Marker = this.markers[i];
      ctx.beginPath();
      ctx.arc(marker.x, marker.y, 14, 0, Math.PI * 2);
      ctx.fill();
    }
  }

  private addMarker(): void {
    const next: Marker[] = this.markers.slice();
    next.push(new Marker(
      this.nextId,
      Math.floor(Math.random() * 401) + 100,
      Math.floor(Math.random() * 301) + 150,
      'New'
    ));
    this.nextId++;
    this.markers = next;
    this.drawMarkers();
  }

  private clearMarkers(): void {
    this.markers = [];
    this.drawMarkers();
  }

  build() {
    Column({ space: Spacing.lg }) {
      Text('Product Detail')
        .fontSize(TypographyTokens.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.primary)

      // 产品信息卡片
      Column({ space: Spacing.md }) {
        Row() {
        }
        .width('100%')
        .height(160)
        .backgroundColor(Colors.surfaceVariant)

        Text('Monochrome Bag')
          .fontSize(TypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)

        Text('A minimalist and timeless design piece.')
          .fontSize(TypographyTokens.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(Colors.tertiary)

        Text('$79.00')
          .fontSize(TypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.primary)

        Button() {
          Text('Add to Cart')
            .fontSize(TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onPrimary)
        }
        .type(ButtonType.Normal)
        .width('100%')
        .height(48)
        .padding(0)
        .backgroundColor(Colors.primary)
        .borderRadius(Shapes.mediumCornerRadius)
        .onClick(() => {
          console.info('Add to Cart tapped!');
        })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding(Spacing.lg)
      .backgroundColor(Colors.surface)
      .borderRadius(Shapes.largeCornerRadius)
      .shadow({
        radius: ElevationMapping.level2.radius,
        color: ElevationMapping.level2.color,
        offsetX: 0,
        offsetY: ElevationMapping.level2.dy
      })

      // 地图区域（Canvas 绘制标记点）
      Stack() {
        Canvas(this.context)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawMarkers();
          })
      }
      .width('100%')
      .height(240)
      .padding(Spacing.lg)
      .backgroundColor(Colors.surface)
      .borderRadius(Shapes.largeCornerRadius)

      // 底部操作按钮行
      Row({ space: Spacing.md }) {
        Button() {
          Text('Add Marker')
            .fontSize(TypographyTokens.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSecondary)
        }
        .type(ButtonType.Normal)
        .layoutWeight(1)
        .height(44)
        .padding(0)
        .backgroundColor(Colors.secondary)
        .borderRadius(Shapes.mediumCornerRadius)
        .onClick(() => {
          this.addMarker();
        })

        Button() {
          Text('Clear')
            .fontSize(TypographyTokens.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onTertiary)
        }
        .type(ButtonType.Normal)
        .layoutWeight(1)
        .height(44)
        .padding(0)
        .backgroundColor(Colors.tertiary)
        .borderRadius(Shapes.mediumCornerRadius)
        .onClick(() => {
          this.clearMarkers();
        })
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .width('100%')
    .height('100%')
    .padding(Spacing.lg)
    .backgroundColor(Colors.background)
  }
}