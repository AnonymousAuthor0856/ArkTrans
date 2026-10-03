// App.ets
import { router } from '@kit.ArkUI';

@Entry
@Component
struct RootScreen {
  @State pins: Pin[] = [
    new Pin(150, 250, "Group A"),
    new Pin(350, 420, "Group B"),
    new Pin(520, 310, "Group C")
  ];

  build() {
    Column() {
      // Title
      Text('Retro Group Buy')
        .font({ size: 28, weight: FontWeight.Bold })
        .foregroundColor('#3E2723')
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 16 })

      // Live Deals Map Card
      Column() {
        Text('Live Deals Map')
          .font({ size: 18, weight: FontWeight.Medium })
          .foregroundColor('#3E2723')
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ bottom: 10 })

        // Map Canvas Area
        Stack() {
          // Background for map
          Row()
            .height('100%')
            .width('100%')
            .backgroundColor('#FFECB3')
            .borderRadius(10)

          // Pins drawn on canvas
          ForEach(this.pins, (pin: Pin) => {
            Circle()
              .width(28)
              .height(28)
              .fill('#FF8C00')
              .position({ x: pin.x, y: pin.y })
          })
        }
        .width('100%')
        .height(220)
        .padding(8)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
      .shadow({ radius: 8, color: 'rgba(62, 39, 35, 0.15)', offsetY: 4 })
      .margin({ bottom: 6 })

      // Buttons Row
      Row() {
        Button('Add Group')
          .onClick(() => {
            const randomX = Math.random() * (550 - 100) + 100;
            const randomY = Math.random() * (450 - 150) + 150;
            this.pins.push(new Pin(randomX, randomY, "New"));
          })
          .width('50%')
          .height(48)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#3E2723')
          .backgroundColor('#FFC107')
          .borderRadius(10)
          .margin({ right: 5 })

        Button('Clear')
          .onClick(() => {
            this.pins = [];
          })
          .width('50%')
          .height(48)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#3E2723')
          .backgroundColor('#FF8C00')
          .borderRadius(10)
      }
      .width('100%')
      .margin({ bottom: 16 })

      // Active Groups Card
      Column() {
        Text('Active Groups')
          .font({ size: 18, weight: FontWeight.Medium })
          .foregroundColor('#FF8C00')
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ bottom: 10 })

        List({ space: 6 }) {
          ForEach(this.pins, (pin: Pin) => {
            ListItem() {
              Row() {
                Text(pin.label)
                  .font({ size: 14, weight: FontWeight.Normal })
                  .foregroundColor('#3E2723')
                
                Blank()

                Circle()
                  .width(14)
                  .height(14)
                  .fill('#FF8C00')
              }
              .width('100%')
            }
          })
        }
        .width('100%')
        .listDirection(Axis.Vertical)
        .divider({ strokeWidth: 0 }) // Remove default dividers if any
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
      .shadow({ radius: 4, color: 'rgba(62, 39, 35, 0.1)', offsetY: 2 })
      
      // Spacer to push content up
      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFF8E1')
  }
}

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