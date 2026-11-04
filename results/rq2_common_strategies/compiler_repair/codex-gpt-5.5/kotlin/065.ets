class AssetMarker {
  id: number;
  name: string;
  type: string;
  x: number;
  y: number;

  constructor(id: number, name: string, type: string, x: number, y: number) {
    this.id = id;
    this.name = name;
    this.type = type;
    this.x = x;
    this.y = y;
  }
}

class AssetColors {
  static readonly primary: string = '#111111';
  static readonly secondary: string = '#2A2A2A';
  static readonly tertiary: string = '#474747';
  static readonly background: string = '#F6F6F6';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#EDEDED';
  static readonly outline: string = '#D1D1D1';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSurface: string = '#0A0A0A';
}

@Entry
@Component
struct Index {
  @State warehouseOn: boolean = true;
  @State deviceOn: boolean = true;
  @State officeOn: boolean = true;
  @State assetName: string = '';
  @State assetCode: string = '';
  @State assetType: string = 'Device';
  @State selectedId: number = 0;
  private markers: AssetMarker[] = [
    new AssetMarker(1, 'Main Warehouse', 'Warehouse', 0.18, 0.34),
    new AssetMarker(2, 'CNC-07', 'Device', 0.52, 0.46),
    new AssetMarker(3, 'HQ Office', 'Office', 0.75, 0.62),
    new AssetMarker(4, 'Spare Parts', 'Warehouse', 0.33, 0.78)
  ];

  private enabledType(type: string): boolean {
    if (type === 'Warehouse') {
      return this.warehouseOn;
    }
    if (type === 'Device') {
      return this.deviceOn;
    }
    return this.officeOn;
  }

  private markerColor(type: string): string {
    if (type === 'Warehouse') {
      return AssetColors.tertiary;
    }
    if (type === 'Device') {
      return AssetColors.secondary;
    }
    return AssetColors.primary;
  }

  private selectedName(): string {
    for (let index = 0; index < this.markers.length; index++) {
      if (this.markers[index].id === this.selectedId) {
        return this.markers[index].name;
      }
    }
    return 'None';
  }

  private resetForm(): void {
    this.assetName = '';
    this.assetCode = '';
    this.assetType = 'Device';
    this.selectedId = 0;
  }

  @Builder
  FilterChip(label: string, active: boolean) {
    Button(label)
      .height(36)
      .fontSize(active ? 16 : 14)
      .fontWeight(active ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(active ? AssetColors.onPrimary : AssetColors.onSurface)
      .backgroundColor(active ? AssetColors.primary : AssetColors.surface)
      .borderRadius(8)
      .border({ width: 1, color: AssetColors.outline })
      .onClick(() => {
        if (label === 'Warehouse') {
          this.warehouseOn = !this.warehouseOn;
        } else if (label === 'Device') {
          this.deviceOn = !this.deviceOn;
        } else {
          this.officeOn = !this.officeOn;
        }
      })
  }

  @Builder
  FormField(label: string, value: string) {
    TextInput({ placeholder: label, text: value })
      .width('100%')
      .height(52)
      .fontSize(14)
      .fontColor(AssetColors.onSurface)
      .backgroundColor(AssetColors.surface)
      .borderRadius(8)
      .border({ width: 1, color: AssetColors.outline })
      .onChange((text: string) => {
        if (label === 'Asset Name') {
          this.assetName = text;
        } else if (label === 'Asset Code') {
          this.assetCode = text;
        } else {
          this.assetType = text;
        }
      })
  }

  @Builder
  SelectedCard() {
    Column() {
      Text('Selected')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AssetColors.onSurface)
      Text(this.selectedName())
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AssetColors.onSurface)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(AssetColors.surface)
    .borderRadius(16)
    .border({ width: 1, color: AssetColors.outline })
    .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  MapGridOverlay() {
    Stack() {
      ForEach([0, 1, 2, 3, 4, 5], (index: number) => {
        Text('')
          .width('90%')
          .height(1)
          .backgroundColor(AssetColors.surfaceVariant)
          .position({ x: 12, y: 36 + index * 48 })
      }, (index: number) => 'h' + index.toString())
      ForEach([0, 1, 2, 3, 4, 5], (index: number) => {
        Text('')
          .width(1)
          .height('88%')
          .backgroundColor(AssetColors.surfaceVariant)
          .position({ x: 24 + index * 48, y: 16 })
      }, (index: number) => 'v' + index.toString())
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  MapMarker(marker: AssetMarker) {
    if (this.enabledType(marker.type)) {
      Row() {
        Circle()
          .width(this.selectedId === marker.id ? 28 : 22)
          .height(this.selectedId === marker.id ? 28 : 22)
          .fill(this.markerColor(marker.type))
          .stroke(this.selectedId === marker.id ? AssetColors.primary : AssetColors.surface)
          .strokeWidth(2)

        Text(marker.type)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AssetColors.onSurface)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(AssetColors.surface)
          .borderRadius(8)
          .border({ width: 1, color: AssetColors.outline })
          .margin({ left: 6 })
      }
      .alignItems(VerticalAlign.Center)
      .position({ x: marker.x * 270, y: marker.y * 330 })
      .onClick(() => {
        if (this.selectedId === marker.id) {
          this.selectedId = 0;
        } else {
          this.selectedId = marker.id;
        }
      })
    }
  }

  @Builder
  MapPanel() {
    Stack() {
      this.MapGridOverlay()
      ForEach(this.markers, (marker: AssetMarker) => {
        this.MapMarker(marker)
      }, (marker: AssetMarker) => marker.id.toString())
    }
    .width('100%')
    .height(360)
    .backgroundColor(AssetColors.surface)
    .borderRadius(16)
    .border({ width: 1, color: AssetColors.outline })
  }

  @Builder
  BottomBar() {
    Row() {
      Button('Reset')
        .height(48)
        .fontSize(16)
        .fontColor(AssetColors.onSurface)
        .backgroundColor(AssetColors.surfaceVariant)
        .borderRadius(12)
        .layoutWeight(1)
        .onClick(() => {
          this.resetForm();
        })

      Button('Save Asset')
        .height(48)
        .fontSize(16)
        .fontColor(AssetColors.onPrimary)
        .backgroundColor(AssetColors.primary)
        .borderRadius(12)
        .layoutWeight(1)
        .margin({ left: 12 })
    }
    .width('100%')
    .height(72)
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor(AssetColors.surface)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          Text('Asset Inventory')
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor(AssetColors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Center)
            .margin({ bottom: 12 })

          Row() {
            this.FilterChip('Warehouse', this.warehouseOn)
            Column() { this.FilterChip('Device', this.deviceOn) }.margin({ left: 8 })
            Column() { this.FilterChip('Office', this.officeOn) }.margin({ left: 8 })
          }
          .width('100%')
          .margin({ bottom: 16 })

          this.FormField('Asset Name', this.assetName)
          Column() { this.FormField('Asset Code', this.assetCode) }.margin({ top: 12 })
          Column() { this.FormField('Asset Type', this.assetType) }.margin({ top: 12 })
          Column() { this.SelectedCard() }.margin({ top: 12, bottom: 16 })
          this.MapPanel()
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 96 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AssetColors.background)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AssetColors.background)
  }
}
