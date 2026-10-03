@Entry
@Component
struct RetroWhiteboard {
  @State points: Point[] = []
  @State color: string = '#EF476F'

  build() {
    Column() {
      Stack({ alignContent: Alignment.BottomEnd }) {
        // === Column (Main Content) ===
        // props: { space: 0 }
        // modifier: { width: '100%', height: '100%' }
        // children: 2
        Column() {
          // === Text (Title) ===
          // props: { text: 'Retro Whiteboard' }
          // modifier: { fontSize: 26, fontWeight: FontWeight.Bold, fontColor: '#1E1E1E', margin: { top: 50, bottom: 16 }, textAlign: TextAlign.Center }
          Text('Retro Whiteboard')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E1E1E')
            .margin({ top: 50, bottom: 16 })
            .textAlign(TextAlign.Center)

          // === Canvas (Drawing Area) ===
          // props: { points: this.points, color: this.color }
          // modifier: { width: '100%', layoutWeight: 1, backgroundColor: '#FFFCF2' }
          // gesture: { onMove: (event: GestureEvent) => this.addPoint(event) }
          DrawingCanvasComponent({ points: this.points, color: this.color })
            .width('100%')
            .layoutWeight(1)
            .backgroundColor('#FFFCF2')
            .onTouch((event: TouchEvent) => {
              if (event.type === TouchType.Move || event.type === TouchType.Down) {
                const point = new Point(event.touches[0].x, event.touches[0].y)
                this.points.push(point)
              }
            })
        }

        // === Button (Clear FAB) ===
        // modifier: { width: 80, height: 80, backgroundColor: '#FFD166', borderRadius: 40, shadow: { radius: 8, color: '#3F000000' }, margin: 24 }
        // children: 1
        // action: { onClick: () => this.clearPoints() }
        Button() {
          // === Text ===
          // props: { text: 'Clear' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: '#1E1E1E' }
          Text('Clear')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')
        }
        .width(80)
        .height(80)
        .backgroundColor('#FFD166')
        .borderRadius(40)
        .shadow({ radius: 8, color: '#3F000000' })
        .margin(24)
        .onClick(() => {
          this.points = []
        })
      }
      .width('100%')
      .layoutWeight(1)

      // === Row (Bottom Bar) ===
      // props: { space: 24 }
      // modifier: { width: '100%', height: 80, padding: 16, backgroundColor: '#FFF0F5', justifyContent: FlexAlign.SpaceEvenly, alignItems: ItemAlign.Center }
      // children: 3
      Row({ space: 24 }) {
        // === Button (Red) ===
        // modifier: { width: 100, height: 48, backgroundColor: '#EF476F', borderRadius: 8 }
        // children: 1
        // action: { onClick: () => this.setColor('#EF476F') }
        Button() {
          // === Text ===
          // props: { text: 'Red' }
          // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#FFF' }
          Text('Red')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFF')
        }
        .width(100)
        .height(48)
        .backgroundColor('#EF476F')
        .borderRadius(8)
        .onClick(() => {
          this.color = '#EF476F'
        })

        // === Button (Yellow) ===
        // modifier: { width: 100, height: 48, backgroundColor: '#FFD166', borderRadius: 8 }
        // children: 1
        // action: { onClick: () => this.setColor('#FFD166') }
        Button() {
          // === Text ===
          // props: { text: 'Yellow' }
          // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#1E1E1E' }
          Text('Yellow')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')
        }
        .width(100)
        .height(48)
        .backgroundColor('#FFD166')
        .borderRadius(8)
        .onClick(() => {
          this.color = '#FFD166'
        })

        // === Button (Green) ===
        // modifier: { width: 100, height: 48, backgroundColor: '#06D6A0', borderRadius: 8 }
        // children: 1
        // action: { onClick: () => this.setColor('#06D6A0') }
        Button() {
          // === Text ===
          // props: { text: 'Green' }
          // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#1E1E1E' }
          Text('Green')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')
        }
        .width(100)
        .height(48)
        .backgroundColor('#06D6A0')
        .borderRadius(8)
        .onClick(() => {
          this.color = '#06D6A0'
        })
      }
      .width('100%')
      .height(80)
      .padding(16)
      .backgroundColor('#FFF0F5')
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }

  addPoint(event: TouchEvent): void {
    const point = new Point(event.touches[0].x, event.touches[0].y)
    this.points.push(point)
  }

  clearPoints(): void {
    this.points = []
  }

  setColor(newColor: string): void {
    this.color = newColor
  }
}

// === Custom Component for Drawing ===
@Component
struct DrawingCanvasComponent {
  @Prop points: Point[] = []
  @Prop color: string = ''

  aboutToAppear() {
    // Initialize with passed values if needed, but here we rely on state binding from parent
  }

  build() {
    // Using a simple Container to draw circles based on points
    // Note: ArkTS doesn't have a direct Canvas equivalent in the same way as Compose.
    // We simulate it by rendering Circles in a Stack.
    Stack() {
      ForEach(this.points, (point: Point) => {
        Circle()
          .width(20)
          .height(20)
          .fill(this.color)
          .position({ x: point.x - 10, y: point.y - 10 })
      })
    }
    .width('100%')
    .height('100%')
  }
}

// === Data Model ===
class Point {
  x: number
  y: number

  constructor(x: number, y: number) {
    this.x = x
    this.y = y
  }
}