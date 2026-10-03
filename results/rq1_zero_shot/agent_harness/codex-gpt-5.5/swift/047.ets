class Pin {
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
  @State private pins: Pin[] = [
    new Pin(150, 250, 'Group A'),
    new Pin(350, 420, 'Group B'),
    new Pin(520, 310, 'Group C')
  ];

  @Builder
  MapCard() {
    Column() {
      Text('Live Deals Map')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#3E2723')
      Stack() {
        Rect()
          .width('100%')
          .height(220)
          .fill('#FFECB3')
          .radius(10)
        ForEach(this.pins, (pin: Pin, index: number) => {
          Circle()
            .width(28)
            .height(28)
            .fill('#FF8C00')
            .position({ x: pin.x, y: pin.y })
        }, (pin: Pin, index: number) => pin.label + index.toString())
      }
      .width('100%')
      .height(220)
      .margin({ top: 10 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 6, color: '#263E2723', offsetX: 0, offsetY: 4 })
  }

  @Builder
  ActiveGroupsCard() {
    Column() {
      Text('Active Groups')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FF8C00')
      ForEach(this.pins, (pin: Pin, index: number) => {
        Row() {
          Text(pin.label)
            .fontSize(14)
            .fontColor('#3E2723')
          Blank()
          Circle()
            .width(14)
            .height(14)
            .fill('#FF8C00')
        }
        .width('100%')
        .margin({ top: 6 })
      }, (pin: Pin, index: number) => pin.label + index.toString())
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 2, color: '#1A3E2723', offsetX: 0, offsetY: 2 })
  }

  build() {
    Column() {
      Text('Retro Group Buy')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3E2723')
        .width('100%')
      this.MapCard()
        .margin({ top: 16 })
      Blank().height(6)
      Row() {
        Button('Add Group')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#3E2723')
          .backgroundColor('#FFC107')
          .height(48)
          .borderRadius(10)
          .layoutWeight(1)
          .onClick(() => {
            const next = this.pins.slice();
            next.push(new Pin(100 + (next.length * 97) % 450, 150 + (next.length * 83) % 300, 'New'));
            this.pins = next;
          })
        Button('Clear')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#3E2723')
          .backgroundColor('#FF8C00')
          .height(48)
          .borderRadius(10)
          .layoutWeight(1)
          .margin({ left: 10 })
          .onClick(() => {
            this.pins = [];
          })
      }
      .width('100%')
      .margin({ top: 10 })
      this.ActiveGroupsCard()
        .margin({ top: 16 })
      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFF8E1')
  }
}
