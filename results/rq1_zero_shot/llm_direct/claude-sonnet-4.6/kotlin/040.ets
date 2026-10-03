import { display } from '@kit.ArkUI';

// ============ Design Tokens ============
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FFFF7B00';
    export const secondary: string = '#FFFFD166';
    export const background: string = '#FFFFF6E5';
    export const surface: string = '#FFFFFFFF';
    export const surfaceVariant: string = '#FFFFF0C1';
    export const outline: string = '#FFE0C080';
    export const onPrimary: string = '#FFFFFFFF';
    export const onSecondary: string = '#FF3E2723';
    export const onBackground: string = '#FF3E2723';
    export const onSurface: string = '#FF3E2723';
  }

  export namespace Spacing {
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
  }

  export namespace Radii {
    export const small: number = 6;
    export const medium: number = 10;
    export const large: number = 14;
  }

  export namespace FontSizes {
    export const display: number = 28;
    export const headline: number = 20;
    export const title: number = 16;
    export const body: number = 14;
    export const label: number = 12;
  }
}

// ============ Data Model ============
interface ResultItem {
  id: number;
  title: string;
}

// ============ Filter Knob Canvas Component ============
@Component
struct FilterKnobCanvas {
  @State knobX: number = 160;
  @State knobY: number = 120;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawScene() {
    const w = this.ctx.width;
    const h = this.ctx.height;

    this.ctx.clearRect(0, 0, w, h);

    // Background rect
    this.ctx.fillStyle = AppTokens.Colors.surfaceVariant;
    this.ctx.fillRect(0, 0, w, h);

    // Radial gradient circle
    const cx = w / 2;
    const cy = h / 2;
    const grad = this.ctx.createRadialGradient(cx, cy, 0, cx, cy, 80);
    grad.addColorStop(0, AppTokens.Colors.secondary);
    grad.addColorStop(1, AppTokens.Colors.primary);
    this.ctx.fillStyle = grad;
    this.ctx.beginPath();
    this.ctx.arc(cx, cy, 80, 0, Math.PI * 2);
    this.ctx.fill();

    // Draggable knob
    this.ctx.fillStyle = AppTokens.Colors.primary;
    this.ctx.beginPath();
    this.ctx.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2);
    this.ctx.fill();
  }

  build() {
    Canvas(this.ctx)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawScene();
      })
      .gesture(
        PanGesture()
          .onActionUpdate((event: GestureEvent) => {
            const w = this.ctx.width;
            const h = this.ctx.height;
            const nx = Math.max(0, Math.min(w, this.knobX + event.offsetX));
            const ny = Math.max(0, Math.min(h, this.knobY + event.offsetY));
            this.knobX = nx;
            this.knobY = ny;
            this.drawScene();
          })
      )
  }
}

// ============ Result Card Component ============
@Component
struct ResultCard {
  item: ResultItem = { id: 0, title: '' };

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Placeholder image box
      Row()
        .width(96)
        .height(96)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Radii.medium)

      Text(this.item.title)
        .fontSize(AppTokens.FontSizes.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      Button('Add')
        .width('100%')
        .height(36)
        .fontSize(AppTokens.FontSizes.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Radii.medium)
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radii.large)
    .shadow({
      radius: 8,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 4
    })
  }
}

// ============ Root Screen ============
@Component
struct RootScreen {
  @State query: string = '';
  private filterTags: string[] = ['Popular', 'New', 'Discount', 'Premium'];
  private results: ResultItem[] = Array.from({ length: 6 }, (_, i) => ({
    id: i,
    title: `Result ${i + 1}`
  }));

  build() {
    Scroll() {
      Column({ space: AppTokens.Spacing.md }) {

        // Title
        Text('Retro Filter Search')
          .fontSize(AppTokens.FontSizes.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')

        // Search TextField
        TextInput({ placeholder: 'Search products', text: this.query })
          .placeholderColor(`${AppTokens.Colors.onSurface}66`)
          .placeholderFont({ size: AppTokens.FontSizes.body })
          .fontSize(AppTokens.FontSizes.body)
          .fontColor(AppTokens.Colors.onSurface)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Radii.medium)
          .borderWidth(1)
          .borderColor(AppTokens.Colors.outline)
          .width('100%')
          .height(48)
          .onChange((val: string) => {
            this.query = val;
          })

        // Filter Tag Buttons
        Row({ space: AppTokens.Spacing.sm }) {
          ForEach(this.filterTags, (tag: string) => {
            Button(tag)
              .height(36)
              .fontSize(AppTokens.FontSizes.label)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSecondary)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Radii.small)
              .padding({ left: 12, right: 12 })
          })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // Knob Canvas Area
        Stack() {
          FilterKnobCanvas()
            .width('100%')
            .height(148)
            .padding(16)
        }
        .width('100%')
        .height(180)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Radii.large)
        .clip(true)

        // Results Grid
        Grid() {
          ForEach(this.results, (item: ResultItem) => {
            GridItem() {
              ResultCard({ item: item })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppTokens.Spacing.lg)
        .rowsGap(AppTokens.Spacing.lg)
        .width('100%')
        .height(this.results.length > 0 ? Math.ceil(this.results.length / 2) * (200 + AppTokens.Spacing.lg) : 0)

        // Bottom padding
        Row().height(24)
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .scrollBar(BarState.Off)
  }
}

// ============ Entry Point ============
@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}