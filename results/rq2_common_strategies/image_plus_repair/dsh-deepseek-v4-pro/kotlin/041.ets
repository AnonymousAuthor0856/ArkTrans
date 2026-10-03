interface Marker {
  x: number;
  y: number;
  label: string;
}

const C_PRIMARY: string = '#111111';
const C_SECONDARY: string = '#333333';
const C_TERTIARY: string = '#777777';
const C_BACKGROUND: string = '#FFFFFF';
const C_SURFACE: string = '#F9F9F9';
const C_SURFACE_VARIANT: string = '#E5E5E5';
const C_ON_PRIMARY: string = '#FFFFFF';
const C_ON_SECONDARY: string = '#FFFFFF';
const C_ON_TERTIARY: string = '#111111';
const C_ON_SURFACE: string = '#111111';

@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    { x: 120, y: 200, label: 'Store A' } as Marker,
    { x: 360, y: 400, label: 'Store B' } as Marker
  ];

  build() {
    Column({ space: 16 }) {
      Text('Product Detail')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(C_PRIMARY)

      Column() {
        Column({ space: 12 }) {
          Row()
            .width('100%')
            .height(160)
            .backgroundColor(C_SURFACE_VARIANT)

          Text('Monochrome Bag')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_ON_SURFACE)

          Text('A minimalist and timeless design piece.')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(C_TERTIARY)

          Text('$79.00')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_PRIMARY)

          Button('Add to Cart')
            .width('100%')
            .height(48)
            .backgroundColor(C_PRIMARY)
            .fontColor(C_ON_PRIMARY)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .borderRadius(10)
            .onClick(() => {})
        }
        .width('100%')
        .padding(16)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .backgroundColor(C_SURFACE)
      .borderRadius(14)
      .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })

      Stack() {
        Stack() {
          ForEach(this.markers, (m: Marker) => {
            Circle({ width: 28, height: 28 })
              .fill(C_PRIMARY)
              .position({ x: m.x - 14, y: m.y - 14 })
          }, (m: Marker, index: number) => index + '_' + m.x + '_' + m.y)
        }
        .width('100%')
        .height('100%')
        .backgroundColor(C_SURFACE_VARIANT)
      }
      .width('100%')
      .height(240)
      .backgroundColor(C_SURFACE)
      .borderRadius(14)
      .padding(16)

      Row() {
        Button('Add Marker')
          .layoutWeight(1)
          .height(44)
          .backgroundColor(C_SECONDARY)
          .fontColor(C_ON_SECONDARY)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .borderRadius(10)
          .onClick(() => {
            const x: number = 100 + Math.floor(Math.random() * 400);
            const y: number = 150 + Math.floor(Math.random() * 300);
            const m: Marker = { x: x, y: y, label: 'New' };
            this.markers = this.markers.concat([m]);
          })

        Row().width(12)

        Button('Clear')
          .layoutWeight(1)
          .height(44)
          .backgroundColor(C_TERTIARY)
          .fontColor(C_ON_TERTIARY)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .borderRadius(10)
          .onClick(() => {
            this.markers = [];
          })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor(C_BACKGROUND)
    .alignItems(HorizontalAlign.Start)
  }
}
