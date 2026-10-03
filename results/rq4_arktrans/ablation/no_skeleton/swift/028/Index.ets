@Entry
@Component
struct ProductivityCheck {
  @State selectedFilter: string = 'Weekly'

  // === Data Models ===
  interface ProductivityItem {
    id: number
    title: string
    status: string
    progress: number
    statusColor: string
  }

  interface ChartData {
    label: string
    value: number
  }

  // === Constants & Tokens ===
  private readonly colors = {
    primary: '#0F172A',
    secondary: '#475569',
    tertiary: '#94A3B8',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#F1F5F9',
    outline: '#E2E8F0',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#0F172A',
    onBackground: '#0F172A',
    onSurface: '#0F172A'
  }

  private readonly spacing = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48
  }

  private readonly shapes = {
    smallCornerRadius: 8,
    mediumCornerRadius: 12,
    largeCornerRadius: 16
  }

  private readonly filters: string[] = ['Daily', 'Weekly', 'Monthly']

  private readonly productivityItems: ProductivityItem[] = [
    { id: 1, title: 'Form Batch #A-102', status: 'Completed', progress: 1.0, statusColor: this.colors.success },
    { id: 2, title: 'Invoice Set #B-231', status: 'In Progress', progress: 0.75, statusColor: this.colors.warning },
    { id: 3, title: 'Document Scan #C-456', status: 'Pending', progress: 0.1, statusColor: this.colors.secondary },
    { id: 4, title: 'Form Batch #A-103', status: 'Completed', progress: 1.0, statusColor: this.colors.success },
    { id: 5, title: 'Data Entry #D-789', status: 'Failed', progress: 0.4, statusColor: this.colors.error }
  ]

  private readonly chartData: ChartData[] = [
    { label: 'Mon', value: 0.6 },
    { label: 'Tue', value: 0.8 },
    { label: 'Wed', value: 0.5 },
    { label: 'Thu', value: 1.0 },
    { label: 'Fri', value: 0.7 },
    { label: 'Sat', value: 0.4 },
    { label: 'Sun', value: 0.2 }
  ]

  build() {
    // === Column (Root) ===
    // props: {}
    // modifier: { width: '100%', height: '100%', backgroundColor: this.colors.background }
    // children: 3
    Column() {
      // === Top Bar ===
      // props: {}
      // modifier: { width: '100%', height: 56, padding: 16, backgroundColor: this.colors.surface, shadow: { radius: 10, color: '#1A000000', offsetY: 4 } }
      // children: 3
      Row() {
        // === Image (Placeholder for Icon) ===
        // modifier: { width: 24, height: 24, backgroundColor: this.colors.outline, borderRadius: 12 }
        Image('').width(24).height(24).backgroundColor(this.colors.outline).borderRadius(12)

        // === Blank ===
        Blank()

        // === Text ===
        // props: { text: 'Productivity Check' }
        // modifier: { fontSize: 24, fontWeight: FontWeight.Semibold, fontColor: this.colors.onSurface }
        Text('Productivity Check').fontSize(24).fontWeight(FontWeight.Semibold).fontColor(this.colors.onSurface)

        // === Blank ===
        Blank()

        // === Image (Placeholder for Icon) ===
        // modifier: { width: 24, height: 24, backgroundColor: this.colors.outline, borderRadius: 12 }
        Image('').width(24).height(24).backgroundColor(this.colors.outline).borderRadius(12)
      }.width('100%').height(56).padding(16).backgroundColor(this.colors.surface).shadow({ radius: 10, color: '#1A000000', offsetY: 4 })

      // === Scrollable Content ===
      // props: {}
      // modifier: { width: '100%', layoutWeight: 1 }
      // children: 1
      Scroll() {
        // === Column ===
        // props: { space: 24 }
        // modifier: { width: '100%', padding: { top: 16, bottom: 16 } }
        // children: 3
        Column({ space: 24 }) {
          // === Filter Chips ===
          // props: { space: 8 }
          // modifier: { width: '100%', padding: { left: 16, right: 16 } }
          // children: 3
          Row({ space: 8 }) {
            ForEach(this.filters, (filter: string) => {
              // === Button (Chip) ===
              // modifier: { padding: { left: 16, right: 16, top: 8, bottom: 8 }, backgroundColor: this.selectedFilter === filter ? this.colors.primary : this.colors.surface, borderColor: this.colors.outline, borderWidth: 1, borderRadius: 8 }
              // children: 1
              Button(filter) {
                // === Text ===
                // props: { text: filter }
                // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: this.selectedFilter === filter ? this.colors.onPrimary : this.colors.onSurface }
                Text(filter).fontSize(14).fontWeight(FontWeight.Medium).fontColor(this.selectedFilter === filter ? this.colors.onPrimary : this.colors.onSurface)
              }.onClick(() => {
                this.selectedFilter = filter
              }).padding({ left: 16, right: 16, top: 8, bottom: 8 }).backgroundColor(this.selectedFilter === filter ? this.colors.primary : this.colors.surface).borderColor(this.colors.outline).borderWidth(1).borderRadius(8)
            })
          }.width('100%').padding({ left: 16, right: 16 })

          // === Weekly Throughput Card ===
          // props: {}
          // modifier: { width: '100%', padding: 16, backgroundColor: this.colors.surface, borderRadius: 16, shadow: { radius: 3, color: '#1A000000', offsetY: 1 }, margin: { left: 16, right: 16 } }
          // children: 2
          Column() {
            // === Text ===
            // props: { text: 'Weekly Throughput' }
            // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: this.colors.onSurface, marginBottom: 16 }
            Text('Weekly Throughput').fontSize(18).fontWeight(FontWeight.Medium).fontColor(this.colors.onSurface).margin({ bottom: 16 })

            // === Chart Area ===
            // props: { space: 8 }
            // modifier: { width: '100%' }
            // children: 2
            Column({ space: 8 }) {
              // === Chart Bars ===
              // props: { space: 0 }
              // modifier: { width: '100%', height: 150 }
              // children: 7
              Row({ space: 0 }) {
                ForEach(this.chartData, (data: ChartData) => {
                  // === Column (Bar Wrapper) ===
                  // props: {}
                  // modifier: { width: '100%', height: '100%', justifyContent: FlexAlign.End }
                  // children: 1
                  Column() {
                    // === Rectangle (Bar) ===
                    // modifier: { width: '60%', height: `${data.value * 100}%`, backgroundColor: this.colors.primary, borderRadius: 8 }
                    // Note: ArkTS doesn't support dynamic height percentage directly in frame easily without GeometryReader logic or fixed calc.
                    // Using a calculated height based on max height 150 for simplicity in static conversion.
                    // However, to match the visual "fillMaxHeight" behavior relative to parent, we use a fixed height calculation here.
                    // 150 * data.value
                    Column().width('60%').height(data.value * 150).backgroundColor(this.colors.primary).borderRadius(8)
                  }.width('100%').height('100%').justifyContent(FlexAlign.End)
                })
              }.width('100%').height(150)

              // === Chart Labels ===
              // props: { space: 0 }
              // modifier: { width: '100%' }
              // children: 7
              Row({ space: 0 }) {
                ForEach(this.chartData, (data: ChartData) => {
                  // === Text ===
                  // props: { text: data.label }
                  // modifier: { width: '100%', fontSize: 14, fontWeight: FontWeight.Medium, fontColor: this.colors.secondary, textAlign: TextAlign.Center }
                  Text(data.label).width('100%').fontSize(14).fontWeight(FontWeight.Medium).fontColor(this.colors.secondary).textAlign(TextAlign.Center)
                })
              }.width('100%')
            }.width('100%')
          }.width('100%').padding(16).backgroundColor(this.colors.surface).borderRadius(16).shadow({ radius: 3, color: '#1A000000', offsetY: 1 }).margin({ left: 16, right: 16 })

          // === Productivity Items List ===
          // props: { space: 16 }
          // modifier: { width: '100%' }
          // children: 5
          Column({ space: 16 }) {
            ForEach(this.productivityItems, (item: ProductivityItem) => {
              // === Item Card ===
              // props: {}
              // modifier: { width: '100%', padding: 16, backgroundColor: this.colors.surface, borderRadius: 12, borderColor: item.statusColor, borderWidth: 1, margin: { left: 16, right: 16 } }
              // children: 2
              Column() {
                // === Header Row ===
                // props: {}
                // modifier: { width: '100%', marginBottom: 16 }
                // children: 2
                Row() {
                  // === Text ===
                  // props: { text: item.title }
                  // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: this.colors.onSurface, layoutWeight: 1 }
                  Text(item.title).fontSize(18).fontWeight(FontWeight.Medium).fontColor(this.colors.onSurface).layoutWeight(1)

                  // === Status Indicator ===
                  // props: { space: 8 }
                  // modifier: {}
                  // children: 2
                  Row({ space: 8 }) {
                    // === Circle (Dot) ===
                    // modifier: { width: 10, height: 10, backgroundColor: item.statusColor }
                    Circle().width(10).height(10).fill(item.statusColor)

                    // === Text ===
                    // props: { text: item.status }
                    // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: item.statusColor }
                    Text(item.status).fontSize(14).fontWeight(FontWeight.Medium).fontColor(item.statusColor)
                  }
                }.width('100%').margin({ bottom: 16 })

                // === Progress Row ===
                // props: { space: 8 }
                // modifier: { width: '100%' }
                // children: 2
                Row({ space: 8 }) {
                  // === Progress Bar ===
                  // props: { value: item.progress * 100, total: 100, type: ProgressType.Linear }
                  // modifier: { width: '100%', height: 8, color: item.statusColor, trackColor: this.colors.surfaceVariant, borderRadius: 4, layoutWeight: 1 }
                  Progress({ value: item.progress * 100, total: 100, type: ProgressType.Linear }).width('100%').height(8).color(item.statusColor).trackColor(this.colors.surfaceVariant).borderRadius(4).layoutWeight(1)

                  // === Text ===
                  // props: { text: `${Math.round(item.progress * 100)}%` }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: this.colors.secondary, width: 40, textAlign: TextAlign.End }
                  Text(`${Math.round(item.progress * 100)}%`).fontSize(14).fontWeight(FontWeight.Medium).fontColor(this.colors.secondary).width(40).textAlign(TextAlign.End)
                }.width('100%')
              }.width('100%').padding(16).backgroundColor(this.colors.surface).borderRadius(12).borderColor(item.statusColor).borderWidth(1).margin({ left: 16, right: 16 })
            })
          }.width('100%')
        }.width('100%').padding({ top: 16, bottom: 16 })
      }.width('100%').layoutWeight(1)

      // === Bottom Bar ===
      // props: {}
      // modifier: { width: '100%', padding: 16, backgroundColor: this.colors.surface, shadow: { radius: 10, color: '#1A000000', offsetY: -4 } }
      // children: 1
      Column() {
        // === Button ===
        // modifier: { width: '100%', height: 56, backgroundColor: this.colors.primary, borderRadius: 12 }
        // children: 1
        Button('Submit New Form') {
          // === Text ===
          // props: { text: 'Submit New Form' }
          // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: this.colors.onPrimary }
          Text('Submit New Form').fontSize(18).fontWeight(FontWeight.Medium).fontColor(this.colors.onPrimary)
        }.width('100%').height(56).backgroundColor(this.colors.primary).borderRadius(12)
      }.width('100%').padding(16).backgroundColor(this.colors.surface).shadow({ radius: 10, color: '#1A000000', offsetY: -4 })
    }.width('100%').height('100%').backgroundColor(this.colors.background)
  }
}