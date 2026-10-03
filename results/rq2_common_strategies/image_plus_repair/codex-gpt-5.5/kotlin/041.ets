interface Marker {
  id: number;
  x: number;
  y: number;
}

const PRIMARY: string = '#111111';
const SECONDARY: string = '#333333';
const TERTIARY: string = '#777777';
const BACKGROUND: string = '#FFFFFF';
const SURFACE: string = '#F9F9F9';
const SURFACE_VARIANT: string = '#E5E5E5';
const WHITE: string = '#FFFFFF';

@Entry
@Component
struct Index {
  @State private markers: Marker[] = [
    { id: 0, x: 120, y: 200 },
    { id: 1, x: 360, y: 400 }
  ];
  private nextMarkerId: number = 2;

  build() {
    Scroll() {
      Column({ space: 0 }) {
        Text('Product Detail')
          .width('100%')
          .fontSize(56)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY)
          .margin({ top: 38, bottom: 32 })
          .textAlign(TextAlign.Start);

        Column({ space: 0 }) {
          Column()
            .width('100%')
            .height(320)
            .backgroundColor(SURFACE_VARIANT);

          Text('Monochrome Bag')
            .width('100%')
            .fontSize(36)
            .fontWeight(FontWeight.Medium)
            .fontColor(PRIMARY)
            .margin({ top: 25 });

          Text('A minimalist and timeless design piece.')
            .width('100%')
            .fontSize(28)
            .fontColor(TERTIARY)
            .margin({ top: 24 });

          Text('$79.00')
            .width('100%')
            .fontSize(36)
            .fontWeight(FontWeight.Medium)
            .fontColor(PRIMARY)
            .margin({ top: 24 });

          Button('Add to Cart')
            .width('100%')
            .height(96)
            .fontSize(36)
            .fontWeight(FontWeight.Medium)
            .fontColor(WHITE)
            .backgroundColor(PRIMARY)
            .borderRadius(20)
            .margin({ top: 24 })
            .onClick(() => {});
        }
        .width('100%')
        .padding(32)
        .backgroundColor(SURFACE)
        .borderRadius(28)
        .shadow({
          radius: 14,
          color: '#26000000',
          offsetX: 0,
          offsetY: 8
        });

        Stack() {
          Column()
            .width('100%')
            .height(360)
            .backgroundColor(SURFACE_VARIANT);

          ForEach(this.markers, (marker: Marker) => {
            Circle()
              .width(28)
              .height(28)
              .fill(PRIMARY)
              .position({ x: marker.x, y: marker.y });
          }, (marker: Marker) => marker.id.toString());
        }
        .width('100%')
        .height(392)
        .padding(32)
        .margin({ top: 32 })
        .backgroundColor(SURFACE)
        .borderRadius(28);

        Row({ space: 16 }) {
          Button('Add Marker')
            .layoutWeight(1)
            .height(88)
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(WHITE)
            .backgroundColor(SECONDARY)
            .borderRadius(20)
            .onClick(() => {
              const marker: Marker = {
                id: this.nextMarkerId++,
                x: 100 + Math.floor(Math.random() * 400),
                y: 150 + Math.floor(Math.random() * 300)
              };
              this.markers = [...this.markers, marker];
            });

          Button('Clear')
            .layoutWeight(1)
            .height(88)
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(PRIMARY)
            .backgroundColor(TERTIARY)
            .borderRadius(20)
            .onClick(() => {
              this.markers = [];
            });
        }
        .width('100%')
        .margin({ top: 32, bottom: 32 });
      }
      .width('100%')
      .padding({ left: 32, right: 32 })
      .backgroundColor(BACKGROUND);
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .backgroundColor(BACKGROUND);
  }
}
