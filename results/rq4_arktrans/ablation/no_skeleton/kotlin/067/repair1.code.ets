@Entry
@Component
struct ClientDetail {
  @State selectedId: number | null = null

  build() {
    Column() {
      // Header
      Text('Client Detail')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3E2723')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 40, bottom: 24 })

      // Gradient Banner
      Row() {
        Text('Regional Client Map')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
      }
      .width('100%')
      .height(200)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .borderRadius(16)
      .linearGradient({
        direction: GradientDirection.RightBottom,
        colors: [['#FFB74D', 0], ['#FF7043', 1]]
      })
      .margin({ left: 16, right: 16 })

      // Map Container
      Stack() {
        // Grid Overlay (Horizontal Lines)
        Column() {
          ForEach([1, 2, 3, 4, 5, 6], () => {
            Divider().color('#FFECB3').strokeWidth(1).margin({ top: 1 })
          })
        }
        .width('100%')
        .height('100%')
        .padding(16)

        // Grid Overlay (Vertical Lines)
        Row() {
          ForEach([1, 2, 3, 4, 5, 6], () => {
            Divider().vertical(true).color('#FFECB3').strokeWidth(1).margin({ left: 1 })
          })
        }
        .width('100%')
        .height('100%')
        .padding(16)

        // Markers
        this.MapMarker({
          label: 'Sunrise Tech',
          level: 'A',
          x: 0.2,
          y: 0.3,
          id: 1
        })

        this.MapMarker({
          label: 'Delta Logistics',
          level: 'B',
          x: 0.5,
          y: 0.45,
          id: 2
        })

        this.MapMarker({
          label: 'Oceanic Foods',
          level: 'A',
          x: 0.72,
          y: 0.6,
          id: 3
        })

        this.MapMarker({
          label: 'Horizon Ltd.',
          level: 'C',
          x: 0.33,
          y: 0.75,
          id: 4
        })
      }
      .width('100%')
      .height(400)
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
      .border({ width: 1, color: '#E0C097' })
      .margin({ left: 16, right: 16, top: -16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8E1')
    .padding({ top: 0, left: 0, right: 0, bottom: 0 })
  }

  @Builder
  MapMarker(params: MapMarkerParams) {
    let isSelected = this.selectedId === params.id
    let dotSize = isSelected ? 28 : 22
    let dotColor = '#FF7043'
    
    if (params.level === 'B') dotColor = '#FFB74D'
    else if (params.level === 'C') dotColor = '#FFD54F'

    Stack() {
      // Dot
      Circle()
        .width(dotSize)
        .height(dotSize)
        .fill(dotColor)
        .border({ width: 2, color: isSelected ? '#FFFFFF' : '#FFFFFF' })
      
      // Label Card
      Text(params.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#3E2723')
        .backgroundColor('#FFECB3')
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .borderRadius(8)
        .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
        .position({ x: dotSize + 4, y: -4 })
    }
    .onClick(() => {
      this.selectedId = isSelected ? null : params.id
    })
    .position({
      x: `${params.x * 100}%`,
      y: `${params.y * 100}%`
    })
  }
}

interface MapMarkerParams {
  label: string;
  level: string;
  x: number;
  y: number;
  id: number;
}