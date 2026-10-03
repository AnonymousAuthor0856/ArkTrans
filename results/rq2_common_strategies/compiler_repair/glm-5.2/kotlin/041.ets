// Index.ets

interface TextStyleSpec {
  fontSize: number;
  fontWeight: number;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
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

@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    new Marker(120, 200, 'Store A'),
    new Marker(360, 400, 'Store B')
  ];

  private displayStyle: TextStyleSpec = { fontSize: 28, fontWeight: FontWeight.Bold };
  private titleStyle: TextStyleSpec = { fontSize: 18, fontWeight: FontWeight.Medium };
  private bodyStyle: TextStyleSpec = { fontSize: 14, fontWeight: FontWeight.Normal };
  private labelStyle: TextStyleSpec = { fontSize: 12, fontWeight: FontWeight.Medium };

  private level2: ShadowSpec = { elevation: 4, radius: 8, dy: 4, opacity: 0.12 };

  addMarker() {
    const x = Math.floor(Math.random() * (500 - 100 + 1)) + 100;
    const y = Math.floor(Math.random() * (450 - 150 + 1)) + 150;
    this.markers.push(new Marker(x, y, 'New'));
  }

  clearMarkers() {
    this.markers = [];
  }

  build() {
    Column() {
      Text('Product Detail')
        .fontSize(this.displayStyle.fontSize)
        .fontWeight(this.displayStyle.fontWeight)
        .fontColor('#111111')
        .margin({ bottom: 16 })

      Column() {
        Column()
          .width('100%')
          .height(160)
          .backgroundColor('#E5E5E5')
          .borderRadius(14)
          .margin({ bottom: 12 })

        Text('Monochrome Bag')
          .fontSize(this.titleStyle.fontSize)
          .fontWeight(this.titleStyle.fontWeight)
          .fontColor('#111111')
          .margin({ bottom: 8 })

        Text('A minimalist and timeless design piece.')
          .fontSize(this.bodyStyle.fontSize)
          .fontWeight(this.bodyStyle.fontWeight)
          .fontColor('#777777')
          .margin({ bottom: 8 })

        Text('$79.00')
          .fontSize(this.titleStyle.fontSize)
          .fontWeight(this.titleStyle.fontWeight)
          .fontColor('#111111')
          .margin({ bottom: 12 })

        Button('Add to Cart')
          .type(ButtonType.Capsule)
          .width('100%')
          .height(48)
          .backgroundColor('#111111')
          .fontColor('#FFFFFF')
          .fontSize(this.titleStyle.fontSize)
          .fontWeight(this.titleStyle.fontWeight)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F9F9F9')
      .borderRadius(14)
      .shadow({
        radius: this.level2.radius,
        color: `rgba(0,0,0,${this.level2.opacity})`,
        offsetX: 0,
        offsetY: this.level2.dy
      })
      .margin({ bottom: 16 })

      Stack({ alignContent: Alignment.TopStart }) {
        ForEach(this.markers, (marker: Marker) => {
          Circle({ width: 28, height: 28 })
            .fill('#111111')
            .position({ x: marker.x, y: marker.y })
        })
      }
      .width('100%')
      .height(240)
      .backgroundColor('#F9F9F9')
      .borderRadius(14)
      .margin({ bottom: 16 })

      Row() {
        Button('Add Marker')
          .type(ButtonType.Capsule)
          .layoutWeight(1)
          .height(44)
          .backgroundColor('#333333')
          .fontColor('#FFFFFF')
          .fontSize(this.labelStyle.fontSize)
          .fontWeight(this.labelStyle.fontWeight)
          .onClick(() => this.addMarker())

        Blank().width(12)

        Button('Clear')
          .type(ButtonType.Capsule)
          .layoutWeight(1)
          .height(44)
          .backgroundColor('#777777')
          .fontColor('#111111')
          .fontSize(this.labelStyle.fontSize)
          .fontWeight(this.labelStyle.fontWeight)
          .onClick(() => this.clearMarkers())
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .alignItems(HorizontalAlign.Start)
  }
}