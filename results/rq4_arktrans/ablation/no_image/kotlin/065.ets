@Entry
@Component
struct Index {
  @State categories: string[] = ["Warehouse", "Device", "Office"]
  @State enabledCats: string[] = ["Warehouse", "Device", "Office"]
  @State assetName: string = ""
  @State assetCode: string = ""
  @State assetType: string = "Device"
  @State c: number = 0
  @State text: string = ''
  @State Asset_Name: number = 0
  @State Asset_Code: number = 0
  @State Asset_Type: number = 0
  @State Selected: number = 0
  @State selectedIdValueLetIdMarkersFirstOrNullItIdEqIdNameNoneNone: number = 0
  @State type: number = 0
  @State Asset_Inventory: number = 0
  @State Reset: number = 0
  @State Save_Asset: number = 0

  // Mock data for markers to satisfy compilation requirements
  private markers: Array<Marker> = [
    { id: 1, name: 'Marker 1', type: 'Warehouse', x: 0.2, y: 0.3 },
    { id: 2, name: 'Marker 2', type: 'Device', x: 0.5, y: 0.5 },
    { id: 3, name: 'Marker 3', type: 'Office', x: 0.8, y: 0.7 }
  ]
  @State selectedId: number | null = null

  build() {
    Stack() {
      // === Scaffold ===
      Stack({ alignContent: Alignment.Top }) {
        // === Column ===
        Column({ space: 16 }) {
          // === LazyRow ===
          List({ space: 8 }) {
            ForEach(this.categories, (c: string) => {
              ListItem() {
                // === FilterChip ===
                Button({ type: ButtonType.Capsule }) {
                  Text(c).fontColor(this.enabledCats.includes(c) ? '#FFFFFF' : '#0A0A0A')
                }
                .backgroundColor(this.enabledCats.includes(c) ? '#6750A4' : '#F5F5F5')
                .borderRadius(16)
                .onClick(() => {
                  if (this.enabledCats.includes(c)) {
                    const index = this.enabledCats.indexOf(c);
                    if (index > -1) {
                      this.enabledCats.splice(index, 1);
                    }
                  } else {
                    this.enabledCats.push(c);
                  }
                })
              }
            })
          }.width('100%').layoutWeight(1).listDirection(Axis.Horizontal)

          // === Row ===
          Row({ space: 16 }) {
            // === Column ===
            Column({ space: 12 }) {
              // === TextField ===
              TextInput({ placeholder: 'Asset Name' })
                .type(InputType.Normal)
                .onChange((value: string) => {
                  this.assetName = value;
                })
                .width('100%')
                .height(48)
                .backgroundColor('#FFFFFF')
                .borderRadius(8)
                .padding({ left: 16 })

              // === TextField ===
              TextInput({ placeholder: 'Asset Code' })
                .type(InputType.Normal)
                .onChange((value: string) => {
                  this.assetCode = value;
                })
                .width('100%')
                .height(48)
                .backgroundColor('#FFFFFF')
                .borderRadius(8)
                .padding({ left: 16 })

              // === TextField ===
              TextInput({ placeholder: 'Asset Type' })
                .type(InputType.Normal)
                .onChange((value: string) => {
                  this.assetType = value;
                })
                .width('100%')
                .height(48)
                .backgroundColor('#FFFFFF')
                .borderRadius(8)
                .padding({ left: 16 })

              // === Card ===
              Column() {
                // === Column ===
                Column({ space: 8 }) {
                  // === Text ===
                  Text('Selected')
                    .fontSize(12)
                    .fontColor('#0A0A0A')

                  // === Text ===
                  Text(this.selectedId !== null 
                    ? this.markers.find(m => m.id === this.selectedId)?.name ?? "None" 
                    : "None")
                    .fontSize(24)
                    .fontColor('#0A0A0A')
                }.width('100%').padding(16)
              }.backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' })
            }.layoutWeight(1)

            // === BoxWithConstraints ===
            Stack() {
              // === MapGridOverlay ===
              Stack() {
                // === Column ===
                Column({ space: 0 }) {
                  // === Box ===
                  Stack({ alignContent: Alignment.Center }) {
                    Divider().color('#EDEDED')
                  }.width('100%').height(1)
                }.width('100%').height('100%').padding(16)

                // === Row ===
                Row({ space: 0 }) {
                  // === Box ===
                  Stack({ alignContent: Alignment.Center }) {
                    Divider().vertical(true).color('#EDEDED')
                  }.width(1).height('100%')
                }.width('100%').height('100%').padding(16)
              }

              // === ForEach ===
              ForEach(this.markers.filter(m => this.enabledCats.includes(m.type)), (m: Marker) => {
                Stack() {
                  // === MapMarker ===
                  Stack() {
                    // === Box ===
                    Circle()
                      .width(this.selectedId === m.id ? 28 : 22)
                      .height(this.selectedId === m.id ? 28 : 22)
                      .fill(this.selectedId === m.id ? '#6750A4' : '#F5F5F5')
                      .border({ width: 2, color: this.selectedId === m.id ? '#6750A4' : '#E0E0E0' })
                      .position({ x: m.x * 100 + '%', y: m.y * 100 + '%' })
                      .onClick(() => {
                        this.selectedId = this.selectedId === m.id ? null : m.id;
                      })

                    // === Card ===
                    if (this.selectedId === m.id) {
                      Column() {
                        // === Text ===
                        Text(m.type)
                          .fontSize(12)
                          .fontColor('#0A0A0A')
                          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                      }
                      .backgroundColor('#FFFFFF')
                      .borderRadius(8)
                      .shadow({ radius: 4, color: '#1A000000' })
                      .position({ x: m.x * 100 + '%', y: m.y * 100 + '%' })
                      .offset({ x: 18, y: -4 })
                    }
                  }
                }
              })
            }.layoutWeight(1).height(360).backgroundColor('#F5F5F5').borderRadius(12).border({ width: 1, color: '#E0E0E0' })
          }.alignItems(VerticalAlign.Top).width('100%')
        }.width('100%').height('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 })

        // === CenterAlignedTopAppBar ===
        Row() {
          Text('Asset Inventory')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0A0A0A')
        }.width('100%').height(56).justifyContent(FlexAlign.Center).padding({ left: 16, right: 16 })

        // === Surface ===
        Column() {
          // === Row ===
          Row({ space: 0 }) {
            // === Button ===
            Button() {
              Text('Reset')
                .fontSize(16)
                .fontColor('#0A0A0A')
            }
            .height(48)
            .layoutWeight(1)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
            .onClick(() => {
              // Reset logic
            })

            // === Spacer ===
            Blank().width(16)

            // === Button ===
            Button() {
              Text('Save Asset')
                .fontSize(16)
                .fontColor('#FFFFFF')
            }
            .height(48)
            .layoutWeight(1)
            .backgroundColor('#6750A4')
            .borderRadius(8)
            .onClick(() => {
              // Save logic
            })
          }.alignItems(VerticalAlign.Center).width('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 })
        }.backgroundColor('#FFFFFF').shadow({ radius: 4, color: '#1A000000' }).alignSelf(ItemAlign.End)
      }
    }.width('100%').height('100%')
  }
}

interface Marker {
  id: number;
  name: string;
  type: string;
  x: number;
  y: number;
}