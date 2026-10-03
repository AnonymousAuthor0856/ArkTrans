@Entry
@Component
struct RootScreen {
  @State pinX1: number = 150;
  @State pinY1: number = 250;
  @State pinLabel1: string = 'Group A';
  @State pinX2: number = 350;
  @State pinY2: number = 420;
  @State pinLabel2: string = 'Group B';
  @State pinX3: number = 520;
  @State pinY3: number = 310;
  @State pinLabel3: string = 'Group C';
  @State pinCount: number = 3;

  build() {
    Stack() {
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
            Row() {
            }
            .width(28)
            .height(28)
            .borderRadius(14)
            .backgroundColor('#FF8C00')
            .position({ x: this.pinX1 - 14, y: this.pinY1 - 14 });

            if (this.pinCount >= 2) {
              Row() {
              }
              .width(28)
              .height(28)
              .borderRadius(14)
              .backgroundColor('#FF8C00')
              .position({ x: this.pinX2 - 14, y: this.pinY2 - 14 });
            }

            if (this.pinCount >= 3) {
              Row() {
              }
              .width(28)
              .height(28)
              .borderRadius(14)
              .backgroundColor('#FF8C00')
              .position({ x: this.pinX3 - 14, y: this.pinY3 - 14 });
            }
          }
          .width('100%')
          .height(220)
          .backgroundColor('#FFECB3')
          .borderRadius(10);
        }
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 8, color: '#263E2723', offsetY: 4 });

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
              if (this.pinCount < 3) {
                this.pinCount++;
              }
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
              this.pinCount = 0;
            });
        }
        .width('100%');

        Column({ space: 6 }) {
          Text('Active Groups')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF8C00')
            .width('100%');

          Row() {
            Text(this.pinLabel1)
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
          .width('100%')
          .visibility(this.pinCount >= 1 ? Visibility.Visible : Visibility.None);

          Row() {
            Text(this.pinLabel2)
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
          .width('100%')
          .visibility(this.pinCount >= 2 ? Visibility.Visible : Visibility.None);

          Row() {
            Text(this.pinLabel3)
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
          .width('100%')
          .visibility(this.pinCount >= 3 ? Visibility.Visible : Visibility.None);
        }
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 4, color: '#1A3E2723', offsetY: 2 });

        Column() {
        }
        .layoutWeight(1);
      }
      .width('100%')
      .height('100%')
      .padding(16);
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8E1');
  }
}
