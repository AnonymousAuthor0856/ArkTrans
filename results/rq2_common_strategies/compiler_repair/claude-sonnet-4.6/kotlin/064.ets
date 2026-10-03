import { router } from '@kit.ArkUI'

class ApprovalPin {
  id: number = 0
  title: string = ''
  status: string = ''
  x: number = 0
  y: number = 0
}

const Colors = {
  primary: '#FF111111',
  secondary: '#FF2A2A2A',
  tertiary: '#FF444444',
  background: '#FFF7F7F7',
  surface: '#FFFFFFFF',
  surfaceVariant: '#FFEDEDED',
  outline: '#FFD6D6D6',
  success: '#FF1E7D4C',
  warning: '#FFB98400',
  error: '#FFB3261E',
  onPrimary: '#FFFFFFFF',
  onSecondary: '#FFFFFFFF',
  onTertiary: '#FFFFFFFF',
  onBackground: '#FF0A0A0A',
  onSurface: '#FF0A0A0A',
}

const pins: ApprovalPin[] = [
  { id: 1, title: 'Purchase Order #1042', status: 'Pending', x: 0.18, y: 0.35 },
  { id: 2, title: 'Travel Request #552', status: 'Approved', x: 0.52, y: 0.42 },
  { id: 3, title: 'Contract #A77', status: 'Pending', x: 0.76, y: 0.58 },
  { id: 4, title: 'Budget Change #09', status: 'Rejected', x: 0.33, y: 0.72 },
]

@Component
struct MapPin {
  title: string = ''
  status: string = ''
  selected: boolean = false
  onPinClick: () => void = () => {}
  offsetX: number = 0
  offsetY: number = 0

  build() {
    Stack() {
      Circle()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .fill(this.status === 'Approved' ? Colors.success : this.status === 'Pending' ? Colors.warning : Colors.error)
        .stroke(this.selected ? Colors.primary : Colors.surface)
        .strokeWidth(2)

      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)
        .backgroundColor(Colors.surface)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .borderRadius(8)
        .border({ width: 1, color: Colors.outline })
        .shadow({ radius: 4, offsetY: 2, color: '#1A000000' })
        .offset({ x: 18, y: -4 })
        .onClick(() => {
          this.onPinClick()
        })
    }
    .alignContent(Alignment.TopStart)
    .position({ x: this.offsetX, y: this.offsetY })
  }
}

@Entry
@Component
struct Index {
  @State filters: string[] = ['Pending', 'Approved']
  @State activeFilters: string[] = ['Pending']
  @State selectedId: number = -1
  @State mapWidth: number = 0
  @State mapHeight: number = 0

  isActive(f: string): boolean {
    return this.activeFilters.indexOf(f) >= 0
  }

  toggleFilter(f: string): void {
    const idx = this.activeFilters.indexOf(f)
    if (idx >= 0) {
      this.activeFilters = this.activeFilters.filter(item => item !== f)
    } else {
      this.activeFilters = [...this.activeFilters, f]
    }
  }

  getFilteredPins(): ApprovalPin[] {
    return pins.filter(p => {
      if (p.status === 'Pending') return this.activeFilters.indexOf('Pending') >= 0
      if (p.status === 'Approved') return this.activeFilters.indexOf('Approved') >= 0
      return true
    })
  }

  getSelectedPin(): ApprovalPin | null {
    if (this.selectedId === -1) return null
    const found = pins.filter(p => p.id === this.selectedId)
    return found.length > 0 ? found[0] : null
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Approval Flow')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Colors.surface)
      .border({ width: { bottom: 1 }, color: Colors.outline })

      // Content
      Column({ space: 12 }) {
        // Filter chips
        Scroll() {
          Row({ space: 8 }) {
            ForEach(this.filters, (f: string) => {
              Text(f)
                .fontSize(this.isActive(f) ? 16 : 14)
                .fontWeight(this.isActive(f) ? FontWeight.Medium : FontWeight.Normal)
                .fontColor(this.isActive(f) ? Colors.onPrimary : Colors.onSurface)
                .backgroundColor(this.isActive(f) ? Colors.primary : Colors.surface)
                .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                .borderRadius(8)
                .border({ width: 1, color: Colors.outline })
                .onClick(() => {
                  this.toggleFilter(f)
                })
            })
          }
          .padding({ left: 0, right: 0 })
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')

        // Map area
        Stack() {
          // Grid overlay - horizontal lines
          Column() {
            ForEach([0, 1, 2, 3, 4, 5], (_: number) => {
              Divider()
                .color(Colors.surfaceVariant)
                .strokeWidth(1)
            })
          }
          .width('100%')
          .height('100%')
          .padding(16)
          .justifyContent(FlexAlign.SpaceEvenly)

          // Grid overlay - vertical lines
          Row() {
            ForEach([0, 1, 2, 3, 4, 5], (_: number) => {
              Divider()
                .vertical(true)
                .color(Colors.surfaceVariant)
                .strokeWidth(1)
                .height('100%')
            })
          }
          .width('100%')
          .height('100%')
          .padding(16)
          .justifyContent(FlexAlign.SpaceEvenly)

          // Pins
          ForEach(this.getFilteredPins(), (p: ApprovalPin) => {
            MapPin({
              title: p.title,
              status: p.status,
              selected: this.selectedId === p.id,
              onPinClick: () => {
                this.selectedId = this.selectedId === p.id ? -1 : p.id
              },
              offsetX: 320 * p.x,
              offsetY: 356 * p.y,
            })
          })

          // Selected pin detail card
          if (this.selectedId !== -1 && this.getSelectedPin() !== null) {
            Row() {
              Column({ space: 4 }) {
                Text(this.getSelectedPin()!.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                Text(this.getSelectedPin()!.status)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Text('Details')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
                .backgroundColor(Colors.surfaceVariant)
                .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                .borderRadius(12)
                .border({ width: 1, color: Colors.outline })
            }
            .width('100%')
            .padding(16)
            .backgroundColor(Colors.surface)
            .borderRadius(16)
            .border({ width: 1, color: Colors.outline })
            .shadow({ radius: 12, offsetY: 6, color: '#29000000' })
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .position({ x: 0, y: 0 })
            .markAnchor({ x: 0, y: 0 })
            .offset({ x: 12, y: 300 })
          }
        }
        .width('100%')
        .height(400)
        .backgroundColor(Colors.surface)
        .borderRadius(16)
        .border({ width: 1, color: Colors.outline })
        .clip(true)
      }
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .layoutWeight(1)

      // Bottom bar
      Row({ space: 12 }) {
        Text('Reject')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .backgroundColor(this.selectedId !== -1 ? Colors.surfaceVariant : '#FFD0D0D0')
          .height(48)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .borderRadius(12)
          .onClick(() => {})

        Text('Approve')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
          .backgroundColor(this.selectedId !== -1 ? Colors.primary : '#FF888888')
          .height(48)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .borderRadius(12)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(Colors.surface)
      .border({ width: { top: 1 }, color: Colors.outline })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}