import { ClickEvent } from '@kit.ArkUI'

@Entry
@Component
struct RootScreen {
  @State categories: string[] = ['Warehouse', 'Device', 'Office']
  @State enabledCats: string[] = ['Warehouse', 'Device', 'Office']
  @State markers: AssetMarker[] = [
    { id: 1, name: 'Main Warehouse', type: 'Warehouse', x: 0.18, y: 0.34 },
    { id: 2, name: 'CNC-07', type: 'Device', x: 0.52, y: 0.46 },
    { id: 3, name: 'HQ Office', type: 'Office', x: 0.75, y: 0.62 },
    { id: 4, name: 'Spare Parts', type: 'Warehouse', x: 0.33, y: 0.78 }
  ]
  @State assetName: string = ''
  @State assetCode: string = ''
  @State assetType: string = 'Device'
  @State selectedId: number | null = null

  build() {
    // === Column ===
    // props: { space: 0 }
    // modifier: { width: '100%', height: '100%', backgroundColor: '#F6F6F6' }
    Column() {
      // === Row ===
      // props: { space: 0, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }
      // modifier: { width: '100%', height: 86, backgroundColor: '#FFF' }
      // children: 1
      Row() {
        // === Text ===
        // props: { text: 'Asset Inventory' }
        // modifier: { fontSize: 28, fontWeight: FontWeight.Semibold, fontColor: '#0A0A0A' }
        Text('Asset Inventory')
      }

      // === Scroll ===
      // props: { scrollable: ScrollDirection.Vertical, barPosition: BarPosition.OutsideEnd }
      // modifier: { width: '100%', layoutWeight: 1 }
      // children: 1
      Scroll() {
        // === Column ===
        // props: { space: 16 }
        // modifier: { width: '100%', padding: { left: 16, right: 16, bottom: 12 } }
        // children: 3
        Column({ space: 16 }) {
          // === Scroll ===
          // props: { scrollable: ScrollDirection.Horizontal, barPosition: BarPosition.OutsideEnd }
          // modifier: { width: '100%' }
          // children: 1
          Scroll() {
            // === Row ===
            // props: { space: 8 }
            // modifier: { width: '100%' }
            // children: 3
            Row({ space: 8 }) {
              // === Button (Warehouse) ===
              // modifier: { backgroundColor: '#111111', borderRadius: 8, padding: { left: 12, right: 12, top: 8, bottom: 8 } }
              // children: 1
              Button() {
                // === Text ===
                // props: { text: 'Warehouse' }
                // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#FFF' }
                Text('Warehouse').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#FFF')
              }.backgroundColor('#111111').borderRadius(8).padding({ left: 12, right: 12, top: 8, bottom: 8 }).onClick(() => {
                this.toggleCategory('Warehouse')
              })

              // === Button (Device) ===
              // modifier: { backgroundColor: '#111111', borderRadius: 8, padding: { left: 12, right: 12, top: 8, bottom: 8 } }
              // children: 1
              Button() {
                // === Text ===
                // props: { text: 'Device' }
                // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#FFF' }
                Text('Device').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#FFF')
              }.backgroundColor('#111111').borderRadius(8).padding({ left: 12, right: 12, top: 8, bottom: 8 }).onClick(() => {
                this.toggleCategory('Device')
              })

              // === Button (Office) ===
              // modifier: { backgroundColor: '#111111', borderRadius: 8, padding: { left: 12, right: 12, top: 8, bottom: 8 } }
              // children: 1
              Button() {
                // === Text ===
                // props: { text: 'Office' }
                // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#FFF' }
                Text('Office').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#FFF')
              }.backgroundColor('#111111').borderRadius(8).padding({ left: 12, right: 12, top: 8, bottom: 8 }).onClick(() => {
                this.toggleCategory('Office')
              })
            }
          }

          // === Row ===
          // props: { space: 16, alignItems: ItemAlign.Top }
          // modifier: { width: '100%' }
          // children: 2
          Row({ space: 16 }) {
            .alignItems(ItemAlign.Top)
            // === Column (Left Inputs) ===
            // props: { space: 12 }
            // modifier: { width: '100%', layoutWeight: 1 }
            // children: 4
            Column({ space: 12 }) {
              // === TextInput (Asset Name) ===
              // props: { placeholder: 'Asset Name', text: this.assetName }
              // modifier: { width: '100%', height: 44, backgroundColor: '#EDEDED', borderRadius: 8, borderColor: '#D1D1D1', borderWidth: 1, padding: { left: 12, right: 12, top: 8, bottom: 8 } }
              TextInput({ placeholder: 'Asset Name', text: this.assetName }).width('100%').height(44).backgroundColor('#EDEDED').borderRadius(8).border({ color: '#D1D1D1', width: 1 }).padding({ left: 12, right: 12, top: 8, bottom: 8 }).onChange((value: string) => { this.assetName = value })

              // === TextInput (Asset Code) ===
              // props: { placeholder: 'Asset Code', text: this.assetCode }
              // modifier: { width: '100%', height: 44, backgroundColor: '#EDEDED', borderRadius: 8, borderColor: '#D1D1D1', borderWidth: 1, padding: { left: 12, right: 12, top: 8, bottom: 8 } }
              TextInput({ placeholder: 'Asset Code', text: this.assetCode }).width('100%').height(44).backgroundColor('#EDEDED').borderRadius(8).border({ color: '#D1D1D1', width: 1 }).padding({ left: 12, right: 12, top: 8, bottom: 8 }).onChange((value: string) => { this.assetCode = value })

              // === TextInput (Asset Type) ===
              // props: { placeholder: 'Asset Type', text: this.assetType }
              // modifier: { width: '100%', height: 44, backgroundColor: '#EDEDED', borderRadius: 8, borderColor: '#D1D1D1', borderWidth: 1, padding: { left: 12, right: 12, top: 8, bottom: 8 } }
              TextInput({ placeholder: 'Asset Type', text: this.assetType }).width('100%').height(44).backgroundColor('#EDEDED').borderRadius(8).border({ color: '#D1D1D1', width: 1 }).padding({ left: 12, right: 12, top: 8, bottom: 8 }).onChange((value: string) => { this.assetType = value })

              // === Card (Selected) ===
              // modifier: { width: '100%', padding: 16, backgroundColor: '#FFF', borderRadius: 16, shadow: { radius: 4, color: '#1A000000', offsetY: 2 }, border: { color: '#D1D1D1', width: 1 } }
              // children: 2
              Column() {
                // === Text ===
                // props: { text: 'Selected' }
                // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#0A0A0A' }
                Text('Selected').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#0A0A0A')
                // === Text ===
                // props: { text: this.getSelectedName() }
                // modifier: { fontSize: 20, fontWeight: FontWeight.Medium, fontColor: '#0A0A0A' }
                Text(this.getSelectedName()).fontSize(20).fontWeight(FontWeight.Medium).fontColor('#0A0A0A')
              }.width('100%').padding(16).backgroundColor('#FFF').borderRadius(16).shadow({ radius: 4, color: '#1A000000', offsetY: 2 }).border({ color: '#D1D1D1', width: 1 })
            }

            // === Stack (Map Area) ===
            // props: { alignContent: Alignment.TopStart }
            // modifier: { width: '100%', layoutWeight: 1, height: 360, aspectRatio: 0.9, backgroundColor: '#FFF', borderRadius: 16, border: { color: '#D1D1D1', width: 1 } }
            // children: 2
            Stack({ alignContent: Alignment.TopStart }) {
              // === MapGridOverlay ===
              MapGridOverlay()

              // === ForEach Markers ===
              ForEach(this.markers.filter(m => this.enabledCats.includes(m.type)), (m: AssetMarker) => {
                // === MapMarker ===
                MapMarker({ type: m.type, selected: this.selectedId === m.id, onClick: () => { this.selectedId = (this.selectedId === m.id) ? null : m.id }, colorScheme: {} as AppColorScheme })
                  .position({ x: `${m.x * 100}%`, y: `${m.y * 100}%` })
              })
            }
          }
        }
      }

      // === Column (Bottom Bar) ===
      // props: { space: 0 }
      // modifier: { width: '100%', backgroundColor: '#FFF' }
      // children: 2
      Column() {
        // === Blank (Shadow Spacer) ===
        // modifier: { height: 0, shadow: { radius: 8, color: '#24000000', offsetY: -4 } }
        Blank().height(0).shadow({ radius: 8, color: '#24000000', offsetY: -4 })

        // === Row (Buttons) ===
        // props: { space: 12 }
        // modifier: { width: '100%', padding: { left: 16, right: 16, top: 12, bottom: 12 } }
        // children: 2
        Row({ space: 12 }) {
          // === Button (Reset) ===
          // modifier: { width: '100%', layoutWeight: 1, height: 48, backgroundColor: '#EDEDED', borderRadius: 12 }
          // children: 1
          Button() {
            // === Text ===
            // props: { text: 'Reset' }
            // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#0A0A0A' }
            Text('Reset').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#0A0A0A')
          }.width('100%').layoutWeight(1).height(48).backgroundColor('#EDEDED').borderRadius(12).onClick(() => {
            this.resetForm()
          })

          // === Button (Save Asset) ===
          // modifier: { width: '100%', layoutWeight: 1, height: 48, backgroundColor: '#111111', borderRadius: 12 }
          // children: 1
          Button() {
            // === Text ===
            // props: { text: 'Save Asset' }
            // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#FFF' }
            Text('Save Asset').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#FFF')
          }.width('100%').layoutWeight(1).height(48).backgroundColor('#111111').borderRadius(12)
        }
      }
    }
  }

  toggleCategory(cat: string) {
    const index = this.enabledCats.indexOf(cat)
    if (index > -1) {
      this.enabledCats.splice(index, 1)
    } else {
      this.enabledCats.push(cat)
    }
  }

  getSelectedName(): string {
    if (this.selectedId === null) return 'None'
    const marker = this.markers.find(m => m.id === this.selectedId)
    return marker ? marker.name : 'None'
  }

  resetForm() {
    this.assetName = ''
    this.assetCode = ''
    this.assetType = 'Device'
    this.selectedId = null
  }
}

interface AssetMarker {
  id: number
  name: string
  type: string
  x: number
  y: number
}

interface AppColorScheme {
  primary: string
  onPrimary: string
  secondary: string
  onSecondary: string
  tertiary: string
  onTertiary: string
  background: string
  onBackground: string
  surface: string
  onSurface: string
  surfaceVariant: string
  outline: string
  error: string
}

const AppTokens = {
  Colors: {
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
}

@Component
struct MapGridOverlay {
  build() {
    // === Stack ===
    // props: { alignContent: Alignment.TopStart }
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack({ alignContent: Alignment.TopStart }) {
      // === Column (Vertical Lines) ===
      // props: { space: 0 }
      // modifier: { width: '100%', height: '100%', padding: 16 }
      // children: 7
      Column() {
        // === Divider ===
        // modifier: { width: '100%', height: 1, color: '#EDEDED' }
        Divider().width('100%').height(1).color('#EDEDED')
        // === Blank ===
        Blank().layoutWeight(1)
        // === Divider ===
        Divider().width('100%').height(1).color('#EDEDED')
        // === Blank ===
        Blank().layoutWeight(1)
        // === Divider ===
        Divider().width('100%').height(1).color('#EDEDED')
        // === Blank ===
        Blank().layoutWeight(1)
        // === Divider ===
        Divider().width('100%').height(1).color('#EDEDED')
        // === Blank ===
        Blank().layoutWeight(1)
        // === Divider ===
        Divider().width('100%').height(1).color('#EDEDED')
        // === Blank ===
        Blank().layoutWeight(1)
        // === Divider ===
        Divider().width('100%').height(1).color('#EDEDED')
        // === Blank ===
        Blank().layoutWeight(1)
        // === Divider ===
        Divider().width('100%').height(1).color('#EDEDED')
      }

      // === Row (Horizontal Lines) ===
      // props: { space: 0 }
      // modifier: { width: '100%', height: '100%', padding: 16 }
      // children: 7
      Row() {
        // === Divider ===
        // modifier: { height: '100%', width: 1, color: '#EDEDED' }
        Divider().height('100%').width(1).color('#EDEDED')
        // === Blank ===
        Blank().layoutWeight(1)
        // === Divider ===
        Divider().height('100%').width(1).color('#EDEDED')
        // === Blank ===
        Blank().layoutWeight(1)
        // === Divider ===
        Divider().height('100%').width(1).color('#EDEDED')
        // === Blank ===
        Blank().layoutWeight(1)
        // === Divider ===
        Divider().height('100%').width(1).color('#EDEDED')
        // === Blank ===
        Blank().layoutWeight(1)
        // === Divider ===
        Divider().height('100%').width(1).color('#EDEDED')
        // === Blank ===
        Blank().layoutWeight(1)
        // === Divider ===
        Divider().height('100%').width(1).color('#EDEDED')
        // === Blank ===
        Blank().layoutWeight(1)
        // === Divider ===
        Divider().height('100%').width(1).color('#EDEDED')
      }
    }
  }
}

@Component
struct MapMarker {
  private type: string = ''
  private selected: boolean = false
  private onClickHandler: () => void = () => {}
  private colorScheme: AppColorScheme = {} as AppColorScheme

  constructor(props: { type: string, selected: boolean, onClick: () => void, colorScheme: AppColorScheme }) {
    super()
    this.type = props.type
    this.selected = props.selected
    this.onClickHandler = props.onClick
    this.colorScheme = props.colorScheme
  }

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.TopStart }
    // modifier: { width: 'auto', height: 'auto' }
    // children: 2
    Stack({ alignContent: Alignment.TopStart }) {
      // === Circle (Dot) ===
      // modifier: { width: this.selected ? 28 : 22, height: this.selected ? 28 : 22, backgroundColor: this.getMarkerColor(), borderColor: this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface, borderWidth: 2 }
      Circle().width(this.selected ? 28 : 22).height(this.selected ? 28 : 22).backgroundColor(this.getMarkerColor()).border({ color: this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface, width: 2 })

      // === Button (Label) ===
      // modifier: { position: { x: 18, y: -4 }, backgroundColor: '#FFF', borderRadius: 8, padding: { left: 8, right: 8, top: 4, bottom: 4 }, shadow: { radius: 4, color: '#1A000000', offsetY: 2 }, border: { color: '#D1D1D1', width: 1 } }
      // children: 1
      Button() {
        // === Text ===
        // props: { text: this.type }
        // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#0A0A0A' }
        Text(this.type).fontSize(12).fontWeight(FontWeight.Medium).fontColor('#0A0A0A')
      }.position({ x: 18, y: -4 }).backgroundColor('#FFF').borderRadius(8).padding({ left: 8, right: 8, top: 4, bottom: 4 }).shadow({ radius: 4, color: '#1A000000', offsetY: 2 }).border({ color: '#D1D1D1', width: 1 }).onClick(() => {
        this.onClickHandler()
      })
    }
  }

  getMarkerColor(): string {
    switch (this.type) {
      case 'Warehouse': return AppTokens.Colors.tertiary
      case 'Device': return AppTokens.Colors.secondary
      default: return AppTokens.Colors.primary
    }
  }
}