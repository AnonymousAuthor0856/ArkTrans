@Entry
@Component
struct RootScreen {
  @State pins: Pin[] = [
    { id: '1', x: 150, y: 250, label: 'Group A' },
    { id: '2', x: 350, y: 420, label: 'Group B' },
    { id: '3', x: 520, y: 310, label: 'Group C' }
  ]

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.TopStart }
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack({ alignContent: Alignment.TopStart }) {
      // === Column ===
      // props: { space: 16 }
      // modifier: { width: '100%', padding: 16, backgroundColor: '#FFF8E1' }
      // children: 5
      Column({ space: 16 }) {
        // === Text ===
        // props: { text: 'Retro Group Buy' }
        // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, fontColor: '#3E2723', textAlign: TextAlign.Start }
        Text('Retro Group Buy')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3E2723')
          .textAlign(TextAlign.Start)

        // === Column (Card 1) ===
        // props: { space: 10 }
        // modifier: { width: '100%', padding: 16, backgroundColor: '#FFFFFF', borderRadius: 16, shadow: { radius: 6, color: '#263E2723', offsetY: 4 } }
        // children: 2
        Column({ space: 10 }) {
          // === Text ===
          // props: { text: 'Live Deals Map' }
          // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: '#3E2723' }
          Text('Live Deals Map')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#3E2723')

          // === Stack (Map Canvas) ===
          // props: { alignContent: Alignment.TopStart }
          // modifier: { width: '100%', height: 220, backgroundColor: '#FFECB3', borderRadius: 10 }
          // children: 1
          Stack({ alignContent: Alignment.TopStart }) {
            // === ForEach (Pins) ===
            ForEach(this.pins, (pin: Pin) => {
              // === Circle ===
              // modifier: { width: 28, height: 28, backgroundColor: '#FF8C00', position: { x: pin.x - 14, y: pin.y - 14 } }
              Circle()
                .width(28)
                .height(28)
                .backgroundColor('#FF8C00')
                .position({ x: pin.x - 14, y: pin.y - 14 })
            })
          }
          .width('100%')
          .height(220)
          .backgroundColor('#FFECB3')
          .borderRadius(10)
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 6, color: '#263E2723', offsetY: 4 })

        // === Row (Buttons) ===
        // props: { space: 10 }
        // modifier: { width: '100%' }
        // children: 2
        Row({ space: 10 }) {
          // === Button (Add Group) ===
          // props: { type: ButtonType.Capsule }
          // modifier: { width: '100%', height: 48, layoutWeight: 1, backgroundColor: '#FFC107', fontColor: '#3E2723', borderRadius: 10 }
          // children: 1
          Button('Add Group')
            .type(ButtonType.Capsule)
            .width('100%')
            .height(48)
            .layoutWeight(1)
            .backgroundColor('#FFC107')
            .fontColor('#3E2723')
            .borderRadius(10)
            .onClick(() => {
              const randomX = Math.floor(Math.random() * (550 - 100 + 1)) + 100;
              const randomY = Math.floor(Math.random() * (450 - 150 + 1)) + 150;
              this.pins.push({ id: Date.now().toString(), x: randomX, y: randomY, label: 'New' });
            })

          // === Button (Clear) ===
          // props: { type: ButtonType.Capsule }
          // modifier: { width: '100%', height: 48, layoutWeight: 1, backgroundColor: '#FF8C00', fontColor: '#3E2723', borderRadius: 10 }
          // children: 1
          Button('Clear')
            .type(ButtonType.Capsule)
            .width('100%')
            .height(48)
            .layoutWeight(1)
            .backgroundColor('#FF8C00')
            .fontColor('#3E2723')
            .borderRadius(10)
            .onClick(() => {
              this.pins = [];
            })
        }
        .width('100%')

        // === Column (Card 2) ===
        // props: { space: 6 }
        // modifier: { width: '100%', padding: 16, backgroundColor: '#FFFFFF', borderRadius: 16, shadow: { radius: 2, color: '#1A3E2723', offsetY: 2 } }
        // children: 2
        Column({ space: 6 }) {
          // === Text ===
          // props: { text: 'Active Groups' }
          // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: '#FF8C00' }
          Text('Active Groups')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF8C00')

          // === ForEach (List Items) ===
          ForEach(this.pins, (pin: Pin) => {
            // === Row ===
            // props: { space: 10 }
            // modifier: { width: '100%' }
            // children: 2
            Row({ space: 10 }) {
              // === Text ===
              // props: { text: pin.label }
              // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, fontColor: '#3E2723', layoutWeight: 1 }
              Text(pin.label)
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor('#3E2723')
                .layoutWeight(1)

              // === Circle ===
              // modifier: { width: 14, height: 14, backgroundColor: '#FF8C00' }
              Circle()
                .width(14)
                .height(14)
                .backgroundColor('#FF8C00')
            }
            .width('100%')
          })
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 2, color: '#1A3E2723', offsetY: 2 })

        // === Blank ===
        Blank()
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFF8E1')
    }
    .width('100%')
    .height('100%')
  }
}

interface Pin {
  id: string;
  x: number;
  y: number;
  label: string;
}