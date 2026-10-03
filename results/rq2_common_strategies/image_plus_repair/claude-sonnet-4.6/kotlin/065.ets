// Index.ets - Asset Inventory ArkTS

class AssetMarker {
  id: number = 0
  name: string = ''
  type: string = ''
  x: number = 0
  y: number = 0

  constructor(id: number, name: string, type: string, x: number, y: number) {
    this.id = id
    this.name = name
    this.type = type
    this.x = x
    this.y = y
  }
}

const COLOR_PRIMARY: string = '#FF111111'
const COLOR_SECONDARY: string = '#FF2A2A2A'
const COLOR_TERTIARY: string = '#FF474747'
const COLOR_BACKGROUND: string = '#FFF6F6F6'
const COLOR_SURFACE: string = '#FFFFFFFF'
const COLOR_SURFACE_VARIANT: string = '#FFEDEDED'
const COLOR_OUTLINE: string = '#FFD1D1D1'
const COLOR_ON_SURFACE: string = '#FF0A0A0A'
const COLOR_ON_PRIMARY: string = '#FFFFFFFF'

const SPACING_XS: number = 4
const SPACING_SM: number = 8
const SPACING_MD: number = 12
const SPACING_LG: number = 16
const SPACING_XL: number = 24

const ALL_MARKERS: AssetMarker[] = [
  new AssetMarker(1, 'Main Warehouse', 'Warehouse', 0.18, 0.34),
  new AssetMarker(2, 'CNC-07', 'Device', 0.52, 0.46),
  new AssetMarker(3, 'HQ Office', 'Office', 0.75, 0.62),
  new AssetMarker(4, 'Spare Parts', 'Warehouse', 0.33, 0.78)
]

const ALL_CATEGORIES: string[] = ['Warehouse', 'Device', 'Office']

function getMarkerColor(type: string): string {
  if (type === 'Warehouse') return COLOR_TERTIARY
  if (type === 'Device') return COLOR_SECONDARY
  return COLOR_PRIMARY
}

function getSelectedMarkerName(markers: AssetMarker[], selectedId: number): string {
  if (selectedId < 0) return 'None'
  for (let i = 0; i < markers.length; i++) {
    if (markers[i].id === selectedId) return markers[i].name
  }
  return 'None'
}

@Component
struct MapGridOverlay {
  build() {
    Stack() {
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Divider()
            .color(COLOR_SURFACE_VARIANT)
            .strokeWidth(1)
        })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding(SPACING_LG)

      Row() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Divider()
            .vertical(true)
            .color(COLOR_SURFACE_VARIANT)
            .strokeWidth(1)
            .height('100%')
        })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding(SPACING_LG)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct MapMarkerView {
  markerType: string = ''
  isSelected: boolean = false
  onMarkerClick: () => void = () => {}
  posX: number = 0
  posY: number = 0

  build() {
    Stack() {
      Circle()
        .width(this.isSelected ? 28 : 22)
        .height(this.isSelected ? 28 : 22)
        .fill(getMarkerColor(this.markerType))
        .stroke(this.isSelected ? COLOR_PRIMARY : COLOR_SURFACE)
        .strokeWidth(2)

      Text(this.markerType)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SURFACE)
        .backgroundColor(COLOR_SURFACE)
        .padding({ left: SPACING_SM, right: SPACING_SM, top: SPACING_XS, bottom: SPACING_XS })
        .borderRadius(8)
        .border({ width: 1, color: COLOR_OUTLINE })
        .offset({ x: 18, y: -4 })
        .onClick(() => {
          this.onMarkerClick()
        })
    }
    .alignContent(Alignment.TopStart)
    .position({ x: this.posX, y: this.posY })
  }
}

@Entry
@Component
struct Index {
  @State enabledCats: string[] = ['Warehouse', 'Device', 'Office']
  @State assetName: string = ''
  @State assetCode: string = ''
  @State assetType: string = 'Device'
  @State selectedId: number = -1
  @State markers: AssetMarker[] = ALL_MARKERS

  getFilteredMarkers(): AssetMarker[] {
    let result: AssetMarker[] = []
    for (let i = 0; i < this.markers.length; i++) {
      let found = false
      for (let j = 0; j < this.enabledCats.length; j++) {
        if (this.markers[i].type === this.enabledCats[j]) {
          found = true
          break
        }
      }
      if (found) result.push(this.markers[i])
    }
    return result
  }

  isCatEnabled(cat: string): boolean {
    for (let i = 0; i < this.enabledCats.length; i++) {
      if (this.enabledCats[i] === cat) return true
    }
    return false
  }

  toggleCat(cat: string): void {
    if (this.isCatEnabled(cat)) {
      let newCats: string[] = []
      for (let i = 0; i < this.enabledCats.length; i++) {
        if (this.enabledCats[i] !== cat) newCats.push(this.enabledCats[i])
      }
      this.enabledCats = newCats
    } else {
      let newCats: string[] = []
      for (let i = 0; i < this.enabledCats.length; i++) {
        newCats.push(this.enabledCats[i])
      }
      newCats.push(cat)
      this.enabledCats = newCats
    }
  }

  build() {
    Column() {
      // Top bar
      Row() {
        Text('Asset Inventory')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: SPACING_XL, bottom: SPACING_LG, left: SPACING_LG, right: SPACING_LG })
      .backgroundColor(COLOR_SURFACE)

      // Content
      Column() {
        // Category filter chips
        Row() {
          ForEach(ALL_CATEGORIES, (cat: string) => {
            Text(cat)
              .fontSize(this.isCatEnabled(cat) ? 16 : 14)
              .fontWeight(this.isCatEnabled(cat) ? FontWeight.Medium : FontWeight.Normal)
              .fontColor(this.isCatEnabled(cat) ? COLOR_ON_PRIMARY : COLOR_ON_SURFACE)
              .backgroundColor(this.isCatEnabled(cat) ? COLOR_PRIMARY : COLOR_SURFACE)
              .padding({ left: SPACING_LG, right: SPACING_LG, top: SPACING_SM, bottom: SPACING_SM })
              .borderRadius(8)
              .border({ width: 1, color: COLOR_OUTLINE })
              .margin({ right: SPACING_SM })
              .onClick(() => {
                this.toggleCat(cat)
              })
          })
        }
        .width('100%')
        .margin({ bottom: SPACING_LG })

        // Main content row
        Row() {
          // Left column - form fields
          Column() {
            TextInput({ placeholder: 'Asset Name', text: this.assetName })
              .onChange((val: string) => { this.assetName = val })
              .width('100%')
              .backgroundColor(COLOR_SURFACE_VARIANT)
              .borderRadius(8)
              .margin({ bottom: SPACING_MD })

            TextInput({ placeholder: 'Asset Code', text: this.assetCode })
              .onChange((val: string) => { this.assetCode = val })
              .width('100%')
              .backgroundColor(COLOR_SURFACE_VARIANT)
              .borderRadius(8)
              .margin({ bottom: SPACING_MD })

            TextInput({ placeholder: 'Asset Type', text: this.assetType })
              .onChange((val: string) => { this.assetType = val })
              .width('100%')
              .backgroundColor(COLOR_SURFACE_VARIANT)
              .borderRadius(8)
              .margin({ bottom: SPACING_MD })

            // Selected card
            Column() {
              Text('Selected')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_SURFACE)
                .margin({ bottom: SPACING_SM })
              Text(getSelectedMarkerName(this.markers, this.selectedId))
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_SURFACE)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding(SPACING_LG)
            .backgroundColor(COLOR_SURFACE)
            .borderRadius(16)
            .border({ width: 1, color: COLOR_OUTLINE })
          }
          .width('48%')
          .alignItems(HorizontalAlign.Start)

          // Right column - map
          Stack() {
            MapGridOverlay()

            ForEach(this.getFilteredMarkers(), (m: AssetMarker) => {
              MapMarkerView({
                markerType: m.type,
                isSelected: this.selectedId === m.id,
                onMarkerClick: () => {
                  if (this.selectedId === m.id) {
                    this.selectedId = -1
                  } else {
                    this.selectedId = m.id
                  }
                },
                posX: m.x * 300,
                posY: m.y * 360
              })
            })
          }
          .width('48%')
          .height(360)
          .backgroundColor(COLOR_SURFACE)
          .borderRadius(16)
          .border({ width: 1, color: COLOR_OUTLINE })
          .clip(true)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Top)
      }
      .layoutWeight(1)
      .padding({ left: SPACING_LG, right: SPACING_LG, top: SPACING_MD, bottom: SPACING_MD })
      .backgroundColor(COLOR_BACKGROUND)

      // Bottom bar
      Row() {
        Button('Reset')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
          .backgroundColor(COLOR_SURFACE_VARIANT)
          .borderRadius(12)
          .height(48)
          .layoutWeight(1)
          .onClick(() => {
            this.assetName = ''
            this.assetCode = ''
            this.assetType = 'Device'
            this.selectedId = -1
          })

        Blank().width(SPACING_MD)

        Button('Save Asset')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_PRIMARY)
          .backgroundColor(COLOR_PRIMARY)
          .borderRadius(12)
          .height(48)
          .layoutWeight(1)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: SPACING_LG, right: SPACING_LG, top: SPACING_MD, bottom: SPACING_MD })
      .backgroundColor(COLOR_SURFACE)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}