// 109AssetInventoryen - Form - Monochrome - en - 720x1280

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

@Entry
@Component
struct AssetInventory {
  private categories: string[] = ["Warehouse", "Device", "Office"];
  @State enabledCats: string[] = ["Warehouse", "Device", "Office"];
  private markers: AssetMarker[] = [
    new AssetMarker(1, "Main Warehouse", "Warehouse", 0.18, 0.34),
    new AssetMarker(2, "CNC-07", "Device", 0.52, 0.46),
    new AssetMarker(3, "HQ Office", "Office", 0.75, 0.62),
    new AssetMarker(4, "Spare Parts", "Warehouse", 0.33, 0.78)
  ];
  @State assetName: string = "";
  @State assetCode: string = "";
  @State assetType: string = "Device";
  @State selectedId: number | null = null;

  private toggleCategory(cat: string) {
    if (this.enabledCats.includes(cat)) {
      this.enabledCats = this.enabledCats.filter(c => c !== cat);
    } else {
      this.enabledCats.push(cat);
    }
  }

  private resetForm() {
    this.assetName = "";
    this.assetCode = "";
    this.assetType = "Device";
    this.selectedId = null;
  }

  private getSelectedName(): string {
    if (this.selectedId === null) return "None";
    const marker = this.markers.find(m => m.id === this.selectedId);
    return marker ? marker.name : "None";
  }

  private getMarkerColor(type: string): ResourceColor {
    if (type === "Warehouse") return "#474747";
    if (type === "Device") return "#2A2A2A";
    return "#111111";
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("Asset Inventory")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor("#0A0A0A")
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Content
      Scroll() {
        Column() {
          // Filter Chips
          Row() {
            ForEach(this.categories, (c: string) => {
              Text(c)
                .fontSize(this.enabledCats.includes(c) ? 16 : 14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.enabledCats.includes(c) ? "#FFFFFF" : "#0A0A0A")
                .backgroundColor(this.enabledCats.includes(c) ? "#111111" : "#FFFFFF")
                .border({ width: 1, color: "#D1D1D1", radius: 8 })
                .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                .margin({ right: 8 })
                .onClick(() => this.toggleCategory(c))
            })
          }
          .width('100%')
          .margin({ bottom: 16 })

          // Form and Map Row
          Row() {
            // Left Column - Form
            Column() {
              // Asset Name
              Column({ space: 4 }) {
                Text("Asset Name")
                  .fontSize(12)
                  .fontColor("#474747")
                TextInput({ text: this.assetName })
                  .onChange((value: string) => this.assetName = value)
                  .backgroundColor("#FFFFFF")
                  .border({ width: 1, color: "#D1D1D1", radius: 8 })
                  .height(48)
              }.margin({ bottom: 12 })

              // Asset Code
              Column({ space: 4 }) {
                Text("Asset Code")
                  .fontSize(12)
                  .fontColor("#474747")
                TextInput({ text: this.assetCode })
                  .onChange((value: string) => this.assetCode = value)
                  .backgroundColor("#FFFFFF")
                  .border({ width: 1, color: "#D1D1D1", radius: 8 })
                  .height(48)
              }.margin({ bottom: 12 })

              // Asset Type
              Column({ space: 4 }) {
                Text("Asset Type")
                  .fontSize(12)
                  .fontColor("#474747")
                TextInput({ text: this.assetType })
                  .onChange((value: string) => this.assetType = value)
                  .backgroundColor("#FFFFFF")
                  .border({ width: 1, color: "#D1D1D1", radius: 8 })
                  .height(48)
              }.margin({ bottom: 12 })

              // Selected Card
              Column() {
                Text("Selected")
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor("#0A0A0A")
                Text(this.getSelectedName())
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor("#0A0A0A")
                  .margin({ top: 4 })
              }
              .width('100%')
              .padding(16)
              .backgroundColor("#FFFFFF")
              .border({ width: 1, color: "#D1D1D1", radius: 16 })
              .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 2 })
            }
            .layoutWeight(1)
            .margin({ right: 16 })

            // Right Column - Map
            Stack() {
              // Grid Overlay
              Column() {
                ForEach([0, 1, 2, 3, 4, 5], () => {
                  Divider().color("#EDEDED").strokeWidth(1).margin({ top: 0, bottom: 0 })
                })
              }
              .width('100%')
              .height('100%')
              .justifyContent(FlexAlign.SpaceEvenly)
              .padding(16)

              // Markers
              ForEach(this.markers.filter(m => this.enabledCats.includes(m.type)), (m: AssetMarker) => {
                Row() {
                  // Marker Dot
                  Stack() {
                    if (this.selectedId === m.id) {
                      // Selection Ring
                      Circle({ width: 32, height: 32 }).fill('transparent').stroke("#111111").strokeWidth(2)
                    }
                    Circle({ width: this.selectedId === m.id ? 24 : 20, height: this.selectedId === m.id ? 24 : 20 })
                      .fill(this.getMarkerColor(m.type))
                      .stroke("#FFFFFF")
                      .strokeWidth(2)
                  }
                  .width(32)
                  .height(32)

                  // Marker Label
                  Text(m.type)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor("#0A0A0A")
                    .backgroundColor("#FFFFFF")
                    .border({ width: 1, color: "#D1D1D1", radius: 8 })
                    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                    .margin({ left: 4 })
                    .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 2 })
                }
                .position({ x: `${m.x * 100}%`, y: `${m.y * 100}%` })
                .onClick(() => {
                  this.selectedId = this.selectedId === m.id ? null : m.id;
                })
              })
            }
            .layoutWeight(1)
            .height(360)
            .aspectRatio(0.9)
            .backgroundColor("#FFFFFF")
            .border({ width: 1, color: "#D1D1D1", radius: 16 })
          }
          .width('100%')
        }
        .padding(16)
      }
      .layoutWeight(1)
      .backgroundColor("#F6F6F6")

      // Bottom Bar
      Row() {
        Button("Reset")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor("#0A0A0A")
          .backgroundColor("#EDEDED")
          .borderRadius(12)
          .height(48)
          .layoutWeight(1)
          .onClick(() => this.resetForm())

        Button("Save Asset")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor("#FFFFFF")
          .backgroundColor("#111111")
          .borderRadius(12)
          .height(48)
          .layoutWeight(1)
          .margin({ left: 12 })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor("#FFFFFF")
    }
    .width('100%')
    .height('100%')
  }
}