// Design tokens
class AppTokens {
  static Colors = class {
    static primary: string = '#111111'
    static secondary: string = '#2A2A2A'
    static tertiary: string = '#444444'
    static background: string = '#F7F7F7'
    static surface: string = '#FFFFFF'
    static surfaceVariant: string = '#EDEDED'
    static outline: string = '#D6D6D6'
    static success: string = '#1E7D4C'
    static warning: string = '#B98400'
    static error: string = '#B3261E'
    static onPrimary: string = '#FFFFFF'
    static onSecondary: string = '#FFFFFF'
    static onTertiary: string = '#FFFFFF'
    static onBackground: string = '#0A0A0A'
    static onSurface: string = '#0A0A0A'
  }

  static Typography = class {
    static displaySize: number = 28
    static displayWeight: FontWeight = FontWeight.Medium
    static headlineSize: number = 20
    static headlineWeight: FontWeight = FontWeight.Medium
    static titleSize: number = 16
    static titleWeight: FontWeight = FontWeight.Medium
    static bodySize: number = 14
    static bodyWeight: FontWeight = FontWeight.Regular
    static labelSize: number = 12
    static labelWeight: FontWeight = FontWeight.Medium
  }

  static Shapes = class {
    static small: number = 8
    static medium: number = 12
    static large: number = 16
  }

  static Spacing = class {
    static xs: number = 4
    static sm: number = 8
    static md: number = 12
    static lg: number = 16
  }

  static Elevation = class {
    static level1 = { radius: 4, dy: 2, opacity: 0.10 }
    static level2 = { radius: 8, dy: 4, opacity: 0.14 }
    static level3 = { radius: 12, dy: 6, opacity: 0.16 }
  }
}

// Data model
interface ApprovalPin {
  id: number
  title: string
  status: string
  x: number
  y: number
}

// Filter chip component
@Component
struct FilterChip {
  text: string = ''
  isSelected: boolean = false
  onTap: () => void = () => {}

  build() {
    Column() {
      Text(this.text)
        .fontSize(this.isSelected ? AppTokens.Typography.titleSize : AppTokens.Typography.bodySize)
        .fontWeight(this.isSelected ? AppTokens.Typography.titleWeight : AppTokens.Typography.bodyWeight)
        .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        .padding({
          left: AppTokens.Spacing.sm,
          right: AppTokens.Spacing.sm,
          top: AppTokens.Spacing.xs,
          bottom: AppTokens.Spacing.xs
        })
    }
    .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.small
    })
    .onClick(() => {
      this.onTap()
    })
  }
}

// Map pin component
@Component
struct MapPin {
  pin: ApprovalPin = { id: 0, title: '', status: '', x: 0, y: 0 }
  selected: boolean = false
  onClick: () => void = () => {}

  private getPinSize(): number {
    return this.selected ? 28 : 22
  }

  private getBaseColor(): ResourceColor {
    switch (this.pin.status) {
      case 'Approved':
        return AppTokens.Colors.success
      case 'Pending':
        return AppTokens.Colors.warning
      case 'Rejected':
        return AppTokens.Colors.error
      default:
        return '#888888'
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Pin circle
      Circle({ width: this.getPinSize(), height: this.getPinSize() })
        .fill(this.getBaseColor())
        .stroke(this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
        .strokeWidth(2)

      // Info card next to pin
      Column() {
        Text(this.pin.title)
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(AppTokens.Typography.labelWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({
            left: AppTokens.Spacing.sm,
            right: AppTokens.Spacing.sm,
            top: AppTokens.Spacing.xs,
            bottom: AppTokens.Spacing.xs
          })
      }
      .backgroundColor(AppTokens.Colors.surface)
      .border({
        width: 1,
        color: AppTokens.Colors.outline,
        radius: AppTokens.Shapes.small
      })
      .shadow({
        radius: AppTokens.Elevation.level1.radius,
        color: `rgba(0, 0, 0, ${AppTokens.Elevation.level1.opacity})`,
        offsetX: 0,
        offsetY: AppTokens.Elevation.level1.dy
      })
      .margin({ left: 18, top: -4 })
      .onClick(() => {
        this.onClick()
      })
    }
  }
}

// Map grid overlay component
@Component
struct MapGridOverlay {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Horizontal grid lines
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], (_item: number, index: number) => {
          Blank()
          Column()
            .width('100%')
            .height(1)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
        }, (_item: number, index: number) => index.toString())
        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

      // Vertical grid lines
      Row() {
        ForEach([0, 1, 2, 3, 4, 5], (_item: number, index: number) => {
          Blank()
          Column()
            .width(1)
            .height('100%')
            .backgroundColor(AppTokens.Colors.surfaceVariant)
        }, (_item: number, index: number) => index.toString())
        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
    }
  }
}

// Main entry
@Entry
@Component
struct ApprovalFlowApp {
  @State filters: string[] = ['Pending', 'Approved']
  @State activeFilters: string[] = ['Pending']
  @State pins: ApprovalPin[] = [
    { id: 1, title: 'Purchase Order #1042', status: 'Pending', x: 0.18, y: 0.35 },
    { id: 2, title: 'Travel Request #552', status: 'Approved', x: 0.52, y: 0.42 },
    { id: 3, title: 'Contract #A77', status: 'Pending', x: 0.76, y: 0.58 },
    { id: 4, title: 'Budget Change #09', status: 'Rejected', x: 0.33, y: 0.72 }
  ]
  @State selectedPinId: number = 0
  @State hasSelection: boolean = false
  @State mapWidth: number = 0
  @State mapHeight: number = 0

  private shouldShowPin(pin: ApprovalPin): boolean {
    switch (pin.status) {
      case 'Pending':
        return this.activeFilters.indexOf('Pending') >= 0
      case 'Approved':
        return this.activeFilters.indexOf('Approved') >= 0
      case 'Rejected':
        return true
      default:
        return true
    }
  }

  private getSelectedPin(): ApprovalPin | null {
    if (!this.hasSelection) {
      return null
    }
    for (let i = 0; i < this.pins.length; i++) {
      if (this.pins[i].id === this.selectedPinId) {
        return this.pins[i]
      }
    }
    return null
  }

  private togglePinSelection(pinId: number): void {
    if (this.hasSelection && this.selectedPinId === pinId) {
      this.hasSelection = false
      this.selectedPinId = 0
    } else {
      this.hasSelection = true
      this.selectedPinId = pinId
    }
  }

  @Builder
  PinItemBuilder(pin: ApprovalPin) {
    MapPin({
      pin: pin,
      selected: this.hasSelection && this.selectedPinId === pin.id,
      onClick: () => {
        this.togglePinSelection(pin.id)
      }
    })
    .position({
      x: this.mapWidth * pin.x,
      y: this.mapHeight * pin.y
    })
  }

  @Builder
  DetailCardBuilder() {
    let selected: ApprovalPin | null = this.getSelectedPin()
    if (selected !== null) {
      let s: ApprovalPin = selected as ApprovalPin
      Row() {
        Column() {
          Text(s.title)
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(AppTokens.Typography.titleWeight)
            .fontColor(AppTokens.Colors.onSurface)
          Text(s.status)
            .fontSize(AppTokens.Typography.labelSize)
            .fontWeight(AppTokens.Typography.labelWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.xs })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button('Details')
          .fontSize(AppTokens.Typography.labelSize)
          .fontColor(AppTokens.Colors.onSurface)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
          .height(40)
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
          .onClick(() => {})
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .border({
        width: 1,
        color: AppTokens.Colors.outline,
        radius: AppTokens.Shapes.large
      })
      .shadow({
        radius: AppTokens.Elevation.level3.radius,
        color: `rgba(0, 0, 0, ${AppTokens.Elevation.level3.opacity})`,
        offsetX: 0,
        offsetY: AppTokens.Elevation.level3.dy
      })
      .margin(AppTokens.Spacing.md)
    }
  }

  @Builder
  MapContentBuilder() {
    Stack({ alignContent: Alignment.TopStart }) {
      MapGridOverlay()

      ForEach(this.pins.filter((p: ApprovalPin) => this.shouldShowPin(p)),
        (pin: ApprovalPin) => {
          this.PinItemBuilder(pin)
        },
        (pin: ApprovalPin) => pin.id.toString()
      )

      if (this.hasSelection) {
        Column() {
          Blank()
          this.DetailCardBuilder()
        }
        .width('100%')
        .height('100%')
      }
    }
    .width('100%')
    .height('100%')
    .onAreaChange((_oldValue: Area, newValue: Area) => {
      this.mapWidth = Number(newValue.width)
      this.mapHeight = Number(newValue.height)
    })
  }

  @Builder
  FilterChipBuilder(filter: string) {
    FilterChip({
      text: filter,
      isSelected: this.activeFilters.indexOf(filter) >= 0,
      onTap: () => {
        let idx: number = this.activeFilters.indexOf(filter)
        if (idx >= 0) {
          this.activeFilters.splice(idx, 1)
        } else {
          this.activeFilters.push(filter)
        }
      }
    })
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column() { }
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main column: top bar + scrollable content + bottom bar
      Column() {
        // Top bar
        Column() {
          Text('Approval Flow')
            .fontSize(AppTokens.Typography.displaySize)
            .fontWeight(AppTokens.Typography.displayWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(AppTokens.Colors.surface)

        // Scrollable content area
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            // Filter chips horizontal scroll
            Scroll() {
              Row({ space: AppTokens.Spacing.sm }) {
                ForEach(this.filters, (filter: string) => {
                  this.FilterChipBuilder(filter)
                }, (filter: string) => filter)
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .margin({ top: AppTokens.Spacing.md })

            // Map area
            Stack({ alignContent: Alignment.TopStart }) {
              this.MapContentBuilder()
            }
            .width('100%')
            .backgroundColor(AppTokens.Colors.surface)
            .border({
              width: 1,
              color: AppTokens.Colors.outline,
              radius: AppTokens.Shapes.large
            })
            .aspectRatio(0.9)
            .margin({
              left: AppTokens.Spacing.lg,
              right: AppTokens.Spacing.lg,
              bottom: AppTokens.Spacing.md
            })
          }
          .width('100%')
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .flexGrow(1)
        .width('100%')

        // Bottom bar
        Column() {
          Row({ space: AppTokens.Spacing.md }) {
            Button('Reject')
              .fontSize(AppTokens.Typography.titleSize)
              .fontWeight(AppTokens.Typography.titleWeight)
              .fontColor(this.hasSelection ? AppTokens.Colors.onSurface : '#999999')
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .height(48)
              .flexGrow(1)
              .enabled(this.hasSelection)
              .onClick(() => {})

            Button('Approve')
              .fontSize(AppTokens.Typography.titleSize)
              .fontWeight(AppTokens.Typography.titleWeight)
              .fontColor(this.hasSelection ? AppTokens.Colors.onPrimary : '#999999')
              .backgroundColor(this.hasSelection ? AppTokens.Colors.primary : '#CCCCCC')
              .borderRadius(AppTokens.Shapes.medium)
              .height(48)
              .flexGrow(1)
              .enabled(this.hasSelection)
              .onClick(() => {})
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            top: AppTokens.Spacing.md,
            bottom: AppTokens.Spacing.md
          })
        }
        .width('100%')
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.Elevation.level2.radius,
          color: `rgba(0, 0, 0, ${AppTokens.Elevation.level2.opacity})`,
          offsetX: 0,
          offsetY: -AppTokens.Elevation.level2.dy
        })
      }
      .width('100%')
      .height('100%')

      // Floating Action Button
      Button('+')
        .fontSize(AppTokens.Typography.headlineSize)
        .fontWeight(AppTokens.Typography.headlineWeight)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(28)
        .width(56)
        .height(56)
        .margin(AppTokens.Spacing.lg)
        .align(Alignment.BottomEnd)
        .onClick(() => {})
    }
    .width('100%')
    .height('100%')
  }
}
