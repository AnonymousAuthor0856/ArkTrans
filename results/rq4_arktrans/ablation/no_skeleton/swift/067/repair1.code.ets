@Entry
@Component
struct ClientDetailApp {
  @State selectedId: number = -1

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Client Detail')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3E2723')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFF8E1')

      // Scrollable Content
      Scroll() {
        Column() {
          // Regional Map Header
          Row() {
            Text('Regional Client Map')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .height(200)
          .justifyContent(FlexAlign.Center)
          .linearGradient({
            angle: 0,
            colors: [['#FFB74D', 0.0], ['#FF7043', 1.0]]
          })
          .borderRadius(16)
          .margin({ left: 16, right: 16, top: 12 })

          // Map Area Container
          Stack() {
            // Background & Border
            Column()
              .width('100%')
              .height('100%')
              .backgroundColor('#FFFFFF')
              .borderRadius(16)
              .border({ width: 1, color: '#E0C097' })

            // Grid Overlay (Simulated with absolute positioning for fixed layout)
            // Horizontal Lines
            ForEach([1, 2, 3, 4, 5, 6], (i: number) => {
              Divider()
                .color('#FFECB3')
                .width('100%')
                .position({ x: 0, y: `${Math.round((i / 7) * 100)}%` })
            })
            // Vertical Lines
            ForEach([1, 2, 3, 4, 5, 6], (i: number) => {
              Divider()
                .vertical(true)
                .color('#FFECB3')
                .height('100%')
                .position({ x: `${Math.round((i / 7) * 100)}%`, y: 0 })
            })

            // Markers
            // Sunrise Tech (x: 0.2, y: 0.3) -> Level A (#FF7043)
            this.MapMarkerComponent('Sunrise Tech', 'A', 1, 20, 30)
            
            // Delta Logistics (x: 0.5, y: 0.45) -> Level B (#FFB74D)
            this.MapMarkerComponent('Delta Logistics', 'B', 2, 50, 45)
            
            // Oceanic Foods (x: 0.72, y: 0.6) -> Level A (#FF7043)
            this.MapMarkerComponent('Oceanic Foods', 'A', 3, 72, 60)
            
            // Horizon Ltd. (x: 0.33, y: 0.75) -> Level C (#FFD54F)
            this.MapMarkerComponent('Horizon Ltd.', 'C', 4, 33, 75)
          }
          .width('100%')
          .aspectRatio(0.9)
          .height(360)
          .borderRadius(16)
          .margin({ left: 16, right: 16 })

          // Client List
          Column({ space: 12 }) {
            this.ClientCard('Sunrise Tech', 'Shanghai', 'A')
            this.ClientCard('Delta Logistics', 'Beijing', 'B')
            this.ClientCard('Oceanic Foods', 'Guangzhou', 'A')
            this.ClientCard('Horizon Ltd.', 'Chengdu', 'C')
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 32 })
        }
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#FFF8E1')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8E1')
  }

  @Builder
  MapMarkerComponent(label: string, level: string, id: number, xPercent: number, yPercent: number) {
    Stack() {
      // Dot
      Circle()
        .width(this.selectedId === id ? 28 : 22)
        .height(this.selectedId === id ? 28 : 22)
        .fill(level === 'A' ? '#FF7043' : (level === 'B' ? '#FFB74D' : '#FFD54F'))
        .strokeWidth(2)
        .strokeColor(this.selectedId === id ? '#FFFFFF' : '#FFFFFF')
      
      // Label Card
      Row() {
        Text(label)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#3E2723')
      }
      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      .backgroundColor('#FFECB3')
      .borderRadius(8)
      .border({ width: 1, color: '#E0C097' })
      .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
      .onClick(() => {
        this.selectedId = (this.selectedId === id) ? -1 : id
      })
      .alignRules({
        top: { anchor: '__container__', align: VerticalAlign.Top },
        start: { anchor: '__container__', align: HorizontalAlign.Start }
      })
      .offset({ x: 20, y: -4 })
    }
    .alignRules({
      top: { anchor: '__container__', align: VerticalAlign.Top },
      start: { anchor: '__container__', align: HorizontalAlign.Start }
    })
    .position({ x: `${xPercent}%`, y: `${yPercent}%` })
  }

  @Builder
  ClientCard(name: string, region: string, level: string) {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .border({ width: 1, color: '#E0C097' })
        .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })

      // Content
      Row() {
        Column({ space: 4 }) {
          Text(name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#3E2723')
          
          Text(region)
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor('#3E2723')
        }
        
        Blank()

        Text(`Level ${level}`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF7043')
      }
      .width('100%')
      .padding(16)
    }
    .width('100%')
  }
}