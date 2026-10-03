// MARK: - AppTokens
const AppColorsMap: Record<string, string> = {
  'primary': '#111111',
  'secondary': '#2A2A2A',
  'tertiary': '#474747',
  'background': '#F6F6F6',
  'surface': '#FFFFFF',
  'surfaceVariant': '#EDEDED',
  'outline': '#D1D1D1',
  'success': '#2E7D32',
  'warning': '#B98900',
  'error': '#B3261E',
  'onPrimary': '#FFFFFF',
  'onSecondary': '#FFFFFF',
  'onTertiary': '#FFFFFF',
  'onBackground': '#0A0A0A',
  'onSurface': '#0A0A0A',
};

const SpacingMap: Record<string, number> = {
  'xs': 4,
  'sm': 8,
  'md': 12,
  'lg': 16,
  'xl': 24,
  'xxl': 32,
  'xxxl': 48,
};

interface AssetMarker {
  id: number;
  name: string;
  type: string;
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  @State categories: string[] = ['Warehouse', 'Device', 'Office'];
  @State enabledCats: string[] = ['Warehouse', 'Device', 'Office'];
  @State markers: AssetMarker[] = [
    { id: 1, name: 'Main Warehouse', type: 'Warehouse', x: 0.18, y: 0.34 },
    { id: 2, name: 'CNC-07', type: 'Device', x: 0.52, y: 0.46 },
    { id: 3, name: 'HQ Office', type: 'Office', x: 0.75, y: 0.62 },
    { id: 4, name: 'Spare Parts', type: 'Warehouse', x: 0.33, y: 0.78 },
  ];
  @State assetName: string = '';
  @State assetCode: string = '';
  @State assetType: string = 'Device';
  @State selectedId: number = -1;
  @State mapWidth: number = 0;
  @State mapHeight: number = 0;

  getMarkerColor(type: string): string {
    if (type === 'Warehouse') return AppColorsMap['tertiary'];
    if (type === 'Device') return AppColorsMap['secondary'];
    return AppColorsMap['primary'];
  }

  getSelectedName(): string {
    if (this.selectedId === -1) return 'None';
    const found = this.markers.find(m => m.id === this.selectedId);
    return found ? found.name : 'None';
  }

  build() {
    Column() {
      // Top Bar
      Stack() {
        Text('Asset Inventory')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColorsMap['onSurface'])
      }
      .width('100%')
      .height(70)
      .backgroundColor(AppColorsMap['surface'])
      .alignContent(Alignment.Center)

      // Main Content
      Scroll() {
        Column({ space: SpacingMap['lg'] }) {
          // Filter Chips
          Scroll() {
            Row({ space: SpacingMap['sm'] }) {
              ForEach(this.categories, (c: string) => {
                FilterChipItem({
                  label: c,
                  isOn: this.enabledCats.includes(c),
                  onToggle: (cat: string, on: boolean) => {
                    if (on) {
                      this.enabledCats = this.enabledCats.filter((x: string) => x !== cat);
                    } else {
                      this.enabledCats = [...this.enabledCats, cat];
                    }
                  }
                })
              })
            }
            .padding({ left: SpacingMap['lg'], right: SpacingMap['lg'] })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
          .padding({ top: SpacingMap['md'] })

          // Asset Details + Map Row
          Row({ space: SpacingMap['lg'] }) {
            // Left Column
            Column({ space: SpacingMap['md'] }) {
              TextInput({ placeholder: 'Asset Name', text: this.assetName })
                .onChange((val: string) => {
                  this.assetName = val;
                })
                .backgroundColor(AppColorsMap['surfaceVariant'])
                .borderRadius(8)
                .borderWidth(1)
                .borderColor(AppColorsMap['outline'])
                .fontSize(14)
                .fontColor(AppColorsMap['onSurface'])
                .placeholderColor('#999999')
                .width('100%')
                .height(44)

              TextInput({ placeholder: 'Asset Code', text: this.assetCode })
                .onChange((val: string) => {
                  this.assetCode = val;
                })
                .backgroundColor(AppColorsMap['surfaceVariant'])
                .borderRadius(8)
                .borderWidth(1)
                .borderColor(AppColorsMap['outline'])
                .fontSize(14)
                .fontColor(AppColorsMap['onSurface'])
                .placeholderColor('#999999')
                .width('100%')
                .height(44)

              TextInput({ placeholder: 'Asset Type', text: this.assetType })
                .onChange((val: string) => {
                  this.assetType = val;
                })
                .backgroundColor(AppColorsMap['surfaceVariant'])
                .borderRadius(8)
                .borderWidth(1)
                .borderColor(AppColorsMap['outline'])
                .fontSize(14)
                .fontColor(AppColorsMap['onSurface'])
                .placeholderColor('#999999')
                .width('100%')
                .height(44)

              // Selected Card
              Column({ space: SpacingMap['sm'] }) {
                Text('Selected')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColorsMap['onSurface'])
                Text(this.getSelectedName())
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColorsMap['onSurface'])
              }
              .padding(SpacingMap['lg'])
              .width('100%')
              .alignItems(HorizontalAlign.Start)
              .backgroundColor(AppColorsMap['surface'])
              .borderRadius(16)
              .borderWidth(1)
              .borderColor(AppColorsMap['outline'])
              .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)

            // Map Area
            Stack({ alignContent: Alignment.TopStart }) {
              // Grid Overlay
              Stack() {
                // Horizontal lines
                Column() {
                  ForEach([0, 1, 2, 3, 4, 5, 6], (idx: number) => {
                    Divider()
                      .color(AppColorsMap['surfaceVariant'])
                      .strokeWidth(1)
                    if (idx < 6) {
                      Blank().layoutWeight(1)
                    }
                  })
                }
                .width('100%')
                .height('100%')
                .padding(SpacingMap['lg'])

                // Vertical lines
                Row() {
                  ForEach([0, 1, 2, 3, 4, 5, 6], (idx: number) => {
                    Divider()
                      .vertical(true)
                      .color(AppColorsMap['surfaceVariant'])
                      .strokeWidth(1)
                    if (idx < 6) {
                      Blank().layoutWeight(1)
                    }
                  })
                }
                .width('100%')
                .height('100%')
                .padding(SpacingMap['lg'])
              }
              .width('100%')
              .height('100%')

              // Markers
              ForEach(
                this.markers.filter((m: AssetMarker) => this.enabledCats.includes(m.type)),
                (m: AssetMarker) => {
                  MapMarkerItem({
                    marker: m,
                    isSelected: this.selectedId === m.id,
                    markerColor: this.getMarkerColor(m.type),
                    mapWidth: this.mapWidth,
                    mapHeight: this.mapHeight,
                    onMarkerClick: (id: number) => {
                      this.selectedId = (this.selectedId === id) ? -1 : id;
                    }
                  })
                }
              )
            }
            .layoutWeight(1)
            .aspectRatio(0.9)
            .constraintSize({ minHeight: 360 })
            .backgroundColor(AppColorsMap['surface'])
            .borderRadius(16)
            .borderWidth(1)
            .borderColor(AppColorsMap['outline'])
            .clip(true)
            .onAreaChange((_old: Area, newVal: Area) => {
              this.mapWidth = newVal.width as number;
              this.mapHeight = newVal.height as number;
            })
          }
          .padding({ left: SpacingMap['lg'], right: SpacingMap['lg'] })
          .alignItems(VerticalAlign.Top)
          .width('100%')
        }
        .width('100%')
        .padding({ bottom: SpacingMap['md'] })
      }
      .scrollBar(BarState.Off)
      .backgroundColor(AppColorsMap['background'])
      .layoutWeight(1)
      .width('100%')

      // Bottom Bar
      Column() {
        Row({ space: SpacingMap['md'] }) {
          Button() {
            Text('Reset')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColorsMap['onSurface'])
          }
          .layoutWeight(1)
          .height(48)
          .backgroundColor(AppColorsMap['surfaceVariant'])
          .borderRadius(12)
          .onClick(() => {
            this.assetName = '';
            this.assetCode = '';
            this.assetType = 'Device';
            this.selectedId = -1;
          })
          .buttonStyle(ButtonStyleMode.NORMAL)

          Button() {
            Text('Save Asset')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColorsMap['onPrimary'])
          }
          .layoutWeight(1)
          .height(48)
          .backgroundColor(AppColorsMap['primary'])
          .borderRadius(12)
          .onClick(() => {})
          .buttonStyle(ButtonStyleMode.NORMAL)
        }
        .padding({
          left: SpacingMap['lg'],
          right: SpacingMap['lg'],
          top: SpacingMap['md'],
          bottom: SpacingMap['md']
        })
        .width('100%')
      }
      .backgroundColor(AppColorsMap['surface'])
      .shadow({ radius: 8, color: '#24000000', offsetX: 0, offsetY: -4 })
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColorsMap['background'])
  }
}

@Component
struct FilterChipItem {
  @Prop label: string = '';
  @Prop isOn: boolean = false;
  onToggle: (cat: string, on: boolean) => void = () => {};

  build() {
    Button() {
      Text(this.label)
        .fontSize(this.isOn ? 16 : 14)
        .fontWeight(this.isOn ? FontWeight.Medium : FontWeight.Regular)
        .fontColor(this.isOn ? AppColorsMap['onPrimary'] : AppColorsMap['onSurface'])
        .padding({
          left: SpacingMap['md'],
          right: SpacingMap['md'],
          top: SpacingMap['sm'],
          bottom: SpacingMap['sm']
        })
    }
    .backgroundColor(this.isOn ? AppColorsMap['primary'] : AppColorsMap['surface'])
    .borderRadius(8)
    .borderWidth(1)
    .borderColor(AppColorsMap['outline'])
    .onClick(() => {
      this.onToggle(this.label, this.isOn);
    })
    .buttonStyle(ButtonStyleMode.NORMAL)
  }
}

@Component
struct MapMarkerItem {
  @Prop marker: AssetMarker = { id: 0, name: '', type: '', x: 0, y: 0 };
  @Prop isSelected: boolean = false;
  @Prop markerColor: string = '#111111';
  @Prop mapWidth: number = 0;
  @Prop mapHeight: number = 0;
  onMarkerClick: (id: number) => void = () => {};

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Circle()
        .fill(this.markerColor)
        .width(this.isSelected ? 28 : 22)
        .height(this.isSelected ? 28 : 22)
        .border({
          width: 2,
          color: this.isSelected ? AppColorsMap['primary'] : AppColorsMap['surface']
        })

      Button() {
        Text(this.marker.type)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColorsMap['onSurface'])
          .padding({
            left: SpacingMap['sm'],
            right: SpacingMap['sm'],
            top: SpacingMap['xs'],
            bottom: SpacingMap['xs']
          })
      }
      .backgroundColor(AppColorsMap['surface'])
      .borderRadius(8)
      .borderWidth(1)
      .borderColor(AppColorsMap['outline'])
      .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
      .onClick(() => {
        this.onMarkerClick(this.marker.id);
      })
      .buttonStyle(ButtonStyleMode.NORMAL)
      .offset({ x: 18, y: -4 })
    }
    .position({ x: this.mapWidth * this.marker.x, y: this.mapHeight * this.marker.y })
  }
}