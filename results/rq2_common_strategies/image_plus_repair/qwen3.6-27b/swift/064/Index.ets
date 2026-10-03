// AppTokens.ts
export interface ColorMap {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

export interface ShapeMap {
  small: number;
  medium: number;
  large: number;
}

export interface SpacingMap {
  xs: number;
  sm: number;
  md: number;
  lg: number;
}

export interface ElevationLevel {
  radius: number;
  dy: number;
  opacity: number;
}

export interface ElevationMapping {
  level1: ElevationLevel;
  level2: ElevationLevel;
  level3: ElevationLevel;
}

export class AppTokens {
  static readonly Colors: ColorMap = {
    primary: '#111111',
    secondary: '#2A2A2A',
    tertiary: '#444444',
    background: '#F7F7F7',
    surface: '#FFFFFF',
    surfaceVariant: '#EDEDED',
    outline: '#D6D6D6',
    success: '#1E7D4C',
    warning: '#B98400',
    error: '#B3261E',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#0A0A0A',
    onSurface: '#0A0A0A'
  }

  static readonly Shapes: ShapeMap = {
    small: 8,
    medium: 12,
    large: 16
  }

  static readonly Spacing: SpacingMap = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16
  }

  static readonly ElevationMapping: ElevationMapping = {
    level1: { radius: 4, dy: 2, opacity: 0.1 },
    level2: { radius: 8, dy: 4, opacity: 0.14 },
    level3: { radius: 12, dy: 6, opacity: 0.16 }
  }
}

// ApprovalPinModel.ts
export interface ApprovalPin {
  id: number;
  title: string;
  status: string;
  x: number;
  y: number;
}

// Index.ets
@Entry
@Component
struct RootScreen {
  @State filters: string[] = ['Pending', 'Approved']
  @State activeFilters: string[] = ['Pending']
  @State selectedPinId: number | null = null

  // Mock Data
  private pins: ApprovalPin[] = [
    { id: 1, title: 'Purchase Order #1042', status: 'Pending', x: 0.18, y: 0.35 },
    { id: 2, title: 'Travel Request #552', status: 'Approved', x: 0.52, y: 0.42 },
    { id: 3, title: 'Contract #A77', status: 'Pending', x: 0.76, y: 0.58 },
    { id: 4, title: 'Budget Change #09', status: 'Rejected', x: 0.33, y: 0.72 }
  ]

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Approval Flow')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)

      // Main Scrollable Content
      Scroll() {
        Column() {
          // Filter Chips
          Row() {
            ForEach(this.filters, (filter: string) => {
              Button(filter)
                .type(ButtonType.Normal)
                .backgroundColor(this.activeFilters.includes(filter) ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                .fontColor(this.activeFilters.includes(filter) ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .margin({ right: AppTokens.Spacing.sm })
                .height(32)
                .onClick(() => {
                  if (this.activeFilters.includes(filter)) {
                    this.activeFilters = this.activeFilters.filter(f => f !== filter)
                  } else {
                    this.activeFilters.push(filter)
                  }
                })
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md })

          // Map Area
          GridOverlayView({
            pins: this.pins,
            activeFilters: this.activeFilters,
            selectedPinId: this.selectedPinId,
            onSelectPin: (id: number) => {
              this.selectedPinId = this.selectedPinId === id ? null : id
            }
          })
          .width('100%')
          .aspectRatio(0.9)
          .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })
        }
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar
      Row() {
        Button('Reject')
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .fontColor(AppTokens.Colors.onSurface)
          .borderRadius(AppTokens.Shapes.medium)
          .height(48)
          .layoutWeight(1)
          .margin({ right: AppTokens.Spacing.md / 2 })
          .enabled(this.selectedPinId !== null)
          .opacity(this.selectedPinId !== null ? 1 : 0.5)

        Button('Approve')
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .borderRadius(AppTokens.Shapes.medium)
          .height(48)
          .layoutWeight(1)
          .margin({ left: AppTokens.Spacing.md / 2 })
          .enabled(this.selectedPinId !== null)
          .opacity(this.selectedPinId !== null ? 1 : 0.5)
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: AppTokens.ElevationMapping.level2.radius, offsetY: AppTokens.ElevationMapping.level2.dy, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})` })
      
      // Floating Action Button moved inside root container to satisfy single root node rule
      Button('+')
        .type(ButtonType.Circle)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(28)
        .width(56)
        .height(56)
        .position({ x: 'calc(100% - 56px - 16px)', y: 'calc(100% - 56px - 16px)' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

interface GridOverlayViewParams {
  pins: ApprovalPin[];
  activeFilters: string[];
  selectedPinId: number | null;
  onSelectPin: (id: number) => void;
}

@Component
struct GridOverlayView {
  @Prop pins: ApprovalPin[]
  @Prop activeFilters: string[]
  @Prop selectedPinId: number | null
  @Prop onSelectPin: (id: number) => void

  build() {
    Stack() {
      // Grid Lines Horizontal
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Divider().color(AppTokens.Colors.surfaceVariant).strokeWidth(1)
        })
      }
      .width('100%')
      .height('100%')

      // Grid Lines Vertical
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Divider().vertical(true).color(AppTokens.Colors.surfaceVariant).strokeWidth(1)
        })
      }
      .width('100%')
      .height('100%')

      // Pins
      ForEach(this.pins, (pin: ApprovalPin) => {
        if (this.shouldShowPin(pin.status)) {
          MapPinComponent({
            pin: pin,
            isSelected: this.selectedPinId === pin.id,
            onClick: () => this.onSelectPin(pin.id)
          })
          .position({ left: `${pin.x * 100}%`, top: `${pin.y * 100}%` })
        }
      })

      // Detail Card
      if (this.selectedPinId !== null) {
        let selectedPin = this.pins.find(p => p.id === this.selectedPinId)
        if (selectedPin) {
          Column() {
            Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
              Column() {
                Text(selectedPin.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)
                Text(selectedPin.status)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ top: AppTokens.Spacing.xs })
              }
              Button('Details')
                .type(ButtonType.Normal)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .fontColor(AppTokens.Colors.onSurface)
                .borderRadius(AppTokens.Shapes.medium)
                .height(40)
                .margin({ left: AppTokens.Spacing.sm })
            }
            .width('100%')
          }
          .width('100%')
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .shadow({ radius: AppTokens.ElevationMapping.level3.radius, offsetY: AppTokens.ElevationMapping.level3.dy, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level3.opacity})` })
          .alignRules({ bottom: { anchor: '__container__', align: VerticalAlign.Bottom } })
          .margin(AppTokens.Spacing.md)
        }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
  }

  shouldShowPin(status: string): boolean {
    if (status === 'Pending') return this.activeFilters.includes('Pending')
    if (status === 'Approved') return this.activeFilters.includes('Approved')
    return true // Rejected always shows in this logic
  }
}

interface MapPinComponentParams {
  pin: ApprovalPin;
  isSelected: boolean;
  onClick: () => void;
}

@Component
struct MapPinComponent {
  @Prop pin: ApprovalPin
  @Prop isSelected: boolean
  @Prop onClick: () => void

  build() {
    Stack() {
      Circle()
        .width(this.isSelected ? 28 : 22)
        .height(this.isSelected ? 28 : 22)
        .fill(this.getPinColor())
        .border({ width: 2, color: this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface })

      Text(this.pin.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.small)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .shadow({ radius: AppTokens.ElevationMapping.level1.radius, offsetY: AppTokens.ElevationMapping.level1.dy, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})` })
        .offset({ x: 18, y: -4 })
    }
    .onClick(() => {
      this.onClick()
    })
  }

  getPinColor(): string {
    switch (this.pin.status) {
      case 'Approved': return AppTokens.Colors.success
      case 'Pending': return AppTokens.Colors.warning
      case 'Rejected': return AppTokens.Colors.error
      default: return '#808080'
    }
  }
}