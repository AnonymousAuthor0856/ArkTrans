@Entry
@Component
struct Index {
  @State filters: string[] = ["Pending", "Approved"]
  @State activeFilters: string[] = ["Pending"]
  @State selectedIndex: number = -1

  // Mock data for the map pins based on screenshot
  private pins: PinData[] = [
    { id: 1, title: 'Purchase Order #1042', status: 'Pending', x: 25, y: 45, color: '#B8860B' },
    { id: 2, title: 'Contract #A7', status: 'Approved', x: 80, y: 65, color: '#B8860B' },
    { id: 3, title: 'Budget Change #09', status: 'Rejected', x: 40, y: 75, color: '#B22222' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Main Content Column ===
      Column({ space: 12 }) {
        // === Filter Chips Row ===
        List({ space: 8 }) {
          ForEach(this.filters, (f: string) => {
            ListItem() {
              Button(f)
                .type(ButtonType.Capsule)
                .backgroundColor(this.activeFilters.includes(f) ? '#1F1F1F' : '#FFFFFF')
                .fontColor(this.activeFilters.includes(f) ? '#FFFFFF' : '#1F1F1F')
                .borderWidth(1)
                .borderColor('#D0D0D0')
                .height(40)
                .onClick(() => {
                  if (!this.activeFilters.includes(f)) {
                    this.activeFilters.push(f)
                  } else {
                    this.activeFilters = this.activeFilters.filter(item => item !== f)
                  }
                })
            }
          }, (f: string) => f)
        }.width('100%').layoutWeight(0).listDirection(Axis.Horizontal)

        // === Map Area (BoxWithConstraints equivalent) ===
        Stack({ alignContent: Alignment.TopStart }) {
          // Grid Background
          Column() {
            Flex({ wrap: FlexWrap.Wrap }) {
              ForEach(Array.from({ length: 25 }), () => {
                Flex().width('20%').height(60).borderWidth({ right: 1, bottom: 1 }).borderColor('#E0E0E0')
              }, () => 'grid-cell')
            }.width('100%').height('100%')
          }.width('100%').height('100%')

          // Pins and Labels
          ForEach(this.pins, (pin: PinData) => {
            // Check filter logic
            let show: boolean = false;
            if (pin.status === 'Pending') show = this.activeFilters.includes('Pending');
            else if (pin.status === 'Approved') show = this.activeFilters.includes('Approved');
            else show = true; // Rejected always visible per skeleton logic

            if (show) {
              Stack({ alignContent: Alignment.Start }) {
                // The Pin Dot
                Circle({ width: 24, height: 24 })
                  .fill(pin.color)
                  .position({ x: `${pin.x}%`, y: `${pin.y}%` })
                
                // The Label Card
                Text(pin.title)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1F1F1F')
                  .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                  .backgroundColor('#FFFFFF')
                  .borderRadius(12)
                  .shadow({ radius: 4, color: '#33000000', offsetY: 2 })
                  .position({ x: `${pin.x + 3}%`, y: `${pin.y - 2}%` })
              }
            }
          }, (pin: PinData) => pin.id.toString())

          // Floating Action Button (+)
          Button('+')
            .type(ButtonType.Circle)
            .backgroundColor('#1F1F1F')
            .fontColor('#FFFFFF')
            .fontSize(32)
            .width(64)
            .height(64)
            .margin({ right: 16, bottom: 16 })
            .alignSelf(ItemAlign.End)
            .position({ right: 0, bottom: 0 })
        }
        .width('100%')
        .height(400) // Fixed height to simulate aspect ratio constraint
        .borderRadius(24)
        .border({ width: 1, color: '#D0D0D0' })
        .backgroundColor('#FFFFFF')

        Blank().layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('#F7F7F7')

      // === Top App Bar ===
      Text('Approval Flow')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1F1F1F')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 40, bottom: 20 })

      // === Bottom App Bar ===
      Row({ space: 16 }) {
        Button('Reject')
          .type(ButtonType.Capsule)
          .backgroundColor('#D0D0D0')
          .fontColor('#757575')
          .height(48)
          .layoutWeight(1)
        
        Button('Approve')
          .type(ButtonType.Capsule)
          .backgroundColor('#D0D0D0')
          .fontColor('#757575')
          .height(48)
          .layoutWeight(1)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .alignSelf(ItemAlign.End)
      .margin({ bottom: 20 })
    }
    .width('100%')
    .height('100%')
  }
}

interface PinData {
  id: number;
  title: string;
  status: string;
  x: number;
  y: number;
  color: string;
}