class InvoiceMarker {
  x: number;
  y: number;
  label: string;

  constructor(x: number, y: number, label: string) {
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

class InvoiceColors {
  static primary: string = '#06B6D4';
  static secondary: string = '#3B82F6';
  static tertiary: string = '#8B5CF6';
  static background: string = '#F0F9FF';
  static surface: string = '#FFFFFF';
  static translucentSurface: string = '#E6FFFFFF';
  static surfaceVariant: string = '#E0F2FE';
  static outline: string = '#BAE6FD';
  static onPrimary: string = '#FFFFFF';
  static onSurface: string = '#0F172A';
}

@Entry
@Component
struct Index {
  @State scanning: boolean = false;
  @State markers: InvoiceMarker[] = [
    new InvoiceMarker(120, 200, 'A1'),
    new InvoiceMarker(300, 400, 'B2'),
    new InvoiceMarker(520, 600, 'C3')
  ];

  private addMarker() {
    if (this.scanning) {
      let index: number = this.markers.length + 1;
      let x: number = 80 + ((index * 97) % 500);
      let y: number = 150 + ((index * 131) % 500);
      this.markers.push(new InvoiceMarker(x, y, 'N' + index.toString()));
    }
  }

  @Builder
  MarkerView(marker: InvoiceMarker) {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(24)
        .height(24)
        .fill(InvoiceColors.primary)
      Text(marker.label)
        .fontSize(9)
        .fontWeight(FontWeight.Bold)
        .fontColor(InvoiceColors.onPrimary)
    }
    .width(32)
    .height(32)
    .position({ x: marker.x / 1.8, y: marker.y / 1.8 })
  }

  @Builder
  ScannerPanel() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(260)
        .height(260)
        .fill(InvoiceColors.surfaceVariant)
      ForEach(this.markers, (marker: InvoiceMarker, index: number) => {
        this.MarkerView(marker)
      }, (marker: InvoiceMarker, index: number) => index.toString())
    }
    .width('100%')
    .height(400)
    .backgroundColor(InvoiceColors.translucentSurface)
    .borderRadius(20)
    .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })
  }

  build() {
    Column() {
      Text('Invoice Scanner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(InvoiceColors.onSurface)
        .lineHeight(34)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 12, bottom: 12 })

      Column() {
        this.ScannerPanel()

        Row() {
          Text('Scanning Active')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(InvoiceColors.onSurface)
            .lineHeight(24)
          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .selectedColor(InvoiceColors.secondary)
            .onChange((isOn: boolean) => {
              this.scanning = isOn;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 16 })

        Button('Add Marker')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(InvoiceColors.onPrimary)
          .width('100%')
          .height(48)
          .backgroundColor(InvoiceColors.primary)
          .borderRadius(12)
          .margin({ top: 16 })
          .onClick(() => {
            this.addMarker();
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#4D3B82F6', 0.0], [InvoiceColors.background, 0.5], ['#4D06B6D4', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(InvoiceColors.background)
  }
}
