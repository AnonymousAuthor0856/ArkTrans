const NAME: string = '108ApprovalFlowen'
const UI_TYPE: string = 'Map'
const STYLE_THEME: string = 'Monochrome'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

interface ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number
}

class AppTokens {
  static readonly Colors = {
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

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16
  }

  static readonly ElevationMapping = {
    level1: { elevation: 1, radius: 4, dy: 2, opacity: 0.10 } as ShadowSpec,
    level2: { elevation: 3, radius: 8, dy: 4, opacity: 0.14 } as ShadowSpec,
    level3: { elevation: 6, radius: 12, dy: 6, opacity: 0.16 } as ShadowSpec
  }
}

class ApprovalPin {
  id: number
  title: string
  status: string
  x: number
  y: number

  constructor(id: number, title: string, status: string, x: number, y: number) {
    this.id = id
    this.title = title
    this.status = status
    this.x = x
    this.y = y
  }
}

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}

@Component
struct RootScreen {
  @State filters: string[] = ['Pending', 'Approved']
  @State active: string[] = ['Pending']
  @State selectedId: number = -1

  private pins: ApprovalPin[] = [
    new ApprovalPin(1, 'Purchase Order #1042', 'Pending', 0.18, 0.35),
    new ApprovalPin(2, 'Travel Request #552', 'Approved', 0.52, 0.42),
    new ApprovalPin(3, 'Contract #A77', 'Pending', 0.76, 0.58),
    new ApprovalPin(4, 'Budget Change #09', 'Rejected', 0.33, 0.72)
  ]

  private isFilterActive(filter: string): boolean {
    return this.active.indexOf(filter) >= 0
  }

  private toggleFilter(filter: string): void {
    const index = this.active.indexOf(filter)
    if (index >= 0) {
      const next: string[] = [...this.active]
      next.splice(index, 1)
      this.active = next
    } else {
      this.active = [...this.active, filter]
    }
  }

  private isPinVisible(pin: ApprovalPin): boolean {
    if (pin.status === 'Pending') {
      return this.active.indexOf('Pending') >= 0
    }
    if (pin.status === 'Approved') {
      return this.active.indexOf('Approved') >= 0
    }
    return true
  }

  private statusColor(status: string): string {
    if (status === 'Approved') {
      return AppTokens.Colors.success
    }
    if (status === 'Pending') {
      return AppTokens.Colors.warning
    }
    return AppTokens.Colors.error
  }

  @Builder
  TopBar() {
    Row() {
      Text('Approval Flow')
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .lineHeight(34)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(72)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  FilterChip(filter: string) {
    Row() {
      Text(filter)
        .fontSize(this.isFilterActive(filter) ? 16 : 14)
        .fontWeight(this.isFilterActive(filter) ? FontWeight.Medium : FontWeight.Normal)
        .lineHeight(this.isFilterActive(filter) ? 22 : 20)
        .fontColor(this.isFilterActive(filter) ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
    }
    .height(36)
    .padding({ left: 12, right: 12 })
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(this.isFilterActive(filter) ? AppTokens.Colors.primary : AppTokens.Colors.surface)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.small
    })
    .onClick(() => {
      this.toggleFilter(filter)
    })
  }

  @Builder
  FilterRow() {
    Scroll() {
      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.filters, (filter: string) => {
          this.FilterChip(filter)
        }, (filter: string) => filter)
      }
      .height(40)
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }

  @Builder
  MapGridOverlay() {
    Stack() {
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], (item: number) => {
          Blank()
            .width('100%')
            .height(1)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
        }, (item: number) => item.toString())
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .justifyContent(FlexAlign.SpaceEvenly)

      Row() {
        ForEach([0, 1, 2, 3, 4, 5], (item: number) => {
          Blank()
            .width(1)
            .height('100%')
            .backgroundColor(AppTokens.Colors.surfaceVariant)
        }, (item: number) => item.toString())
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  MapPin(pin: ApprovalPin) {
    Stack({ alignContent: Alignment.TopStart }) {
      Row()
        .width(this.selectedId === pin.id ? 28 : 22)
        .height(this.selectedId === pin.id ? 28 : 22)
        .backgroundColor(this.statusColor(pin.status))
        .border({
          width: 2,
          color: this.selectedId === pin.id ? AppTokens.Colors.primary : AppTokens.Colors.surface,
          radius: 50
        })
        .position({ x: 0, y: 4 })

      Row() {
        Text(pin.title)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .lineHeight(16)
          .fontColor(AppTokens.Colors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .padding({
        left: AppTokens.Spacing.sm,
        right: AppTokens.Spacing.sm,
        top: AppTokens.Spacing.xs,
        bottom: AppTokens.Spacing.xs
      })
      .constraintSize({ maxWidth: 180 })
      .backgroundColor(AppTokens.Colors.surface)
      .border({
        width: 1,
        color: AppTokens.Colors.outline,
        radius: AppTokens.Shapes.small
      })
      .shadow({
        radius: AppTokens.ElevationMapping.level1.radius,
        color: '#1A000000',
        offsetY: AppTokens.ElevationMapping.level1.dy
      })
      .position({ x: 18, y: 0 })
      .onClick(() => {
        this.selectedId = this.selectedId === pin.id ? -1 : pin.id
      })
    }
    .width(230)
    .height(48)
    .position({
      x: `${pin.x * 100}%`,
      y: `${pin.y * 100}%`
    })
    .zIndex(this.selectedId === pin.id ? 3 : 2)
  }

  @Builder
  SelectedCard() {
    ForEach(this.pins.filter((pin: ApprovalPin) => pin.id === this.selectedId), (sel: ApprovalPin) => {
      Row() {
        Column({ space: AppTokens.Spacing.xs }) {
          Text(sel.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .lineHeight(22)
            .fontColor(AppTokens.Colors.onSurface)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Text(sel.status)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .lineHeight(16)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .layoutWeight(1)

        Row({ space: AppTokens.Spacing.sm }) {
          Button('Details', { type: ButtonType.Normal })
            .height(40)
            .padding({ left: 12, right: 12 })
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('94%')
      .padding(AppTokens.Spacing.lg)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)
      .border({
        width: 1,
        color: AppTokens.Colors.outline,
        radius: AppTokens.Shapes.large
      })
      .shadow({
        radius: AppTokens.ElevationMapping.level3.radius,
        color: '#29000000',
        offsetY: AppTokens.ElevationMapping.level3.dy
      })
      .align(Alignment.Bottom)
      .margin({ bottom: AppTokens.Spacing.md })
      .zIndex(5)
    }, (sel: ApprovalPin) => sel.id.toString())
  }

  @Builder
  MapArea() {
    Stack({ alignContent: Alignment.TopStart }) {
      this.MapGridOverlay()

      ForEach(this.pins.filter((pin: ApprovalPin) => this.isPinVisible(pin)), (pin: ApprovalPin) => {
        this.MapPin(pin)
      }, (pin: ApprovalPin) => pin.id.toString())

      if (this.selectedId !== -1) {
        this.SelectedCard()
      }
    }
    .width('100%')
    .constraintSize({ minHeight: 360 })
    .aspectRatio(0.9)
    .backgroundColor(AppTokens.Colors.surface)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.large
    })
    .clip(true)
  }

  @Builder
  BottomBar() {
    Row({ space: AppTokens.Spacing.md }) {
      Button('Reject', { type: ButtonType.Normal })
        .height(48)
        .layoutWeight(1)
        .enabled(this.selectedId !== -1)
        .opacity(this.selectedId !== -1 ? 1 : 0.45)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Button('Approve', { type: ButtonType.Normal })
        .height(48)
        .layoutWeight(1)
        .enabled(this.selectedId !== -1)
        .opacity(this.selectedId !== -1 ? 1 : 0.45)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
    }
    .width('100%')
    .padding({
      left: AppTokens.Spacing.lg,
      right: AppTokens.Spacing.lg,
      top: AppTokens.Spacing.md,
      bottom: AppTokens.Spacing.md
    })
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: '#24000000',
      offsetY: -AppTokens.ElevationMapping.level2.dy
    })
  }

  build() {
    Stack() {
      Column() {
        this.TopBar()

        Column({ space: AppTokens.Spacing.md }) {
          this.FilterRow()
          this.MapArea()
        }
        .width('100%')
        .layoutWeight(1)
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.md,
          bottom: AppTokens.Spacing.md
        })

        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      Button('+', { type: ButtonType.Circle })
        .width(56)
        .height(56)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .align(Alignment.BottomEnd)
        .margin({ right: 16, bottom: 96 })
        .zIndex(20)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}