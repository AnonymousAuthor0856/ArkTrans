@Entry
@Component
struct ApprovalFlowApp {
  @State filters: string[] = ['Pending', 'Approved']
  @State activeFilters: string[] = ['Pending']
  @State selectedPinId: number | null = null

  // Data Model
  pins: ApprovalPin[] = [
    { id: 1, title: 'Purchase Order #1042', status: 'Pending', x: 0.18, y: 0.35 },
    { id: 2, title: 'Travel Request #552', status: 'Approved', x: 0.52, y: 0.42 },
    { id: 3, title: 'Contract #A77', status: 'Pending', x: 0.76, y: 0.58 },
    { id: 4, title: 'Budget Change #09', status: 'Rejected', x: 0.33, y: 0.72 }
  ]

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // === Main Content Column ===
      Column() {
        // === Header ===
        Text('Approval Flow')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0A0A0A')
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 12, bottom: 12 })
          .backgroundColor('#FFFFFF')

        // === Scrollable Body ===
        Scroll() {
          Column({ space: 12 }) {
            // === Filter Chips Row ===
            Row({ space: 8 }) {
              ForEach(this.filters, (filter: string) => {
                Button(filter)
                  .type(ButtonType.Normal)
                  .onClick(() => {
                    this.toggleFilter(filter)
                  })
                  .backgroundColor(this.activeFilters.includes(filter) ? '#111111' : '#FFFFFF')
                  .fontColor(this.activeFilters.includes(filter) ? '#FFFFFF' : '#0A0A0A')
                  .borderRadius(8)
                  .border({ width: 1, color: '#D6D6D6' })
                  .height(32)
                  .margin({ top: 12 })
              })
            }
            .width('100%')
            .padding({ left: 16, right: 16 })

            // === Map Area ===
            Stack() {
              // Grid Background
              Column() {
                ForEach(Array.from({ length: 6 }), () => {
                  Divider().color('#EDEDED').margin({ bottom: 1 })
                })
              }
              .layoutWeight(1)
              .width('100%')
              .position({ x: 16, y: 0 })

              Column() {
                ForEach(Array.from({ length: 6 }), () => {
                  Divider().vertical(true).color('#EDEDED').margin({ right: 1 })
                })
              }
              .layoutWeight(1)
              .height('100%')
              .position({ x: 0, y: 16 })

              // Pins
              ForEach(this.pins.filter((p: ApprovalPin) => {
                if (p.status === 'Rejected') return true
                return this.activeFilters.includes(p.status)
              }), (pin: ApprovalPin) => {
                MapPinView({ 
                  pin: pin, 
                  isSelected: this.selectedPinId === pin.id, 
                  onClick: () => {
                    this.selectedPinId = this.selectedPinId === pin.id ? null : pin.id
                  } 
                })
              })

              // Selected Detail Card
              if (this.selectedPinId !== null) {
                let sel = this.pins.find((p: ApprovalPin) => p.id === this.selectedPinId)
                if (sel) {
                  Column() {
                    Blank()
                    Row() {
                      Column({ space: 4 }) {
                        Text(sel.title).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#0A0A0A')
                        Text(sel.status).fontSize(12).fontWeight(FontWeight.Medium).fontColor('#0A0A0A')
                      }
                      .alignItems(HorizontalAlign.Start)

                      Blank()

                      Button('Details')
                        .type(ButtonType.Normal)
                        .backgroundColor('#EDEDED')
                        .fontColor('#0A0A0A')
                        .borderRadius(12)
                        .height(40)
                        .margin({ right: 16 })
                    }
                    .width('100%')
                    .padding(16)
                    .backgroundColor('#FFFFFF')
                    .borderRadius(16)
                    .shadow({ radius: 12, color: '#29000000', offsetY: 6 })
                    .border({ width: 1, color: '#D6D6D6' })
                    .margin(12)
                  }
                  .width('100%')
                  .height('100%')
                }
              }
            }
            .width('100%')
            .height(360)
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .border({ width: 1, color: '#D6D6D6' })
            .padding({ left: 16, right: 16, bottom: 12 })
          }
        }
        .layoutWeight(1)
        .backgroundColor('#F7F7F7')
      }
      .width('100%')
      .height('100%')

      // === Bottom Bar ===
      Column() {
        Row({ space: 12 }) {
          Button('Reject')
            .type(ButtonType.Normal)
            .backgroundColor('#EDEDED')
            .fontColor('#0A0A0A')
            .borderRadius(12)
            .height(48)
            .layoutWeight(1)
            .enabled(this.selectedPinId !== null)

          Button('Approve')
            .type(ButtonType.Normal)
            .backgroundColor('#111111')
            .fontColor('#FFFFFF')
            .borderRadius(12)
            .height(48)
            .layoutWeight(1)
            .enabled(this.selectedPinId !== null)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 8, color: '#24000000', offsetY: -4 })

      // === FAB ===
      Button('+')
        .type(ButtonType.Circle)
        .backgroundColor('#111111')
        .fontColor('#FFFFFF')
        .fontSize(28)
        .width(56)
        .height(56)
        .margin(24)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F7F7')
  }

  toggleFilter(filter: string): void {
    const index = this.activeFilters.indexOf(filter)
    if (index > -1) {
      this.activeFilters.splice(index, 1)
    } else {
      this.activeFilters.push(filter)
    }
  }
}

interface ApprovalPin {
  id: number
  title: string
  status: string
  x: number
  y: number
}

@Component
struct MapPinView {
  @Prop pin: ApprovalPin = {} as ApprovalPin
  @Prop isSelected: boolean = false
  @Prop onClick: () => void = () => {}

  aboutToAppear() {
    // Initialization handled by property defaults or parent passing via constructor-like syntax in newer ArkTS versions
    // In standard ArkTS component model, properties are passed directly in the struct definition or via @Prop/@Link
    // Since we cannot change the interface of MapPinView usage easily without breaking the call site, 
    // we rely on the fact that ArkTS components receive props via the struct instantiation arguments implicitly mapped to fields if defined correctly.
    // However, the error indicates strict initialization. The previous fix using defaults satisfies the compiler.
    // The actual values are passed when instantiating MapPinView({ pin: ..., isSelected: ..., onClick: ... }).
    // Note: In strict ArkTS, you should use @Prop for read-only data from parent.
    // To maintain compatibility with the provided structure and fix compilation errors specifically:
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Circle()
        .fill(this.getStatusColor())
        .width(this.isSelected ? 28 : 22)
        .height(this.isSelected ? 28 : 22)
        .border({ width: 2, color: this.isSelected ? '#111111' : '#FFFFFF' })

      Text(this.pin.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0A0A0A')
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
        .border({ width: 1, color: '#D6D6D6' })
        .position({ x: 18, y: -4 })
    }
    .onClick(() => {
      this.onClick()
    })
    .position({ x: this.pin.x * 100 + '%', y: this.pin.y * 100 + '%' })
  }

  getStatusColor(): ResourceColor {
    switch (this.pin.status) {
      case 'Approved':
        return '#1E7D4C'
      case 'Pending':
        return '#B98400'
      case 'Rejected':
        return '#B3261E'
      default:
        return '#999999'
    }
  }
}