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
  posX: number = 0
  posY: number = 0

  getColor(): string {
    if (this.level === 'A') return COLOR_PRIMARY
    if (this.level === 'B') return COLOR_SECONDARY
    return COLOR_TERTIARY
  }

  build() {
    Stack() {
      // Dot marker
      Stack() {
      }
      .width(this.selected ? 28 : 22)
      .height(this.selected ? 28 : 22)
      .borderRadius(this.selected ? 14 : 11)
      .backgroundColor(this.getColor())
      .border({
        width: 2,
        color: this.selected ? COLOR_ON_PRIMARY : COLOR_SURFACE
      })

      // Label card
      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SURFACE)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor(COLOR_SURFACE_VARIANT)
        .borderRadius(8)
        .border({ width: 1, color: COLOR_OUTLINE })
        .shadow({ radius: 4, offsetY: 2, color: '#1A000000' })
        .margin({ left: 26, top: 0 })
        .onClick(() => {
          this.onMarkerClick()
        })
    }
    .alignContent(Alignment.TopStart)
    .position({ x: this.posX, y: this.posY })
  }
}

@Component
struct MapGridOverlay {
  build() {
    Stack() {
      // Horizontal lines
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Divider()
            .width('100%')
            .height(1)
            .color(COLOR_SURFACE_VARIANT)
        })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .justifyContent(FlexAlign.SpaceAround)

      // Vertical lines
      Row() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Divider()
            .vertical(true)
            .height('100%')
            .width(1)
            .color(COLOR_SURFACE_VARIANT)
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
    .shadow({ radius: 4, offsetY: 2, color: '#1A000000' })
  }
}

@Entry
@Component
struct Index {
  @State selectedId: number = -1

  private clients: ClientData[] = [
    { id: 1, name: 'Sunrise Tech', region: 'Shanghai', level: 'A', x: 0.2, y: 0.3 },
    { id: 2, name: 'Delta Logistics', region: 'Beijing', level: 'B', x: 0.5, y: 0.45 },
    { id: 3, name: 'Oceanic Foods', region: 'Guangzhou', level: 'A', x: 0.72, y: 0.6 },
    { id: 4, name: 'Horizon Ltd.', region: 'Chengdu', level: 'C', x: 0.33, y: 0.75 }
  ]

  private mapWidth: number = 360
  private mapHeight: number = 400

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
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(COLOR_SURFACE)

      // Scrollable content
      Scroll() {
        Column() {
          // Gradient banner
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
          .margin({ bottom: 12 })

          // Map area
          Stack() {
            MapGridOverlay()

            ForEach(this.clients, (c: ClientData) => {
              MapMarker({
                label: c.name,
                level: c.level,
                selected: this.selectedId === c.id,
                onMarkerClick: () => {
                  if (this.selectedId === c.id) {
                    this.selectedId = -1
                  } else {
                    this.selectedId = c.id
                  }
                },
                posX: this.mapWidth * c.x,
                posY: this.mapHeight * c.y
              })
            })
          }
          .width('100%')
          .height(this.mapHeight)
          .backgroundColor(COLOR_SURFACE)
          .borderRadius(16)
          .border({ width: 1, color: COLOR_OUTLINE })
          .clip(true)
          .margin({ bottom: 12 })

          // Client list
          Column() {
            ForEach(this.clients, (c: ClientData) => {
              ClientCard({ client: c })
                .margin({ bottom: 12 })
            })
          }
          .width('100%')
          .padding({ bottom: 32 })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12 })
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