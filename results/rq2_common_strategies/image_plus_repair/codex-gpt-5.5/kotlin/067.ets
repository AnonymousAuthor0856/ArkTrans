interface Client {
  id: number
  name: string
  region: string
  level: string
  x: number
  y: number
}

class AppColors {
  static primary: string = '#FF7043'
  static secondary: string = '#FFB74D'
  static tertiary: string = '#FFD54F'
  static background: string = '#FFF8E1'
  static surface: string = '#FFFFFF'
  static surfaceVariant: string = '#FFECB3'
  static outline: string = '#E0C097'
  static onPrimary: string = '#FFFFFF'
  static onSurface: string = '#3E2723'
}

@Entry
@Component
struct ClientDetailPage {
  @State selectedId: number = -1

  clients: Client[] = [
    { id: 1, name: 'Sunrise Tech', region: 'Shanghai', level: 'A', x: 0.20, y: 0.30 },
    { id: 2, name: 'Delta Logistics', region: 'Beijing', level: 'B', x: 0.50, y: 0.45 },
    { id: 3, name: 'Oceanic Foods', region: 'Guangzhou', level: 'A', x: 0.72, y: 0.60 },
    { id: 4, name: 'Horizon Ltd.', region: 'Chengdu', level: 'C', x: 0.33, y: 0.75 }
  ]

  markerColor(level: string): string {
    if (level === 'A') {
      return AppColors.primary
    }
    if (level === 'B') {
      return AppColors.secondary
    }
    return AppColors.tertiary
  }

  build() {
    Column() {
      Row() {
        Text('Client Detail')
          .fontSize(52)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(176)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.surface)

      Scroll() {
        Column({ space: 12 }) {
          Stack({ alignContent: Alignment.Center }) {
            Text('Regional Client Map')
              .fontSize(38)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onPrimary)
          }
          .width('100%')
          .height(400)
          .borderRadius(28)
          .linearGradient({
            angle: 105,
            colors: [[AppColors.secondary, 0.0], [AppColors.primary, 1.0]]
          })

          Stack({ alignContent: Alignment.TopStart }) {
            this.MapGrid()

            ForEach(this.clients, (client: Client) => {
              this.MapMarker(client)
            }, (client: Client) => client.id.toString())
          }
          .width('100%')
          .height(696)
          .clip(true)
          .backgroundColor(AppColors.surface)
          .border({
            width: 1,
            color: AppColors.outline,
            radius: 28
          })

          ForEach(this.clients, (client: Client) => {
            this.ClientCard(client)
          }, (client: Client) => `card-${client.id}`)
        }
        .width('100%')
        .padding({
          left: 32,
          right: 32,
          top: 24,
          bottom: 32
        })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  MapGrid() {
    Stack() {
      ForEach([0, 1, 2, 3, 4, 5], (item: number) => {
        Blank()
          .width('100%')
          .height(1)
          .backgroundColor(AppColors.surfaceVariant)
          .position({ x: 0, y: 92 + item * 96 })
      }, (item: number) => `h-${item}`)

      ForEach([0, 1, 2, 3, 4, 5], (item: number) => {
        Blank()
          .width(1)
          .height('100%')
          .backgroundColor(AppColors.surfaceVariant)
          .position({ x: 84 + item * 84.8, y: 0 })
      }, (item: number) => `v-${item}`)
    }
    .width('100%')
    .height('100%')
    .padding(32)
  }

  @Builder
  MapMarker(client: Client) {
    Stack({ alignContent: Alignment.TopStart }) {
      Circle()
        .width(this.selectedId === client.id ? 28 : 22)
        .height(this.selectedId === client.id ? 28 : 22)
        .fill(this.markerColor(client.level))
        .stroke(AppColors.surface)
        .strokeWidth(4)
        .position({ x: 0, y: 4 })

      Text(client.name)
        .fontSize(23)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .maxLines(1)
        .padding({
          left: 14,
          right: 14,
          top: 8,
          bottom: 8
        })
        .backgroundColor(AppColors.surfaceVariant)
        .border({
          width: 1,
          color: AppColors.outline,
          radius: 12
        })
        .shadow({
          radius: 5,
          color: '#33000000',
          offsetX: 0,
          offsetY: 2
        })
        .position({ x: 38, y: 18 })
        .onClick(() => {
          this.selectedId = this.selectedId === client.id ? -1 : client.id
        })
    }
    .width(290)
    .height(72)
    .position({ x: 132 + client.x * 420, y: 118 + client.y * 520 })
  }

  @Builder
  ClientCard(client: Client) {
    Row() {
      Column({ space: 4 }) {
        Text(client.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Text(client.region)
          .fontSize(14)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text(`Level ${client.level}`)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .border({
      width: 1,
      color: AppColors.outline,
      radius: 12
    })
    .shadow({
      radius: 4,
      color: '#22000000',
      offsetX: 0,
      offsetY: 2
    })
  }
}
