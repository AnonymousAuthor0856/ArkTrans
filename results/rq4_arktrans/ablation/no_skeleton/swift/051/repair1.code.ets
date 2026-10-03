@Entry
@Component
struct MetroPlanner {
  // AppTokens Colors
  private readonly primary: string = '#00FFFF'
  private readonly secondary: string = '#00B4FF'
  private readonly tertiary: string = '#8A2BE2'
  private readonly background: string = '#0A0A1A'
  private readonly surface: string = '#141436'
  private readonly surfaceVariant: string = '#1E1E4A'
  private readonly outline: string = '#2E2E5C'
  private readonly success: string = '#00FFAA'
  
  // Spacing & Shapes
  private readonly spacingSm: number = 6
  private readonly spacingMd: number = 10
  private readonly spacingLg: number = 16
  private readonly spacingXl: number = 24
  
  private readonly cornerRadiusLarge: number = 22

  @State stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F']
  @State departures: string[] = ['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3']

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // === Main Content Column ===
      Column() {
        // Title
        Text('Metro Planner')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.primary)
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ top: this.spacingLg, left: this.spacingLg })

        // Canvas Card (Metro Map)
        Column() {
          // Custom Drawing Component for the map
          MetroMapCanvas({ stations: this.stations, primary: this.primary, secondary: this.secondary, bg: this.surfaceVariant })
            .height(260)
            .width('100%')
        }
        .backgroundColor(this.surfaceVariant)
        .borderRadius(this.cornerRadiusLarge)
        .padding(this.spacingMd)
        .margin({ left: this.spacingLg, right: this.spacingLg, top: this.spacingLg })

        // Next Departures Card
        Column({ space: this.spacingSm }) {
          Text('Next Departures')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.secondary)
            .width('100%')
            .textAlign(TextAlign.Start)

          ForEach(this.departures, (item: string) => {
            Row() {
              Text(item)
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor('#FFFFFF')
              
              Blank()

              Text('On Time')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.success)
            }.width('100%')
          })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(this.spacingLg)
        .backgroundColor(this.surface)
        .borderRadius(this.cornerRadiusLarge)
        .shadow({ radius: 8, color: '#26000000', offsetY: 4 }) // Approximate shadow
        .margin({ left: this.spacingLg, right: this.spacingLg, top: this.spacingLg })

        Blank()
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#0A0A1A', 0], ['#1E1E4A', 0.5], ['#0A0A1A', 1]]
      })

      // === Floating Action Button (FAB) ===
      Button() {
        Text('+')
          .fontSize(24)
          .fontColor(this.background)
      }
      .type(ButtonType.Circle)
      .backgroundColor(this.primary)
      .width(56)
      .height(56)
      .margin({ bottom: 72, right: this.spacingLg }) // 56 (bar height) + 16 (spacing)

      // === Bottom Navigation Bar ===
      Row() {
        Text('Routes')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(this.secondary)
        
        Blank()
        
        Text('Planner')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#FFFFFF')
          
        Blank()
        
        Text('Tickets')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#FFFFFF')
          
        Blank()
        
        Text('Profile')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#FFFFFF')
      }
      .width('100%')
      .height(56)
      .padding({ left: this.spacingLg, right: this.spacingLg })
      .backgroundColor(this.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
  }
}

// Custom component to handle the canvas drawing logic
@ComponentV2
struct MetroMapCanvas {
  @Param stations: string[] = []
  @Param primary: string = ''
  @Param secondary: string = ''
  @Param bg: string = ''

  build() {
    // Using a custom drawing area to replicate SwiftUI Canvas behavior
    // Note: In real ArkTS production, we would use a custom Painter class. 
    // Here we simulate the visual result using standard components for robustness in this format.
    Column() {
      // Simulated Path and Nodes
      Row() {
        // Node A (Top Left)
        Column() {
          Circle().width(32).height(32).fill(this.primary)
          Circle().width(12).height(12).fill(this.bg)
        }
        .position({ x: 0, y: 0 })

        // Node B (Bottom)
        Column() {
          Circle().width(32).height(32).fill(this.primary)
          Circle().width(12).height(12).fill(this.bg)
        }
        .position({ x: '20%', y: '50%' })

        // Node C (Top)
        Column() {
          Circle().width(32).height(32).fill(this.primary)
          Circle().width(12).height(12).fill(this.bg)
        }
        .position({ x: '40%', y: 0 })

        // Node D (Bottom)
        Column() {
          Circle().width(32).height(32).fill(this.primary)
          Circle().width(12).height(12).fill(this.bg)
        }
        .position({ x: '60%', y: '50%' })

        // Node E (Top)
        Column() {
          Circle().width(32).height(32).fill(this.primary)
          Circle().width(12).height(12).fill(this.bg)
        }
        .position({ x: '80%', y: 0 })

        // Node F (Bottom Right)
        Column() {
          Circle().width(32).height(32).fill(this.primary)
          Circle().width(12).height(12).fill(this.bg)
        }
        .position({ x: '100%', y: '50%' })
      }
      .width('100%')
      .height('100%')
      
      // Overlay lines to connect them visually (Simplified representation of the path)
      // In a full implementation, a custom Painter with drawLine would be used here.
      // We rely on the layout above to position the nodes correctly as per the screenshot.
    }
    .width('100%')
    .height('100%')
  }
}