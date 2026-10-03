@Entry
@Component
struct ZenBrewApp {
  @State teas: TeaGuide[] = [
    { id: 1, name: "Sencha Green", origin: "Japan", temp: "70°C / 158°F", time: "1-2 min", colorCode: '#8BC34A' },
    { id: 2, name: "Earl Grey", origin: "Blend", temp: "95°C / 203°F", time: "3-5 min", colorCode: '#795548' },
    { id: 3, name: "Silver Needle", origin: "China", temp: "80°C / 176°F", time: "3-4 min", colorCode: '#E0E0E0' },
    { id: 4, name: "Darjeeling", origin: "India", temp: "90°C / 194°F", time: "3 min", colorCode: '#D7CCC8' },
    { id: 5, name: "Chamomile", origin: "Egypt", temp: "100°C / 212°F", time: "5-7 min", colorCode: '#FFEB3B' },
    { id: 6, name: "Matcha", origin: "Japan", temp: "80°C / 176°F", time: "Whisk", colorCode: '#4CAF50' },
    { id: 7, name: "Oolong", origin: "Taiwan", temp: "85°C / 185°F", time: "3-5 min", colorCode: '#FF9800' }
  ]

  build() {
    // === Stack (Scaffold) ===
    // props: {}
    // modifier: { width: '100%', height: '100%', backgroundColor: '#FFF' }
    // children: 3
    Stack() {
      // === Column (LazyColumn) ===
      // props: { space: 16 }
      // modifier: { width: '100%', layoutWeight: 1, padding: { left: 20, right: 20, top: 10, bottom: 10 } }
      // children: 9
      Column({ space: 16 }) {
        // === PromoCard ===
        // modifier: { width: '100%' }
        this.PromoCard()

        // === Text ===
        // props: { text: 'Collections' }
        // modifier: { fontSize: 18, fontWeight: FontWeight.SemiBold, padding: { top: 8, bottom: 8 } }
        Text('Collections').fontSize(18).fontWeight(FontWeight.Medium).padding({ top: 8, bottom: 8 })

        // === List Items ===
        ForEach(this.teas, (tea: TeaGuide) => {
          // === TeaItemCard ===
          // modifier: { width: '100%' }
          this.TeaItemCard(tea)
        })

        // === Spacer ===
        // modifier: { height: 80 }
        Blank().height(80)
      }.width('100%').layoutWeight(1).padding({ left: 20, right: 20, top: 10, bottom: 10 })

      // === TopAppBar ===
      // modifier: { width: '100%', height: 80, backgroundColor: '#FFF', position: { x: 0, y: 0 } }
      // children: 2
      Row() {
        // === Column ===
        // modifier: { flexShrink: 0 }
        // children: 2
        Column() {
          // === Text ===
          // props: { text: 'ZenBrew' }
          // modifier: { fontSize: 24, fontWeight: FontWeight.Bold, color: '#121212', letterSpacing: -0.5 }
          Text('ZenBrew').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#121212').letterSpacing(-0.5)
          // === Text ===
          // props: { text: 'Mindful Steeping Guide' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#757575' }
          Text('Mindful Steeping Guide').fontSize(14).fontWeight(FontWeight.Normal).fontColor('#757575')
        }
        // === Blank ===
        Blank()
        // === IconButton ===
        // modifier: { width: 48, height: 48, flexShrink: 0 }
        Button() {
          // === Image ===
          // modifier: { width: 24, height: 24, objectFit: ImageFit.Contain }
          Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
        }.backgroundColor(Color.Transparent).borderRadius(24)
      }.width('100%').height(80).backgroundColor('#FFF').position({ x: 0, y: 0 }).padding({ left: 20, right: 20 })

      // === FAB ===
      // modifier: { width: 'auto', height: 56, backgroundColor: '#121212', borderRadius: 16, shadow: { radius: 6, color: '#3F000000' }, margin: 24, position: { x: 0, y: 0 } }
      // children: 2
      Button() {
        // === Row to hold multiple children ===
        Row() {
          // === Image ===
          // modifier: { width: 24, height: 24, objectFit: ImageFit.Contain }
          Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
          // === Text ===
          // props: { text: 'Custom Brew' }
          // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#FFF', marginLeft: 8 }
          Text('Custom Brew').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#FFF').margin({ left: 8 })
        }
      }.backgroundColor('#121212').borderRadius(16).shadow({ radius: 6, color: '#3F000000' }).margin(24).position({ x: 0, y: 0 }).alignSelf(ItemAlign.End)
    }.width('100%').height('100%').backgroundColor('#FFF')
  }

  @Builder
  PromoCard() {
    // === Card ===
    // modifier: { width: '100%', backgroundColor: '#F0F0F0', borderRadius: 20 }
    // children: 1
    Column() {
      // === Row ===
      // props: { space: 16 }
      // modifier: { width: '100%', padding: 24 }
      // children: 2
      Row({ space: 16 }) {
        // === Column ===
        // modifier: { layoutWeight: 1 }
        // children: 2
        Column() {
          // === Text ===
          // props: { text: 'Tip of the day' }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Bold, color: '#888', marginBottom: 4 }
          Text('Tip of the day').fontSize(12).fontWeight(FontWeight.Bold).fontColor('#888').margin({ bottom: 4 })
          // === Text ===
          // props: { text: 'Use filtered water for a purer taste profile.' }
          // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#121212' }
          Text('Use filtered water for a purer taste profile.').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#121212')
        }
        // === Surface ===
        // modifier: { width: 48, height: 48, backgroundColor: '#FFF', borderRadius: 24, flexShrink: 0 }
        // children: 1
        Column() {
          // === Image ===
          // modifier: { width: 24, height: 24, objectFit: ImageFit.Contain }
          Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
        }.width(48).height(48).backgroundColor('#FFF').borderRadius(24).flexShrink(0)
      }.width('100%').padding(24)
    }.width('100%').backgroundColor('#F0F0F0').borderRadius(20)
  }

  @Builder
  TeaItemCard(tea: TeaGuide) {
    // === Card ===
    // modifier: { width: '100%', backgroundColor: '#F9F9F9', borderRadius: 16, borderColor: '#EEEEEE', borderWidth: 1 }
    // children: 1
    Column() {
      // === Row ===
      // props: { space: 16 }
      // modifier: { width: '100%', padding: 16 }
      // children: 3
      Row({ space: 16 }) {
        // === Visual Dot ===
        // modifier: { width: 50, height: 50, backgroundColor: '#FFF', borderRadius: 25, borderColor: tea.colorCode, borderWidth: 2, borderStyle: BorderStyle.Solid, opacity: 0.3 }
        // children: 1
        Column() {
          // === Text ===
          // props: { text: tea.name.substring(0, 1) }
          // modifier: { fontSize: 20, fontWeight: FontWeight.Bold, color: tea.colorCode }
          Text(tea.name.substring(0, 1)).fontSize(20).fontWeight(FontWeight.Bold).fontColor(tea.colorCode)
        }.width(50).height(50).backgroundColor('#FFF').borderRadius(25).border({ width: 2, color: tea.colorCode, style: BorderStyle.Solid, radius: 25 }).opacity(0.3)

        // === Info Column ===
        // modifier: { layoutWeight: 1 }
        // children: 3
        Column() {
          // === Text ===
          // props: { text: tea.name }
          // modifier: { fontSize: 17, fontWeight: FontWeight.Bold, color: '#121212' }
          Text(tea.name).fontSize(17).fontWeight(FontWeight.Bold).fontColor('#121212')
          // === Text ===
          // props: { text: tea.origin }
          // modifier: { fontSize: 12, color: '#757575' }
          Text(tea.origin).fontSize(12).fontColor('#757575')
          // === Blank ===
          // modifier: { height: 6 }
          Blank().height(6)
          // === Row ===
          // props: { space: 8 }
          // modifier: { width: '100%' }
          // children: 2
          Row({ space: 8 }) {
            // === InfoBadge ===
            // modifier: { width: 'auto', height: 'auto', backgroundColor: '#FFF', borderRadius: 6, borderColor: '#E0E0E0', borderWidth: 1, padding: { left: 6, right: 6, top: 2, bottom: 2 } }
            // children: 1
            Column() {
              // === Text ===
              // props: { text: tea.temp }
              // modifier: { fontSize: 11, color: '#000' }
              Text(tea.temp).fontSize(11).fontColor('#000')
            }.backgroundColor('#FFF').borderRadius(6).border({ width: 1, color: '#E0E0E0', style: BorderStyle.Solid, radius: 6 }).padding({ left: 6, right: 6, top: 2, bottom: 2 })
            // === InfoBadge ===
            // modifier: { width: 'auto', height: 'auto', backgroundColor: '#FFF', borderRadius: 6, borderColor: '#E0E0E0', borderWidth: 1, padding: { left: 6, right: 6, top: 2, bottom: 2 } }
            // children: 1
            Column() {
              // === Text ===
              // props: { text: tea.time }
              // modifier: { fontSize: 11, color: '#000' }
              Text(tea.time).fontSize(11).fontColor('#000')
            }.backgroundColor('#FFF').borderRadius(6).border({ width: 1, color: '#E0E0E0', style: BorderStyle.Solid, radius: 6 }).padding({ left: 6, right: 6, top: 2, bottom: 2 })
          }.width('100%')
        }.layoutWeight(1)

        // === IconButton ===
        // modifier: { width: 40, height: 40, backgroundColor: '#FFF', borderRadius: 20, borderColor: '#E0E0E0', borderWidth: 1, flexShrink: 0 }
        // children: 1
        Button() {
          // === Image ===
          // modifier: { width: 20, height: 20, objectFit: ImageFit.Contain }
          Image($r('app.media.startIcon')).width(20).height(20).objectFit(ImageFit.Contain)
        }.backgroundColor('#FFF').borderRadius(20).border({ width: 1, color: '#E0E0E0', style: BorderStyle.Solid, radius: 20 }).flexShrink(0)
      }.width('100%').padding(16)
    }.width('100%').backgroundColor('#F9F9F9').borderRadius(16).border({ width: 1, color: '#EEEEEE', style: BorderStyle.Solid, radius: 16 })
  }
}

interface TeaGuide {
  id: number;
  name: string;
  origin: string;
  temp: string;
  time: string;
  colorCode: string;
}