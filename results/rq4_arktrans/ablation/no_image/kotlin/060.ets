@Entry
@Component
struct Index {
  @State active: string = 'Length'
  @State selected: number = 0
  @State unit: string = 'Meter'
  @State value: string = '1.0'
  @State it: string = ''

  // Mock data to replace 'markers' and 'any' types
  private markers: string[] = ['Length', 'Weight', 'Temperature']

  build() {
    Stack() {
      Column({ space: 14 }) {
        Text('Unit Converter')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')

        // MapArea equivalent
        Column({ space: 0 }) {
          Text('Unit Map Visualization')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')

          Blank().height(16)

          Text(`Active Unit: ${this.active}`)
            .fontSize(16)
            .fontColor('#1E293B')
        }
        .alignItems(HorizontalAlign.Center)
        .width('100%')
        .height(240)
        .backgroundColor('#E2E8F0')
        .borderRadius(16)
        .border({ width: 1, color: '#CBD5E1', radius: 16 })
        .padding(14)

        // ForEach equivalent for MarkerBox
        ForEach(this.markers, (item: string) => {
          let isActive = this.active === item
          
          Stack({ alignContent: Alignment.Start }) {
            Column({ space: 0 }) {
              Text(item)
                .fontSize(24)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1E293B')
              
              Text(isActive ? this.value : 'Tap to convert')
                .fontSize(16)
                .fontColor('#1E293B')
            }
          }
          .width('100%')
          .height(80)
          .backgroundColor(isActive ? '#DBEAFE' : '#FFFFFF')
          .borderRadius(12)
          .border({ width: 1, color: '#CBD5E1', radius: 12 })
          .padding(10)
          .onClick(() => {
            this.active = item
          })
        }, (item: string) => item)

        Blank().height(16)

        Row({ space: 10 }) {
          ForEach(this.markers, (item: string) => {
            let isActive = this.active === item
            
            Button(item) {
              Text(item)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
            }
            .backgroundColor(isActive ? '#3B82F6' : '#E2E8F0')
            .fontColor(isActive ? '#FFFFFF' : '#1E293B')
            .borderRadius(8)
            .onClick(() => {
              this.active = item
            })
          }, (item: string) => item)
        }
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#60A5FA', 0], ['#3B82F6', 1]]
      })
      .opacity(0.15)
      .padding(14)
      
      // Overlay for gradient effect since ArkTS doesn't support complex brush gradients directly on background easily without custom components
      // Using a simple background color as fallback for the complex gradient requirement if linearGradient isn't sufficient for the specific "Brush" look
      // However, to strictly follow "compilable", we use standard modifiers.
      
    }.width('100%').height('100%')
  }
}