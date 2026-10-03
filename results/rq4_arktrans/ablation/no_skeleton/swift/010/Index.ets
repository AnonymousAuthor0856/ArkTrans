@Entry
@Component
struct RootScreen {
  @State textOpacity: number = 1.0
  @State uploadProgress: number = 0.65
  @State layers: StoryLayer[] = [
    { id: 1, type: 'BG', content: 'Gradient' },
    { id: 2, type: 'IMG', content: 'User Photo' },
    { id: 3, type: 'TXT', content: 'Hello World' },
    { id: 4, type: 'ICO', content: 'Sticker' }
  ]
  @State selectedLayer: number = 3

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Bottom }
    // modifier: { width: '100%', height: '100%', backgroundColor: '#ECEFF1' }
    // children: 2
    Stack({ alignContent: Alignment.Bottom }) {
      // === Column ===
      // props: { space: 0 }
      // modifier: { width: '100%' }
      // children: 2
      Column() {
        // === Row ===
        // props: { space: 0 }
        // modifier: { width: '100%', height: 64, backgroundColor: '#FFF' }
        // children: 3
        Row() {
          // === Button ===
          // modifier: { padding: { left: 8, right: 8 } }
          // children: 1
          Button() {
            // === Text ===
            // props: { text: 'Exit' }
            // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, fontColor: '#263238' }
            Text('Exit').fontSize(14).fontWeight(FontWeight.Normal).fontColor('#263238')
          }.padding({ left: 8, right: 8 })

          // === Blank ===
          Blank()

          // === Text ===
          // props: { text: 'Story Editor' }
          // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: '#263238' }
          Text('Story Editor').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#263238')

          // === Blank ===
          Blank()

          // === Button ===
          // modifier: { padding: { left: 8, right: 8 } }
          // children: 1
          Button() {
            // === Text ===
            // props: { text: 'Post' }
            // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, fontColor: '#FFF', padding: { left: 12, right: 12, top: 8, bottom: 8 } }
            Text('Post').fontSize(14).fontWeight(FontWeight.Normal).fontColor('#FFF').padding({ left: 12, right: 12, top: 8, bottom: 8 })
          }.backgroundColor('#1976D2').borderRadius(8).padding({ left: 8, right: 8 })
        }

        // === Scroll ===
        // modifier: { width: '100%', layoutWeight: 1, backgroundColor: '#ECEFF1' }
        // children: 1
        Scroll() {
          // === Column ===
          // props: { space: 16 }
          // modifier: { width: '100%', padding: { top: 16, bottom: 16 } }
          // children: 3
          Column({ space: 16 }) {
            // === Stack ===
            // props: { alignContent: Alignment.Center }
            // modifier: { width: '100%', height: 200, padding: { left: 16, right: 16 }, borderRadius: 12, shadow: { radius: 3, color: '#1A000000', offsetY: 1 } }
            // children: 2
            Stack({ alignContent: Alignment.Center }) {
              // === Rectangle ===
              // modifier: { width: '100%', height: '100%', backgroundColor: '#757575' }
              Rect().width('100%').height('100%').fill('#757575')

              // === Text ===
              // props: { text: 'Your Story Preview' }
              // modifier: { fontSize: 24, fontWeight: FontWeight.Semibold, fontColor: '#FFF', textAlign: TextAlign.Center }
              Text('Your Story Preview').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#FFF').textAlign(TextAlign.Center)
            }.borderRadius(12).shadow({ radius: 3, color: '#1A000000', offsetY: 1 }).padding({ left: 16, right: 16 })

            // === Column ===
            // props: { space: 8 }
            // modifier: { width: '100%', padding: { left: 16, right: 16 } }
            // children: 2
            Column({ space: 8 }) {
              // === Text ===
              // props: { text: 'Upload Status' }
              // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#607D8B' }
              Text('Upload Status').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#607D8B')

              // === Stack ===
              // props: { alignContent: Alignment.Start }
              // modifier: { width: '100%', height: 8 }
              // children: 2
              Stack({ alignContent: Alignment.Start }) {
                // === Rectangle ===
                // modifier: { width: '100%', height: '100%', backgroundColor: '#CFD8DC', borderRadius: 4 }
                Rect().width('100%').height('100%').fill('#CFD8DC').borderRadius(4)

                // === Rectangle ===
                // modifier: { width: `${this.uploadProgress * 100}%`, height: '100%', backgroundColor: '#4CAF50', borderRadius: 4 }
                Rect().width(`${this.uploadProgress * 100}%`).height('100%').fill('#4CAF50').borderRadius(4)
              }.height(8)
            }.padding({ left: 16, right: 16 })

            // === Column ===
            // props: { space: 8 }
            // modifier: { width: '100%' }
            // children: 2
            Column({ space: 8 }) {
              // === Text ===
              // props: { text: 'Story Layers' }
              // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#607D8B', padding: { left: 16, right: 16 } }
              Text('Story Layers').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#607D8B').padding({ left: 16, right: 16 })

              // === Scroll ===
              // props: { scrollable: ScrollDirection.Horizontal, showScrollbar: false }
              // modifier: { width: '100%' }
              // children: 1
              Scroll(new Scroller()) {
                // === Row ===
                // props: { space: 16 }
                // modifier: { width: '100%', padding: { left: 16, right: 16, top: 12, bottom: 12 } }
                // children: 4
                Row({ space: 16 }) {
                  ForEach(this.layers, (layer: StoryLayer) => {
                    // === LayerItemView ===
                    // props: { layer: layer, isSelected: layer.id == this.selectedLayer, onSelect: () => { this.selectedLayer = layer.id } }
                    LayerItemView({ layer: layer, isSelected: layer.id == this.selectedLayer, onSelect: () => { this.selectedLayer = layer.id } })
                  })
                }.padding({ left: 16, right: 16, top: 12, bottom: 12 })
              }.scrollable(ScrollDirection.Horizontal).scrollBar(BarState.Off)
            }
          }.padding({ top: 16, bottom: 16 })
        }
      }

      // === Column ===
      // props: { space: 12 }
      // modifier: { width: '100%', padding: 16, backgroundColor: '#FFF', shadow: { radius: 6, color: '#1A000000', offsetY: -2 } }
      // children: 2
      Column({ space: 12 }) {
        // === Text ===
        // props: { text: 'Layer Properties' }
        // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#607D8B' }
        Text('Layer Properties').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#607D8B')

        // === Row ===
        // props: { space: 0 }
        // modifier: { width: '100%' }
        // children: 2
        Row() {
          // === Text ===
          // props: { text: 'Opacity' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, width: 80, textAlign: TextAlign.Start }
          Text('Opacity').fontSize(14).fontWeight(FontWeight.Normal).width(80).textAlign(TextAlign.Start)

          // === Slider ===
          // props: { value: this.textOpacity, min: 0, max: 1 }
          // modifier: { width: '100%' }
          Slider({ value: this.textOpacity, min: 0, max: 1 }).width('100%')
        }
      }.padding(16).backgroundColor('#FFF').shadow({ radius: 6, color: '#1A000000', offsetY: -2 })
    }.width('100%').height('100%').backgroundColor('#ECEFF1')
  }
}

interface StoryLayer {
  id: number;
  type: string;
  content: string;
}

@Component
struct LayerItemView {
  private layer: StoryLayer = { id: 0, type: '', content: '' }
  private isSelected: boolean = false
  private onSelect: () => void = () => {}

  build() {
    // === Button ===
    // modifier: { width: 130, padding: { left: 32, right: 32, top: 12, bottom: 12 }, backgroundColor: this.isSelected ? '#1976D2' : '#FFF', borderRadius: 8, borderColor: this.isSelected ? '#1976D2' : '#B0BEC5', borderWidth: 1 }
    // children: 1
    Button() {
      // === Column ===
      // props: { space: 8 }
      // modifier: { width: '100%' }
      // children: 3
      Column({ space: 8 }) {
        // === Circle ===
        // modifier: { width: 32, height: 32, fill: this.isSelected ? '#33FFFFFF' : '#CFD8DC' }
        Circle().width(32).height(32).fill(this.isSelected ? '#33FFFFFF' : '#CFD8DC')

        // === Text ===
        // props: { text: this.layer.type }
        // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: this.isSelected ? '#FFF' : '#3F263238' }
        Text(this.layer.type).fontSize(12).fontWeight(FontWeight.Medium).fontColor(this.isSelected ? '#FFF' : '#3F263238')

        // === Text ===
        // props: { text: this.layer.content }
        // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, fontColor: this.isSelected ? '#FFF' : '#263238', textAlign: TextAlign.Center, maxLines: 2 }
        Text(this.layer.content).fontSize(14).fontWeight(FontWeight.Normal).fontColor(this.isSelected ? '#FFF' : '#263238').textAlign(TextAlign.Center).maxLines(2)
      }
    }.width(130).padding({ left: 32, right: 32, top: 12, bottom: 12 }).backgroundColor(this.isSelected ? '#1976D2' : '#FFF').borderRadius(8).border({ width: 1, color: this.isSelected ? '#1976D2' : '#B0BEC5' })
  }
}