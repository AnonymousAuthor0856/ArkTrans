import { drawing } from '@kit.ArkGraphics2D';

interface MarkerData {
  x: number;
  y: number;
  label: string;
}

@Entry
@Component
struct RootScreen {
  @State markers: MarkerData[] = [
    { x: 120, y: 200, label: 'Store A' },
    { x: 360, y: 400, label: 'Store B' }
  ];

  build() {
    Scroll() {
      Column({ space: 16 }) {
        Text('Product Detail')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')
          .alignSelf(ItemAlign.Start)

        Column({ space: 12 }) {
          Row()
            .width('100%')
            .height(160)
            .backgroundColor('#E5E5E5')
            .borderRadius(10)

          Text('Monochrome Bag')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#111111')
            .alignSelf(ItemAlign.Start)

          Text('A minimalist and timeless design piece.')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#777777')
            .alignSelf(ItemAlign.Start)

          Text('$79.00')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#111111')
            .alignSelf(ItemAlign.Start)

          Button('Add to Cart')
            .width('100%')
            .height(48)
            .backgroundColor('#111111')
            .fontColor('#FFFFFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .borderRadius(10)
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#F9F9F9')
        .borderRadius(14)
        .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })

        Stack() {
          Canvas(this.context)
            .width('100%')
            .height(240)
            .onReady(() => {
              this.drawCanvas();
            })
        }
        .width('100%')
        .height(240)
        .backgroundColor('#F9F9F9')
        .borderRadius(14)

        Row({ space: 12 }) {
          Button('Add Marker')
            .layoutWeight(1)
            .height(44)
            .backgroundColor('#333333')
            .fontColor('#FFFFFF')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .borderRadius(10)
            .onClick(() => {
              const x = Math.floor(Math.random() * 400) + 100;
              const y = Math.floor(Math.random() * 300) + 150;
              this.markers.push({ x, y, label: 'New' });
              this.drawCanvas();
            })

          Button('Clear')
            .layoutWeight(1)
            .height(44)
            .backgroundColor('#777777')
            .fontColor('#111111')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .borderRadius(10)
            .onClick(() => {
              this.markers = [];
              this.drawCanvas();
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .padding(16)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  );

  private drawCanvas() {
    const ctx = this.context;
    if (!ctx) return;

    ctx.clearRect(0, 0, ctx.width, ctx.height);

    ctx.fillStyle = '#E5E5E5';
    ctx.fillRect(0, 0, ctx.width, ctx.height);

    this.markers.forEach(marker => {
      ctx.beginPath();
      ctx.arc(marker.x, marker.y, 14, 0, Math.PI * 2);
      ctx.fillStyle = '#111111';
      ctx.fill();
      ctx.closePath();
    });
  }
}