@Entry
@Component
struct RootScreen {
  @State markers: Array<Marker> = [
    new Marker(120, 200, "Store A"),
    new Marker(360, 400, "Store B")
  ];

  build() {
    Column() {
      Column() {
        Text('Product Detail')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')
          .margin({ bottom: 16 })

        Column() {
          Column() {
            Row()
              .width('100%')
              .height(160)
              .backgroundColor('#E5E5E5')
              .borderRadius(14)

            Text('Monochrome Bag')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111111')
              .margin({ top: 12 })

            Text('A minimalist and timeless design piece.')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor('#777777')
              .margin({ top: 8 })

            Text('$79.00')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111111')
              .margin({ top: 8 })

            Button('Add to Cart')
              .width('100%')
              .height(48)
              .backgroundColor('#111111')
              .fontColor('#FFFFFF')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .borderRadius(10)
              .margin({ top: 12 })
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#F9F9F9')
          .borderRadius(14)
        }
        .width('100%')
        .borderRadius(14)
        .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.12)', offsetY: 4 })

        Column() {
          Canvas(this.markers)
            .width('100%')
            .height(240)
            .backgroundColor('#F9F9F9')
            .borderRadius(14)
        }
        .width('100%')
        .height(240)
        .backgroundColor('#F9F9F9')
        .borderRadius(14)
        .margin({ top: 16 })

        Row() {
          Button('Add Marker')
            .layoutWeight(1)
            .height(44)
            .backgroundColor('#333333')
            .fontColor('#FFFFFF')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .borderRadius(10)
            .onClick(() => {
              this.markers.push(new Marker(
                Math.floor(Math.random() * 400) + 100,
                Math.floor(Math.random() * 300) + 150,
                'New'
              ));
            })

          Blank()
            .width(12)

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
            })
        }
        .width('100%')
        .margin({ top: 16 })
      }
      .width('100%')
      .height('100%')
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

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

@Builder
function Canvas(markers: Array<Marker>) {
  CanvasRender(markers)
}

@Component
struct CanvasRender {
  @Prop markers: Array<Marker>;

  build() {
    Stack() {
      Canvas(this.markers)
        .width('100%')
        .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

@Builder
function CanvasContent(markers: Array<Marker>) {
  Canvas(this.markers)
    .width('100%')
    .height('100%')
    .onReady(() => {
      const ctx = this.getContext('2d');
      ctx.fillStyle = '#E5E5E5';
      ctx.fillRect(0, 0, this.width, this.height);
      for (let i = 0; i < markers.length; i++) {
        ctx.fillStyle = '#111111';
        ctx.beginPath();
        ctx.arc(markers[i].x, markers[i].y, 14, 0, 2 * Math.PI);
        ctx.fill();
      }
    })
}