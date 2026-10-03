@Entry
@Component
struct ApprovalFlowApp {
  @State activeFilters: string[] = ['Pending']
  @State selectedPinId: number | null = null
  private readonly filters: string[] = ['Pending', 'Approved']
  private readonly pins: ApprovalPin[] = [
    { id: 1, title: 'Purchase Order #1042', status: 'Pending', x: 0.18, y: 0.35 },
    { id: 2, title: 'Travel Request #552', status: 'Approved', x: 0.52, y: 0.42 },
    { id: 3, title: 'Contract #A77', status: 'Pending', x: 0.76, y: 0.58 },
    { id: 4, title: 'Budget Change #09', status: 'Rejected', x: 0.33, y: 0.72 }
  ]

  private getFilteredPins(): ApprovalPin[] {
    return this.pins.filter(p => {
      if (p.status === 'Rejected') return true
      return this.activeFilters.includes(p.status)
    })
  }

  private getSelectedPin(): ApprovalPin | null {
    if (this.selectedPinId === null) return null
    return this.pins.find(p => p.id === this.selectedPinId) || null
  }

  private getStatusColor(status: string): string {
    switch (status) {
      case 'Approved': return '#1E7D4C'
      case 'Pending': return '#B98400'
      case 'Rejected': return '#B3261E'
      default: return '#888888'
    }
  }

  @Builder
  buildDetailCard(pin: ApprovalPin): void {
    Column() {
      Row({ space: 0 }) {
        Column({ space: 4 }) {
          Text(pin.title)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#0A0A0A')
          Text(pin.status)
            .fontSize(12)
            .foregroundColor('#0A0A0A')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Row({ space: 8 }) {
          Button() {
            Text('Details')
              .fontSize(12)
              .foregroundColor('#0A0A0A')
              .padding({ left: 12, right: 12 })
              .height(40)
              .textAlign(TextAlign.Center)
          }
          .height(40)
          .backgroundColor('#EDEDED')
          .borderRadius(12)
        }
      }
      .padding(16)
      .width('100%')
    }
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#D6D6D6' })
    .shadow({ radius: 12, color: '#29000000', offsetX: 0, offsetY: 6 })
    .padding(12)
    .position({ x: 0, y: 320 })
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F7F7F7')

      Column({ space: 0 }) {
        // Top bar
        Row({ space: 0 }) {
          Text('Approval Flow')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .foregroundColor('#0A0A0A')
            .width('100%')
            .textAlign(TextAlign.Center)
            .padding({ top: 12, bottom: 12 })
        }
        .width('100%')
        .backgroundColor('#FFFFFF')

        Column({ space: 12 }) {
          // Filter chips row
          Row({ space: 8 }) {
            ForEach(this.filters, (filter: string) => {
              Button() {
                Text(filter)
                  .fontSize(this.activeFilters.includes(filter) ? 16 : 14)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor(this.activeFilters.includes(filter) ? '#FFFFFF' : '#0A0A0A')
                  .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                  .textAlign(TextAlign.Center)
              }
              .backgroundColor(this.activeFilters.includes(filter) ? '#111111' : '#FFFFFF')
              .borderRadius(8)
              .border({ width: 1, color: '#D6D6D6' })
              .onClick(() => {
                if (this.activeFilters.includes(filter)) {
                  this.activeFilters = this.activeFilters.filter(f => f !== filter)
                } else {
                  this.activeFilters = [...this.activeFilters, filter]
                }
              })
            })
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 12 })

          // Map area
          Stack({ alignContent: Alignment.TopStart }) {
            Column()
              .width('100%')
              .height(400)
              .backgroundColor('#FFFFFF')
              .borderRadius(16)
              .border({ width: 1, color: '#D6D6D6' })

            // Horizontal grid lines
            Divider().width('100%').height(1).color('#EDEDED').position({ x: 0, y: 80 })
            Divider().width('100%').height(1).color('#EDEDED').position({ x: 0, y: 160 })
            Divider().width('100%').height(1).color('#EDEDED').position({ x: 0, y: 240 })

            // Vertical grid lines
            Divider().width(1).height('100%').color('#EDEDED').position({ x: 100, y: 0 })
            Divider().width(1).height('100%').color('#EDEDED').position({ x: 200, y: 0 })

            // Pins and info cards
            ForEach(this.getFilteredPins(), (pin: ApprovalPin) => {
              // Pin circle
              Column()
                .width(this.selectedPinId === pin.id ? 28 : 22)
                .height(this.selectedPinId === pin.id ? 28 : 22)
                .borderRadius(this.selectedPinId === pin.id ? 14 : 11)
                .backgroundColor(this.getStatusColor(pin.status))
                .border({ width: 2, color: this.selectedPinId === pin.id ? '#111111' : '#FFFFFF' })
                .position({ x: 360 * pin.x, y: 400 * pin.y })
                .onClick(() => {
                  this.selectedPinId = this.selectedPinId === pin.id ? null : pin.id
                })

              // Pin info card when selected
              if (this.selectedPinId === pin.id) {
                Column() {
                  Text(pin.title)
                    .fontSize(12)
                    .foregroundColor('#0A0A0A')
                    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                }
                .backgroundColor('#FFFFFF')
                .borderRadius(8)
                .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
                .position({ x: 360 * pin.x + 18, y: 400 * pin.y - 4 })
              }
            })

            // Detail card at bottom when a pin is selected
            if (this.selectedPinId !== null) {
              let selPin = this.getSelectedPin()
              if (selPin) {
                this.buildDetailCard(selPin)
              }
            }
          }
          .width('100%')
          .height(400)
          .padding({ left: 16, right: 16, bottom: 12 })
        }
        .layoutWeight(1)

        // Bottom bar
        Row({ space: 12 }) {
          Button() {
            Text('Reject')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .foregroundColor(this.selectedPinId !== null ? '#0A0A0A' : '#B0B0B0')
              .width('100%')
              .height(48)
              .textAlign(TextAlign.Center)
          }
          .layoutWeight(1)
          .height(48)
          .backgroundColor('#EDEDED')
          .borderRadius(12)
          .enabled(this.selectedPinId !== null)

          Button() {
            Text('Approve')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .foregroundColor(this.selectedPinId !== null ? '#FFFFFF' : '#FFFFFF80')
              .width('100%')
              .height(48)
              .textAlign(TextAlign.Center)
          }
          .layoutWeight(1)
          .height(48)
          .backgroundColor('#111111')
          .borderRadius(12)
          .enabled(this.selectedPinId !== null)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 8, color: '#24000000', offsetY: 4 })
      }
      .width('100%')
      .height('100%')

      // FAB
      Button() {
        Text('+')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#FFFFFF')
          .textAlign(TextAlign.Center)
          .width(56)
          .height(56)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor('#111111')
      .position({ x: '100%', y: '100%' })
      .margin({ right: 16, bottom: 16 })
    }
    .width('100%')
    .height('100%')
  }
}

interface ApprovalPin {
  id: number
  title: string
  status: string
  x: number
  y: number
}