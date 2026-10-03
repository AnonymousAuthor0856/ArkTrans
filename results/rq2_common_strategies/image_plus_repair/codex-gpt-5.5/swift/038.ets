interface Marker {
  x: number;
  y: number;
  label: string;
}

@Entry
@Component
struct InvoiceScanner {
  @State private scanning: boolean = false;
  @State private markers: Marker[] = [
    { x: 0.40, y: 0.56, label: 'A1' }
  ];

  private addMarker(): void {
    if (!this.scanning) {
      return;
    }

    const next: Marker = {
      x: 0.18 + Math.random() * 0.64,
      y: 0.20 + Math.random() * 0.62,
      label: `N${this.markers.length + 1}`
    };
    this.markers = [...this.markers, next];
  }

  @Builder
  private scannerSurface(): void {
    Stack() {
      Circle()
        .width('75%')
        .aspectRatio(1)
        .fill('#E0F2FE')
        .position({ x: '12.5%', y: '12.5%' });

      ForEach(this.markers, (marker: Marker) => {
        Circle()
          .width(48)
          .height(48)
          .fill('#06B6D4')
          .position({
            x: `${marker.x * 100}%`,
            y: `${marker.y * 100}%`
          })
          .translate({ x: -24, y: -24 });
      }, (marker: Marker) => marker.label);
    }
    .width('100%')
    .height('100%')
    .clip(true);
  }

  build() {
    Column() {
      Text('Invoice Scanner')
        .fontSize(56)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(132)
        .padding({ top: 35, bottom: 25 })
        .backgroundColor('#F0F9FF');

      Column({ space: 24 }) {
        Stack() {
          this.scannerSurface();
        }
        .width('100%')
        .height(800)
        .padding(16)
        .backgroundColor('#E6FFFFFF')
        .borderRadius(40)
        .shadow({
          radius: 8,
          color: '#2D000000',
          offsetX: 0,
          offsetY: 4
        });

        Row() {
          Text('Scanning Active')
            .fontSize(36)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0F172A');

          Blank();

          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .width(96)
            .height(54)
            .selectedColor('#3B82F6')
            .switchPointColor('#BAE6FD')
            .onChange((isOn: boolean) => {
              this.scanning = isOn;
            });
        }
        .width('100%')
        .height(64)
        .alignItems(VerticalAlign.Center);

        Button('Add Marker', { type: ButtonType.Capsule })
          .width('100%')
          .height(96)
          .fontSize(36)
          .fontColor('#FFFFFF')
          .backgroundColor('#06B6D4')
          .borderRadius(24)
          .onClick(() => this.addMarker());
      }
      .width('100%')
      .height('100%')
      .padding({ left: 32, right: 32, top: 92, bottom: 32 })
      .linearGradient({
        angle: 180,
        direction: GradientDirection.Bottom,
        colors: [
          ['#4F8EF74D', 0.0],
          ['#F0F9FF', 0.54],
          ['#06B6D44D', 1.0]
        ]
      })
      .layoutWeight(1);
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]);
  }
}
