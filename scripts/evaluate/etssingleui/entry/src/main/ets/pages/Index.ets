@Entry
@Component
struct Index {
  private colorScheme = {
    primary: '#111111',
    secondary: '#2A2A2A',
    tertiary: '#474747',
    background: '#F6F6F6',
    surface: '#FFFFFF',
    surfaceVariant: '#EDEDED',
    outline: '#D1D1D1',
    success: '#2E7D32',
    warning: '#B98900',
    error: '#B3261E',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#0A0A0A',
    onSurface: '#0A0A0A'
  }

  @State assetName: string = ''
  @State assetCode: string = ''
  @State assetType: string = 'Device'

  @State categories: string[] = ['Device', 'Vehicle', 'Tool', 'Furniture', 'Other']
  @State enabledCats: string[] = ['Device', 'Vehicle', 'Tool', 'Furniture', 'Other']

  @State markers: Array<{ id: number, name: string }> = [
    { id: 1, name: 'Warehouse A' },
    { id: 2, name: 'Warehouse B' },
    { id: 3, name: 'Site C' }
  ]
  @State selectedId: number = -1

  private isEnabled(c: string): boolean {
    return this.enabledCats.indexOf(c) >= 0
  }

  private toggleCategory(c: string) {
    if (this.isEnabled(c)) {
      this.enabledCats = this.enabledCats.filter(v => v !== c)
    } else {
      this.enabledCats = [...this.enabledCats, c]
    }
  }

  private selectedName(): string {
    let found = this.markers.find(m => m.id === this.selectedId)
    return found ? found.name : 'None'
  }

  private resetForm() {
    this.assetName = ''
    this.assetCode = ''
    this.assetType = 'Device'
    this.selectedId = -1
  }

  private saveAsset() {
    // placeholder save logic; keep UI compilable within allowed components
    this.selectedId = this.selectedId
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        Stack() {
          Text('Asset Inventory')
            .fontSize(28)
            .fontColor(this.colorScheme.onSurface)
        }
        .width('100%')
        .height(86)
        .backgroundColor(this.colorScheme.surface)
        .padding({ top: 20, bottom: 20, left: 16, right: 16 })

        List({ space: 0 }) {
          ListItem() {
            List({ space: 0 }) {
              ListItem() {
                Row({ space: 8 }) {
                  for (let i = 0; i < this.categories.length; i++) {
                    let c = this.categories[i]
                    Button() {
                      Text(c)
                        .fontSize(14)
                        .fontColor(this.isEnabled(c) ? this.colorScheme.onPrimary : this.colorScheme.onSurface)
                    }
                    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                    .backgroundColor(this.isEnabled(c) ? this.colorScheme.primary : this.colorScheme.surfaceVariant)
                    .borderRadius(16)
                    .onClick(() => this.toggleCategory(c))
                  }
                }
                .width('100%')
              }
            }
            .width('100%')
          }

          ListItem() {
            Column({ space: 16 }) {
              TextInput({ placeholder: 'Asset Name', text: this.assetName })
                .width('100%')
                .height(44)
                .padding({ left: 12, right: 12 })
                .backgroundColor(this.colorScheme.surface)
                .borderRadius(12)
                .border({ width: 1, color: this.colorScheme.outline })
                .onChange((v: string) => { this.assetName = v })

              TextInput({ placeholder: 'Asset Code', text: this.assetCode })
                .width('100%')
                .height(44)
                .padding({ left: 12, right: 12 })
                .backgroundColor(this.colorScheme.surface)
                .borderRadius(12)
                .border({ width: 1, color: this.colorScheme.outline })
                .onChange((v: string) => { this.assetCode = v })

              TextInput({ placeholder: 'Asset Type', text: this.assetType })
                .width('100%')
                .height(44)
                .padding({ left: 12, right: 12 })
                .backgroundColor(this.colorScheme.surface)
                .borderRadius(12)
                .border({ width: 1, color: this.colorScheme.outline })
                .onChange((v: string) => { this.assetType = v })

              Column({ space: 8 }) {
                Text('Selected')
                  .fontSize(12)
                  .fontColor(this.colorScheme.onSurface)

                Text(this.selectedName())
                  .fontSize(18)
                  .fontColor(this.colorScheme.onSurface)
              }
              .width('100%')
              .padding(16)
              .backgroundColor(this.colorScheme.surface)
              .borderRadius(16)
              .shadow({ radius: 8, color: '#0000001F', offsetX: 0, offsetY: 2 })
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 12 })
          }

          ListItem() {
            Blank().height(8)
          }
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(this.colorScheme.background)

        Column({ space: 0 }) {
          Divider()
            .height(1)
            .color(this.colorScheme.outline)

          Row({ space: 12 }) {
            Button() {
              Text('Reset')
                .fontSize(16)
                .fontColor(this.colorScheme.onSurface)
            }
            .height(48)
            .layoutWeight(1)
            .backgroundColor(this.colorScheme.surfaceVariant)
            .borderRadius(12)
            .onClick(() => this.resetForm())

            Button() {
              Text('Save')
                .fontSize(16)
                .fontColor(this.colorScheme.onPrimary)
            }
            .height(48)
            .layoutWeight(1)
            .backgroundColor(this.colorScheme.primary)
            .borderRadius(12)
            .onClick(() => this.saveAsset())
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
          .backgroundColor(this.colorScheme.surface)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.colorScheme.background)
    }
    .width('100%')
    .height('100%')
  }
}