@Entry
@Component
struct Index {
  @State assetName: string = ''
  @State assetCode: string = ''
  @State assetType: string = 'Device'
  @State selectedId: number | null = null

  build() {
    Stack() {
      Column() {
        // Header Section
        Stack() {
          Text('Asset Inventory')
            .fontSize(28)
            .fontColor('#000000') // Approximation of colorScheme.onSurface
            .padding({ top: 200, bottom: 200 }) // Note: Original padding(.vertical, 200) is likely a typo in skeleton for such a small header, but implemented as requested or adjusted to reasonable UI if strictly following "skeleton" logic. Given the context of "display" typography, usually padding is smaller. However, I will follow the skeleton's explicit value but note that 200px vertical padding on a text inside an 86px stack is visually broken. I will assume standard padding for readability if strict adherence breaks layout, but here I stick to the structure. 
            // Correction: The skeleton says `padding(.vertical, 200)`. In ArkTS this is huge. I will keep it as per instruction "Implement every child".
        }
        .height(86)
        .backgroundColor('#FFFFFF') // Approximation of colorScheme.surface

        // Scrollable Content
        Scroll() {
          Column() {
            // Horizontal Category Scroll
            Scroll() {
              Row() {
                ForEach(['Category1', 'Category2', 'Category3'], (item: string) => {
                  Button() {
                    Text(item).fontColor('#000000')
                  }
                  .type(ButtonType.Capsule)
                  .margin({ right: 12 })
                })
              }
            }
            .width('100%')
            .padding({ top: 8, left: 12, right: 12 })

            // Form Fields
            Row() {
              Column() {
                TextInput({ placeholder: 'Asset Name' })
                  .borderWidth(1)
                  .borderColor('#CCCCCC')
                  .borderRadius(8)
                  .margin({ bottom: 16 })
                  .onChange((value: string) => {
                    this.assetName = value
                  })

                TextInput({ placeholder: 'Asset Code' })
                  .borderWidth(1)
                  .borderColor('#CCCCCC')
                  .borderRadius(8)
                  .margin({ bottom: 16 })
                  .onChange((value: string) => {
                    this.assetCode = value
                  })

                TextInput({ placeholder: 'Asset Type' })
                  .borderWidth(1)
                  .borderColor('#CCCCCC')
                  .borderRadius(8)
                  .margin({ bottom: 16 })
                  .onChange((value: string) => {
                    this.assetType = value
                  })

                // Selected Info Card
                Column() {
                  Text('Selected')
                    .fontSize(12)
                    .fontColor('#000000')
                    .margin({ bottom: 4 })
                  
                  Text(this.selectedId !== null ? 'Item Name' : 'None')
                    .fontSize(20)
                    .fontColor('#000000')
                }
                .width('100%')
                .padding(16)
                .backgroundColor('#FFFFFF')
                .borderRadius(16)
                .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })

              }
              .width('100%')
            }
            .padding({ left: 16, right: 16 })
            .margin({ top: 16 })

          }
          .width('100%')
          .padding({ bottom: 8 })
        }
        .layoutWeight(1)
        .backgroundColor('#F5F5F5') // Approximation of colorScheme.background

        // Bottom Action Bar
        Column() {
          Rect()
            .height(0)
            .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: -2 })
            .fill('#FFFFFF')

          Row() {
            Button() {
              Text('Reset').fontColor('#000000')
            }
            .type(ButtonType.Capsule)
            .onClick(() => {
              this.assetName = ''
              this.assetCode = ''
              this.assetType = 'Device'
              this.selectedId = null
            })

            Blank()

            Button() {
              Text('Save').fontColor('#000000')
            }
            .type(ButtonType.Capsule)
            .onClick(() => {
              // Save logic
            })
          }
          .width('100%')
          .padding({ top: 16, bottom: 16, left: 16, right: 16 })
          .backgroundColor('#FFFFFF')
        }
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}