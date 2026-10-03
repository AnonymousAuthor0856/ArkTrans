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

// Reusable components

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
        .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm,
                   top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
    }
    .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.small })
    .onClick(() => {
      this.onTap()
    })
  }
}

@Component
struct CardView {
  @BuilderParam contentBuilder: () => void
  elevation: { radius: number, dy: number, opacity: number } = AppTokens.Elevation.level1
  cornerRadius: number = AppTokens.Shapes.small
  hasBorder: boolean = true
  borderWidth: number = 1
  borderColor: string = AppTokens.Colors.outline
  onClick: () => void = () => {}
  hasOnClick: boolean = false

  build() {
    Column() {
      this.contentBuilder()
    }
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(this.cornerRadius)
    .shadow({
      radius: this.elevation.radius,
      color: `rgba(0, 0, 0, ${this.elevation.opacity})`,
      offsetX: 0,
      offsetY: this.elevation.dy
    })
    .border(this.hasBorder ? {
      width: this.borderWidth,
      color: this.borderColor,
      radius: this.cornerRadius
    } : undefined)
    .onClick(() => {
      if (this.hasOnClick) {
        this.onClick()
      }
    })
  }
}

@Component
struct MapPin {
  pin: ApprovalPin = { id: 0, title: '', status: '', x: 0, y: 0 }
  selected: boolean = false
  onClick: () => void = () => {}

  private getPinSize(): number {
    return this.selected ? 28 : 22
  }

  private getBaseColor(): string {
    switch (this.pin.status) {
      case 'Approved': return AppTokens.Colors.success
      case 'Pending': return AppTokens.Colors.warning
      case 'Rejected': return AppTokens.Colors.error
      default: return '#888888'
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Pin circle
      Circle()
        .width(this.getPinSize())
        .height(this.getPinSize())
        .fill(this.getBaseColor())
        .stroke(this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface, 2)

      // Info card
      Row() {
        Text(this.pin.title)
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(AppTokens.Typography.labelWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm,
                     top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
      }
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.small })
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

@Component
struct MapGridOverlay {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Horizontal grid lines
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], (_item: number, index: number) => {
          Blank()
          Rect()
            .width('100%')
            .height(1)
            .fill(AppTokens.Colors.surfaceVariant)
        })
        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

      // Vertical grid lines
      Row() {
        ForEach([0, 1, 2, 3, 4, 5], (_item: number, index: number) => {
          Blank()
          Rect()
            .width(1)
            .height('100%')
            .fill(AppTokens.Colors.surfaceVariant)
        })
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
  @State selectedPinId: number | null = null
  @State mapWidth: number = 0
  @State mapHeight: number = 0

  private shouldShowPin(pin: ApprovalPin): boolean {
    switch (pin.status) {
      case 'Pending': return this.activeFilters.indexOf('Pending') >= 0
      case 'Approved': return this.activeFilters.indexOf('Approved') >= 0
      case 'Rejected': return true
      default: return true
    }
  }

  private getSelectedPin(): ApprovalPin | null {
    if (this.selectedPinId === null) return null
    for (let i = 0; i < this.pins.length; i++) {
      if (this.pins[i].id === this.selectedPinId) {
        return this.pins[i]
      }
    }
    return null
  }

  @Builder
  PinContentBuilder(pin: ApprovalPin) {
    MapPin({
      pin: pin,
      selected: this.selectedPinId === pin.id,
      onClick: () => {
        this.selectedPinId = (this.selectedPinId === pin.id) ? null : pin.id
      }
    })
    .position({
      x: this.mapWidth * pin.x,
      y: this.mapHeight * pin.y
    })
  }

  @Builder
  MapContentBuilder() {
    Stack({ alignContent: Alignment.TopStart }) {
      MapGridOverlay()

      ForEach(this.pins.filter(p => this.shouldShowPin(p)), (pin: ApprovalPin) => {
        this.PinContentBuilder(pin)
      }, (pin: ApprovalPin) => pin.id.toString())

      if (this.getSelectedPin() !== null) {
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
      this.mapWidth = newValue.width as number
      this.mapHeight = newValue.height as number
    })
  }

  @Builder
  DetailCardBuilder() {
    let selected = this.getSelectedPin()
    if (selected !== null) {
      Row() {
        Column() {
          Text(selected.title)
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(AppTokens.Typography.titleWeight)
            .fontColor(AppTokens.Colors.onSurface)
          Text(selected.status)
            .fontSize(AppTokens.Typography.labelSize)
            .fontWeight(AppTokens.Typography.labelWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.xs })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Row() {
          Button('Details')
            .fontSize(AppTokens.Typography.labelSize)
            .fontColor(AppTokens.Colors.onSurface)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .height(40)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
        }
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large })
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
  FilterChipBuilder(filter: string) {
    FilterChip({
      text: filter,
      isSelected: this.activeFilters.indexOf(filter) >= 0,
      onTap: () => {
        let idx = this.activeFilters.indexOf(filter)
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

      // Main column
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

        // Scrollable content
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            // Filter chips row
            Scroll() {
              Row({ space: AppTokens.Spacing.sm }) {
                ForEach(this.filters, (filter: string) => {
                  this.FilterChipBuilder(filter)
                }, (filter: string) => filter)
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .margin({ top: AppTokens.Spacing.md })

            // Map area
            Column() {
              this.MapContentBuilder()
            }
            .width('100%')
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large })
            .aspectRatio(0.9)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .margin({ bottom: AppTokens.Spacing.md })
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
              .fontColor(this.selectedPinId === null ? '#999999' : AppTokens.Colors.onSurface)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .height(48)
              .flexGrow(1)
              .enabled(this.selectedPinId !== null)
              .onClick(() => {})

            Button('Approve')
              .fontSize(AppTokens.Typography.titleSize)
              .fontWeight(AppTokens.Typography.titleWeight)
              .fontColor(this.selectedPinId === null ? '#999999' : AppTokens.Colors.onPrimary)
              .backgroundColor(this.selectedPinId === null ? '#AAAAAA' : AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.medium)
              .height(48)
              .flexGrow(1)
              .enabled(this.selectedPinId !== null)
              .onClick(() => {})
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg,
                     top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
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
        .position({
          x: this.mapWidth > 0 ? 0 : 0, // placeholder, we'll use align
          y: 0
        })
        .margin(AppTokens.Spacing.lg)
        .align(Alignment.BottomEnd)
        .onClick(() => {})
    }
    .width('100%')
    .height('100%')
  }
}
