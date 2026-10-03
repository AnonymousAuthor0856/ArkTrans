@Entry
@Component
struct RootScreen {
  @State items: Array<string> = ['Group A', 'Group B', 'Group C'];

  build() {
    Column({ space: 16 }) {
      Text('Retro Group Buy')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3E2723')
        .width('100%');

      Column({ space: 10 }) {
        Text('Live Deals Map')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#3E2723')
          .width('100%');

        Stack() {
        }
        .width('100%')
        .height(220)
        .backgroundColor('#FFECB3')
        .borderRadius(10);
      }
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
      .shadow({
        radius: 8,
        color: 'rgba(0, 0, 0, 0.15)',
        offsetX: 0,
        offsetY: 4
      });

      Row()
        .height(6);

      Row({ space: 10 }) {
        Button('Add Group')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#3E2723')
          .backgroundColor('#FFC107')
          .borderRadius(10)
          .height(48)
          .layoutWeight(1)
          .onClick(() => {
            this.items.push('New');
          });

        Button('Clear')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#3E2723')
          .backgroundColor('#FF8C00')
          .borderRadius(10)
          .height(48)
          .layoutWeight(1)
          .onClick(() => {
            while (this.items.length > 0) {
              this.items.pop();
            }
          });
      }
      .width('100%');

      Column({ space: 6 }) {
        Text('Active Groups')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF8C00')
          .width('100%');

        ForEach(this.items, (item: string, index: number) => {
          Row() {
            Text(item)
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor('#3E2723')
              .layoutWeight(1);

            Row() {
            }
            .width(14)
            .height(14)
            .borderRadius(7)
            .backgroundColor('#FF8C00');
          }
          .width('100%');
        }, (item: string, index: number) => index.toString());
      }
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
      .shadow({
        radius: 4,
        color: 'rgba(0, 0, 0, 0.10)',
        offsetX: 0,
        offsetY: 2
      });

      Column() {
      }
      .layoutWeight(1);
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFF8E1');
  }
}
