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
  @State private markers: Marker[] = [new Marker(120, 200, 'Store A'), new Marker(360, 400, 'Store B')];

  @Builder
  ProductCard() {
    Column() {
      Rect()
        .width('100%')
        .height(160)
        .fill('#E5E5E5')
      Text('Monochrome Bag')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#111111')
        .margin({ top: 12 })
      Text('A minimalist and timeless design piece.')
        .fontSize(14)
        .fontColor('#777777')
        .margin({ top: 12 })
      Text('$79.00')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#111111')
        .margin({ top: 12 })
      Button('Add to Cart')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#111111')
        .width('100%')
        .height(48)
        .borderRadius(10)
        .margin({ top: 12 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .backgroundColor('#F9F9F9')
    .borderRadius(14)
    .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })
  }

  @Builder
  MapArea() {
    Stack() {
      Rect()
        .width('100%')
        .height(240)
        .fill('#E5E5E5')
        .radius(14)
      ForEach(this.markers, (marker: Marker, index: number) => {
        Circle()
          .width(28)
          .height(28)
          .fill('#111111')
          .position({ x: marker.x, y: marker.y })
      }, (marker: Marker, index: number) => marker.label + index.toString())
    }
    .width('100%')
    .height(240)
    .backgroundColor('#F9F9F9')
    .borderRadius(14)
  }

  build() {
    Column() {
      Text('Product Detail')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111111')
        .width('100%')
      this.ProductCard()
        .margin({ top: 16 })
      this.MapArea()
        .margin({ top: 16 })
      Row() {
        Button('Add Marker')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#333333')
          .height(44)
          .borderRadius(10)
          .layoutWeight(1)
          .onClick(() => {
            const next = this.markers.slice();
            next.push(new Marker(100 + (next.length * 83) % 400, 150 + (next.length * 79) % 300, 'New'));
            this.markers = next;
          })
        Button('Clear')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
          .backgroundColor('#777777')
          .height(44)
          .borderRadius(10)
          .layoutWeight(1)
          .margin({ left: 12 })
          .onClick(() => {
            this.markers = [];
          })
      }
      .width('100%')
      .margin({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .backgroundColor('#FFFFFF')
  }
}
