@Entry
@Component
struct Index {
  @State MetroPlanner: string = '0'
  @State y: string = '0'
  @State NextDepartures: string = '0'
  @State it: string = '0'
  @State OnTime: string = '0'
  @State plus: string = '0'
  @State Routes: string = '0'
  @State Planner: string = '0'
  @State Tickets: string = '0'
  @State Profile: string = '0'

  private ctx: CanvasRenderingContext2D | null = null;

  build() {
    Stack() {
      // === Scaffold ===
      Stack({ alignContent: Alignment.Top }) {
        // === Column ===
        Column({ space: 16 }) {
          // === Text ===
          Text('Metro Planner')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#00FFFF')

          // === Canvas ===
          // Note: ArkTS Canvas requires a drawing function. Since the skeleton implies a visual block,
          // we provide a minimal implementation or use a placeholder if drawing logic is unknown.
          // Given the constraints, we will use a simple colored rectangle to represent the canvas area
          // as true Canvas drawing code was not provided in the skeleton's children details.
          // However, to strictly follow "Implement every child", we use a ContainerShape or similar
          // if Canvas is too complex without draw instructions. 
          // Standard ArkTS Canvas:
          Canvas(this.ctx).width('100%').height(260).backgroundColor('#1E1E3F').borderRadius(16).padding(12)

          // === Card ===
          Column() {
            // === Column ===
            Column({ space: 6 }) {
              // === Text ===
              Text('Next Departures')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#00B4FF')

              // === ForEach ===
              // In ArkTS, we typically use List/ForEach for dynamic content, but inside a Column,
              // we can iterate and build components directly if the list is small/static.
              // Using LazyForEach or standard ForEach with array is preferred. 
              // Here we simulate the loop by explicitly listing items or using a proper ForEach if supported in this context.
              // Since direct forEach in build function is not allowed for UI generation in strict ArkTS, 
              // we replace the forEach with explicit Rows or use a List if dynamic. 
              // Given the static nature, we unroll the loop.
              
              Row({ space: 0 }) {
                Text('08:45 • Line 1')
                  .fontSize(14)
                  .fontColor('#FFFFFF')
                
                Blank()

                Text('On Time')
                  .fontSize(12)
                  .fontColor('#00FFAA')
              }.width('100%')

              Row({ space: 0 }) {
                Text('09:10 • Line 2')
                  .fontSize(14)
                  .fontColor('#FFFFFF')
                
                Blank()

                Text('On Time')
                  .fontSize(12)
                  .fontColor('#00FFAA')
              }.width('100%')

              Row({ space: 0 }) {
                Text('09:30 • Line 3')
                  .fontSize(14)
                  .fontColor('#FFFFFF')
                
                Blank()

                Text('On Time')
                  .fontSize(12)
                  .fontColor('#00FFAA')
              }.width('100%')
            }
            .width('100%')
            .padding(16)
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000' })
          .width('100%')

          // === Spacer ===
          Blank().height(10)
        }
        .width('100%')
        .height('100%')
        .padding(16)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#0A0A1A', 0], ['#1E1E3F', 0.5], ['#0A0A1A', 1]]
        })

        // === FloatingActionButton ===
        Button() {
          Text('+')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0A0A1A')
        }
        .type(ButtonType.Circle)
        .backgroundColor('#00FFFF')
        .width(56)
        .height(56)
        .position({ x: 'auto', y: 'auto' }) // Default FAB positioning usually handled by parent or explicit pos
        .margin({ right: 24, bottom: 80 }) // Approximate FAB position relative to bottom bar

        // === BottomAppBar ===
        Row({ space: 0 }) {
          // === Text ===
          Text('Routes')
            .fontSize(14)
            .fontColor('#00B4FF')
          
          // === Text ===
          Text('Planner')
            .fontSize(14)
            .fontColor('#FFFFFF')
          
          // === Text ===
          Text('Tickets')
            .fontSize(14)
            .fontColor('#FFFFFF')
          
          // === Text ===
          Text('Profile')
            .fontSize(14)
            .fontColor('#FFFFFF')
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .backgroundColor('#141436')
        .position({ x: 0, y: 'auto' })
        .margin({ bottom: 0 })
      }
    }
    .width('100%')
    .height('100%')
  }
}