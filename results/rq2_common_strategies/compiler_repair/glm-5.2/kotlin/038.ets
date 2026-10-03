// 049*InvoiceScanner*en.ets
interface Marker {
  x: number;
  y: number;
  label: string;
}

@Entry
@Component
struct InvoiceScanner {
  @State markers: Marker[] = [
    { x: 120, y: 200, label: 'A1' },
    { x: 300, y: 400, label: 'B2' },
    { x: 520, y: 600, label: 'C3' }
  ];
  @State scanning: boolean = false;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Invoice Scanner')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F0F9FF')

      // Content Area
      Column() {
        // Canvas Surface
        Stack({ alignContent: Alignment.Center }) {
          // Background Circle
          Circle()
            .width('80%')
            .height('80%')
            .fill('#E0F2FE')

          // Markers
          ForEach(this.markers, (marker: Marker) => {
            Stack({ alignContent: Alignment.Center }) {
              Circle()
                .width(24)
                .height(24)
                .fill('#06B6D4')
              Text(marker.label)
                .fontSize(10)
                .fontColor('#FFFFFF')
            }
            .position({ x: marker.x - 12, y: marker.y - 12 })
          })
        }
        .width('100%')
        .height(400)
        .backgroundColor('rgba(255, 255, 255, 0.9)')
        .borderRadius(20)
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetX: 0, offsetY: 4 })

        // Scanning Active Switch Row
        Row() {
          Text('Scanning Active')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0F172A')
          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .selectedColor('#3B82F6')
            .onChange((isOn: boolean) => {
              this.scanning = isOn;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: 16, bottom: 16 })

        // Add Marker Button
        Button('Add Marker')
          .width('100%')
          .height(48)
          .backgroundColor('#06B6D4')
          .fontColor('#FFFFFF')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .borderRadius(12)
          .onClick(() => {
            if (this.scanning) {
              const newX = Math.floor(Math.random() * (580 - 80 + 1)) + 80;
              const newY = Math.floor(Math.random() * (650 - 150 + 1)) + 150;
              this.markers.push({
                x: newX,
                y: newY,
                label: `N${this.markers.length + 1}`
              });
            }
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        angle: 180,
        colors: [
          ['rgba(59, 130, 246, 0.3)', 0.0],
          ['#F0F9FF', 0.5],
          ['rgba(6, 182, 212, 0.3)', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}