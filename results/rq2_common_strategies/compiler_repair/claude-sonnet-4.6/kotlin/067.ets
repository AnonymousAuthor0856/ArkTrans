import { LengthMetrics } from '@kit.ArkUI'

// Color tokens
const COLOR_PRIMARY = '#FFFF7043'
const COLOR_SECONDARY = '#FFFFB74D'
const COLOR_TERTIARY = '#FFFFD54F'
const COLOR_BACKGROUND = '#FFFFF8E1'
const COLOR_SURFACE = '#FFFFFFFF'
const COLOR_SURFACE_VARIANT = '#FFFFECB3'
const COLOR_OUTLINE = '#FFE0C097'
const COLOR_ON_PRIMARY = '#FFFFFFFF'
const COLOR_ON_SURFACE = '#FF3E2723'

interface ClientData {
  id: number
  name: string
  region: string
  level: string
  x: number
  y: number
}

@Component
struct MapMarker {
  label: string = ''
  level: string = ''
  selected: boolean = false
  onMarkerClick: () => void = () => {}
  offsetX: number = 0
  offsetY: number = 0

  getColor(): string {
    if (this.level === 'A') return COLOR_PRIMARY
    if (this.level === 'B') return COLOR_SECONDARY
    return COLOR_TERTIARY
  }

  build() {
    Stack() {
      Circle()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .fill(this.getColor())
        .stroke(this.selected ? COLOR_ON_PRIMARY : COLOR_SURFACE)
        .strokeWidth(2)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SURFACE)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor(COLOR_SURFACE_VARIANT)
        .borderRadius(8)
        .border({ width: 1, color: COLOR_OUTLINE })
        .offset({ x: 24, y: -4 })
        .onClick(() => {
          this.onMarkerClick()
        })
    }
    .alignContent(Alignment.TopStart)
    .position({ x: this.offsetX, y: this.offsetY })
  }
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
      .padding(16)
      .justifyContent(FlexAlign.SpaceAround)

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
      .padding(16)
      .justifyContent(FlexAlign.SpaceAround)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct ClientCard {
  client: ClientData = { id: 0, name: '', region: '', level: '', x: 0, y: 0 }

  build() {
    Row() {
      Column() {
        Text(this.client.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
        Text(this.client.region)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(COLOR_ON_SURFACE)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Text(`Level ${this.client.level}`)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_PRIMARY)
    }
    .width('100%')
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(12)
    .border({ width: 1, color: COLOR_OUTLINE })
    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
  }
}

@Entry
@Component
struct Index {
  @State selectedId: number = -1

  clients: ClientData[] = [
    { id: 1, name: 'Sunrise Tech', region: 'Shanghai', level: 'A', x: 0.2, y: 0.3 },
    { id: 2, name: 'Delta Logistics', region: 'Beijing', level: 'B', x: 0.5, y: 0.45 },
    { id: 3, name: 'Oceanic Foods', region: 'Guangzhou', level: 'A', x: 0.72, y: 0.6 },
    { id: 4, name: 'Horizon Ltd.', region: 'Chengdu', level: 'C', x: 0.33, y: 0.75 }
  ]

  mapWidth: number = 360
  mapHeight: number = 400

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Client Detail')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(COLOR_SURFACE)

      Scroll() {
        Column({ space: 12 }) {
          // Header Banner
          Stack() {
            Text('Regional Client Map')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(COLOR_ON_PRIMARY)
          }
          .width('100%')
          .height(200)
          .borderRadius(16)
          .linearGradient({
            angle: 135,
            colors: [[0xFFFFB74D, 0.0], [0xFFFF7043, 1.0]]
          })
          .alignContent(Alignment.Center)

          // Map Area
          Stack() {
            MapGridOverlay()

            ForEach(this.clients, (c: ClientData) => {
              MapMarker({
                label: c.name,
                level: c.level,
                selected: this.selectedId === c.id,
                onMarkerClick: () => {
                  this.selectedId = this.selectedId === c.id ? -1 : c.id
                },
                offsetX: this.mapWidth * c.x,
                offsetY: this.mapHeight * c.y
              })
            })
          }
          .width('100%')
          .height(this.mapHeight)
          .backgroundColor(COLOR_SURFACE)
          .borderRadius(16)
          .border({ width: 1, color: COLOR_OUTLINE })
          .clip(true)

          // Client List
          Column({ space: 12 }) {
            ForEach(this.clients, (c: ClientData) => {
              ClientCard({ client: c })
            })
          }
          .width('100%')
          .padding({ bottom: 32 })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}