class AssetMarker {
  id: number
  name: string
  type: string
  x: number
  y: number

  constructor(id: number, name: string, type: string, x: number, y: number) {
    this.id = id
    this.name = name
    this.type = type
    this.x = x
    this.y = y
  }
}

const COLOR_PRIMARY: string = '#111111'
const COLOR_SECONDARY: string = '#2A2A2A'
const COLOR_TERTIARY: string = '#474747'
const COLOR_BACKGROUND: string = '#F6F6F6'
const COLOR_SURFACE: string = '#FFFFFF'
const COLOR_SURFACE_VARIANT: string = '#EDEDED'
const COLOR_OUTLINE: string = '#D1D1D1'
const COLOR_ON_SURFACE: string = '#0A0A0A'
const COLOR_FIELD: string = '#E8E2EC'
const COLOR_FIELD_TEXT: string = '#54515B'

@Entry
@Component
struct Index {
  @State private enabledCats: string[] = ['Warehouse', 'Device', 'Office']
  @State private assetName: string = ''
  @State private assetCode: string = ''
  @State private assetType: string = 'Device'
  @State private selectedId: number = -1

  private categories: string[] = ['Warehouse', 'Device', 'Office']
  private markers: AssetMarker[] = [
    new AssetMarker(1, 'Main Warehouse', 'Warehouse', 0.18, 0.34),
    new AssetMarker(2, 'CNC-07', 'Device', 0.52, 0.46),
    new AssetMarker(3, 'HQ Office', 'Office', 0.75, 0.62),
    new AssetMarker(4, 'Spare Parts', 'Warehouse', 0.33, 0.78)
  ]

  private mapWidth: number = 312
  private mapHeight: number = 346

  private isEnabled(category: string): boolean {
    return this.enabledCats.indexOf(category) >= 0
  }

  private toggleCategory(category: string): void {
    const index = this.enabledCats.indexOf(category)
    if (index >= 0) {
      const next: string[] = this.enabledCats.slice()
      next.splice(index, 1)
      this.enabledCats = next
    } else {
      this.enabledCats = this.enabledCats.concat([category])
    }
  }

  private selectedName(): string {
    if (this.selectedId < 0) {
      return 'None'
    }
    for (let i = 0; i < this.markers.length; i++) {
      if (this.markers[i].id === this.selectedId) {
        return this.markers[i].name
      }
    }
    return 'None'
  }

  private markerColor(type: string): string {
    if (type === 'Warehouse') {
      return COLOR_TERTIARY
    }
    if (type === 'Device') {
      return COLOR_SECONDARY
    }
    return COLOR_PRIMARY
  }

  @Builder
  Header() {
    Row() {
      Text('Asset Inventory')
        .fontSize(54)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON_SURFACE)
        .maxLines(1)
    }
    .width('100%')
    .height(176)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(COLOR_SURFACE)
  }

  @Builder
  CategoryChip(category: string) {
    Button(category, { type: ButtonType.Normal, stateEffect: true })
      .height(64)
      .padding({ left: 32, right: 32 })
      .borderRadius(14)
      .backgroundColor(this.isEnabled(category) ? COLOR_PRIMARY : COLOR_SURFACE)
      .fontColor(this.isEnabled(category) ? COLOR_SURFACE : COLOR_ON_SURFACE)
      .fontSize(30)
      .fontWeight(this.isEnabled(category) ? FontWeight.Bold : FontWeight.Regular)
      .border({ width: 1, color: COLOR_OUTLINE })
      .onClick(() => {
        this.toggleCategory(category)
      })
  }

  @Builder
  PlainInput(placeholderText: string, mode: number) {
    Stack({ alignContent: Alignment.BottomStart }) {
      TextInput({
        placeholder: placeholderText,
        text: mode === 0 ? this.assetName : this.assetCode
      })
        .width(312)
        .height(112)
        .backgroundColor(COLOR_FIELD)
        .borderRadius({ topLeft: 14, topRight: 14, bottomLeft: 0, bottomRight: 0 })
        .padding({ left: 32, right: 16 })
        .fontSize(31)
        .fontColor(COLOR_ON_SURFACE)
        .placeholderColor(COLOR_FIELD_TEXT)
        .placeholderFont({ size: 31, weight: FontWeight.Regular })
        .caretColor(COLOR_PRIMARY)
        .onChange((value: string) => {
          if (mode === 0) {
            this.assetName = value
          } else {
            this.assetCode = value
          }
        })

      Divider()
        .width(312)
        .height(1)
        .backgroundColor('#4E4A53')
    }
    .width(312)
    .height(112)
  }

  @Builder
  TypeInput() {
    Stack({ alignContent: Alignment.BottomStart }) {
      Column() {
        Text('Asset Type')
          .fontSize(25)
          .fontColor(COLOR_FIELD_TEXT)
          .fontWeight(FontWeight.Regular)
          .margin({ left: 32, top: 18 })

        TextInput({ text: this.assetType })
          .width(280)
          .height(54)
          .backgroundColor(Color.Transparent)
          .padding({ left: 28, right: 0 })
          .fontSize(31)
          .fontColor(COLOR_ON_SURFACE)
          .caretColor(COLOR_PRIMARY)
          .onChange((value: string) => {
            this.assetType = value
          })
      }
      .width(312)
      .height(112)
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(COLOR_FIELD)
      .borderRadius({ topLeft: 14, topRight: 14, bottomLeft: 0, bottomRight: 0 })

      Divider()
        .width(312)
        .height(1)
        .backgroundColor('#4E4A53')
    }
    .width(312)
    .height(112)
  }

  @Builder
  SelectedCard() {
    Column() {
      Text('Selected')
        .fontSize(25)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SURFACE)

      Text(this.selectedName())
        .fontSize(38)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON_SURFACE)
        .margin({ top: 18 })
        .maxLines(1)
    }
    .width(312)
    .height(154)
    .padding({ left: 32, top: 30, right: 24 })
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(28)
    .border({ width: 1, color: COLOR_OUTLINE })
    .shadow({
      radius: 8,
      color: '#26000000',
      offsetX: 0,
      offsetY: 3
    })
  }

  @Builder
  MapGridOverlay() {
    Stack() {
      ForEach([0, 1, 2, 3, 4, 5], (index: number) => {
        Divider()
          .width(248)
          .height(1)
          .backgroundColor(COLOR_SURFACE_VARIANT)
          .position({ x: 32, y: 70 + index * 41 })
      }, (index: number) => index.toString())

      ForEach([0, 1, 2, 3, 4, 5], (index: number) => {
        Divider()
          .width(1)
          .height(282)
          .vertical(true)
          .backgroundColor(COLOR_SURFACE_VARIANT)
          .position({ x: 67 + index * 36, y: 32 })
      }, (index: number) => `v${index}`)
    }
    .width(this.mapWidth)
    .height(this.mapHeight)
  }

  @Builder
  MapMarker(marker: AssetMarker) {
    Stack({ alignContent: Alignment.TopStart }) {
      Circle()
        .width(this.selectedId === marker.id ? 28 : 22)
        .height(this.selectedId === marker.id ? 28 : 22)
        .fill(this.markerColor(marker.type))
        .stroke(this.selectedId === marker.id ? COLOR_PRIMARY : COLOR_SURFACE)
        .strokeWidth(2)

      Row() {
        Text(marker.type)
          .fontSize(23)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
          .maxLines(1)
      }
      .height(42)
      .padding({ left: 12, right: 12 })
      .backgroundColor(COLOR_SURFACE)
      .borderRadius(12)
      .border({ width: 1, color: COLOR_OUTLINE })
      .shadow({
        radius: 5,
        color: '#26000000',
        offsetX: 0,
        offsetY: 2
      })
      .position({ x: 18, y: -4 })
      .onClick(() => {
        this.selectedId = this.selectedId === marker.id ? -1 : marker.id
      })
    }
    .width(170)
    .height(62)
    .position({
      x: this.mapWidth * marker.x,
      y: this.mapHeight * marker.y
    })
  }

  @Builder
  MapPanel() {
    Stack({ alignContent: Alignment.TopStart }) {
      this.MapGridOverlay()

      ForEach(this.markers.filter((item: AssetMarker) => this.isEnabled(item.type)), (marker: AssetMarker) => {
        this.MapMarker(marker)
      }, (marker: AssetMarker) => marker.id.toString())
    }
    .width(this.mapWidth)
    .height(this.mapHeight)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(30)
    .border({ width: 1, color: COLOR_OUTLINE })
    .clip(false)
  }

  @Builder
  BottomBar() {
    Row() {
      Button('Reset', { type: ButtonType.Normal, stateEffect: true })
        .height(96)
        .layoutWeight(1)
        .borderRadius(20)
        .backgroundColor('#F2F2F2')
        .fontColor(COLOR_ON_SURFACE)
        .fontSize(30)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
          this.assetName = ''
          this.assetCode = ''
          this.assetType = 'Device'
          this.selectedId = -1
        })

      Blank()
        .width(24)

      Button('Save Asset', { type: ButtonType.Normal, stateEffect: true })
        .height(96)
        .layoutWeight(1)
        .borderRadius(20)
        .backgroundColor(COLOR_PRIMARY)
        .fontColor(COLOR_SURFACE)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
        })
    }
    .width('100%')
    .height(144)
    .padding({ left: 32, right: 32, top: 24, bottom: 24 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(COLOR_SURFACE)
    .shadow({
      radius: 8,
      color: '#14000000',
      offsetX: 0,
      offsetY: -2
    })
  }

  build() {
    Column() {
      this.Header()

      Column() {
        Row() {
          ForEach(this.categories, (category: string) => {
            this.CategoryChip(category)
          }, (category: string) => category)
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)
        .gap(16)

        Row() {
          Column() {
            this.PlainInput('Asset Name', 0)
            this.PlainInput('Asset Code', 1)
            this.TypeInput()
            this.SelectedCard()
          }
          .width(312)
          .alignItems(HorizontalAlign.Start)
          .gap(24)

          this.MapPanel()
            .margin({ left: 32, top: 187 })
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)
        .margin({ top: 48 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 32, right: 32, top: 40 })
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(COLOR_BACKGROUND)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}