// Pin data model
class Pin {
  id: string;
  x: number;
  y: number;
  label: string;

  constructor(id: string, x: number, y: number, label: string) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

function generateId(): string {
  let result: string = '';
  let chars: string = 'abcdefghijklmnopqrstuvwxyz0123456789';
  let i: number = 0;
  for (i = 0; i < 12; i++) {
    result += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return result;
}

@Component
export struct RootScreen {
  @State pins: Pin[] = [
    new Pin('pin1', 150, 250, 'Group A'),
    new Pin('pin2', 350, 420, 'Group B'),
    new Pin('pin3', 520, 310, 'Group C')
  ];

  addGroup(): void {
    let rx: number = 100 + Math.random() * 450;
    let ry: number = 150 + Math.random() * 300;
    let newArr: Pin[] = this.pins.concat([new Pin(generateId(), rx, ry, 'New')]);
    this.pins = newArr;
  }

  clearGroups(): void {
    this.pins = [];
  }

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
            ForEach(this.pins, (item: Pin) => {
              Row() {
              }
              .width(28)
              .height(28)
              .borderRadius(14)
              .backgroundColor('#FF8C00')
              .position({ x: item.x - 14, y: item.y - 14 });
            }, (item: Pin) => item.id);
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
              this.addGroup();
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
              this.clearGroups();
            });
        }
        .width('100%');

        Column({ space: 6 }) {
          Text('Active Groups')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF8C00')
            .width('100%');

          ForEach(this.pins, (item: Pin) => {
            Row() {
              Text(item.label)
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
          }, (item: Pin) => item.id);
        }
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 4, color: '#1A3E2723', offsetY: 2 });

        Row() {
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
