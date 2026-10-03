// entry/src/main/ets/viewmodel/AppTokens.ets
export class AppTokens {
  static readonly Colors = {
    primary: '#EF476F',
    secondary: '#FFD166',
    tertiary: '#06D6A0',
    background: '#FFFCF2',
    surface: '#FFFFFF',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E'
  }

  static readonly Spacing = {
    md: 12,
    xl: 24
  }

  static readonly Shapes = {
    smallCornerRadius: 6,
    fabSize: 56
  }
}

// entry/src/main/ets/pages/Index.ets
@Entry
@Component
struct RetroWhiteboard {
  @State points: Point[] = []
  @State currentColor: string = AppTokens.Colors.primary

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Canvas Area
      Canvas(this.renderContext)
        .width('100%')
        .layoutWeight(1)
        .padding({ top: 80, bottom: 100 })
        .gesture(
          PanGesture()
            .onActionUpdate((event?: GestureEvent) => {
              if (event) {
                this.points.push(new Point(event.localX, event.localY))
              }
            })
        )

      // Top Bar
      Text("Retro Whiteboard")
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .margin({ top: 30, left: 20 })

      // Bottom Controls Container
      Column() {
        Row() {
          Button("Red")
            .type(ButtonType.Normal)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .cornerRadius(AppTokens.Shapes.smallCornerRadius)
            .height(44)
            .onClick(() => this.currentColor = AppTokens.Colors.primary)
          
          Button("Yellow")
            .type(ButtonType.Normal)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .cornerRadius(AppTokens.Shapes.smallCornerRadius)
            .height(44)
            .onClick(() => this.currentColor = AppTokens.Colors.secondary)
            
          Button("Green")
            .type(ButtonType.Normal)
            .backgroundColor(AppTokens.Colors.tertiary)
            .fontColor(AppTokens.Colors.onSecondary)
            .cornerRadius(AppTokens.Shapes.smallCornerRadius)
            .height(44)
            .onClick(() => this.currentColor = AppTokens.Colors.tertiary)
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')
        .padding({ top: 12, bottom: 12 })
        .backgroundColor(AppTokens.Colors.surface)
        
        // Floating Action Button
        Button("Clear")
          .type(ButtonType.Circle)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .width(AppTokens.Shapes.fabSize)
          .height(AppTokens.Shapes.fabSize)
          .position({ x: '90%', y: -30 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.12)', offsetY: 4 })
          .onClick(() => this.points = [])
      }
      .alignSelf(ItemAlign.End)
    }
  }

  renderContext(context: CanvasRenderingContext2D, size: Size) {
    context.fillStyle = this.currentColor
    for (let i = 0; i < this.points.length; i++) {
      const p = this.points[i]
      context.beginPath()
      context.arc(p.x, p.y, 10, 0, Math.PI * 2)
      context.fill()
    }
  }
}

class Point {
  x: number
  y: number
  constructor(x: number, y: number) {
    this.x = x
    this.y = y
  }
}