@Entry
@Component
struct RootScreen {
  @State selectedPage: number = 1
  @State selectedTool: string = 'pen'

  build() {
    // === Column ===
    // props: { space: 0 }
    // modifier: { width: '100%', height: '100%', backgroundColor: '#F8F7FF' }
    // children: 2
    Column() {
      // === Row ===
      // props: { space: 8 }
      // modifier: { width: '100%', height: 56, padding: 12, backgroundColor: '#FFF' }
      // children: 3
      Row() {
        // === Button ===
        // modifier: { width: 24, height: 24, backgroundColor: '#F0F0F5', borderRadius: 12 }
        // children: 0
        Button() {}

        // === Blank ===
        Blank()

        // === Text ===
        // props: { text: 'Document.pdf' }
        // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: '#1B1B1F' }
        Text('Document.pdf')

        // === Blank ===
        Blank()

        // === Button ===
        // modifier: { padding: { left: 8, right: 8, top: 4, bottom: 4 }, backgroundColor: '#A0C4FF', borderRadius: 4 }
        // children: 1
        Button() {
          // === Text ===
          // props: { text: 'Share' }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#001D3D' }
          Text('Share')
        }
      }

      // === Row ===
      // props: { space: 12 }
      // modifier: { width: '100%', layoutWeight: 1, padding: { left: 12, right: 12 } }
      // children: 2
      Row() {
        // === Grid ===
        // props: { columnsTemplate: '1fr 1fr', rowsGap: 8, columnsGap: 8 }
        // modifier: { width: 150, padding: 8 }
        // children: 12
        Grid() {
          ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], (page: number) => {
            GridItem() {
              // === Button ===
              // modifier: { aspectRatio: 0.7, backgroundColor: this.selectedPage === page ? '#A0C4FF' : '#F0F0F5', borderRadius: 8, borderColor: this.selectedPage === page ? '#A0C4FF' : 'transparent', borderWidth: this.selectedPage === page ? 2 : 0 }
              // children: 1
              Button() {
                // === Text ===
                // props: { text: String(page) }
                // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: this.selectedPage === page ? '#001D3D' : '#1B1B1F' }
                Text(String(page))
              }.onClick(() => {
                this.selectedPage = page
              })
            }
          })
        }

        // === Stack ===
        // props: { alignContent: Alignment.Center }
        // modifier: { width: '100%', layoutWeight: 1 }
        // children: 2
        Stack() {
          // === Column ===
          // modifier: { width: '100%', height: '100%', backgroundColor: '#FFF', borderRadius: 12, shadow: { radius: 2, color: '#14000000', offsetY: 1 } }
          // children: 1
          Column() {
            // === Text ===
            // props: { text: `Page ${this.selectedPage}` }
            // modifier: { fontSize: 24, fontWeight: FontWeight.Semibold, fontColor: '#1B1B1F' }
            Text(`Page ${this.selectedPage}`)
          }

          // === Column ===
          // props: { space: 8 }
          // modifier: { padding: 8, backgroundColor: '#FFFFFFCC', borderRadius: 12, borderColor: '#D9D9E3', borderWidth: 1, margin: 12, alignSelf: ItemAlign.Start }
          // children: 4
          Column({ space: 8 }) {
            // === AnnotationToolButton ===
            // props: { icon: 'P', toolName: 'pen', selectedTool: this.selectedTool }
            this.AnnotationToolButton('P', 'pen', this.selectedTool)
            // === AnnotationToolButton ===
            // props: { icon: 'H', toolName: 'highlighter', selectedTool: this.selectedTool }
            this.AnnotationToolButton('H', 'highlighter', this.selectedTool)
            // === AnnotationToolButton ===
            // props: { icon: 'T', toolName: 'text', selectedTool: this.selectedTool }
            this.AnnotationToolButton('T', 'text', this.selectedTool)
            // === AnnotationToolButton ===
            // props: { icon: 'S', toolName: 'shape', selectedTool: this.selectedTool }
            this.AnnotationToolButton('S', 'shape', this.selectedTool)
          }
        }
      }
    }
  }

  @Builder
  AnnotationToolButton(icon: string, toolName: string, selectedTool: string) {
    // === Button ===
    // modifier: { width: 40, height: 40, backgroundColor: toolName === selectedTool ? '#B7E4C7' : '#F0F0F5', borderRadius: 20 }
    // children: 1
    Button() {
      // === Text ===
      // props: { text: icon }
      // modifier: { fontSize: 17, fontWeight: FontWeight.Bold, fontColor: toolName === selectedTool ? '#003720' : '#1B1B1F' }
      Text(icon)
    }.onClick(() => {
      this.selectedTool = toolName
    })
  }
}