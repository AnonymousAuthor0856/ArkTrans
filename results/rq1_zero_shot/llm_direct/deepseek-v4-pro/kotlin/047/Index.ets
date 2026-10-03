import { randomUUID } from '@ohos.util';

@Entry
@Component
struct MainPage {
  @State pins: Pin[] = [
    { x: 150, y: 250, label: "Group A" },
    { x: 350, y: 420, label: "Group B" },
    { x: 520, y: 310, label: "Group C" }
  ];

  build() {
    Column() {
      Column() {
        Text("Retro Group Buy")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3E2723')
          .margin({ bottom: 16 })

        Column() {
          Text("Live Deals Map")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#3E2723')
            .margin({ bottom: 10 })

          Stack() {
            Canvas(this.context)
              .width('100%')
              .height(220)
              .backgroundColor('#FFECB3')
              .borderRadius(10)
              .onReady(() => {
                this.drawPins();
              })
          }
          .width('100%')
          .height(220)
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.15)', offsetY: 4 })
        .margin({ bottom: 16 })

        Row() {
          Button('Add Group')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#3E2723')
            .backgroundColor('#FFC107')
            .borderRadius(10)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.pins.push({
                x: Math.floor(Math.random() * 450) + 100,
                y: Math.floor(Math.random() * 300) + 150,
                label: "New"
              });
            })

          Blank().width(10)

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
            })
        }
        .width('100%')
        .margin({ bottom: 16 })

        Column() {
          Text("Active Groups")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF8C00')
            .margin({ bottom: 6 })

          ForEach(this.pins, (pin: Pin) => {
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
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .margin({ bottom: 6 })
          }, (pin: Pin) => pin.label + pin.x.toString() + pin.y.toString())
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#FFF8E1')
    }
    .width('100%')
    .height('100%')
  }

  private drawPins() {
    // Canvas drawing is handled via the Canvas component's onReady callback
    // The pins are drawn using the CanvasRenderingContext2D
  }
}

interface Pin {
  x: number;
  y: number;
  label: string;
}