import { BusinessError } from '@kit.BasicServicesKit';

interface TeaPreset {
  name: string;
  temp: string;
  time: string;
}

@Entry
@Component
struct TeaMasterApp {
  @State selectedTeaIndex: number = 0

  // Sample Data
  private teaPresets: Array<TeaPreset> = [
    { name: "Sencha", temp: "70°C", time: "1-2 min" },
    { name: "Earl Grey", temp: "98°C", time: "3-4 min" },
    { name: "Oolong", temp: "85°C", time: "3-5 min" },
    { name: "Chamomile", temp: "100°C", time: "5 min" },
    { name: "Matcha", temp: "80°C", time: "Whisk" }
  ]

  build() {
    // === Stack (Root) ===
    // props: {}
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack() {
      // === Color Background ===
      // modifier: { width: '100%', height: '100%', backgroundColor: '#FFFFFF' }
      Column() {
        // Empty column to act as background layer
      }.width('100%').height('100%').backgroundColor('#FFFFFF')

      // === Column (Content) ===
      // props: { space: 0 }
      // modifier: { width: '100%', height: '100%' }
      // children: 9
      Column({ space: 0 }) {
        // === HeaderSection ===
        // modifier: { padding: { top: 24, left: 24, right: 24 } }
        this.HeaderSection()

        // === Spacer ===
        // modifier: { height: 32 }
        Blank().height(32)

        // === BrewingVisualizer ===
        // children: 1
        this.BrewingVisualizer(this.teaPresets[this.selectedTeaIndex])

        // === Spacer ===
        // modifier: { height: 40 }
        Blank().height(40)

        // === BrewStatsRow ===
        // modifier: { padding: { left: 24, right: 24 } }
        this.BrewStatsRow(this.teaPresets[this.selectedTeaIndex])

        // === Spacer ===
        // modifier: { height: 40 }
        Blank().height(40)

        // === TeaSelector ===
        // modifier: { padding: { left: 24, right: 24 } }
        this.TeaSelector(this.teaPresets, this.selectedTeaIndex, (index: number) => {
          this.selectedTeaIndex = index
        })

        // === Spacer ===
        // modifier: { layoutWeight: 1 }
        Blank().layoutWeight(1)

        // === StartBrewButton ===
        // modifier: { padding: { left: 24, right: 24, bottom: 32 } }
        this.StartBrewButton()
      }.width('100%').height('100%')
    }
  }

  // MARK: - Components

  @Builder
  HeaderSection() {
    // === Row ===
    // props: { space: 0, verticalAlignment: VerticalAlign.Center }
    // modifier: { width: '100%' }
    // children: 3
    Row({ space: 0 }) {
      // === Column (Texts) ===
      // props: { space: 4, horizontalAlignment: HorizontalAlign.Start }
      // modifier: { flexShrink: 1 }
      // children: 2
      Column({ space: 4 }) {
        // === Text ===
        // props: { text: 'Tea Master' }
        // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, fontColor: '#000000' }
        Text('Tea Master').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#000000')
        
        // === Text ===
        // props: { text: 'Perfect brew, every time' }
        // modifier: { fontSize: 12, fontWeight: FontWeight.Normal, fontColor: '#9E9E9E' }
        Text('Perfect brew, every time').fontSize(12).fontWeight(FontWeight.Normal).fontColor('#9E9E9E')
      }.alignItems(HorizontalAlign.Start)

      // === Blank ===
      // modifier: { layoutWeight: 1 }
      Blank().layoutWeight(1)

      // === Button (Settings) ===
      // modifier: { width: 40, height: 40 }
      // children: 1
      Button() {
        // === Image ===
        // props: { src: $r('app.media.startIcon') }
        // modifier: { width: 24, height: 24, objectFit: ImageFit.Contain }
        Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
      }.width(40).height(40)
    }.width('100%').alignItems(VerticalAlign.Center)
  }

  @Builder
  BrewingVisualizer(tea: TeaPreset) {
    // === Stack ===
    // props: { alignContent: Alignment.Center }
    // modifier: { width: 220, height: 220 }
    // children: 2
    Stack({ alignContent: Alignment.Center }) {
      // === Circle Background ===
      // modifier: { width: 220, height: 220, backgroundColor: '#F5F5F5' }
      Column() {
        // Placeholder for circle shape
      }.width(220).height(220).borderRadius(110).backgroundColor('#F5F5F5')

      // === Column (Content) ===
      // props: { space: 8 }
      // modifier: { width: '100%' }
      // children: 2
      Column({ space: 8 }) {
        // === Image (Heart Icon) ===
        // props: { src: $r('app.media.startIcon') }
        // modifier: { width: 48, height: 48, objectFit: ImageFit.Contain }
        Image($r('app.media.startIcon')).width(48).height(48).objectFit(ImageFit.Contain)

        // === Text ===
        // props: { text: tea.name }
        // modifier: { fontSize: 22, fontWeight: FontWeight.Medium, fontColor: '#000000' }
        Text(tea.name).fontSize(22).fontWeight(FontWeight.Medium).fontColor('#000000')
      }
    }.width(220).height(220)
  }

  @Builder
  BrewStatsRow(tea: TeaPreset) {
    // === Row ===
    // props: { space: 0 }
    // modifier: { width: '100%' }
    // children: 6
    Row({ space: 0 }) {
      // === InfoItem (Temp) ===
      // modifier: { flexShrink: 1 }
      this.InfoItem("TEMP", tea.temp)

      // === VerticalDivider ===
      // modifier: { margin: { left: 12, right: 12 } }
      this.VerticalDivider()

      // === InfoItem (Time) ===
      // modifier: { flexShrink: 1 }
      this.InfoItem("TIME", tea.time)

      // === VerticalDivider ===
      // modifier: { margin: { left: 12, right: 12 } }
      this.VerticalDivider()

      // === InfoItem (Amount) ===
      // modifier: { flexShrink: 1 }
      this.InfoItem("AMOUNT", "250ml")
    }.width('100%')
  }

  @Builder
  VerticalDivider() {
    // === Divider ===
    // modifier: { width: 1, height: 40, color: '#E0E0E0' }
    Divider().width(1).height(40).color('#E0E0E0')
  }

  @Builder
  InfoItem(label: string, value: string) {
    // === Column ===
    // props: { space: 4, horizontalAlignment: HorizontalAlign.Center }
    // modifier: { width: '100%' }
    // children: 2
    Column({ space: 4 }) {
      // === Text ===
      // props: { text: label }
      // modifier: { fontSize: 11, fontWeight: FontWeight.Bold, fontColor: '#9E9E9E', letterSpacing: 1 }
      Text(label).fontSize(11).fontWeight(FontWeight.Bold).fontColor('#9E9E9E').letterSpacing(1)

      // === Text ===
      // props: { text: value }
      // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#000000' }
      Text(value).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
    }.alignItems(HorizontalAlign.Center)
  }

  @Builder
  TeaSelector(presets: Array<TeaPreset>, selectedIndex: number, onClick: (index: number) => void) {
    // === Column ===
    // props: { space: 12, horizontalAlignment: HorizontalAlign.Start }
    // modifier: { width: '100%' }
    // children: 2
    Column({ space: 12 }) {
      // === Text ===
      // props: { text: 'Select Variety' }
      // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: '#000000', padding: { left: 4 } }
      Text('Select Variety').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000').padding({ left: 4 })

      // === Scroll (Horizontal) ===
      // props: { scrollable: ScrollDirection.Horizontal }
      // modifier: { width: '100%' }
      // children: 1
      Scroll() {
        // === Row ===
        // props: { space: 12 }
        // modifier: { width: '100%', padding: { left: 4, right: 4 } }
        // children: N
        Row({ space: 12 }) {
          ForEach(presets, (item: TeaPreset, index: number) => {
            // === TeaChip ===
            // modifier: { flexShrink: 0 }
            this.TeaChip(item.name, index === selectedIndex, () => {
              onClick(index)
            })
          })
        }.width('100%').padding({ left: 4, right: 4 })
      }.width('100%').scrollable(ScrollDirection.Horizontal).edgeEffect(EdgeEffect.Spring)
    }.alignItems(HorizontalAlign.Start).width('100%')
  }

  @Builder
  TeaChip(name: string, isSelected: boolean, onClick: () => void) {
    // === Button ===
    // modifier: { borderRadius: 20 }
    // children: 1
    Button() {
      // === Text ===
      // props: { text: name }
      // modifier: { fontSize: 14, fontWeight: isSelected ? FontWeight.Bold : FontWeight.Normal, fontColor: isSelected ? '#FFFFFF' : '#000000' }
      Text(name).fontSize(14).fontWeight(isSelected ? FontWeight.Bold : FontWeight.Normal).fontColor(isSelected ? '#FFFFFF' : '#000000')
    }
    .type(ButtonType.Normal)
    .backgroundColor(isSelected ? '#000000' : '#FFFFFF')
    .borderWidth(1)
    .borderColor(isSelected ? '#000000' : '#E0E0E0')
    .borderRadius(20)
    .padding({ left: 20, right: 20, top: 10, bottom: 10 })
    .onClick(() => {
      onClick()
    })
  }

  @Builder
  StartBrewButton() {
    // === Button ===
    // modifier: { width: '100%', height: 56, borderRadius: 16, backgroundColor: '#000000' }
    // children: 1
    Button() {
      // === Row ===
      // props: { space: 8, verticalAlignment: VerticalAlign.Center }
      // modifier: { width: '100%', justifyContent: FlexAlign.Center }
      // children: 2
      Row({ space: 8 }) {
        // === Image (Play Icon) ===
        // props: { src: $r('app.media.startIcon') }
        // modifier: { width: 20, height: 20, objectFit: ImageFit.Contain }
        Image($r('app.media.startIcon')).width(20).height(20).objectFit(ImageFit.Contain)

        // === Text ===
        // props: { text: 'START TIMER' }
        // modifier: { fontSize: 14, fontWeight: FontWeight.Bold, fontColor: '#FFFFFF' }
        Text('START TIMER').fontSize(14).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
      }.width('100%').justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
    }
    .type(ButtonType.Normal)
    .width('100%')
    .height(56)
    .borderRadius(16)
    .backgroundColor('#000000')
  }
}