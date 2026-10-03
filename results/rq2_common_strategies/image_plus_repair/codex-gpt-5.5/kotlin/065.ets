interface AssetMarker {
  id: number;
  name: string;
  type: string;
  x: number;
  y: number;
}

const PAGE_BACKGROUND: string = '#F6F6F6';
const WHITE: string = '#FFFFFF';
const BLACK: string = '#111111';
const TEXT: string = '#0A0A0A';
const MUTED_TEXT: string = '#504D58';
const FIELD_BACKGROUND: string = '#E7E1EA';
const GRID: string = '#EDEDED';
const OUTLINE: string = '#D1D1D1';
const WAREHOUSE: string = '#474747';
const DEVICE: string = '#2A2A2A';
const OFFICE: string = '#111111';

@Entry
@Component
struct MainPage {
  @State private assetName: string = '';
  @State private assetCode: string = '';
  @State private assetType: string = 'Device';
  @State private selectedId: number = -1;
  @State private enabledCategories: string[] = ['Warehouse', 'Device', 'Office'];

  private readonly categories: string[] = ['Warehouse', 'Device', 'Office'];
  private readonly markers: AssetMarker[] = [
    { id: 1, name: 'Main Warehouse', type: 'Warehouse', x: 0.18, y: 0.34 },
    { id: 2, name: 'CNC-07', type: 'Device', x: 0.52, y: 0.46 },
    { id: 3, name: 'HQ Office', type: 'Office', x: 0.75, y: 0.62 },
    { id: 4, name: 'Spare Parts', type: 'Warehouse', x: 0.33, y: 0.78 }
  ];

  private categoryEnabled(category: string): boolean {
    return this.enabledCategories.indexOf(category) >= 0;
  }

  private toggleCategory(category: string): void {
    const index: number = this.enabledCategories.indexOf(category);
    if (index >= 0) {
      this.enabledCategories = this.enabledCategories.filter((item: string) => item !== category);
    } else {
      this.enabledCategories = [...this.enabledCategories, category];
    }
  }

  private markerColor(type: string): string {
    if (type === 'Warehouse') {
      return WAREHOUSE;
    }
    if (type === 'Device') {
      return DEVICE;
    }
    return OFFICE;
  }

  private selectedMarkerName(): string {
    const marker: AssetMarker | undefined = this.markers.find((item: AssetMarker) => item.id === this.selectedId);
    return marker === undefined ? 'None' : marker.name;
  }

  private resetForm(): void {
    this.assetName = '';
    this.assetCode = '';
    this.assetType = 'Device';
    this.selectedId = -1;
  }

  build() {
    Column() {
      Text('Asset Inventory')
        .width('100%')
        .height(176)
        .padding({ top: 77 })
        .fontSize(54)
        .fontWeight(FontWeight.Bold)
        .fontColor(TEXT)
        .textAlign(TextAlign.Center)
        .backgroundColor(WHITE);

      Column() {
        Scroll() {
          Column({ space: 0 }) {
            Row({ space: 16 }) {
              ForEach(this.categories, (category: string) => {
                Button(category)
                  .height(64)
                  .layoutWeight(1)
                  .fontSize(30)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(WHITE)
                  .backgroundColor(this.categoryEnabled(category) ? BLACK : '#FFFFFF')
                  .borderRadius(16)
                  .border({
                    width: 1,
                    color: this.categoryEnabled(category) ? '#BDBDBD' : OUTLINE
                  })
                  .onClick(() => {
                    this.toggleCategory(category);
                  });
              }, (category: string) => category);
            }
            .width('100%')
            .height(64)
            .margin({ bottom: 48 });

            Row({ space: 32 }) {
              Column({ space: 24 }) {
                TextInput({ text: this.assetName, placeholder: 'Asset Name' })
                  .width('100%')
                  .height(112)
                  .fontSize(32)
                  .fontColor(MUTED_TEXT)
                  .placeholderColor(MUTED_TEXT)
                  .padding({ left: 32, right: 18 })
                  .backgroundColor(FIELD_BACKGROUND)
                  .borderRadius({ topLeft: 16, topRight: 16 })
                  .border({ width: { bottom: 2 }, color: MUTED_TEXT })
                  .onChange((value: string) => {
                    this.assetName = value;
                  });

                TextInput({ text: this.assetCode, placeholder: 'Asset Code' })
                  .width('100%')
                  .height(112)
                  .fontSize(32)
                  .fontColor(MUTED_TEXT)
                  .placeholderColor(MUTED_TEXT)
                  .padding({ left: 32, right: 18 })
                  .backgroundColor(FIELD_BACKGROUND)
                  .borderRadius({ topLeft: 16, topRight: 16 })
                  .border({ width: { bottom: 2 }, color: MUTED_TEXT })
                  .onChange((value: string) => {
                    this.assetCode = value;
                  });

                Column() {
                  Text('Asset Type')
                    .width('100%')
                    .fontSize(24)
                    .fontColor(MUTED_TEXT)
                    .margin({ bottom: 8 });
                  TextInput({ text: this.assetType })
                    .width('100%')
                    .height(42)
                    .fontSize(30)
                    .fontColor(TEXT)
                    .padding(0)
                    .backgroundColor(FIELD_BACKGROUND)
                    .onChange((value: string) => {
                      this.assetType = value;
                    });
                }
                .width('100%')
                .height(112)
                .padding({ left: 32, right: 18, top: 20 })
                .backgroundColor(FIELD_BACKGROUND)
                .borderRadius({ topLeft: 16, topRight: 16 })
                .border({ width: { bottom: 2 }, color: MUTED_TEXT })
                .alignItems(HorizontalAlign.Start);

                Column({ space: 10 }) {
                  Text('Selected')
                    .fontSize(24)
                    .fontColor(TEXT)
                    .fontWeight(FontWeight.Medium);
                  Text(this.selectedMarkerName())
                    .fontSize(40)
                    .fontColor(TEXT)
                    .fontWeight(FontWeight.Bold);
                }
                .width('100%')
                .height(154)
                .padding({ left: 32, top: 28 })
                .backgroundColor(WHITE)
                .borderRadius(26)
                .border({ width: 1, color: OUTLINE })
                .shadow({ radius: 4, color: '#25000000', offsetX: 0, offsetY: 2 })
                .alignItems(HorizontalAlign.Start);
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start);

              Stack() {
                Column({ space: 0 }) {
                  ForEach([0, 1, 2, 3, 4, 5], () => {
                    Row()
                      .width('100%')
                      .height(1)
                      .backgroundColor(GRID)
                      .margin({ top: 40 });
                  });
                }
                .width('100%')
                .height('100%')
                .padding({ left: 31, right: 31, top: 31 });

                Row({ space: 35 }) {
                  ForEach([0, 1, 2, 3, 4, 5], () => {
                    Column()
                      .width(1)
                      .height('100%')
                      .backgroundColor(GRID);
                  });
                }
                .width('100%')
                .height('100%')
                .padding({ left: 66, right: 66, top: 31, bottom: 31 });

                ForEach(this.markers.filter((marker: AssetMarker) => this.categoryEnabled(marker.type)),
                  (marker: AssetMarker) => {
                    Stack() {
                      Circle()
                        .width(this.selectedId === marker.id ? 42 : 38)
                        .height(this.selectedId === marker.id ? 42 : 38)
                        .fill(this.markerColor(marker.type))
                        .border({
                          width: 2,
                          color: this.selectedId === marker.id ? BLACK : WHITE
                        });

                      Text(marker.type)
                        .fontSize(23)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(TEXT)
                        .padding({ left: 14, right: 14, top: 7, bottom: 7 })
                        .backgroundColor(WHITE)
                        .borderRadius(14)
                        .border({ width: 1, color: OUTLINE })
                        .shadow({ radius: 5, color: '#30000000', offsetX: 0, offsetY: 2 })
                        .position({ x: 34, y: -4 });
                    }
                    .width(44)
                    .height(44)
                    .position({ x: marker.x * 300, y: marker.y * 290 })
                    .onClick(() => {
                      this.selectedId = this.selectedId === marker.id ? -1 : marker.id;
                    });
                  }, (marker: AssetMarker) => marker.id.toString());
              }
              .width('100%')
              .height(346)
              .backgroundColor(WHITE)
              .borderRadius(28)
              .border({ width: 2, color: OUTLINE })
              .clip(true);
            }
            .width('100%')
            .alignItems(VerticalAlign.Top);
          }
          .width('100%')
          .padding({ left: 32, right: 32, top: 40, bottom: 24 });
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off);
      }
      .layoutWeight(1)
      .backgroundColor(PAGE_BACKGROUND);

      Row({ space: 24 }) {
        Button('Reset')
          .layoutWeight(1)
          .height(96)
          .fontSize(30)
          .fontWeight(FontWeight.Medium)
          .fontColor(TEXT)
          .backgroundColor('#F8F8F8')
          .borderRadius(24)
          .onClick(() => {
            this.resetForm();
          });

        Button('Save Asset')
          .layoutWeight(1)
          .height(96)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(WHITE)
          .backgroundColor(BLACK)
          .borderRadius(24)
          .onClick(() => {
          });
      }
      .width('100%')
      .height(144)
      .padding({ left: 32, right: 32, top: 24, bottom: 24 })
      .backgroundColor('#F0F0F0');
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PAGE_BACKGROUND);
  }
}
