@Entry
@Component
struct RootScreen {
  @State pins: Pin[] = [
    { x: 150, y: 250, label: "Group A" },
    { x: 350, y: 420, label: "Group B" },
    { x: 520, y: 310, label: "Group C" }
  ]

  build() {
    Stack() {
      Column({ space: 16 }) {
        // Title
        Text('Retro Group Buy')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#FF3E2723')
          .width('100%')
          .textAlign(TextAlign.Start)

        // Card: Live Deals Map
        Column({ space: 10 }) {
          Text('Live Deals Map')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FF3E2723')

          // Map simulation (colored area)
          Stack() {
            // Background
            Column() { }
              .width('100%')
              .height(220)
              .backgroundColor('#FFFFECB3')
              .borderRadius(10)

            // Pin placeholders (circles)
            ForEach(this.pins, (pin: Pin) => {
              Button() {
                Text(pin.label)
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#FFFFFFFF')
              }
              .width(28)
              .height(28)
              .borderRadius(14)
              .backgroundColor('#FFFF8C00')
              .position({ x: pin.x, y: pin.y })
            })
          }
          .width('100%')
          .height(220)
          .backgroundColor('#FFFFECB3')
          .borderRadius(10)
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFFFF')
        .borderRadius(16)
        .shadow({
          radius: 8,
          color: 'rgba(62,39,35,0.15)',
          offsetX: 0,
          offsetY: 4
        })

        Blank().height(6)

        // Buttons row
        Row({ space: 10 }) {
          Button() {
            Text('Add Group')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FF3E2723')
          }
          .layoutWeight(1)
          .height(48)
          .backgroundColor('#FFFFC107')
          .borderRadius(10)
          .onClick(() => {
            const newX: number = Math.floor(Math.random() * 450) + 100
            const newY: number = Math.floor(Math.random() * 300) + 150
            this.pins.push({ x: newX, y: newY, label: "New" })
          })

          Button() {
            Text('Clear')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FFFFFFFF')
          }
          .layoutWeight(1)
          .height(48)
          .backgroundColor('#FFFF8C00')
          .borderRadius(10)
          .onClick(() => {
            this.pins = []
          })
        }
        .width('100%')

        // Card: Active Groups
        Column({ space: 6 }) {
          Text('Active Groups')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FFFF8C00')

          List({ space: 4 }) {
            ForEach(this.pins, (pin: Pin) => {
              ListItem() {
                Row({ space: 0 }) {
                  Text(pin.label)
                    .fontSize(14)
                    .fontWeight(FontWeight.Regular)
                    .foregroundColor('#FF3E2723')
                  Blank().layoutWeight(1)
                  // Circle indicator
                  Button() { }
                    .width(14)
                    .height(14)
                    .borderRadius(7)
                    .backgroundColor('#FFFF8C00')
                }
                .width('100%')
              }
            })
          }
          .width('100%')
          .height(this.pins.length * 30 + 10) // approximate
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFFFF')
        .borderRadius(16)
        .shadow({
          radius: 4,
          color: 'rgba(62,39,35,0.1)',
          offsetX: 0,
          offsetY: 2
        })

        Blank().layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFF8E1')
  }
}

interface Pin {
  x: number
  y: number
  label: string
}