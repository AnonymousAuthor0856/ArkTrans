// Product Detail - Monochrome E-Commerce
// Converted from Kotlin Compose to ArkTS

class Marker {
  x: number;
  y: number;
  label: string;

  constructor(x: number, y: number, label: string) {
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

@Entry
@Component
struct ProductDetailPage {
  @State markers: Marker[] = [
    new Marker(120, 200, 'Store A'),
    new Marker(360, 400, 'Store B')
  ];

  build() {
    Column() {
      // Title
      Text('Product Detail')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111111')
        .width('100%')
        .margin({ bottom: 16 });

      // Product Card
      Column() {
        // Product image placeholder
        Row() {
        }
        .width('100%')
        .height(160)
        .backgroundColor('#E5E5E5')
        .borderRadius({ topLeft: 14, topRight: 14, bottomLeft: 0, bottomRight: 0 });

        Column() {
          Text('Monochrome Bag')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#111111');

          Text('A minimalist and timeless design piece.')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#777777');

          Text('$79.00')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#111111');

          Button('Add to Cart')
            .width('100%')
            .height(48)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#111111')
            .borderRadius(10)
            .onClick(() => {
            });
        }
        .width('100%')
        .padding(16)
        .justifyContent(FlexAlign.Start)
        .space(12)
        .backgroundColor('#F9F9F9')
        .borderRadius({ bottomLeft: 14, bottomRight: 14, topLeft: 0, topRight: 0 });
      }
      .width('100%')
      .borderRadius(14)
      .shadow({
        radius: 8,
        color: 'rgba(0, 0, 0, 0.12)',
        offsetY: 4
      })
      .margin({ bottom: 16 });

      // Map / Marker Canvas
      Stack() {
        Canvas(this.canvasSettings)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawMarkers();
          })
          .padding(16);
      }
      .width('100%')
      .height(240)
      .backgroundColor('#F9F9F9')
      .borderRadius(14)
      .margin({ bottom: 16 });

      // Action Buttons Row
      Row() {
        Button('Add Marker')
          .layoutWeight(1)
          .height(44)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#333333')
          .borderRadius(10)
          .onClick(() => {
            let newX = 100 + Math.random() * 400;
            let newY = 150 + Math.random() * 300;
            this.markers.push(new Marker(newX, newY, 'New'));
          });

        Blank().width(12);

        Button('Clear')
          .layoutWeight(1)
          .height(44)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
          .backgroundColor('#777777')
          .borderRadius(10)
          .onClick(() => {
            this.markers = [];
          });
      }
      .width('100%')
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .justifyContent(FlexAlign.Start);
  }

  private canvasSettings: CanvasRenderingContext2D | null = null;

  drawMarkers(): void {
    const ctx = this.canvasSettings;
    if (!ctx) return;

    ctx.fillStyle = '#E5E5E5';
    ctx.fillRect(0, 0, 400, 220);

    for (let i = 0; i < this.markers.length; i++) {
      const marker = this.markers[i];
      ctx.beginPath();
      ctx.arc(marker.x, marker.y, 14, 0, Math.PI * 2);
      ctx.fillStyle = '#111111';
      ctx.fill();
    }
  }
}
