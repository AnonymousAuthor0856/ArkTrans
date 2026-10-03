// Shadow spec interface
interface ShadowSpec {
  radius: number;
  y: number;
  opacity: number;
}

// Pin data model
interface Pin {
  id: string;
  x: number;
  y: number;
  label: string;
}

// Helper to generate unique IDs
function generateId(): string {
  let result: string = '';
  const chars: string = 'abcdefghijklmnopqrstuvwxyz0123456789';
  for (let i: number = 0; i < 12; i++) {
    result += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return result;
}

@Component
export struct RootScreen {
  @State pins: Pin[] = [
    { id: 'pin1', x: 150, y: 250, label: 'Group A' },
    { id: 'pin2', x: 350, y: 420, label: 'Group B' },
    { id: 'pin3', x: 520, y: 310, label: 'Group C' }
  ];

  build() {
    Stack() {
      Column({ space: 16 }) {
        Text('Retro Group Buy')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3E2723')
          .width('100%')
          .textAlign(TextAlign.Start);

        Column({ space: 10 }) {
          Text('Live Deals Map')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#3E2723')
            .width('100%')
            .textAlign(TextAlign.Start);

          Stack() {
            ForEach(this.pins, (pin: Pin) => {
              Row() {
              }
              .width(28)
              .height(28)
              .borderRadius(14)
              .backgroundColor('#FF8C00')
              .position({ x: pin.x - 14, y: pin.y - 14 });
            }, (pin: Pin) => pin.id);
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
          color: 'rgba(62,39,35,0.15)',
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
              let randomX: number = 100 + Math.random() * 450;
              let randomY: number = 150 + Math.random() * 300;
              let newPin: Pin = { id: generateId(), x: randomX, y: randomY, label: 'New' };
              this.pins.push(newPin);
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
              this.pins = [];
            });
        }
        .width('100%');

        Column({ space: 6 }) {
          Text('Active Groups')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF8C00')
            .width('100%')
            .textAlign(TextAlign.Start);

          ForEach(this.pins, (pin: Pin) => {
            Row() {
              Text(pin.label)
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
          }, (pin: Pin) => pin.id);
        }
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({
          radius: 4,
          color: 'rgba(62,39,35,0.1)',
          offsetY: 2
        });

        Blank();
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
