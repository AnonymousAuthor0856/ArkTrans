// 055*ProductDetail*en
// UI_TYPE: ECommerce
// STYLE_THEME: Monochrome
// LANG: en
// BASELINE_SIZE: 720x1280

class Marker {
  x: number = 0;
  y: number = 0;
  label: string = '';

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

  private addMarker() {
    const x = Math.floor(Math.random() * (500 - 100 + 1)) + 100;
    const y = Math.floor(Math.random() * (450 - 150 + 1)) + 150;
    this.markers.push(new Marker(x, y, 'New'));
  }

  private clearMarkers() {
    this.markers = [];
  }

  build() {
    Column() {
      Text('Product Detail')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111111')
        .margin({ bottom: 16 })

      Column() {
        Column()
          .width('100%')
          .height(160)
          .backgroundColor('#E5E5E5')
          .margin({ bottom: 12 })

        Text('Monochrome Bag')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
          .margin({ bottom: 8 })

        Text('A minimalist and timeless design piece.')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#777777')
          .margin({ bottom: 8 })

        Text('$79.00')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
          .margin({ bottom: 12 })

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
      .shadow({ radius: 8, color: '#1A000000', offsetX: 0, offsetY: 4 })
      .margin({ bottom: 16 })

      Stack() {
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('#E5E5E5')
          .borderRadius(14)

        ForEach(this.markers, (marker: Marker) => {
          Circle({ width: 28, height: 28 })
            .backgroundColor('#111111')
            .position({ x: marker.x, y: marker.y })
        })
      }
      .width('100%')
      .height(240)
      .padding(16)
      .backgroundColor('#F9F9F9')
      .borderRadius(14)
      .margin({ bottom: 16 })

      Row() {
        Button('Add Marker')
          .layoutWeight(1)
          .height(44)
          .backgroundColor('#333333')
          .fontColor('#FFFFFF')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .borderRadius(10)
          .onClick(() => this.addMarker())

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
          .onClick(() => this.clearMarkers())
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .alignItems(HorizontalAlign.Start)
  }
}