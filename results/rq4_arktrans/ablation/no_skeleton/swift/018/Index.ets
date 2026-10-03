@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'vintage'

  build() {
    // === Column ===
    // props: { space: 0 }
    // modifier: { width: '100%', height: '100%', backgroundColor: '#F0EBE3' }
    // children: 3
    Column() {
      // === Column ===
      // props: { space: 12 }
      // modifier: { width: '100%', padding: { left: 16, right: 16, top: 12, bottom: 12 }, backgroundColor: '#F0EBE3', alignItems: ItemAlign.Start }
      // children: 2
      Column() {
        // === Text ===
        // props: { text: 'Filter Shop' }
        // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, fontColor: '#433E3A' }
        Text('Filter Shop')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#433E3A')

        // === Row ===
        // props: { space: 8 }
        // modifier: { width: '100%' }
        // children: 4
        Row() {
          // === Button (Vintage) ===
          // modifier: { backgroundColor: this.selectedFilter === 'vintage' ? '#D7BBA8' : '#FFFFFF', borderColor: this.selectedFilter === 'vintage' ? '#433E3A1A' : '#DCD7CF', borderWidth: 2, borderRadius: 24, padding: { left: 12, right: 12, top: 8, bottom: 8 } }
          // children: 1
          Button() {
            // === Text ===
            // props: { text: 'Vintage' }
            // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, letterSpacing: 0.5, fontColor: this.selectedFilter === 'vintage' ? '#433E3A' : '#433E3A' }
            Text('Vintage')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .letterSpacing(0.5)
              .fontColor(this.selectedFilter === 'vintage' ? '#433E3A' : '#433E3A')
          }
          .backgroundColor(this.selectedFilter === 'vintage' ? '#D7BBA8' : '#FFFFFF')
          .border({ color: this.selectedFilter === 'vintage' ? '#433E3A1A' : '#DCD7CF', width: 2 })
          .borderRadius(24)
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .onClick(() => {
            this.selectedFilter = 'vintage'
          })

          // === Button (Grain) ===
          // modifier: { backgroundColor: this.selectedFilter === 'grain' ? '#D7BBA8' : '#FFFFFF', borderColor: this.selectedFilter === 'grain' ? '#433E3A1A' : '#DCD7CF', borderWidth: 2, borderRadius: 24, padding: { left: 12, right: 12, top: 8, bottom: 8 } }
          // children: 1
          Button() {
            // === Text ===
            // props: { text: 'Grain' }
            // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, letterSpacing: 0.5, fontColor: this.selectedFilter === 'grain' ? '#433E3A' : '#433E3A' }
            Text('Grain')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .letterSpacing(0.5)
              .fontColor(this.selectedFilter === 'grain' ? '#433E3A' : '#433E3A')
          }
          .backgroundColor(this.selectedFilter === 'grain' ? '#D7BBA8' : '#FFFFFF')
          .border({ color: this.selectedFilter === 'grain' ? '#433E3A1A' : '#DCD7CF', width: 2 })
          .borderRadius(24)
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .onClick(() => {
            this.selectedFilter = 'grain'
          })

          // === Button (B&W) ===
          // modifier: { backgroundColor: this.selectedFilter === 'b&w' ? '#D7BBA8' : '#FFFFFF', borderColor: this.selectedFilter === 'b&w' ? '#433E3A1A' : '#DCD7CF', borderWidth: 2, borderRadius: 24, padding: { left: 12, right: 12, top: 8, bottom: 8 } }
          // children: 1
          Button() {
            // === Text ===
            // props: { text: 'B&W' }
            // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, letterSpacing: 0.5, fontColor: this.selectedFilter === 'b&w' ? '#433E3A' : '#433E3A' }
            Text('B&W')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .letterSpacing(0.5)
              .fontColor(this.selectedFilter === 'b&w' ? '#433E3A' : '#433E3A')
          }
          .backgroundColor(this.selectedFilter === 'b&w' ? '#D7BBA8' : '#FFFFFF')
          .border({ color: this.selectedFilter === 'b&w' ? '#433E3A1A' : '#DCD7CF', width: 2 })
          .borderRadius(24)
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .onClick(() => {
            this.selectedFilter = 'b&w'
          })

          // === Button (Neon) ===
          // modifier: { backgroundColor: this.selectedFilter === 'neon' ? '#D7BBA8' : '#FFFFFF', borderColor: this.selectedFilter === 'neon' ? '#433E3A1A' : '#DCD7CF', borderWidth: 2, borderRadius: 24, padding: { left: 12, right: 12, top: 8, bottom: 8 } }
          // children: 1
          Button() {
            // === Text ===
            // props: { text: 'Neon' }
            // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, letterSpacing: 0.5, fontColor: this.selectedFilter === 'neon' ? '#433E3A' : '#433E3A' }
            Text('Neon')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .letterSpacing(0.5)
              .fontColor(this.selectedFilter === 'neon' ? '#433E3A' : '#433E3A')
          }
          .backgroundColor(this.selectedFilter === 'neon' ? '#D7BBA8' : '#FFFFFF')
          .border({ color: this.selectedFilter === 'neon' ? '#433E3A1A' : '#DCD7CF', width: 2 })
          .borderRadius(24)
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .onClick(() => {
            this.selectedFilter = 'neon'
          })
        }
      }

      // === Scroll ===
      // props: { scrollable: ScrollDirection.Vertical }
      // modifier: { width: '100%', layoutWeight: 1, backgroundColor: '#F0EBE3' }
      // children: 1
      Scroll() {
        // === Grid ===
        // props: { columnsTemplate: '1fr 1fr', columnsGap: 12, rowsGap: 12 }
        // modifier: { width: '100%', padding: 16 }
        // children: 6
        Grid() {
          // === GridItem (Redscale) ===
          GridItem() {
            // === Column ===
            // props: { space: 0 }
            // modifier: { width: '100%', padding: 8, backgroundColor: '#FFF', borderRadius: 24, shadow: { radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 } }
            // children: 2
            Column() {
              // === Image ===
              // modifier: { width: '100%', aspectRatio: 1, borderRadius: 16, backgroundColor: '#D98B8B' }
              Image('').width('100%').aspectRatio(1).borderRadius(16).backgroundColor('#D98B8B')

              // === Column ===
              // props: { space: 8 }
              // modifier: { width: '100%', padding: 8, alignItems: ItemAlign.Start }
              // children: 3
              Column() {
                // === Text ===
                // props: { text: 'Redscale' }
                // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, fontColor: '#433E3A' }
                Text('Redscale').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#433E3A')

                // === Text ===
                // props: { text: 'by UserA' }
                // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, letterSpacing: 0.5, fontColor: '#6C6662' }
                Text('by UserA').fontSize(12).fontWeight(FontWeight.Medium).letterSpacing(0.5).fontColor('#6C6662')

                // === Text ===
                // props: { text: '$4.99' }
                // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, fontColor: '#D7BBA8' }
                Text('$4.99').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#D7BBA8')
              }
            }
          }

          // === GridItem (Sepia Tone) ===
          GridItem() {
            // === Column ===
            // props: { space: 0 }
            // modifier: { width: '100%', padding: 8, backgroundColor: '#FFF', borderRadius: 24, shadow: { radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 } }
            // children: 2
            Column() {
              // === Image ===
              // modifier: { width: '100%', aspectRatio: 1, borderRadius: 16, backgroundColor: '#D7BBA8' }
              Image('').width('100%').aspectRatio(1).borderRadius(16).backgroundColor('#D7BBA8')

              // === Column ===
              // props: { space: 8 }
              // modifier: { width: '100%', padding: 8, alignItems: ItemAlign.Start }
              // children: 3
              Column() {
                // === Text ===
                // props: { text: 'Sepia Tone' }
                // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, fontColor: '#433E3A' }
                Text('Sepia Tone').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#433E3A')

                // === Text ===
                // props: { text: 'by UserB' }
                // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, letterSpacing: 0.5, fontColor: '#6C6662' }
                Text('by UserB').fontSize(12).fontWeight(FontWeight.Medium).letterSpacing(0.5).fontColor('#6C6662')

                // === Text ===
                // props: { text: '$2.99' }
                // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, fontColor: '#D7BBA8' }
                Text('$2.99').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#D7BBA8')
              }
            }
          }

          // === GridItem (Aqua) ===
          GridItem() {
            // === Column ===
            // props: { space: 0 }
            // modifier: { width: '100%', padding: 8, backgroundColor: '#FFF', borderRadius: 24, shadow: { radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 } }
            // children: 2
            Column() {
              // === Image ===
              // modifier: { width: '100%', aspectRatio: 1, borderRadius: 16, backgroundColor: '#A2C4C9' }
              Image('').width('100%').aspectRatio(1).borderRadius(16).backgroundColor('#A2C4C9')

              // === Column ===
              // props: { space: 8 }
              // modifier: { width: '100%', padding: 8, alignItems: ItemAlign.Start }
              // children: 3
              Column() {
                // === Text ===
                // props: { text: 'Aqua' }
                // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, fontColor: '#433E3A' }
                Text('Aqua').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#433E3A')

                // === Text ===
                // props: { text: 'by UserC' }
                // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, letterSpacing: 0.5, fontColor: '#6C6662' }
                Text('by UserC').fontSize(12).fontWeight(FontWeight.Medium).letterSpacing(0.5).fontColor('#6C6662')

                // === Text ===
                // props: { text: '$4.99' }
                // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, fontColor: '#D7BBA8' }
                Text('$4.99').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#D7BBA8')
              }
            }
          }

          // === GridItem (Forest) ===
          GridItem() {
            // === Column ===
            // props: { space: 0 }
            // modifier: { width: '100%', padding: 8, backgroundColor: '#FFF', borderRadius: 24, shadow: { radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 } }
            // children: 2
            Column() {
              // === Image ===
              // modifier: { width: '100%', aspectRatio: 1, borderRadius: 16, backgroundColor: '#B3C9A2' }
              Image('').width('100%').aspectRatio(1).borderRadius(16).backgroundColor('#B3C9A2')

              // === Column ===
              // props: { space: 8 }
              // modifier: { width: '100%', padding: 8, alignItems: ItemAlign.Start }
              // children: 3
              Column() {
                // === Text ===
                // props: { text: 'Forest' }
                // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, fontColor: '#433E3A' }
                Text('Forest').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#433E3A')

                // === Text ===
                // props: { text: 'by UserD' }
                // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, letterSpacing: 0.5, fontColor: '#6C6662' }
                Text('by UserD').fontSize(12).fontWeight(FontWeight.Medium).letterSpacing(0.5).fontColor('#6C6662')

                // === Text ===
                // props: { text: '$3.99' }
                // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, fontColor: '#D7BBA8' }
                Text('$3.99').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#D7BBA8')
              }
            }
          }

          // === GridItem (Golden Hour) ===
          GridItem() {
            // === Column ===
            // props: { space: 0 }
            // modifier: { width: '100%', padding: 8, backgroundColor: '#FFF', borderRadius: 24, shadow: { radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 } }
            // children: 2
            Column() {
              // === Image ===
              // modifier: { width: '100%', aspectRatio: 1, borderRadius: 16, backgroundColor: '#D9B872' }
              Image('').width('100%').aspectRatio(1).borderRadius(16).backgroundColor('#D9B872')

              // === Column ===
              // props: { space: 8 }
              // modifier: { width: '100%', padding: 8, alignItems: ItemAlign.Start }
              // children: 3
              Column() {
                // === Text ===
                // props: { text: 'Golden Hour' }
                // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, fontColor: '#433E3A' }
                Text('Golden Hour').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#433E3A')

                // === Text ===
                // props: { text: 'by UserE' }
                // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, letterSpacing: 0.5, fontColor: '#6C6662' }
                Text('by UserE').fontSize(12).fontWeight(FontWeight.Medium).letterSpacing(0.5).fontColor('#6C6662')

                // === Text ===
                // props: { text: '$5.99' }
                // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, fontColor: '#D7BBA8' }
                Text('$5.99').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#D7BBA8')
              }
            }
          }

          // === GridItem (Monochrome) ===
          GridItem() {
            // === Column ===
            // props: { space: 0 }
            // modifier: { width: '100%', padding: 8, backgroundColor: '#FFF', borderRadius: 24, shadow: { radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 } }
            // children: 2
            Column() {
              // === Image ===
              // modifier: { width: '100%', aspectRatio: 1, borderRadius: 16, backgroundColor: '#DCD7CF' }
              Image('').width('100%').aspectRatio(1).borderRadius(16).backgroundColor('#DCD7CF')

              // === Column ===
              // props: { space: 8 }
              // modifier: { width: '100%', padding: 8, alignItems: ItemAlign.Start }
              // children: 3
              Column() {
                // === Text ===
                // props: { text: 'Monochrome' }
                // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, fontColor: '#433E3A' }
                Text('Monochrome').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#433E3A')

                // === Text ===
                // props: { text: 'by UserF' }
                // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, letterSpacing: 0.5, fontColor: '#6C6662' }
                Text('by UserF').fontSize(12).fontWeight(FontWeight.Medium).letterSpacing(0.5).fontColor('#6C6662')

                // === Text ===
                // props: { text: '$1.99' }
                // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, fontColor: '#D7BBA8' }
                Text('$1.99').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#D7BBA8')
              }
            }
          }
        }.columnsTemplate('1fr 1fr').columnsGap(12).rowsGap(12).width('100%').padding(16)
      }

      // === Row ===
      // props: { space: 0 }
      // modifier: { width: '100%', padding: { left: 16, right: 16, top: 12, bottom: 12 }, backgroundColor: '#FFF', shadow: { radius: 12, color: '#14000000', offsetX: 6, offsetY: 6 } }
      // children: 2
      Row() {
        // === Text ===
        // props: { text: '3 items in cart' }
        // modifier: { fontSize: 14, fontWeight: FontWeight.Regular, lineHeight: 20, fontColor: '#433E3A' }
        Text('3 items in cart').fontSize(14).fontWeight(FontWeight.Regular).lineHeight(20).fontColor('#433E3A')

        // === Blank ===
        Blank()

        // === Button ===
        // modifier: { backgroundColor: '#D7BBA8', borderRadius: 24, padding: { left: 24, right: 24, top: 8, bottom: 8 }, shadow: { radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 } }
        // children: 2
        Button() {
          // === Row ===
          // props: { space: 8 }
          // modifier: { verticalCenter: true }
          // children: 2
          Row() {
            // === Circle ===
            // modifier: { width: 16, height: 16, backgroundColor: '#0D433E3A' }
            Circle().width(16).height(16).backgroundColor('#0D433E3A')

            // === Text ===
            // props: { text: 'Checkout' }
            // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#433E3A' }
            Text('Checkout').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#433E3A')
          }
        }
        .backgroundColor('#D7BBA8')
        .borderRadius(24)
        .padding({ left: 24, right: 24, top: 8, bottom: 8 })
        .shadow({ radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 })
      }
    }
  }
}