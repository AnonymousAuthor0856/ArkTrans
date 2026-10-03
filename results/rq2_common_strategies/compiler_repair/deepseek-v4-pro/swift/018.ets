@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'vintage'

  private readonly cPrimary: string = '#D7BBA8'
  private readonly cSecondary: string = '#A2C4C9'
  private readonly cTertiary: string = '#B3C9A2'
  private readonly cBackground: string = '#F0EBE3'
  private readonly cSurface: string = '#FFFFFF'
  private readonly cSurfaceVariant: string = '#E6E0D9'
  private readonly cOutline: string = '#DCD7CF'
  private readonly cSuccess: string = '#7EA87E'
  private readonly cWarning: string = '#D9B872'
  private readonly cError: string = '#D98B8B'
  private readonly cOnPrimary: string = '#433E3A'
  private readonly cOnSecondary: string = '#433E3A'
  private readonly cOnTertiary: string = '#433E3A'
  private readonly cOnBackground: string = '#433E3A'
  private readonly cOnSurface: string = '#433E3A'

  private readonly filterNames: string[] = ['Vintage', 'Grain', 'B&W', 'Neon']
  private readonly filterIds: string[] = ['vintage', 'grain', 'b&w', 'neon']

  private readonly itemNames: string[] = ['Redscale', 'Sepia Tone', 'Aqua', 'Forest', 'Golden Hour', 'Monochrome']
  private readonly itemAuthors: string[] = ['by UserA', 'by UserB', 'by UserC', 'by UserD', 'by UserE', 'by UserF']
  private readonly itemPrices: string[] = ['$4.99', '$2.99', '$4.99', '$3.99', '$5.99', '$1.99']
  private readonly itemColors: string[] = [this.cError, this.cPrimary, this.cSecondary, this.cTertiary, this.cWarning, this.cOutline]

  build() {
    Column({ space: 0 }) {
      // ===== Top Bar Section =====
      Column({ space: 12 }) {
        Text('Filter Shop')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.cOnBackground)
          .width('100%')

        Row({ space: 8 }) {
          // Filter 0
          Button() {
            Text('Vintage')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedFilter == 'vintage' ? this.cOnPrimary : this.cOnBackground)
          }
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .backgroundColor(this.selectedFilter == 'vintage' ? this.cPrimary : this.cSurface)
          .borderRadius(24)
          .border({ width: 2, color: this.selectedFilter == 'vintage' ? this.cOnBackground : this.cOutline })
          .onClick(() => { this.selectedFilter = 'vintage' })

          // Filter 1
          Button() {
            Text('Grain')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedFilter == 'grain' ? this.cOnPrimary : this.cOnBackground)
          }
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .backgroundColor(this.selectedFilter == 'grain' ? this.cPrimary : this.cSurface)
          .borderRadius(24)
          .border({ width: 2, color: this.selectedFilter == 'grain' ? this.cOnBackground : this.cOutline })
          .onClick(() => { this.selectedFilter = 'grain' })

          // Filter 2
          Button() {
            Text('B&W')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedFilter == 'b&w' ? this.cOnPrimary : this.cOnBackground)
          }
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .backgroundColor(this.selectedFilter == 'b&w' ? this.cPrimary : this.cSurface)
          .borderRadius(24)
          .border({ width: 2, color: this.selectedFilter == 'b&w' ? this.cOnBackground : this.cOutline })
          .onClick(() => { this.selectedFilter = 'b&w' })

          // Filter 3
          Button() {
            Text('Neon')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedFilter == 'neon' ? this.cOnPrimary : this.cOnBackground)
          }
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .backgroundColor(this.selectedFilter == 'neon' ? this.cPrimary : this.cSurface)
          .borderRadius(24)
          .border({ width: 2, color: this.selectedFilter == 'neon' ? this.cOnBackground : this.cOutline })
          .onClick(() => { this.selectedFilter = 'neon' })
        }.width('100%')
      }
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(this.cBackground)

      // ===== Scrollable Grid of Filter Cards =====
      List() {
        ListItem() {
          Grid() {
            GridItem() { this.FilterCard(0) }
            GridItem() { this.FilterCard(1) }
            GridItem() { this.FilterCard(2) }
            GridItem() { this.FilterCard(3) }
            GridItem() { this.FilterCard(4) }
            GridItem() { this.FilterCard(5) }
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(12)
          .rowsGap(12)
          .padding(16)
        }
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(this.cBackground)

      // ===== Bottom Bar Section =====
      Row({ space: 0 }) {
        Text('3 items in cart')
          .fontSize(14)
          .fontColor(this.cOnSurface)
          .layoutWeight(1)

        Button() {
          Row({ space: 8 }) {
            Blank().width(16).height(16).borderRadius(8).backgroundColor(this.cOnPrimary).opacity(0.2)
            Text('Checkout')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.cOnPrimary)
          }
        }
        .padding({ left: 24, right: 24, top: 8, bottom: 8 })
        .backgroundColor(this.cPrimary)
        .borderRadius(24)
        .shadow({ radius: 8, color: '#1A000000', offsetX: 6, offsetY: 6 })
        .onClick(() => {})
      }
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .width('100%')
      .backgroundColor(this.cSurface)
      .shadow({ radius: 12, color: '#1A000000', offsetX: 6, offsetY: 6 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBackground)
    .padding(0)
  }

  @Builder FilterCard(index: number) {
    Column({ space: 0 }) {
      // Image placeholder (colored square with rounded corners)
      Column()
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(this.itemColors[index])
        .borderRadius(16)

      // Text details
      Column({ space: 8 }) {
        Text(this.itemNames[index])
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.cOnSurface)

        Text(this.itemAuthors[index])
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cOnSurface)
          .opacity(0.6)

        Text(this.itemPrices[index])
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.cPrimary)
      }
      .padding(8)
    }
    .padding(8)
    .backgroundColor(this.cSurface)
    .borderRadius(24)
    .shadow({ radius: 8, color: '#1A000000', offsetX: 4, offsetY: 4 })
  }
}