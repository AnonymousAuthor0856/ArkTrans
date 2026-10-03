// Shadow spec interface
interface ShadowSpec {
  radius: number
  dy: number
  color: string
}

// Design tokens - Colors
class AppColors {
  static readonly primary: string = '#111111'
  static readonly secondary: string = '#2A2A2A'
  static readonly tertiary: string = '#444444'
  static readonly background: string = '#F7F7F7'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#EDEDED'
  static readonly outline: string = '#D6D6D6'
  static readonly success: string = '#1E7D4C'
  static readonly warning: string = '#B98400'
  static readonly error: string = '#B3261E'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#FFFFFF'
  static readonly onBackground: string = '#0A0A0A'
  static readonly onSurface: string = '#0A0A0A'
}

// Design tokens - Typography
class AppTypography {
  static readonly displaySize: number = 28
  static readonly displayWeight: FontWeight = FontWeight.Medium
  static readonly headlineSize: number = 20
  static readonly headlineWeight: FontWeight = FontWeight.Medium
  static readonly titleSize: number = 16
  static readonly titleWeight: FontWeight = FontWeight.Medium
  static readonly bodySize: number = 14
  static readonly bodyWeight: FontWeight = FontWeight.Regular
  static readonly labelSize: number = 12
  static readonly labelWeight: FontWeight = FontWeight.Medium
}

// Design tokens - Shapes
class AppShapes {
  static readonly small: number = 8
  static readonly medium: number = 12
  static readonly large: number = 16
}

// Design tokens - Spacing
class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
}

// Design tokens - Elevation
class AppElevation {
  static readonly level1: ShadowSpec = { radius: 4, dy: 2, color: '#1A000000' }
  static readonly level2: ShadowSpec = { radius: 8, dy: 4, color: '#24000000' }
  static readonly level3: ShadowSpec = { radius: 12, dy: 6, color: '#29000000' }
}

// Data model
interface ApprovalPin {
  id: number
  title: string
  status: string
  x: number
  y: number
}

// Grid indices
const GRID_INDICES: number[] = [0, 1, 2, 3, 4, 5]

// Filter chip component
@Component
struct FilterChip {
  text: string = ''
  isSelected: boolean = false
  onTap: () => void = () => {}

  build() {
    Column() {
      Text(this.text)
        .fontSize(this.isSelected ? AppTypography.titleSize : AppTypography.bodySize)
        .fontWeight(this.isSelected ? AppTypography.titleWeight : AppTypography.bodyWeight)
        .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
        .padding({
          left: AppSpacing.sm,
          right: AppSpacing.sm,
          top: AppSpacing.xs,
          bottom: AppSpacing.xs
        })
    }
    .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surface)
    .border({ width: 1, color: AppColors.outline })
    .borderRadius(AppShapes.small)
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
  onPinClick: () => void = () => {}

  private getPinSize(): number {
    return this.selected ? 28 : 22
  }

  private getBaseColor(): string {
    if (this.pin.status === 'Approved') {
      return AppColors.success
    } else if (this.pin.status === 'Pending') {
      return AppColors.warning
    } else if (this.pin.status === 'Rejected') {
      return AppColors.error
    } else {
      return '#888888'
    }
  }

  private getStrokeColor(): string {
    if (this.selected) {
      return AppColors.primary
    } else {
      return AppColors.surface
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Pin circle using Column + borderRadius
      Column() { }
        .width(this.getPinSize())
        .height(this.getPinSize())
        .backgroundColor(this.getBaseColor())
        .border({ width: 2, color: this.getStrokeColor() })
        .borderRadius(this.getPinSize() / 2)

      // Info card next to pin
      Column() {
        Text(this.pin.title)
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.onSurface)
          .padding({
            left: AppSpacing.sm,
            right: AppSpacing.sm,
            top: AppSpacing.xs,
            bottom: AppSpacing.xs
          })
      }
      .backgroundColor(AppColors.surface)
      .border({ width: 1, color: AppColors.outline })
      .borderRadius(AppShapes.small)
      .shadow({
        radius: AppElevation.level1.radius,
        color: AppElevation.level1.color,
        offsetX: 0,
        offsetY: AppElevation.level1.dy
      })
      .margin({ left: 18, top: -4 })
      .onClick(() => {
        this.onPinClick()
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
        ForEach(GRID_INDICES, (_item: number, index: number) => {
          Blank()
          Column()
            .width('100%')
            .height(1)
            .backgroundColor(AppColors.surfaceVariant)
        }, (_item: number, index: number) => index.toString())
        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

      // Vertical grid lines
      Row() {
        ForEach(GRID_INDICES, (_item: number, index: number) => {
          Blank()
          Column()
            .width(1)
            .height('100%')
            .backgroundColor(AppColors.surfaceVariant)
        }, (_item: number, index: number) => index.toString())
        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
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
  @State visiblePins: ApprovalPin[] = [
    { id: 1, title: 'Purchase Order #1042', status: 'Pending', x: 0.18, y: 0.35 },
    { id: 3, title: 'Contract #A77', status: 'Pending', x: 0.76, y: 0.58 },
    { id: 4, title: 'Budget Change #09', status: 'Rejected', x: 0.33, y: 0.72 }
  ]
  @State selectedPinId: number = 0
  @State hasSelection: boolean = false
  @State selectedTitle: string = ''
  @State selectedStatus: string = ''
  @State mapWidth: number = 0
  @State mapHeight: number = 0

  private updateVisiblePins(): void {
    let result: ApprovalPin[] = []
    for (let i = 0; i < this.pins.length; i++) {
      let pin: ApprovalPin = this.pins[i]
      let show: boolean = false
      if (pin.status === 'Pending') {
        show = this.activeFilters.indexOf('Pending') >= 0
      } else if (pin.status === 'Approved') {
        show = this.activeFilters.indexOf('Approved') >= 0
      } else {
        show = true
      }
      if (show) {
        result.push(pin)
      }
    }
    this.visiblePins = result
  }

  private toggleFilter(filter: string): void {
    let idx: number = this.activeFilters.indexOf(filter)
    if (idx >= 0) {
      this.activeFilters.splice(idx, 1)
    } else {
      this.activeFilters.push(filter)
    }
    this.updateVisiblePins()
  }

  private togglePinSelection(pinId: number): void {
    if (this.hasSelection && this.selectedPinId === pinId) {
      this.hasSelection = false
      this.selectedPinId = 0
      this.selectedTitle = ''
      this.selectedStatus = ''
    } else {
      this.hasSelection = true
      this.selectedPinId = pinId
      for (let i = 0; i < this.pins.length; i++) {
        if (this.pins[i].id === pinId) {
          this.selectedTitle = this.pins[i].title
          this.selectedStatus = this.pins[i].status
          break
        }
      }
    }
  }

  @Builder
  PinItemBuilder(pin: ApprovalPin) {
    MapPin({
      pin: pin,
      selected: this.hasSelection && this.selectedPinId === pin.id,
      onPinClick: () => {
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
    Row() {
      Column() {
        Text(this.selectedTitle)
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.onSurface)
        Text(this.selectedStatus)
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.onSurface)
          .margin({ top: AppSpacing.xs })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button('Details')
        .fontSize(AppTypography.labelSize)
        .fontColor(AppColors.onSurface)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)
        .height(40)
        .padding({ left: AppSpacing.md, right: AppSpacing.md })
        .onClick(() => {})
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline })
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevation.level3.radius,
      color: AppElevation.level3.color,
      offsetX: 0,
      offsetY: AppElevation.level3.dy
    })
    .margin(AppSpacing.md)
  }

  @Builder
  MapContentBuilder() {
    Stack({ alignContent: Alignment.TopStart }) {
      MapGridOverlay()

      ForEach(this.visiblePins, (pin: ApprovalPin) => {
        this.PinItemBuilder(pin)
      }, (pin: ApprovalPin) => pin.id.toString())

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
    .onSizeChange((_oldValue: SizeOptions, newValue: SizeOptions) => {
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
        this.toggleFilter(filter)
      }
    })
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column() { }
        .width('100%')
        .height('100%')
        .backgroundColor(AppColors.background)

      // Main column: top bar + scrollable content + bottom bar
      Column() {
        // Top bar
        Column() {
          Text('Approval Flow')
            .fontSize(AppTypography.displaySize)
            .fontWeight(AppTypography.displayWeight)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
        .backgroundColor(AppColors.surface)

        // Scrollable content area
        Scroll() {
          Column({ space: AppSpacing.md }) {
            // Filter chips horizontal scroll
            Scroll() {
              Row({ space: AppSpacing.sm }) {
                ForEach(this.filters, (filter: string) => {
                  this.FilterChipBuilder(filter)
                }, (filter: string) => filter)
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            .margin({ top: AppSpacing.md })

            // Map area
            Stack({ alignContent: Alignment.TopStart }) {
              this.MapContentBuilder()
            }
            .width('100%')
            .backgroundColor(AppColors.surface)
            .border({ width: 1, color: AppColors.outline })
            .borderRadius(AppShapes.large)
            .aspectRatio(0.9)
            .margin({
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              bottom: AppSpacing.md
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
          Row({ space: AppSpacing.md }) {
            Button('Reject')
              .fontSize(AppTypography.titleSize)
              .fontWeight(AppTypography.titleWeight)
              .fontColor(this.hasSelection ? AppColors.onSurface : '#999999')
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(AppShapes.medium)
              .height(48)
              .flexGrow(1)
              .enabled(this.hasSelection)
              .onClick(() => {})

            Button('Approve')
              .fontSize(AppTypography.titleSize)
              .fontWeight(AppTypography.titleWeight)
              .fontColor(this.hasSelection ? AppColors.onPrimary : '#999999')
              .backgroundColor(this.hasSelection ? AppColors.primary : '#CCCCCC')
              .borderRadius(AppShapes.medium)
              .height(48)
              .flexGrow(1)
              .enabled(this.hasSelection)
              .onClick(() => {})
          }
          .width('100%')
          .padding({
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.md,
            bottom: AppSpacing.md
          })
        }
        .width('100%')
        .backgroundColor(AppColors.surface)
        .shadow({
          radius: AppElevation.level2.radius,
          color: AppElevation.level2.color,
          offsetX: 0,
          offsetY: -AppElevation.level2.dy
        })
      }
      .width('100%')
      .height('100%')

      // Floating Action Button container
      Column() {
        Blank()
        Row() {
          Blank()
          Button('+')
            .fontSize(AppTypography.headlineSize)
            .fontWeight(AppTypography.headlineWeight)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(28)
            .width(56)
            .height(56)
            .margin(AppSpacing.lg)
            .onClick(() => {})
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}
