import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
// 统一管理应用程序的颜色、字体、形状、间距和阴影规范，方便修改和维护。

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface ElevationToken {
  radius: number;
  dy: number;
  opacity: number;
}

interface ColorMap {
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

interface TypographyMap {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeMap {
  small: number;
  medium: number;
  large: number;
}

interface SpacingMap {
  xs: number;
  sm: number;
  md: number;
  lg: number;
}

interface ElevationMap {
  level1: ElevationToken;
  level2: ElevationToken;
  level3: ElevationToken;
}

class AppTokens {
  static Colors: ColorMap = {
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
  };

  static TypographyTokens: TypographyMap = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes: ShapeMap = {
    small: 8,
    medium: 12,
    large: 16
  };

  static Spacing: SpacingMap = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16
  };

  static ElevationMapping: ElevationMap = {
    level1: { radius: 4, dy: 2, opacity: 0.10 },
    level2: { radius: 8, dy: 4, opacity: 0.14 },
    level3: { radius: 12, dy: 6, opacity: 0.16 }
  };
}

// MARK: - 数据模型
interface ApprovalPin {
  id: number;
  title: string;
  status: string;
  x: number;
  y: number;
}

// MARK: - 可复用 UI 组件

@Component
struct FilterChipView {
  @Prop text: string;
  @Prop isSelected: boolean;
  onTapCallback: () => void = () => {};

  build() {
    Button(this.text)
      .type(ButtonType.Capsule)
      .backgroundColor(Color.Transparent)
      .onClick(() => {
        this.onTapCallback();
      })
      .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.small })
      .height(32)
      .width('auto')
      .margin({ right: AppTokens.Spacing.sm })
  }
}

@Component
struct CardView {
  @State elevation: ElevationToken = AppTokens.ElevationMapping.level1;
  @State cornerRadius: number = AppTokens.Shapes.small;
  @State borderConfig: BorderOptions | null = { width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.small };
  onClickHandler: (() => void) | null = null;
  @BuilderParam content: Content;

  build() {
    Column() {
      this.content()
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(this.cornerRadius)
    .shadow({
      radius: this.elevation.radius,
      color: new Color('#000000').withOpacity(this.elevation.opacity),
      offsetX: 0,
      offsetY: this.elevation.dy
    })
    .border(this.borderConfig ? this.borderConfig : { width: 0, color: Color.Transparent, radius: this.cornerRadius })
    .onClick(() => {
      if (this.onClickHandler) {
        this.onClickHandler();
      }
    })
  }
}

@Component
struct MapPinView {
  @Prop pin: ApprovalPin;
  @Prop selected: boolean;
  onClickHandler: () => void = () => {};

  getBaseColor(): string {
    switch (this.pin.status) {
      case 'Approved': return AppTokens.Colors.success;
      case 'Pending': return AppTokens.Colors.warning;
      case 'Rejected': return AppTokens.Colors.error;
      default: return '#808080';
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Pin Circle
      Circle()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .fill(this.getBaseColor())
        .border({
          width: 2,
          color: this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface
        })

      // Info Card
      CardView({
        elevation: AppTokens.ElevationMapping.level1,
        cornerRadius: AppTokens.Shapes.small,
        borderConfig: { width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.small },
        onClickHandler: this.onClickHandler
      }) {
        Text(this.pin.title)
          .font({
            size: AppTokens.TypographyTokens.label.size,
            weight: AppTokens.TypographyTokens.label.weight
          })
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
      }
      .offset({ x: 18, y: -4 })
    }
  }
}

@Component
struct MapGridOverlay {
  build() {
    Stack() {
      // Horizontal Lines
      Column() {
        ForEach([1, 2, 3, 4, 5], () => {
          Flex().layoutWeight(1)
          Divider().color(AppTokens.Colors.surfaceVariant).strokeWidth(1)
        })
        Flex().layoutWeight(1)
      }
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

      // Vertical Lines
      Row() {
        ForEach([1, 2, 3, 4, 5], () => {
          Flex().layoutWeight(1)
          Divider().vertical(true).color(AppTokens.Colors.surfaceVariant).strokeWidth(1)
        })
        Flex().layoutWeight(1)
      }
      .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - RootScreen (主界面)

@Entry
@Component
struct RootScreen {
  @State filters: string[] = ['Pending', 'Approved'];
  @State activeFilters: string[] = ['Pending'];
  @State pins: ApprovalPin[] = [
    { id: 1, title: 'Purchase Order #1042', status: 'Pending', x: 0.18, y: 0.35 },
    { id: 2, title: 'Travel Request #552', status: 'Approved', x: 0.52, y: 0.42 },
    { id: 3, title: 'Contract #A77', status: 'Pending', x: 0.76, y: 0.58 },
    { id: 4, title: 'Budget Change #09', status: 'Rejected', x: 0.33, y: 0.72 }
  ];
  @State selectedPinId: number | null = null;

  toggleFilter(filter: string): void {
    const index = this.activeFilters.indexOf(filter);
    if (index > -1) {
      this.activeFilters.splice(index, 1);
    } else {
      this.activeFilters.push(filter);
    }
  }

  selectPin(id: number): void {
    this.selectedPinId = this.selectedPinId === id ? null : id;
  }

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        // Top Bar
        Row() {
          Text('Approval Flow')
            .font({
              size: AppTokens.TypographyTokens.display.size,
              weight: AppTokens.TypographyTokens.display.weight
            })
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(AppTokens.Colors.surface)

        // Main Scrollable Content
        Scroll() {
          Column() {
            // Filters
            Scroll() {
              Row() {
                ForEach(this.filters, (filter: string) => {
                  FilterChipView({
                    text: filter,
                    isSelected: this.activeFilters.includes(filter),
                    onTapCallback: () => this.toggleFilter(filter)
                  })
                })
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md })

            // Map Area
            Column() {
              GridMapComponent({
                pins: this.pins,
                activeFilters: this.activeFilters,
                selectedPinId: this.selectedPinId,
                onSelectPinCallback: (id: number) => this.selectPin(id)
              })
            }
            .width('100%')
            .height(360)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })
          }
        }
        .layoutWeight(1)
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)

        // Bottom Bar
        Row() {
          Button('Reject')
            .layoutWeight(1)
            .height(48)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .margin({ right: AppTokens.Spacing.md / 2 })
            .enabled(this.selectedPinId !== null)
            .fontColor(AppTokens.Colors.onSurface)

          Button('Approve')
            .layoutWeight(1)
            .height(48)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .margin({ left: AppTokens.Spacing.md / 2 })
            .enabled(this.selectedPinId !== null)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: new Color('#000000').withOpacity(AppTokens.ElevationMapping.level2.opacity),
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
      }
      .width('100%')
      .height('100%')

      // Floating Action Button
      Row() {
        Flex().layoutWeight(1)
        Button('+')
          .width(56)
          .height(56)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(28)
          .margin(AppTokens.Spacing.lg)
          .fontColor(AppTokens.Colors.onPrimary)
      }
      .alignItems(VerticalAlign.Bottom)
      .justifyContent(FlexAlign.End)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct GridMapComponent {
  @Prop pins: ApprovalPin[];
  @Prop activeFilters: string[];
  @Prop selectedPinId: number | null;
  onSelectPinCallback: (id: number) => void = () => {};

  build() {
    Stack() {
      MapGridOverlay()

      // Pins
      ForEach(this.pins.filter(p => {
        if (p.status === 'Pending') return this.activeFilters.includes('Pending');
        if (p.status === 'Approved') return this.activeFilters.includes('Approved');
        return true; // Rejected always shows
      }), (pin: ApprovalPin) => {
        MapPinView({
          pin: pin,
          selected: this.selectedPinId === pin.id,
          onClickHandler: () => this.onSelectPinCallback(pin.id)
        })
        .position({ x: `${pin.x * 100}%`, y: `${pin.y * 100}%` })
      })

      // Selected Detail Card
      if (this.selectedPinId !== null) {
        let sel = this.pins.find(p => p.id === this.selectedPinId);
        if (sel) {
          Column() {
            Flex().layoutWeight(1)
            CardView({
              elevation: AppTokens.ElevationMapping.level3,
              cornerRadius: AppTokens.Shapes.large,
              borderConfig: { width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large },
              onClickHandler: null
            }) {
              Row() {
                Column() {
                  Text(sel.title)
                    .font({
                      size: AppTokens.TypographyTokens.title.size,
                      weight: AppTokens.TypographyTokens.title.weight
                    })
                    .fontColor(AppTokens.Colors.onSurface)
                  Text(sel.status)
                    .font({
                      size: AppTokens.TypographyTokens.label.size,
                      weight: AppTokens.TypographyTokens.label.weight
                    })
                    .fontColor(AppTokens.Colors.onSurface)
                    .margin({ top: AppTokens.Spacing.xs })
                }
                .alignItems(HorizontalAlign.Start)

                Flex().layoutWeight(1)

                Button('Details')
                  .height(40)
                  .backgroundColor(AppTokens.Colors.surfaceVariant)
                  .borderRadius(AppTokens.Shapes.medium)
                  .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
                  .fontColor(AppTokens.Colors.onSurface)
              }
              .width('100%')
              .padding(AppTokens.Spacing.lg)
            }
            .margin(AppTokens.Spacing.md)
          }
          .width('100%')
          .height('100%')
        }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large })
  }
}