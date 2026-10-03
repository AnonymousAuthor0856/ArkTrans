class Marker {
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
  @State private markers: Marker[] = [new Marker(120, 200, 'A1'), new Marker(300, 400, 'B2'), new Marker(520, 600, 'C3')];
  @State private scanning: boolean = false;

  @Builder
  MarkerSurface() {
    Stack({ alignContent: Alignment.Center }) {
      Rect()
        .width('100%')
        .height(400)
        .fill('#E6FFFFFF')
        .radius(20)
      Circle()
        .width(260)
        .height(260)
        .fill('#E0F2FE')
      ForEach(this.markers, (marker: Marker, index: number) => {
        Circle()
          .width(24)
          .height(24)
          .fill('#06B6D4')
          .position({ x: marker.x, y: marker.y })
      }, (marker: Marker, index: number) => marker.label + index.toString())
    }
    .width('100%')
    .height(400)
    .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })
  }

  build() {
    Column() {
      Text('Invoice Scanner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor('#F0F9FF')

      Column() {
        this.MarkerSurface()
        Row() {
          Text('Scanning Active')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0F172A')
          Blank()
          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .selectedColor('#3B82F6')
            .onChange((value: boolean) => {
              this.scanning = value;
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 16 })

        Button('Add Marker')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#06B6D4')
          .width('100%')
          .height(48)
          .borderRadius(12)
          .margin({ top: 16 })
          .onClick(() => {
            if (this.scanning) {
              const next = this.markers.slice();
              next.push(new Marker(80 + (next.length * 89) % 500, 150 + (next.length * 117) % 500, 'N' + (next.length + 1).toString()));
              this.markers = next;
            }
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .backgroundColor('#F0F9FF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}
