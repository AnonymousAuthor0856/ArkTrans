@Entry
@Component
struct RootScreen {
  @State textOpacity: number = 1.0
  @State uploadProgress: number = 0.65
  @State selectedLayerId: number = 3

  private layers: StoryLayer[] = [
    { id: 1, type: 'BG', content: 'Gradient' },
    { id: 2, type: 'IMG', content: 'User Photo' },
    { id: 3, type: 'TXT', content: 'Hello World' },
    { id: 4, type: 'ICO', content: 'Sticker' }
  ]

  build() {
    Column() {
      // === Top Bar ===
      Row() {
        Text('Exit')
          .fontColor('#263238')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {})
        
        Blank()
        
        Text('Story Editor')
          .fontColor('#263238')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
        
        Blank()
        
        Button('Post')
          .backgroundColor('#1976D2')
          .borderRadius(8)
          .width(80)
          .height(40)
          .onClick(() => {})
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)

      // === Main Content Area ===
      Column() {
        // Preview Card
        Column() {
          Text('Your Story Preview')
            .fontColor(Color.White)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .opacity(this.textOpacity)
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#757575')
        .borderRadius(12)
        .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })

        // Upload Status
        Column() {
          Text('Upload Status')
            .fontColor('#607D8B')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
          
          Progress({ value: this.uploadProgress * 100, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color('#4CAF50')
            .backgroundColor('#CFD8DC')
        }
        .width('100%')
        .padding({ top: 16, bottom: 16 })
        .childrenGap(12)

        // Layers List (Horizontal Scroll)
        Scroll() {
          Row() {
            ForEach(this.layers, (layer: StoryLayer) => {
              Column() {
                Circle()
                  .width(32)
                  .height(32)
                  .fill(layer.id === this.selectedLayerId ? '#FFFFFF33' : '#CFD8DC')
                
                Text(layer.type)
                  .fontColor(layer.id === this.selectedLayerId ? '#FFFFFF' : '#26323899')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .margin({ top: 8 })
                
                Text(layer.content)
                  .fontColor(layer.id === this.selectedLayerId ? '#FFFFFF' : '#263238')
                  .fontSize(14)
                  .fontWeight(FontWeight.Normal)
              }
              .width(100)
              .height(120)
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
              .backgroundColor(layer.id === this.selectedLayerId ? '#1976D2' : '#FFFFFF')
              .borderRadius(8)
              .border({ width: 1, color: layer.id === this.selectedLayerId ? '#1976D2' : '#B0BEC5' })
              .onClick(() => {
                this.selectedLayerId = layer.id
              })
              .margin({ right: 12 })
            })
          }
        }
        .width('100%')
        .scrollable(ScrollDirection.Horizontal)
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
      .childrenGap(16)

      // === Bottom Bar ===
      Column() {
        Text('Layer Properties')
          .fontColor('#607D8B')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
        
        Row() {
          Text('Opacity')
            .fontColor('#263238')
            .fontSize(14)
            .width(80)
          
          Slider({ value: this.textOpacity * 100, min: 0, max: 100 })
            .width('100%')
            .onChange((value: number) => {
              this.textOpacity = value / 100
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 6, color: '#1A000000', offsetY: -2 })
      .childrenGap(12)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ECEFF1')
  }
}

interface StoryLayer {
  id: number;
  type: string;
  content: string;
}